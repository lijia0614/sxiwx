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
use app\admin\model\RoleNav;
use app\admin\model\OperationLog;
use app\admin\model\Config as ConfigModel;

class Setting extends Common {
	
    public function __construct() {
        parent::__construct();
        $this->modelFields(); //获取模型字段
    }	

    public function index() {
		$act=input("request.act",'index','trim');
		if($_POST){
			if($act=='customize'){
				$this->doCustomize();
				exit;	
			}
			if($act=='index'){
				$this->doSaveWebsite();
				exit;
			}
			if($act=='sysPath'){
				$this->doSaveSysPath();
				exit;	
			}
		}
        $config = model('config'); //实例化模型
        $webConfig = $config->getCfgByModule('WEB_SITE');
        $config = json_decode($webConfig['WEB_SITE'], true);
        $this->assign("config", $config);
		$this->assign("act", $act);
		$this->getCustomize();//获取自定义站点信息
        return view($act);
    }
	


    /**
     * 保存全局设置 
     * @author 四川挚梦科技有限公司 
     * @date 2017-01-12
     */
    public function doSaveWebsite() {
        try {
            if ($_POST) {
                $data = input("request.");
				unset($data['act']);
				unset($data['s']);
				unset($data['random']);
                if (str_replace("\r\n", "", $data['request_cache_except']) == '') {
                    $data['request_cache_except'] = '';
                }
                $value = json_encode($data);
                $result = model("Config")->setConfig('WEB_SITE', $value, '站点全局设置');
                if ($result) {
					cache('WEBSITE', null);//更改了配置清空缓存
                    JsonDie("1", "保存成功", "yes");
                } else {
                    JsonDie("0", "保存失败", "no");
                }
            }
        } catch (\Exception $e) {
            JsonDie(0, '操作失败' . $e, 'no');
        }
    }
    /**
     * 保存自定义全局信息
     * @author 四川挚梦科技有限公司
     * @date 2018-05-01
     */
	public function doCustomize(){
        try {
            if ($_POST) {
                $data = input("request.");
				unset($data['act']);
				unset($data['s']);
				unset($data['random']);
                $value = json_encode($data);
                $result = model("Config")->setConfig('CUSTOMIZE_SITE', $value, '自定义站点设置');
                if ($result) {
					cache('CUSTOMIZE_SITE', null);//更改了配置清空缓存
                    JsonDie("1", "保存成功", "yes");
                } else {
                    JsonDie("0", "保存失败", "no");
                }
            }
        } catch (\Exception $e) {
            JsonDie(0, '操作失败' . $e, 'no');
        }
	}
	
	
   /**
     * 获取自定义站点信息 
     * @author 四川挚梦科技有限公司 
     * @date 2018-05-01
     */
	public function getCustomize(){
        $c = model('config')->getCfgByModule('CUSTOMIZE_SITE');
        $config = json_decode($c['CUSTOMIZE_SITE'], true);
        $this->assign("data", $config);
	}
	
    /**
     * 设置后台入口别名 
     * @author 四川挚梦科技有限公司 
     * @date 2018-05-01
     */
	public function doSaveSysPath(){
		$sysPath=input("request.sysPath",0);
		if(!$sysPath){
			JsonDie("0", "保存失败", "no");
		}
		if(!preg_match("/^[a-z\d]*$/i",$sysPath)){
			JsonDie("0", "只能是字母和数字组合", "no");
		}
		if(strtolower($sysPath)=='admin'){
			JsonDie("0", "系统默认禁止admin模块,请换个名字", "no");
		}		
        $config = array(
            'adminPath' => $sysPath,
        );
        @file_put_contents(WEB_PATH . "/config/admin.php", ("<?php\t\nreturn " . var_export($config, true) . ";\n?>"));
		$this->setRoute($sysPath);//设置路由
        JsonDie("1", "保存成功", "no",array("adminPath"=>$sysPath));
	}	
	
	
    /**
     * 设置后台别名路由 
     * @author 四川挚梦科技有限公司 
     * @date 2018-05-01
     */
	
	public function setRoute($sysPath){
		$str="Route::rule('admin', function(){return '404 not found!';});\r\n";
		$str.="Route::rule('".$sysPath."/:c/:a', 'admin/:c/:a');\r\n";
		$str.="Route::rule('".$sysPath."', 'admin/index/index');\r\n";	
		@file_put_contents(WEB_PATH . "/route/admin.php","<?php\t\n ".$str."\r\n?>");
	}	


    /**
     * 验证码列表
     * @author 四川挚梦科技有限公司
     * @date 2017-01-12
     */
    public function codeset() {
        $ConfigModel=new ConfigModel();
        $listData=$ConfigModel->getCodeSet();
        $this->assign("listData",$listData);
        return view();
    }
    /**
     * 保存验证码设置
     * @author 四川挚梦科技有限公司
     * @date 2018-04-24
     */
    public function code_edit(){
        $c_key=input("request.c_key",0,"trim");
        try {
            if ($_POST) {
                $postdata = input("request.");
                $savedata = input("request.");
                unset($savedata['dialogid']);
                unset($savedata['dosubmit']);
                $value = json_encode($savedata);
                $result = model("Config")->setConfig($c_key, $value, '','codeset',$postdata['status']);
                if ($result) {
                    cache("MEMBER_CODE",$savedata);
                    JsonDie("1", "保存成功", "yes");
                } else {
                    JsonDie("0", "保存失败", "no");
                }
            }
        } catch (\Exception $e) {
            JsonDie(0, '操作失败' . $e, 'no');
        }
        if($c_key){
            $config = model('config')->getCfgByModule($c_key);
            $c_value = json_decode($config[$c_key], true);
            $this->assign("data", $c_value);
        }
        return view();

    }

    /**
     * 验证码状态改变
     * @author四川挚梦科技有限公司
     * @date 2018-04-21
     */
    public function code_dostatus(){
        try{
            $id=input("request.id",0,"intval");
            $value=input("request.value",0,"intval");
            if(!$id){JsonDie('0',"参数错误",'yes');	}

            $config = model("config")->find($id);
            $data = json_decode($config['c_value'], true);
            if($value==0){
                $data['status']=1;
                $savedata['status']=1;
            }else{
                $data['status']=0;
                $savedata['status']=0;
            }
            $savedata['c_value']=json_encode($data);
            $ary_result=db('config')->where(array("id" => $id))->data($savedata)->update();
            if($ary_result){
                cache("MEMBER_CODE",$data);
                JsonDie('1',"操作成功",'yes');
            }else{
                JsonDie('0',"操作失败",'no');
            }
        }catch (\Exception $e) {
            JsonDie(0,'操作失败'.$e,'no');
        }
    }


	
    /**
     * 上传图片设置列表
     * @author 四川挚梦科技有限公司 
     * @date 2017-01-12
     */
    public function imgset() {
		$ConfigModel=new ConfigModel();
		$listData=$ConfigModel->getImgSet();
		$this->assign("listData",$listData);
		return view();
    }


	
	public function imgset_edit(){
		$c_key=input("request.c_key",0,"trim");
        try {
            if ($_POST) {
                $postdata = input("request.");
				$savedata = input("request.");
				unset($savedata['dialogid']);
				unset($savedata['dosubmit']);
                $value = json_encode($savedata);
				$c_key="IMG_".strtoupper($savedata['module'])."_".strtoupper($savedata['action']);
                $result = model("Config")->setConfig($c_key, $value, $savedata['title'],'imgset',$postdata['status']);
                if ($result) {
                    JsonDie("1", "保存成功", "yes");
                } else {
                    JsonDie("0", "保存失败", "no");
                }
            }
        } catch (\Exception $e) {
            JsonDie(0, '操作失败' . $e, 'no');
        }
		if($c_key){
			$config = model('config')->getCfgByModule($c_key);
			$c_value = json_decode($config[$c_key], true);
			$this->assign("data", $c_value);		
		}
		return view();
	}
    /**
     * 删除图片设置 
     * @author 四川挚梦科技有限公司 
     * @date 2017-01-12
     */
	public function imgsetDelete(){
        try{
            $c_key = input("request.c_key",0,"trim");
            if (isset($c_key)) {
                $ary_result=db("config")->where("c_key",$c_key)->delete();
                if (FALSE !== $ary_result) {
                    JsonDie(1,'操作成功','no');
                } else {
                    JsonDie(0,'操作失败','no');
                }
            } else {
                JsonDie(0,'参数错误','no');
            }
        }catch (\Exception $e) {
            JsonDie(0,'操作失败'.$e,'no');
        }
	}
	
    /**
     * 更新图片设置状态
     * @author四川挚梦科技有限公司
     * @date 2018-04-21
     */
    public function imgset_dostatus(){
        try{
            $id=input("request.id",0,"intval");
            $value=input("request.value",0,"intval");
            if(!$id){JsonDie('0',"参数错误",'yes');	}

        	$config = model("config")->find($id);
        	$data = json_decode($config['c_value'], true);
            if($value==0){
                $data['status']=1;
				$savedata['status']=1;
            }else{
                $data['status']=0;
				$savedata['status']=0;
            }
			$savedata['c_value']=json_encode($data);	
            $ary_result=db('config')->where(array("id" => $id))->data($savedata)->update();
            if($ary_result){
                JsonDie('1',"操作成功",'yes');
            }else{
                JsonDie('0',"操作失败",'no');
            }
        }catch (\Exception $e) {
            JsonDie(0,'操作失败'.$e,'no');
        }
    }	




    public function staticCache() {
        if ($_POST) {
            $request = input("request.");
            $CACHE_NO_GROUP = explode("\r\n", strtolower($request['CACHE_NO_GROUP']));
            $CACHE_NO_MODULE = explode("\r\n", strtolower($request['CACHE_NO_MODULE']));
            $CACHE_NO_ACTION = explode("\r\n", strtolower($request['CACHE_NO_ACTION']));
            if (!in_array("admin", $CACHE_NO_GROUP)) {
                $CACHE_NO_GROUP[] = "admin";
            }
            if (!in_array("member", $CACHE_NO_GROUP)) {
                $CACHE_NO_GROUP[] = "member";
				$CACHE_NO_GROUP[] = "wxapp";
            }
            if (!in_array("/home/ajax/", $CACHE_NO_MODULE)) {
                $CACHE_NO_MODULE[] = "/home/ajax/";
            }
            if (!in_array("/home/login/", $CACHE_NO_MODULE)) {
                $CACHE_NO_MODULE[] = "/home/login/";
            }
            $data = array(
                'CACHE_ON' => $request['CACHE_ON'],
				'CACHE_RULES' => array('*'=>array('{$_SERVER.REQUEST_URI|md5}')),//缓存规则
                'CACHE_TIME' => $request['CACHE_TIME'],
                'CACHE_NO_GROUP' => $CACHE_NO_GROUP,
                'CACHE_NO_MODULE' => $CACHE_NO_MODULE,
                'CACHE_NO_ACTION' => $CACHE_NO_ACTION
            );
            $value = json_encode($data);
            $result = model("Config")->setConfig('STATIC_CACHE', $value, '静态缓存配置');
            if ($result) {
                $this->writeCacheConfig($data);//写入配置文件
            }
            JsonDie("1", "保存成功", "yes");
        }
        $webConfig = model("Config")->getCfgByModule('STATIC_CACHE');
        $config = json_decode($webConfig['STATIC_CACHE'], true);
        $config['CACHE_NO_GROUP'] = implode("\r\n", $config['CACHE_NO_GROUP']);
        $config['CACHE_NO_MODULE'] = implode("\r\n", $config['CACHE_NO_MODULE']);
        $config['CACHE_NO_ACTION'] = implode("\r\n", $config['CACHE_NO_ACTION']);
        $this->assign("config", $config);
        return view();
    }

    /**
     * 缓存管理
     * @author billow.wang<admin@zhi-meng.cn>
     * @date 2016-12-13
     */
    public function cache() {
        $type = input('request.type');
        if (isset($type)) {
            $this->clear();
            exit;
        }
        return view();
    }

    /**
     * 清理数据缓存
     * @author billow.wang<admin@zhi-meng.cn>
     * @date 2017-09-30
     */
    public function ClearDataCache() {
        $obj_dir = new Dir(WEB_PATH);
        if (is_dir(CACHE_PATH)) {
            $obj_dir->delDir(CACHE_PATH);
        }
    }

    /**
     * 根据选择清理数据缓存
     * @author billow.wang<admin@zhi-meng.cn>
     * @date 2017-09-30
     */
    public function clear() {
        $type = input('request.type');
        $obj_dir = new Dir(WEB_PATH);
        switch ($type) {
            case 'field':
                is_dir(FIELD_PATH) && $obj_dir->del(FIELD_PATH);
                break;
            case 'tpl':
                is_dir(TEMP_PATH) && $obj_dir->del(TEMP_PATH);
                is_dir(TEMP_PATH) && $obj_dir->delDir(TEMP_PATH);
                break;
            case 'data':
                is_dir(DATA_PATH) && $obj_dir->del(DATA_PATH);
                is_dir(DATA_PATH) && $obj_dir->delDir(DATA_PATH);
                break;
            case 'html':
                is_dir(HTML_PATH) && $obj_dir->del(HTML_PATH);
                is_dir(HTML_PATH) && $obj_dir->delDir(HTML_PATH);
                break;
            case 'logs':
                is_dir(LOG_PATH) && $obj_dir->delDir(LOG_PATH);
                break;
        }
        die(json_encode(array('status' => 1)));
    }
	
    /**
     * 静态缓存配置写入缓存配置文件 
     * @author 四川挚梦科技有限公司 
     * @date 2018-04-06
     */
    public function writeCacheConfig($data) {
        $CacheConfig = array(
            'CACHE_ON' => $data['CACHE_ON'], // 开启静态缓存
			'CACHE_RULES'=>$data['CACHE_RULES'],//缓存规则
            'CACHE_TIME' => $data['CACHE_TIME'], // 全局静态缓存有效期（秒）
            'CACHE_NO' => array('module' => $data['CACHE_NO_GROUP'],
           						'controller' => $data['CACHE_NO_MODULE'], 
            					'action' => $data['CACHE_NO_ACTION']
            					)
        );
        @file_put_contents(WEB_PATH . "/config/filecache.php", ("<?php\t\nreturn " . var_export($CacheConfig, true) . ";\n?>"));
        return true;
    }
	


}
