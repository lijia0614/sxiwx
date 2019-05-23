<?php

namespace app\home\behavior;

/**
 * 系统行为扩展：访问PC端域名时，PC端检测是否使用移动设备访问，如果是则跳转到移动端域名
 */
class CheckPc {

    protected static $actionName;
    protected static $controllerName;
    protected static $moduleName;
    protected $storage;

    // 行为扩展的执行入口必须是run
    public function run() {
        if (is_mobile_request() && config("mobile_domain")) {
            header("Location: " . config("mobile_domain"));
            exit;
        }
    }

}
