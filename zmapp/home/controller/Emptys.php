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

class Emptys extends Common {

    public function __construct() {
        parent::__construct();
    }

    /**
     * 空控制器下模拟方法  
     * @author 四川挚梦科技有限公司
     * @date 2017-01-09
     */
    public function _empty() {

        //判断别名下是否有模板文件

        $path = config("template.view_path") . strtolower(CONTROLLER) . "/" . strtolower(ACTION) . "." . config("template.view_suffix");
        if (file_exists($path)) {
            return view($path);
            exit;
        } else {
            die("<h2><span style='text-decoration:underline; color:red;'>" . strtolower(CONTROLLER) . "/" . strtolower(ACTION) . "." . config("template.view_suffix") . "</span> not found</h2>");
        }
    }

}
