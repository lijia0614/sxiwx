<?php

namespace app\admin\controller;

use think\Controller;
use think\facade\Config;
use think\facade\Request;
use think\facade\Session;
use think\Db;
use Auths\Auth;
use Pages\Page;
use Dir\Dir;
use app\common\controller\AppCommon;

class Template extends Common {

    public function __construct() {
        parent::__construct();
    }

    /**
     * 模板风格设置
     * @author 四川挚梦科技有限公司
     * @date 2018-04-07
     */
    public function index() {
        if ($_POST) {
            $this->doSave();
            exit;
        }
		$this->getPcTheme();//PC端模板目录
		$this->getMobileTheme();//移动端模板目录
		$this->getMembersTheme();//用户端模板目录
 		$config = model('config'); //实例化模型
        $webConfig = $config->getCfgByModule('TEMPLATE_CONFIG');
        $config = json_decode($webConfig['TEMPLATE_CONFIG'], true);
        $this->assign("config", $config);	
        return view();
    }	
     

    /**
     * 模板风格设置 
     * @author 四川挚梦科技有限公司 
     * @date 2018-04-07
     */
    public function doSave() {
        try {
            if ($_POST) {
                $data = input("request.");
                $value = json_encode($data);
                $result = model("Config")->setConfig('TEMPLATE_CONFIG', $value, '模板设置');
                if ($result) {
					cache('TEMPLATE_CONFIG', null);//更改了配置清空缓存
                    JsonDie("1", "保存成功", "yes");
                } else {
                    JsonDie("0", "保存失败", "no");
                }
            }
        } catch (\Exception $e) {
            JsonDie(0, '操作失败' . $e, 'no');
        }
    }
	
    /* 获取模板主题列表 */

    public function getPcTheme() {
        $dir = WEB_PATH . "/theme/Home/";
        $child_dirs = $this->getDir($dir);
        $this->assign("pcThemes", $child_dirs);
    }

    /* 获取移动端模板主题列表 */

    public function getMobileTheme() {
        $dir = WEB_PATH . "/theme/Mobile/";
        $child_dirs = $this->getDir($dir);
        $this->assign("mobileThemes", $child_dirs);
    }
	
    /* 获取会员中心主题列表 */

    public function getMembersTheme() {
        $dir = WEB_PATH . "/theme/Members/";
        $child_dirs = $this->getDir($dir);
        $this->assign("membersThemes", $child_dirs);
    }	

    //获取目录列表
    public function getDir($dir) {
        $dirArray[] = NULL;
        if (false != ($handle = opendir($dir))) {
            $i = 0;
            while (false !== ($file = readdir($handle))) {
                if ($file != "." && $file != ".." && !strpos($file, ".")) {//去掉"“.”、“..”以及带“.xxx”后缀的文件
                    $dirArray[$i] = $file;
                    $i++;
                }
            }
            closedir($handle); //关闭句柄
        }
        return $dirArray;
    }	
	
}
