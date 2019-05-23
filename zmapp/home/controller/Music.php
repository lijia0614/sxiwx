<?php
/**
 * Created by PhpStorm.
 * User: 李贾
 * Date: 2019/3/7
 * Time: 15:07
 */

namespace app\home\controller;


use getid3\getID3;
use think\Db;

class Music extends Common
{
    public function __construct() {
        parent::__construct();
    }

    public function index(){
        $user_id = $this->user_id;
        if ($user_id){
            $user = Db::name('member')->where('id',$user_id)->find();
            $this->assign('user',$user);
        }
        $this->assign('music',1);

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
            ->field('a.*,b.title as lang,c.title as type,d.title as feel')
            ->select();

        $this->assign('list',$list);
        $this->assign('page',$page);
        return view();
    }

    public function getMusic(){
        $post = input('post.');
        $where = '';
        if ($post['lang'] != 0){
            $where .= 'b.id ='.$post['lang'].' and ';
        }
        if ($post['type'] != 0){
            $where .= 'c.id ='.$post['type'].' and ';
        }
        if ($post['feel'] != 0){
            $where .= 'd.id ='.$post['feel'].' and ';
        }
        $order = 'sort asc,id asc';
        if ($post['sort'] == 1){
            $order = 'id desc';
        }
        if ($post['sort'] == 2){
            $order = 'click desc';
        }
        $where .= ' a.status = 1';
        $list = Db::name('music')
            ->alias('a')
            ->join('lang b','a.lang = b.id')
            ->join('type c','a.type = c.id')
            ->join('feel d','a.feel = d.id')
            ->where($where)
            ->order($order)
            ->field('a.*,b.title as lang,c.title as type,d.title as feel')
            ->select();
        if ($list){
            return JsonDie(1,'success','yes',$list);
        }else{
            return JsonDie(0,'没有查询到相关数据','no');
        }
    }

    public function updateClick(){
        $id = input('post.id');
        $c = Db::name('music')->where('id',$id)->field('click')->find();
        $where = [
            'click' => $c['click'] + 1
        ];
        Db::name('music')->where('id',$id)->update($where);
    }

}