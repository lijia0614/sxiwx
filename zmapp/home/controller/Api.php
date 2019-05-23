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


class Api extends Common {

    public function __construct() {
        parent::__construct();
    }

    public function clicks(){
		try {
			$id = input('request.id', 0, 'intval');
			$model = input('request.model', '', 'trim');
			if (!$id) {
				die('fail');
			}
			if (!$model) {
				die('fail');
			}
			$ary_res = db($model)->where(array('id' => $id))->setInc('click'); //自增1
			if (!$ary_res) {
				die('fail');
			}
			$count = db($model)->where(array('id' => $id))->value('click');//查询点击次数
			die("document.write('" . $count . "');");
		} catch (\Exception $e) {
           	die("fail");
        }
    }
	
	

}
