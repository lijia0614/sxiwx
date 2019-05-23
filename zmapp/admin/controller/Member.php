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

class Member extends Common
{

    public function __construct()
    {
        parent::__construct();
        $modules = $this->getModule(CONTROLLER); //获取模型配置 
        $this->assign("modules", $modules);
        $this->modelFields($modules['table']);
    }


    /**
     * 所有用户列表
     */
    public function all()
    {
        $start_date = input("get.start_date", '');
        $end_date = input("get.end_date", '');
        $keyword = input("get.keyword", '');
        $where = '';
        if (!empty($start_date) && empty($end_date)){
            $where .= "time > '".$start_date."' AND ";
        }elseif(!empty($end_date) && empty($start_date)){
            $where .= "time < '".$end_date."' AND ";
        }elseif (!empty($start_date) && !empty($end_date)){
            $where .= "time > '".$start_date."' AND ";
            $where .= "time < '".$end_date."' AND ";
        }
        if (!empty($keyword)) {
            $where .= "phone like '%" . urldecode($keyword) . "%' OR ";
            $where .= "name like '%" . urldecode($keyword) . "%' AND ";
        }
        $where .= ' 1=1';
        $count = Db::name('member')
            ->where($where)
            ->count();

        $obj_page = $this->_Page($count,20);
        $page = $obj_page->newshow();
        $list = Db::name('member')
            ->where($where)
            ->limit($obj_page->firstRow, $obj_page->listRows)
            ->order('id desc')
            ->select();
        $this->assign('count',$count);
        $this->assign("page", $page);
        $this->assign('list',$list);
        return view();
    }

    /**
     * 普通用户列表
     */
    public function index()
    {
        $start_date = input("get.start_date", '');
        $end_date = input("get.end_date", '');
        $keyword = input("get.keyword", '');
        $where = '';
        if (!empty($start_date) && empty($end_date)){
            $where .= "time > '".$start_date."' AND ";
        }elseif(!empty($end_date) && empty($start_date)){
            $where .= "time < '".$end_date."' AND ";
        }elseif (!empty($start_date) && !empty($end_date)){
            $where .= "time > '".$start_date."' AND ";
            $where .= "time < '".$end_date."' AND ";
        }
        if (!empty($keyword)) {
            $where .= "phone like '%" . urldecode($keyword) . "%' OR ";
            $where .= "name like '%" . urldecode($keyword) . "%' AND ";
        }
        $where .= ' is_author=0';
        $count = Db::name('member')
            ->where($where)
            ->count();

        $obj_page = $this->_Page($count,20);
        $page = $obj_page->newshow();
        $list = Db::name('member')
            ->where($where)
            ->limit($obj_page->firstRow, $obj_page->listRows)
            ->order('id desc')
            ->select();

        $this->assign('count',$count);
        $this->assign("page", $page);
        $this->assign('list',$list);
        return view();
    }

    public function addLetter(){
        $id = input('get.id');
        $user = Db::name('member')->where('id',$id)->field('phone,id')->find();
        if ($user['phone']){
            $name = $user['phone'];
        }else{
            $name = '编号为'.$user['id'].'用户';
        }
        $this->assign('name',$name);
        $this->assign('id',$user['id']);
        return view();
    }

    public function toLetter(){
        $post = input('post.');
        $data = [
            'u_id' => $post['id'],
            'type' => 2,
            'title' => $post['title'],
            'content' => $post['content'],
            'create_time' => date('Y-m-d H:i:s',time())
        ];
        $res = Db::name('notice')->insert($data);
        if ($res){
            JsonDie(1, '操作成功', 'yes');
        }else{
            JsonDie(0, '操作失败', 'no');
        }
    }

    /**
     * 作者用户
     */
    public function author(){
        $start_date = input("get.start_date", '');
        $end_date = input("get.end_date", '');
        $keyword = input("get.keyword", '');
        $where = '';
        if (!empty($start_date) && empty($end_date)){
            $where .= "time > '".$start_date."' AND ";
        }elseif(!empty($end_date) && empty($start_date)){
            $where .= "time < '".$end_date."' AND ";
        }elseif (!empty($start_date) && !empty($end_date)){
            $where .= "time > '".$start_date."' AND ";
            $where .= "time < '".$end_date."' AND ";
        }
        if (!empty($keyword)) {
            $where .= "phone like '%" . urldecode($keyword) . "%' OR ";
            $where .= "name like '%" . urldecode($keyword) . "%' AND ";
        }
        $where .= ' is_author=1';
        $count = Db::name('member')
            ->where($where)
            ->count();
        $obj_page = $this->_Page($count,20);
        $page = $obj_page->newshow();
        $list = Db::name('member')
            ->where($where)
            ->limit($obj_page->firstRow, $obj_page->listRows)
            ->order('id desc')
            ->select();

        $this->assign('count',$count);
        $this->assign("page", $page);
        $this->assign('list',$list);
        return view();
    }

    /**
     * 用户详情
     */
    public function edit(){
        $id = input('get.id');
        $data = Db::name('member')->where('id',$id)->find();
        if ($_POST){
            $this->toEdit();
        }
        $this->assign('data',$data);
        return view();
    }

    /**
     * 编辑用户
     */
    public function toEdit(){
        $post = input('post.');
        $data = [
            'name' => $post['name'],
            'pen_name' => $post['pen_name'],
            'money' => $post['money'],
            'qq' => $post['qq'],
            'wechat' => $post['wechat'],
            'id_num' => $post['id_num'],
            'address' => $post['address']
        ];
        $res = Db::name('member')
            ->where('id',$post['id'])
            ->update($data);
        if ($res){
            JsonDie(1, '操作成功', 'yes');
        }else{
            JsonDie(0, '操作失败', 'no');
        }
    }

    /**
     * 删除用户
     */
    public function del(){
        $id = input('get.id');
        $res = Db::name('member')
            ->where('id',$id)
            ->delete();
        if ($res){
            JsonDie(1, '操作成功', 'yes');
        }else{
            JsonDie(0, '操作失败', 'no');
        }
    }

    /**
     * 用户留言
     */
    public function message(){
        $start_date = input("get.start_date", '');
        $end_date = input("get.end_date", '');
        $keyword = input("get.keyword", '');
        $where = '';
        if (!empty($start_date) && empty($end_date)){
            $where .= "a.time > '".strtotime($start_date)."' AND ";
        }elseif(!empty($end_date) && empty($start_date)){
            $where .= "a.time < '".strtotime($end_date)."' AND ";
        }elseif (!empty($start_date) && !empty($end_date)){
            $where .= "a.time > '".strtotime($start_date)."' AND ";
            $where .= "a.time < '".strtotime($end_date)."' AND ";
        }
        if (!empty($keyword)) {
            $where .= "b.phone like '%" . urldecode($keyword) . "%' OR ";
            $where .= "c.name like '%" . urldecode($keyword) . "%' AND ";
        }
        $where .= ' 1=1';

        $count = Db::name('message')
            ->alias('a')
            ->join('member b','a.u_id = b.id')
            ->join('book c','c.id = a.b_id')
            ->field('a.id')
            ->count();

        $obj_page = $this->_Page($count,20);
        $page = $obj_page->newshow();
        $list = Db::name('message')
            ->alias('a')
            ->join('member b','a.u_id = b.id')
            ->join('book c','c.id = a.b_id')
            ->where($where)
            ->field('a.*,b.phone,b.pen_name,b.unionid,c.name as b_name')
            ->limit($obj_page->firstRow, $obj_page->listRows)
            ->order('a.time desc')
            ->select();
        $this->assign('list',$list);
        $this->assign('count',$count);
        $this->assign("page", $page);
        return view();
    }

    /**
     * 编辑留言
     */
    public function msgEdit(){
        $id = input('get.id');
        if ($_POST){
            $post = input('post.');
            $data = [
                'content' => $post['content']
            ];
            $res = Db::name('message')->where('id',$post['id'])->update($data);
            if ($res){
                JsonDie(1, '操作成功', 'yes');
            }else{
                JsonDie(0, '操作失败', 'no');
            }
        }
        $data = Db::name('message')
            ->alias('a')
            ->join('member b','a.u_id = b.id')
            ->join('book c','c.id = a.b_id')
            ->field('a.*,b.phone,b.pen_name,b.unionid,c.name as book')
            ->where('a.id',$id)
            ->find();

        $this->assign('data',$data);
        return view();
    }

    /**
     * 删除留言
     */
    public function delMsg(){
        $id = input('get.id');
        $res = Db::name('message')->where('id',$id)->delete();
        if ($res){
            JsonDie(1, '删除成功', 'yes');
        }else{
            JsonDie(0, '删除失败', 'no');
        }
    }
}
