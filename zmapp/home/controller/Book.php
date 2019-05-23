<?php

namespace app\home\controller;

use think\Db;


class Book extends Common {
    protected $b_id = '';
    public function __construct() {
        parent::__construct();
        $this->b_id = input('get.id','','intval');
        $this->isLogin();
        $user = Db::name('member')->where('id',$this->user_id)->find();
        $this->assign('user',$user);
    }

    /**
     * 书籍管理
     */
    public function manage(){
        $where = [
            'u_id' => $this->user_id,
            'is_del' => 0
        ];
        $book = Db::name('book')->where($where)->select();
        $count = count($book);
        $this->assign('book',$book);
        $this->assign('count',$count);
        return view();
    }

    /**
     * 草稿
     */
    public function draft(){
        $get = input('get.','','intval');

        $book = Db::name('book')->where('id',$get['id'])->field('name')->find();
        $draft_count = Db::name('chapter')->where('b_id',$get['id'])->where('status',2)->count();
        $count = Db::name('chapter')->where('b_id',$get['id'])->count();
        $number = '第'.($this->numToWord($count+1)).'章';
        $draft = Db::name('chapter')->where('b_id',$get['id'])->where('status',2)->select();
        foreach ($draft as $k=>$v){
            $length = mb_strlen(strip_tags($v['content']));
            $draft[$k]['leng'] = $length;
        }

        $data = Db::name('chapter')->where('b_id',$get['id'])->where('id',$get['d_id'])->find();
        $leng = mb_strlen($data['content']);
        $data['leng'] = $leng;

        $this->assign('b_id',$get['id']);
        $this->assign('list',$draft);
        $this->assign('book',$book);
        $this->assign('data',$data);
        $this->assign('count',$draft_count);
        $this->assign('number',$number);
        return view();
    }

    /**
     * 保存草稿
     */
    public function doSaveDraft(){
        $post = input('post.');
        //b_id 所属书籍id; d_id 文章id
        $count = Db::name('chapter')->where('b_id',$post['b_id'])->count();
        $number = '第'.($this->numToWord($count+1)).'章';
        $data = [
            'status' => 2,
            'say' => $post['say'],
            'name' => $post['name'],
            'content' => $post['content'],
            'number' => $number,
            'b_id' =>$post['b_id'],
            'time' => time()
        ];
        // 查询文章是否存在，存在则修改，不存在则新增
        $is_exist = Db::name('chapter')->where('b_id',$post['b_id'])->where('id',$post['d_id'])->find();
        if ($is_exist){
            $res = Db::name('chapter')
                ->where('id',$post['d_id'])
                ->update($data);
            if ($res){
                JsonDie("1", '保存成功', '',$post['b_id']);
            }else{
                JsonDie("0", '保存失败', '',$post['b_id']);
            }
        }else{
            $res = Db::name('chapter')->insert($data);
            if ($res){
                JsonDie("1", '保存成功', '',$post['b_id']);
            }else{
                JsonDie("0", '保存失败', '',$post['b_id']);
            }
        }
    }

    /**
     * 发布草稿
     */
    public function publish(){
        $post = input('post.');
        $number = Db::name('chapter')
            ->where('b_id',$post['b_id'])
            ->where('is_del',0)
            ->where('status',1)
            ->count();

        $data = [
            'status' => 0,
            'name' => $post['name'],
            'content' => $post['content'],
            'b_id' => $post['b_id'],
            'say' => $post['say'],
            'number' => $number + 1,
            'time' => time()
        ];

        if ($post['type'] == 1){
            // 立即发布
            if (!$post['d_id']){
                // 草稿中没有，则新增
                $res = Db::name('chapter')->where('b_id',$post['b_id'])->insert($data);
            }else{
                // 修改草稿并发布
                $res = Db::name('chapter')->where('id',$post['d_id'])->update($data);
            }
            if ($res){
                JsonDie("1", '发布成功，请等待审核', '',$post['b_id']);
            }else{
                JsonDie("0", '发布失败', '',$post['b_id']);
            }
        }else if($post['type'] == 2){
            $this->timingPublish();
        }
    }


    /**
     * 定时发布
     */
    public function timingPublish(){
        $post = input('post.');
        $time = time();
        $publishTime = strtotime($post['time']); // 定时时间
        if ($publishTime < $time){
            JsonDie("0", '定时时间不能小于现在时间', '');
        }
        $number = Db::name('chapter')
            ->where('b_id',$post['b_id'])
            ->where('is_del',0)
            ->where('status',1)
            ->count();
        $data = [
            'status' => 0,
            'name' => $post['name'],
            'content' => $post['content'],
            'b_id' => $post['b_id'],
            'number' => $number + 1,
            'publish_time' => strtotime($post['time']),
            'pub' => 2,
            'time' => time()
        ];
        if (!$post['d_id']){
            // 草稿中没有，则新增

            $res = Db::name('chapter')
                ->where('b_id',$post['b_id'])
                ->insert($data);
        }else{
            // 修改草稿并发布
            $res = Db::name('chapter')
                ->where('id',$post['d_id'])
                ->update($data);
        }
        if ($res){
            JsonDie("1", '已成功提交你的定时发布', '',$post['b_id']);
        }else{
            JsonDie("0", '发布失败', '',$post['b_id']);
        }
    }



    /**
     * 待发布
     */
    public function publishing(){
        $list = Db::name('chapter')->where('b_id',$this->b_id)->where('status',0)->select();
        $count = Db::name('chapter')->where('b_id',$this->b_id)->where('status',0)->count();
        $number = '第'.($this->numToWord($count+1)).'章';

        foreach ($list as $k=>$v){
            $length = mb_strlen(strip_tags(DeleteHtml($v['content'])));
            $list[$k]['leng'] = $length;
        }

        $get = input('get.');
        $data = Db::name('chapter')->where('b_id',$get['id'])->where('id',$get['d_id'])->find();
        $this->assign('data',$data);
        $this->assign('list',$list);
        $this->assign('count',$count);
        $this->assign('number',$number);
        return view();
    }

    /**
     * 已发布
     */
    public function published(){
        $list = Db::name('chapter')->where('b_id',$this->b_id)->where('status',1)->select();
        $count = Db::name('chapter')->where('b_id',$this->b_id)->where('status',1)->count();
        $number = '第'.($this->numToWord($count+1)).'章';

        foreach ($list as $k=>$v){
            $length = mb_strlen(strip_tags(DeleteHtml($v['content'])));
            $list[$k]['leng'] = $length;
        }

        $get = input('get.');
        $data = Db::name('chapter')->where('b_id',$get['id'])->where('id',$get['d_id'])->find();
        $this->assign('data',$data);
        $this->assign('list',$list);
        $this->assign('count',$count);
        $this->assign('number',$number);
        return view();
    }


	/**
     * 作品设置
     */
	public function setting(){
	    $id = input('get.id','','intval');
        $book = Db::name('book')->where('id',$id)->find();
        $where = [
            'b_id' => $id,
            'is_del' => 0
        ];
        $chapter = Db::name('chapter')
            ->where($where)
            ->where('is_del',0)
            ->where('status',1)
            ->field('content')
            ->select();

        $num = 0;
        foreach ($chapter as $k=>$v){
            $num += mb_strlen(strip_tags($v['content']),'utf-8');
        }
        $this->assign('num',$num);
        $this->assign('book',$book);
	    return view();
    }

    /**
     * 修改书籍
     */
    public function editBook(){
        if($_POST){
            $this->doSave();
        }
        $book = Db::name('book')->where('id',$this->b_id)->find();
        $where = [
            'b_id' => $this->b_id,
            'is_del' => 0
        ];
        $chapter = Db::name('chapter')->where($where)->field('content')->select();
        $num = 0;
        foreach ($chapter as $k=>$v){
            $num += mb_strlen($v['content'],'utf-8');
        }
        $this->assign('num',$num);
        $this->assign('book',$book);
        return view();
    }


    /**
     * 保存修改书籍
     */
    public function doSave(){
        $post = input('post.');

        $data = [
            'name' => $post['name'],
            'cid' => $post['cid'],
            'info' => $post['info'],
            'image' => $post['image'],
            'type' => $post['type']
        ];
        $id = $post['id'];
        $res = Db::name('book')->where('id',$id)->update($data);
        if ($res){
            JsonDie("1", '修改成功', '',$id);
        }else{
            JsonDie("0", '修改失败', '',$id);
        }
    }


    public function editPublish(){
        $data = [
            'name' => input('post.name','','trim'),
            'content' => input('post.content','','trim'),
        ];

        $where = [
            'b_id' => input('post.b_id','','intval'),
            'id' => input('post.id','','intval'),
        ];

        $res = Db::name('chapter')->where($where)->update($data);

        if ($res){
            JsonDie("1", '修改成功', '');
        }else{
            JsonDie("0", '修改失败', '');
        }
    }

    /**
     * 上传书籍封面
     */
    public function uplodePhoto()
    {
        $file = request()->file('uplodePhoto');
        // 移动到框架应用根目录/uploads/ 目录下
        $save_path = '/uploads/img/'; //上传路径
        $info = $file->validate(array('size' => 4096000, 'ext' => 'jpg,png,gif'))->move(WEB_PATH . $save_path); // 根目录/uploads下
        if ($info) {
            $filePath = $save_path . str_replace("\\", "/", $info->getSaveName()); //服务器上相对路径
            JsonDie(200, '上传成功', 'yes', $filePath);
        } else {
            // 上传失败获取错误信息
            JsonDie(0, $file->getError());
        }
    }
}











