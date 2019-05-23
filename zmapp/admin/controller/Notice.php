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

class Notice extends Common
{

    public function __construct()
    {
        parent::__construct();
        $modules = $this->getModule(CONTROLLER); //获取模型配置 
        $this->assign("modules", $modules);
        $this->modelFields($modules['table']);
    }

    /**
     * 公告
     */
    public function notice(){
        $keyword = input('get.keyword','','trim');
        $where = '';
        if ($keyword){
            $where .= "title like '%" . urldecode($keyword) . "%' AND ";
        }
        $where .= 'type = 3';
        $count = Db::name('notice')
            ->where($where)
            ->count();
        $obj_page = $this->_Page($count,20);
        $page = $obj_page->newshow();
        $list = Db::name('notice')
            ->where($where)
            ->limit($obj_page->firstRow, $obj_page->listRows)
            ->order('id desc')
            ->select();
        $this->assign('list',$list);
        $this->assign('page',$page);
        $this->assign('count',$count);
        return view();
    }

    /**
     * 新增公告
     */
    public function addNotice(){
        if($_POST){
            $this->add();
        }
        $id = input('get.id');
        $data = Db::name('notice')->where('id',$id)->find();
        $this->assign('data',$data);
        $this->assign('id',$data['id']);
        return view();
    }

    /**
     * 编辑公告
     */
    public function editNotice(){
        $post = input('post.');
        $data = [
            'title' => $post['title'],
            'content' => $post['content']
        ];
        $res = Db::name('notice')->where('id',$post['id'])->update($data);
        if ($res){
            JsonDie(1, '保存成功', 'yes');
        }else{
            JsonDie(0, '保存失败', 'no');
        }
    }

    /**
     * 删除公告
     */
    public function delNotice(){
        $id = input('get.id');
        $res = Db::name('notice')->where('id',$id)->delete();
        if ($res){
            JsonDie(1, '删除成功', 'yes');
        }else{
            JsonDie(0, '删除失败', 'no');
        }
    }

    public function add(){
        $post = input('post.');
        $data = [
            'title' => $post['title'],
            'content' => $post['content'],
            'type' => 3,
            'create_time' => date('Y:m:d H:i:s')
        ];
        $res = Db::name('notice')->insert($data);
        if ($res){
            JsonDie(1, '新增成功', 'yes');
        }else{
            JsonDie(0, '新增失败', 'no');
        }
    }

    /**
     * 给用户私信
     */
    public function letter(){
        $keyword = input('get.keyword','');
        $status = input('get.status');
        $where = '';
        if ($keyword){
            $where .= "a.title like '%" . urldecode($keyword) . "%' OR ";
            $where .= "b.phone like '%" . urldecode($keyword) . "%' AND ";
        }
        if ($status){
            $where .= " a.status = '".$status."' AND ";
        }
        $where .= 'type = 2';
        $count = Db::name('notice')
            ->alias('a')
            ->where($where)
            ->count();
        $obj_page = $this->_Page($count,20);
        $page = $obj_page->newshow();
        $list = Db::name('notice')
            ->alias('a')
            ->join('member b','a.u_id = b.id')
            ->field('a.*,b.phone,b.name,b.pen_name,b.unionid')
            ->where($where)
            ->limit($obj_page->firstRow, $obj_page->listRows)
            ->order('id desc')
            ->select();
        $this->assign('page',$page);
        $this->assign('count',$count);
        $this->assign('list',$list);
        return view();
    }

    /**
     * 新增私信
     */
    public function addLetter(){
        $id = input('get.id','');
        $keyword = input('get.keyword','');
        $where = '';
        if ($id){
            $where .= "id = '".$id."' AND  ";
        }
        if ($keyword){
            $where .= "phone like '%" . urldecode($keyword) . "%' OR ";
            $where .= "pen_name like '%" . urldecode($keyword) . "%' OR ";
            $where .= "name like '%" . urldecode($keyword) . "%' AND ";
        }
        $where .= '1 = 1';
        $count = Db::name('member')
            ->where($where)
            ->count();
        $obj_page = $this->_Page($count,20);
        $page = $obj_page->newshow();
        $user = Db::name('member')
            ->where($where)
            ->limit($obj_page->firstRow, $obj_page->listRows)
            ->order('id desc')
            ->select();
        $this->assign('count',$count);
        $this->assign('count',$count);
        $this->assign("page", $page);
        $this->assign('user',$user);
        return view();
    }

    public function editLetter(){
        $id = input('get.id');
        if ($_POST){
            $post = input('post.');
            $data = [
                'title' => $post['title'],
                'content' => $post['content'],
                'type' => 2, // 私信
                'create_time' => date('Y:m:d H:i:s')
            ];
            $res = Db::name('notice')->where('id',$post['id'])->update($data);
            if ($res){
                JsonDie(1, '保存成功', 'yes');
            }else{
                JsonDie(0, '保存失败', 'no');
            }
        }
        $data = Db::name('notice')
            ->alias('a')
            ->join('member b','a.u_id = b.id')
            ->field('a.*,b.phone,b.name,b.pen_name,b.unionid')
            ->where('a.id',$id)
            ->find();
        $this->assign('data',$data);
        return view();
    }

    public function edit(){
        $id = input('get.id');
        if ($_POST){
            $this->save();
        }
        $user = Db::name('member')
            ->where('id',$id)
            ->find();
        $this->assign('user',$user);
        return view();
    }

    public function save(){
        $post = input('post.');
        $data = [
            'u_id' => $post['u_id'],
            'title' => $post['title'],
            'content' => $post['content'],
            'type' => 2, // 私信
            'create_time' => date('Y:m:d H:i:s')
        ];
        $res = Db::name('notice')->insert($data);
        if ($res){
            JsonDie(1, '发送成功', 'yes');
        }else{
            JsonDie(0, '发送失败', 'no');
        }
    }

    public function del(){
        $id = input('get.id');
        $res = Db::name('notice')->where('id',$id)->delete();
        if ($res){
            JsonDie(1, '删除成功', 'yes');
        }else{
            JsonDie(0, '删除失败', 'no');
        }
    }

}
