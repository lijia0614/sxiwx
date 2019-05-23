<?php

/**
 * @空控制器
 * @author 四川挚梦科技有限公司 
 * @date 2018-03-20
 * @copyright Copyright (C) 2016-2017, ChengDu ZhiMengCMS Co., Ltd.
 */

namespace app\home\controller;

use think\App;
use think\Controller;
use think\Session;
use think\Request;
use think\Db;
use think\Model;
use think\Json;
use think\Config;
use think\Hook;

class Flow extends Common {

    public function __construct() {
        parent::__construct();
    }

    public function index(){
        $path = $_SERVER['HTTP_HOST']."/counter.txt";

        $fp = fopen($path, "r+");
        if(!file_exists($path)){
            $counter = 0;
            $cf = fopen($path,"w");  //打开文件
            fputs($cf,'0');                    //初始化计数器
            fclose($cf);                   //关闭文件
        }else{
            echo 2;
        }

    }

}
