<?php

/**
 * @空控制器
 * @author 四川挚梦科技有限公司 
 * @date 2018-03-20
 * @copyright Copyright (C) 2016-2017, ChengDu ZhiMengCMS Co., Ltd.
 */

namespace app\home\controller;

use think\Controller;
use think\Session;
use think\Request;
use think\Db;
use think\Model;
use think\Json;
use think\Config;
use think\Hook;

class About extends Common {

    public function __construct() {
        parent::__construct();
    }

    public function about(){
        $user_id = $this->user_id;
        $user = Db::name('member')->where('id',$user_id)->find();
        $this->assign('user',$user);
        return view();
    }

}
