<?php

namespace app\admin\controller;
use think\Controller;
use think\facade\Config;
use think\facade\Request;
use think\facade\Session;
use think\Db;
use app\common\controller\AppCommon;
use app\admin\model\RoleNav;
use app\admin\model\OperationLog;
use Auths\Auth;
use Pages\Page;
use Tree\Tree;

class Cartoon extends Common
{

    public function __construct()
    {
        parent::__construct();
        $modules = $this->getModule(CONTROLLER); //获取模型配置 
        $this->assign("modules", $modules);
        $this->modelFields($modules['table']);
    }

    /**
     * 歌词分类
     */
    public function cate(){
        $list = Db::name('poetry_category')->select();
        $this->assign('list',$list);
        return view();
    }

    /**
     * 删除分类
     */
    public function cateDel(){
        $id = input('get.id', 0, 'intval');

        $is_book = Db::name('poetry')->where('cid',$id)->select();
        if ($is_book){
            JsonDie(1, '该分类下还有诗歌，不能删除', 'no');
        }
        $res = Db::name('poetry_category')->where('id',$id)->delete();
        if (FALSE !== $res) {
            JsonDie(1, '操作成功', 'yes');
        } else {
            JsonDie(1, '操作失败', 'no');
        }
    }

    public function addCate(){
        if ($_POST){
            $post = input('post.','','trim');
            $check = Db::name('poetry_category')->where('title',$post['name'])->find();
            if ($check){
                JsonDie(0, '该分类已存在', 'no');
            }
            $data = [
                'title' => $post['name'],
                'create_time' => date('Y-m-d H:i:s'),
                'sort' => $post['sort']
            ];
            $res = Db::name('poetry_category')->insert($data);
            if (FALSE !== $res) {
                JsonDie(1, '操作成功', 'yes');
            } else {
                JsonDie(0, '操作失败', 'no');
            }
        }
        return view();
    }

    public function cateEdit(){
        $id = input('get.id');
        $data = Db::name('poetry_category')->where('id',$id)->find();
        if($_POST){
            $this->categorySave();
        }
        $this->assign('data',$data);
        return view();
    }

    public function categorySave(){
        try {
            $ary_post = input("post.");
            $id = input('request.id', 0, 'intval');
            $data = [
                'title' => $ary_post['title'],
                'status' => $ary_post['status'],
                'sort' => $ary_post['sort']
            ];
            $ary_result = Db::name('poetry_category')->where('id',$id)->update($data);

            if (FALSE !== $ary_result) {
                JsonDie(1, '操作成功', 'yes');
            } else {
                JsonDie(1, '操作失败', 'no');
            }
        } catch (\Exception $e) {
            JsonDie(0, '操作失败' . $e, 'no');
        }
    }

    /**
     * 古风歌词
     */
    public function index()
    {
        $count = Db::name('poetry')->count();
        $obj_page = $this->_Page($count,20);
        $page = $obj_page->newshow();

        $list = Db::name('poetry')
            ->limit($obj_page->firstRow, $obj_page->listRows)
            ->order('sort asc,id desc')
            ->select();

        $this->assign('count',$count);
        $this->assign("page", $page);
        $this->assign('list',$list);
        return view();
    }

    public function edit(){
        if ($_POST){
            $this->save();
        }
        $id = input('get.id');
        $data = Db::name('poetry')
            ->where('id',$id)
            ->find();
        $this->assign('data',$data);
        $this->assign('id',$data['id']);
        return view();
    }

    public function save(){
        $id = input('get.id');
        $post = input('post.');
        $data = [
            'cid' => $post['cid'],
            'title' => $post['title'],
            'content' => $post['content'],
            'author' => $post['author'],
            'sort' => $post['sort'],
            'image' => $post['image'],
        ];
        $res = Db::name('poetry')->where('id',$id)->update($data);
        if ($res) {
            JsonDie(1, '保存成功', 'yes');
        } else {
            JsonDie(1, '保存失败', 'no');
        }
    }

    public function add(){
        $post = input('post.');
        $data = [
            'cid' => $post['cid'],
            'title' => $post['title'],
            'content' => $post['content'],
            'author' => $post['author'],
            'sort' => $post['sort'],
            'image' => $post['image'],
            'create_time' => time()
        ];
        $res = Db::name('poetry')->insert($data);
        if ($res) {
            JsonDie(1, '添加成功', 'yes');
        } else {
            JsonDie(1, '添加失败', 'no');
        }
    }

    public function doDelete(){
        $id = input('get.id');
        $res = Db::name('poetry')->where('id',$id)->delete();
        if ($res) {
            JsonDie(1, '删除成功', 'yes');
        } else {
            JsonDie(1, '删除失败', 'no');
        }
    }

    public function editStatus()
    {
        try{
            $id=input("get.id",0,"intval");
            $value=input("get.value",0,"intval");
            if(!$id){JsonDie('0',"参数错误",'yes');	}
            if($value==0){
                $data=array('status'=>1);
            }else{
                $data=array('status'=>0);
            }

            $ary_result=Db::name('poetry_category')->where(array("id" => $id))->data($data)->update();
            if($ary_result){
                JsonDie('1',"操作成功",'yes');
            }else{
                JsonDie('0',"操作失败",'no');
            }
        }catch (\Exception $e) {
            JsonDie(0,'操作失败'.$e,'no');
        }
    }

    public function reStatus()
    {
        try{
            $id=input("get.id",0,"intval");
            $value=input("get.value",0,"intval");
            if(!$id){JsonDie('0',"参数错误",'yes');	}
            if($value==0){
                $data=array('is_recommend'=>1);
            }else{
                $data=array('is_recommend'=>0);
            }

            $ary_result=Db::name('poetry')->where(array("id" => $id))->data($data)->update();
            if($ary_result){
                JsonDie('1',"操作成功",'yes');
            }else{
                JsonDie('0',"操作失败",'no');
            }
        }catch (\Exception $e) {
            JsonDie(0,'操作失败'.$e,'no');
        }
    }

}
