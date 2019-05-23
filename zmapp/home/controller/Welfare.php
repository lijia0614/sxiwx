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


class Welfare extends Common {

    public function __construct() {
        parent::__construct();
        $user = Db::name('member')->where('id',$this->user_id)->find();
        $this->assign('user',$user);
    }

    /**
     * 首页
     */
    public function welfare() {

        return view();
    }

}
