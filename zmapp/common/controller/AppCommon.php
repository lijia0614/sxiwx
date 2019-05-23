<?php

namespace app\common\controller;

use think\Controller;
use think\facade\Config;
use think\facade\Request;
use think\Db;
use Pages\Page;


class AppCommon extends Controller {
    public function __construct() {
        parent::__construct();
		
		self::setSystemDefine(); //设置后台系统常量
        if (!file_exists(WEB_PATH . '/config/install.lock')) {
            header("location:/Install/");
            exit;
        }
    }
	
    /**
     * 获取当前访问的模块及控制器
     * @author 四川挚梦科技有限公司
     * @date 2048-03-17
     */
    static function setSystemDefine() {
        $module = Request::module();
        $controller = Request::controller();
        $action = Request::action();
		$version=config("version.version");
        define("MODULE", $module);
        define("CONTROLLER", $controller);
        define("ACTION", $action);
		define("DATA_PATH", WEB_PATH."/runtime/cache/");//数据缓存
		define("TEMP_PATH", WEB_PATH."/runtime/temp/");//模板编译缓存
		define("FIELD_PATH", WEB_PATH."/runtime/field/");//字段缓存地址
		define("HTML_PATH", WEB_PATH."/Html/");//html静态缓存地址
		define("LOG_PATH", WEB_PATH."/runtime/log/");//日志文件地址
		define("ZMCMS_VERSION","ZmCMS V".$version);
    }	
	
    /**
     * 分页
     * @author:四川挚梦科技有限公司
     * @date 2018-03-31
     */
    public function _Page($count, $pagesize) {
        $page = new Page($count, $pagesize);
        $page->setConfig("header", "条");
        $page->setConfig('theme', '<span>共%totalRow%%header%&nbsp;%nowPage%/%totalPage%页</span>&nbsp;%first%&nbsp;%upPage%&nbsp;%prePage%&nbsp;%linkPage%&nbsp;%nextPage%&nbsp;%downPage%&nbsp;%end%');
        return $page;
    }
		

}
