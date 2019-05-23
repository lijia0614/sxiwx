<?php

namespace app\home\controller;

use think\Controller;
use think\facade\Config;
use think\Db;
use think\facade\Env;
use think\facade\Validate;
use think\facade\Session;
use Upload\UploadFile;
use Payments\aliPay;
use Sms\aliyun;
use Excels\Excel;
use Oauths\qq;


class Library extends Common {

    public function __construct() {
        parent::__construct();
    }

    /**
     * 首页
     * @author 四川挚梦科技有限公司
     * @date 2018-04-05
     */
    public function library() {
        $user_id = $this->user_id;
        if ($user_id){
            $user = Db::name('member')->where('id',$user_id)->find();
            $this->assign('user',$user);
        }

        if($_POST){
            $this->getBook();
        }
        return view();
    }

    /**
     * 条件查询书籍
     */
	public function getBook(){
        $post = input('post.');
        $where = 'a.is_del = 0 AND ';
        if ($post['category'] != -1){
            $where .= " a.cid = ".$post['category']." AND ";
        }
        if ($post['words_num'] == '3w'){
            // 小于300000字
            $where .= "a.words_num < '300000' AND ";
        }
        if ($post['words_num'] == '5w'){
            // 30w-50w
            $where .= " a.words_num > '300000' AND ";
            $where .= " a.words_num < '500000' AND ";
        }
        if ($post['words_num'] == '10w'){
            // 50w-100w
            $where .= " a.words_num > '500000' AND ";
            $where .= " a.words_num < '1000000' AND ";
        }
        if ($post['words_num'] == '20w'){
            // 100w-200w
            $where .= " a.words_num > '1000000' AND ";
            $where .= " a.words_num < '2000000' AND ";
        }
        if ($post['words_num'] == '20s'){
            // 200w以上
            $where .= " a.words_num > '2000000' AND ";
        }
        if($post['status'] != -1){
            $where .= " a.is_end = ".$post['status']." AND ";
        }
        $where .= " a.status = 1";

        $data = Db::name('book')
            ->alias('a')
            ->join('book_category b','a.cid = b.id')
            ->where($where)
            ->order('a.clicks desc')
            ->field('a.id,a.name,a.words_num,a.author,a.info,a.image,a.is_end,b.name as c_name')
            ->select();

        foreach ($data as $k=>$v){
            if ($v['is_end'] == 1){
                $data[$k]['status'] = '完结';
            }else{
                $data[$k]['status'] = '连载';
            }
            if ($v['words_num'] > 9999){
                $number = round($v['words_num']/10000,2);
                $data[$k]['words_num'] = $number.'万';
            }
        }
        if ($data){
            return JsonDie(1,'success','yes',$data);
        }else{
            return JsonDie(0,'没有查询到相关数据','no');
        }
    }

    /**
     * 按点击量，总字数，更新时间查询
     */
    public function queryBook(){
        $post = input('post.');
        $where = 'a.is_del = 0 AND ';
        if ($post['category'] != -1){
            $where .= " a.cid = ".$post['category']." AND ";
        }
        if ($post['words_num'] == '3w'){
            // 小于300000字
            $where .= "a.words_num < '300000' AND ";
        }
        if ($post['words_num'] == '5w'){
            // 30w-50w
            $where .= " a.words_num > '300000' AND ";
            $where .= " a.words_num < '500000' AND ";
        }
        if ($post['words_num'] == '10w'){
            // 50w-100w
            $where .= " a.words_num > '500000' AND ";
            $where .= " a.words_num < '1000000' AND ";
        }
        if ($post['words_num'] == '20w'){
            // 100w-200w
            $where .= " a.words_num > '1000000' AND ";
            $where .= " a.words_num < '2000000' AND ";
        }
        if ($post['words_num'] == '20s'){
            // 200w以上
            $where .= " a.words_num > '2000000' AND ";
        }
        if($post['status'] != -1){
            $where .= " a.is_end = ".$post['status']." AND ";
        }
        $where .= " 1 = 1";
        if ($post['type'] == 001){
            $order = ['a.clicks'=>'desc'];
        }elseif ($post['type'] == 002){
            $order = ['a.words_num'=>'desc'];
        }elseif ($post['type'] == 003){
            $new_table = Db::name('chapter')
                ->alias('a')
                ->where(['a.status' => 1])
                ->order('a.time desc')
                ->field('id,name,time,b_id')
                ->buildSql();

            $news_chapter = Db::table($new_table.'AS temp')
                ->group('b_id')
                ->order('time desc')
                ->select();
            $info = [];
            foreach ($news_chapter as $k=>$v){
                $data = Db::name('book')
                    ->alias('a')
                    ->join('book_category b','a.cid = b.id')
                    ->where('a.id',$v['b_id'])
                    ->where($where)
                    ->where('a.status',1)
                    ->field('a.id,a.name,a.words_num,a.author,a.info,a.image,a.clicks,a.is_end,b.name as c_name')
                    ->find();
                if ($data['name']){
                    $info[] = $data;
                }
            }

            foreach ($info as $k=>$v){
                if ($v['is_end'] == 1){
                    $info[$k]['status'] = '完结';
                }else{
                    $info[$k]['status'] = '连载';
                }
                if ($v['words_num'] > 9999){
                    $number = round($v['words_num']/10000,2);
                    $info[$k]['words_num'] = $number.' 万';
                }
            }
            if ($info){
                return JsonDie(1,'success','yes',$info);
            }else{
                return JsonDie(0,'没有查询到相关数据','no','');
            }
        }

        $data = Db::name('book')
            ->alias('a')
            ->join('book_category b','a.cid = b.id')
            ->where($where)
            ->order($order)
            ->limit(50)
            ->field('a.id,a.name,a.words_num,a.author,a.info,a.image,a.clicks,a.is_end,b.name as c_name')
            ->select();

        foreach ($data as $k=>$v){
            if ($v['is_end'] == 1){
                $data[$k]['status'] = '完结';
            }else{
                $data[$k]['status'] = '连载';
            }
            if ($v['words_num'] > 9999) {
                $number = round($v['words_num'] / 10000, 2);
                $data[$k]['words_num'] = $number . ' 万';
            }
        }
        if ($data){
            return JsonDie(1,'success','yes',$data);
        }else{
            return JsonDie(0,'没有查询到相关数据','no','');
        }
    }

}
