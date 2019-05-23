<?php


namespace app\home\controller;

use think\Controller;
use think\Session;
use think\Request;
use think\Db;
use think\Model;
use think\Json;
use think\Config;
use think\Hook;

class Search extends Common {

    public function __construct() {
        parent::__construct();
    }


    public function index(){
        $user_id = $this->user_id;
        $user = Db::name('member')->where('id',$user_id)->find();
        $this->assign('user',$user);
        $keywords = input('get.keywords');
        $where = '';
        if (!empty($keywords)) {
            $where .= "a.name like '%" . urldecode($keywords) . "%' AND ";
        }
        $where .= "a.is_del=0 AND ";
        $where .= "a.status=1";
        $book = Db::name('book')
            ->alias('a')
//            ->join('book_category b','b.id = a.cid')
            ->field('a.name,a.info,a.id,a.author,a.is_end,a.words_num,a.image')
            ->where($where)
            ->select();
//        c_print($book);
        $count = count($book);
        $this->assign('count',$count);
        $this->assign('book',$book);
        $this->assign('keywords',$keywords);
        return view();
    }


    public function mIndex(){
        $user_id = $this->user_id;
        $user = Db::name('member')->where('id',$user_id)->find();
        $this->assign('user',$user);
        $keywords = input('get.keywords');
        $where = '';
        if (!empty($keywords)) {
            $where .= "a.name like '%" . urldecode($keywords) . "%' AND ";
        }
        $where .= "a.is_del=0 AND ";
        $where .= "a.status=1";
        $book = Db::name('book')
            ->alias('a')
            ->join('book_category b','b.id = a.cid')
            ->field('b.name as c_name,a.name,a.info,a.id,a.author,a.is_end,a.words_num,a.image')
            ->where($where)
            ->select();
        $count = count($book);
        $this->assign('count',$count);
        $this->assign('book',$book);
        $this->assign('keywords',$keywords);
        return view();
    }

    public function mSearch(){
        return view();
    }
}
