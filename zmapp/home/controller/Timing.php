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


class Timing extends Common {

    public function __construct() {
        parent::__construct();
    }

    /**
     * 定时发布文章
     */
    public function index(){
        $time = time();
        $list = Db::name('chapter')
            ->where('status',0)
            ->where('pub',2)
            ->where('publish_time','<',$time)
            ->field('id,b_id,name,price,status,time,publish_time,pub')
            ->select();

        if ($list){
            $data = [
                'status' => 0,
                'pub' => 1
            ];
            foreach ($list as $k=>$v){
                Db::name('chapter')->where('id',$v['id'])->update($data);
            }
        }
    }



}
