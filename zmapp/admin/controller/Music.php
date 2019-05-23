<?php
/**
 * Created by PhpStorm.
 * User: 李贾
 * Date: 2019/3/7
 * Time: 10:30
 */

namespace app\admin\controller;


use think\Db;

class Music extends Common
{
    public function index(){
        $ary_get['pageall'] = input("request.pageall", 15, 'intval');
        $count = Db::name('music')->where('status',1)->count();
        $this->assign("count", 15);
        $obj_page = $this->_Page($count, $ary_get['pageall']);
        $page = $obj_page->newshow();
        $list = Db::name('music')
            ->alias('a')
            ->join('lang b','a.lang = b.id')
            ->join('type c','a.type = c.id')
            ->join('feel d','a.feel = d.id')
            ->order('sort asc,id desc')
            ->limit($obj_page->firstRow, $obj_page->listRows)
            ->field('a.id,a.image,a.title,a.sort,a.create_time,b.title as lang,c.title as type,d.title as feel')
            ->select();
        $this->assign('list',$list);
        $this->assign('page',$page);
        return view();
    }

    /**
     * 编辑音乐
     */
    public function editMusic(){
        $id = input('get.id','','intval');
        $data = Db::name('music')->where('id',$id)->find();
        $lang = Db::name('lang')
            ->where('status',1)
            ->order('sort asc,id desc')
            ->field('id,title,sort,create_time')
            ->select();
        $this->assign('lang',$lang);
        $type = Db::name('type')
            ->where('status',1)
            ->order('sort asc,id desc')
            ->field('id,title,sort,create_time')
            ->select();
        $this->assign('type',$type);
        $feel = Db::name('feel')
            ->where('status',1)
            ->order('sort asc,id desc')
            ->field('id,title,sort,create_time')
            ->select();
        $this->assign('feel',$feel);
        if ($_POST){
            $post = input('post.');
            $data = [
                'title' => $post['title'],
                'lang' => $post['lang'],
                'type' => $post['type'],
                'feel' => $post['feel'],
                'image' => $post['image'],
                'songer' => $post['songer'],
                'zj' => $post['zj'],
                'content' => $post['content'],
                'update_time' => time()
            ];
            $res = Db::name('music')->where('id',$post['id'])->update($data);
            if (FALSE !== $res) {
                JsonDie(1, '操作成功', 'yes');
            } else {
                JsonDie(1, '操作失败', 'no');
            }
        }
        $this->assign('data',$data);
        return view();
    }

    /**
     * 删除音乐
     */
    public function delMusic(){
        $id = input('get.id','','intval');
        $res = Db::name('music')->where('id',$id)->delete();
        if (FALSE !== $res) {
            JsonDie(1, '操作成功', 'yes');
        } else {
            JsonDie(1, '操作失败', 'no');
        }
    }

    /**
     * 添加音乐
     */
    public function addMusic(){
        $lang = Db::name('lang')
            ->where('status',1)
            ->order('sort asc,id desc')
            ->field('id,title,sort,create_time')
            ->select();
        $this->assign('lang',$lang);
        $type = Db::name('type')
            ->where('status',1)
            ->order('sort asc,id desc')
            ->field('id,title,sort,create_time')
            ->select();
        $this->assign('type',$type);
        $feel = Db::name('feel')
            ->where('status',1)
            ->order('sort asc,id desc')
            ->field('id,title,sort,create_time')
            ->select();
        $this->assign('feel',$feel);
        if ($_POST){
            $post = input('post.');
            $data = [
                'title' => $post['title'],
                'lang' => $post['lang'],
                'type' => $post['type'],
                'feel' => $post['feel'],
                'image' => $post['image'],
                'songer' => $post['songer'],
                'zj' => $post['zj'],
                'content' => $post['content'],
                'create_time' => time()
            ];
            $res = Db::name('music')->insert($data);
            if (FALSE !== $res) {
                JsonDie(1, '操作成功', 'yes');
            } else {
                JsonDie(1, '操作失败', 'no');
            }
        }
        return view();
    }

    /**
     * 语言分类
     */
    public function lang(){
        $list = Db::name('lang')
            ->where('status',1)
            ->order('sort asc,id desc')
            ->field('id,title,sort,create_time')
            ->select();
        $this->assign('list',$list);
        return view();
    }

    /**
     * 音乐风格
     */
    public function type(){
        $list = Db::name('type')
            ->where('status',1)
            ->order('sort asc,id desc')
            ->field('id,title,sort,create_time')
            ->select();
        $this->assign('list',$list);
        return view();
    }

    /**
     * 音乐情感
     */
    public function feel(){
        $list = Db::name('feel')
            ->where('status',1)
            ->order('sort asc,id desc')
            ->field('id,title,sort,create_time')
            ->select();
        $this->assign('list',$list);
        return view();
    }

    /**
     * 添加语言类型
     */
    public function addLang(){
        if ($_POST){
            $post = input('post.');
            $data = [
                'title' => $post['title'],
                'sort' => $post['sort'],
                'create_time' => time()
            ];
            $res = Db::name('lang')->insert($data);
            if (FALSE !== $res) {
                JsonDie(1, '操作成功', 'yes');
            } else {
                JsonDie(1, '操作失败', 'no');
            }
        }
        return view();
    }

    /**
     * 添加语言类型
     */
    public function addType(){
        if ($_POST){
            $post = input('post.');
            $data = [
                'title' => $post['title'],
                'sort' => $post['sort'],
                'create_time' => time()
            ];
            $res = Db::name('type')->insert($data);
            if (FALSE !== $res) {
                JsonDie(1, '操作成功', 'yes');
            } else {
                JsonDie(1, '操作失败', 'no');
            }
        }
        return view();
    }

    /**
     * 添加音乐情感
     */
    public function addFeel(){
        if ($_POST){
            $post = input('post.');
            $data = [
                'title' => $post['title'],
                'sort' => $post['sort'],
                'create_time' => time()
            ];
            $res = Db::name('feel')->insert($data);
            if (FALSE !== $res) {
                JsonDie(1, '操作成功', 'yes');
            } else {
                JsonDie(1, '操作失败', 'no');
            }
        }
        return view();
    }

    /**
     * 编辑语言类型
     */
    public function editLang(){
        $id = input('get.id','','intval');
        $data = Db::name('lang')->where('id',$id)->find();
        if ($_POST){
            $post = input('post.');
            $data = [
                'title' => $post['title'],
                'sort' => $post['sort'],
                'update_time' => time()
            ];
            $res = Db::name('lang')->where('id',$post['id'])->update($data);
            if (FALSE !== $res) {
                JsonDie(1, '操作成功', 'yes');
            } else {
                JsonDie(1, '操作失败', 'no');
            }
        }
        $this->assign('data',$data);
        return view();
    }

    /**
     * 编辑风格类型
     */
    public function editType(){
        $id = input('get.id','','intval');
        $data = Db::name('type')->where('id',$id)->find();
        if ($_POST){
            $post = input('post.');
            $data = [
                'title' => $post['title'],
                'sort' => $post['sort'],
                'update_time' => time()
            ];
            $res = Db::name('type')->where('id',$post['id'])->update($data);
            if (FALSE !== $res) {
                JsonDie(1, '操作成功', 'yes');
            } else {
                JsonDie(1, '操作失败', 'no');
            }
        }
        $this->assign('data',$data);
        return view();
    }

    /**
     * 编辑情感类型
     */
    public function editFeel(){
        $id = input('get.id','','intval');
        $data = Db::name('feel')->where('id',$id)->find();
        if ($_POST){
            $post = input('post.');
            $data = [
                'title' => $post['title'],
                'sort' => $post['sort'],
                'update_time' => time()
            ];
            $res = Db::name('feel')->where('id',$post['id'])->update($data);
            if (FALSE !== $res) {
                JsonDie(1, '操作成功', 'yes');
            } else {
                JsonDie(1, '操作失败', 'no');
            }
        }
        $this->assign('data',$data);
        return view();
    }

    /**
     * 删除语种
     */
    public function delLang(){
        $id = input('get.id','','intval');
        $res = Db::name('lang')->where('id',$id)->delete();
        if (FALSE !== $res) {
            JsonDie(1, '操作成功', 'yes');
        } else {
            JsonDie(1, '操作失败', 'no');
        }
    }

    /**
     * 删除风格
     */
    public function delType(){
        $id = input('get.id','','intval');
        $res = Db::name('type')->where('id',$id)->delete();
        if (FALSE !== $res) {
            JsonDie(1, '操作成功', 'yes');
        } else {
            JsonDie(1, '操作失败', 'no');
        }
    }

    /**
     * 删除情感
     */
    public function delFeel(){
        $id = input('get.id','','intval');
        $res = Db::name('feel')->where('id',$id)->delete();
        if (FALSE !== $res) {
            JsonDie(1, '操作成功', 'yes');
        } else {
            JsonDie(1, '操作失败', 'no');
        }
    }


    /**
     * 上传音乐
     */
    public function mediaUpload(){
        try {
            $save_path = '/uploads/media/'; //上传路径
            $files = request()->file("uplodePhoto");

            $info = $files->validate(array('size' => 20480000, 'ext' => 'swf,flv,mp3,mp4,wav,wma,wmv,mid,avi,mpg,asf,rm,rmvb'))->move(WEB_PATH . $save_path); // 根目录/uploads下
            if ($info) {
                $filePath = $save_path . str_replace("\\", "/", $info->getSaveName()); //服务器上相对路径

                $data=array('error'=>0,'ext'=>$info->getExtension(),'url'=>$filePath,'file_name'=>$info->getFilename());
            } else {
                $data=array('error'=>1,'message'=>$files->getError(),'file_name'=>'error');
            }
            die(json_encode($data));
        } catch (\Exception $e) {
            JsonDie(0, '操作失败' . $e, 'no');
        }
    }
}