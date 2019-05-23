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


class Anime extends Common {

    public function __construct() {
        parent::__construct();
        $user_id = $this->user_id;
        if ($user_id){
            $user = Db::name('member')->where('id',$user_id)->find();
            $this->assign('user',$user);
        }
    }

    /**
     * 首页
     * @author 四川挚梦科技有限公司
     * @date 2018-04-05
     */
    public function anime() {
        if ($_POST){
            $post = input('post.');
            $where = 'status = 1 AND ';
            if ($post['cid'] != -1){
                $where .= " cid = ".$post['cid']." AND ";
            }
            $where .= "1=1";
            $data = Db::name('poetry')->where($where)->select();
            if ($data){
                return JsonDie(1,'success','yes',$data);
            }else{
                return JsonDie(0,'没有查询到相关数据','no');
            }
        }
        return view();
    }

    public function seAnime(){
        if ($_POST){
            $post = input('post.');
            $where = 'status = 1 AND ';
            if ($post['cid'] != -1){
                $where .= " cid = ".$post['cid']." AND ";
            }
            $where .= "1=1";
            if ($post['type'] == 001){
                $order = ['click'=>'desc'];
            }elseif ($post['type'] == 002){
                $order = ['create_time'=>'desc'];
            }else{
                $order = ['click'=>'desc'];
            }
            $data = Db::name('poetry')->where($where)->order($order)->select();
            if ($data){
                return JsonDie(1,'success','yes',$data);
            }else{
                return JsonDie(0,'没有查询到相关数据','no');
            }
        }
    }

    public function anime_show() {
        $id = input('get.id');
        $old = Db::name('poetry')->where('id',$id)->find();
        if ($old){
            $clcik = [
                'click' => $old['click']+1
            ];
            Db::name('poetry')->where('id',$id)->update($clcik);
        }
        $data = Db::name('poetry')->where('id',$id)->find();
        $this->assign('data',$data);
        return view();
    }
}







