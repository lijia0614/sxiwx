<?php

namespace app\admin\controller;

use think\Controller;
use think\facade\Config;
use think\facade\Request;
use think\facade\Session;
use think\Db;
use Pages\Page;
use Dir\Dir;
use PhpZip\PhpZip;

class update extends Controller {

    public $updateStatus = false; //更新状态
	public $errormsg="";

    public function __construct() {
        parent::__construct();
        $this->doCheckLogin();
    }

	
    /**
     * 系统授权检测
     * @author 四川挚梦科技有限公司
     * @date 2018-04-29
     */	
	public function versionCheck(){
		$result=$this->getOauthStatus();//获取授权状态
        if (!$result) {
                JsonDie(0,$this->errormsg, 'no');
        }
		JsonDie(1, "已授权", 'no');
	}	
	
	
	/*
		检测授权状态
	*/
	public function getOauthStatus(){
		$hosturl = urlencode('http://' . $_SERVER['HTTP_HOST'] . $_SERVER['PHP_SELF']);
        $chkUrl = 'http://auth.zhi-meng.cn/api/version/client_check.html';//检测url
		$v=config("version.version");
		$ip = gethostbyname($_SERVER['SERVER_NAME']);//本机服务器ip地址
		
		$code=input("request.code",0);
		if(!$code){
			$code=config("oauth.code");
		}
        $url = $chkUrl . '?ip=' . $ip . '&url=' . $hosturl . '&v=' . $v . '&code=' . $code;
		$c = @file_get_contents($url); //获取更新的包名
        $info = json_decode($c, true);	
		if($info['status']==0){
			$this->errormsg=$info['msg'];
			return false;	
		}	
		return true;
	}
	
	
    /**
     * 保存授权码
     * @author:四川挚梦科技有限公司
     * @date 2018-04-29
     */
    public function authCodeSave() {
		$result=$this->getOauthStatus();//获取授权状态
		if($result){
			$code=input("request.code",0);
			$data['code']=$code;
			@file_put_contents(WEB_PATH . "/config/oauth.php", ("<?php\t\nreturn " . var_export($data, true) . ";\n?>"));			
			JsonDie(1, '系统授权成功', 'no');
			
		}
		JsonDie(0, $this->errormsg, 'no');
		
    }

    /**
     * 更新系统
     * @author:四川挚梦科技有限公司
     * @date 2018-04-29
     */
    public function updateSystem() {
        try {
            $version = config("version.");
            $code = config("oauth.code");
            $ver = $version['version'];
            $hosturl = urlencode('http://' . $_SERVER['HTTP_HOST'] . $_SERVER['PHP_SELF']);
            $updatehost = 'http://auth.zhi-meng.cn/api/Version/update.html';
            $ip = gethostbyname($_SERVER['SERVER_NAME']);
            $updatehosturl = $updatehost . '?ip=' . $ip . '&url=' . $hosturl . '&v=' . $ver . '&code=' . $code;

            $update_info = @file_get_contents($updatehosturl); //获取更新的包名
            $file_info = json_decode($update_info, true);
            if (isset($file_info['status']) && $file_info['status'] == 0) {
                JsonDie(0, $file_info['msg'], 'no');
            }
            if (strstr($file_info['filename'], 'zip')) {
                $updatedir = WEB_PATH . '/runtime/update/Temp/'; //更新的文件临时存放目录
                $obj_dir = new Dir();
                $obj_dir->del($updatedir); //删除文件夹下所有文件
                if (!is_dir($updatedir)) {
                    mkdir($updatedir, 0777, true);
                }
                $filename = getFile($file_info['fileurl'], $updatedir, $file_info['filename']); //下载文件到本地
                $PHPZip = new PhpZip();
                $PHPZip->unZip($updatedir . $file_info['filename'], WEB_PATH); //解压文件
                $sqlfile = WEB_PATH . '/update.sql';
				if(file_exists($sqlfile)){//更新数据库文件存在，则执行数据库更新文件
					$this->sql_execute($sqlfile,config("database.prefix"));//执行sql语句
					@unlink($sqlfile);
				}
				$this->updateVersionFile($file_info['version']);//更新本地版本文件
                JsonDie(1, '系统更新成功!', 'no');
            }
			JsonDie(0, '暂时只支持zip格式!', 'no');
            
        } catch (\Exception $e) {
            JsonDie(0, '系统出错' . $e, 'no');
        }
    }
	
   /**
     * 更新版本文件
     * @author 四川挚梦科技有限公司
     * @date 2018-04-30
     */
	public function updateVersionFile($version){
		   $data['version']=$version;
	       @file_put_contents(WEB_PATH . "/config/version.php", ("<?php\t\nreturn " . var_export($data, true) . ";\n?>"));	
	}

   /**
     * 执行sql语句
     * @author 四川挚梦科技有限公司
     * @date 2018-03-17
     */
    public function sql_execute($sqlfile, $tablepre) {
		$sql=@file_get_contents($sqlfile);
        $sqls = $this->sql_split($sql, $tablepre);
        if (is_array($sqls)) {
            foreach ($sqls as $sql) {
                if (trim($sql) != '') {
                    Db::execute($sql);
                }
            }
        } else {
            Db::execute($sqls);
        }
        return true;
    }

    /**
     * 分割sql文件
     * @author 四川挚梦科技有限公司
     * @date 2018-03-17
     */
    public function sql_split($sql, $tablepre) {
        $tablepre = strtolower($tablepre); //转换前缀为小写
        if ($tablepre != "zhimeng_") {
            $sql = str_replace("zhimeng_", $tablepre, $sql);
        }
        $sql = preg_replace("/TYPE=(InnoDB|MyISAM|MEMORY)( DEFAULT CHARSET=[^; ]+)?/", "ENGINE=\\1 DEFAULT CHARSET=utf8", $sql);
        if ($r_tablepre != $s_tablepre) {
            $sql = str_replace($s_tablepre, $r_tablepre, $sql);
        }
        $sql = str_replace("\r", "\n", $sql);
        $ret = array();
        $num = 0;
        $queriesarray = explode(";\n", trim($sql));
        unset($sql);
        foreach ($queriesarray as $query) {
            $ret[$num] = '';
            $queries = explode("\n", trim($query));
            $queries = array_filter($queries);
            foreach ($queries as $query) {
                $str1 = substr($query, 0, 1);
                if ($str1 != '#' && $str1 != '-')
                    $ret[$num] .= $query;
            }
            $num++;
        }
        return $ret;
    }

    /**
     * 判断用户是否登陆
     * @author 四川挚梦科技有限公司
     * @date 2018-03-18
     */
    public function doCheckLogin() {
        if (!session(config('auth.USER_AUTH_KEY'))) {
            $int_port = "";
            if ($_SERVER["SERVER_PORT"] != 80) {
                $int_port = ':' . $_SERVER["SERVER_PORT"];
            }
            $string_request_uri = "http://" . $_SERVER["SERVER_NAME"] . $int_port . $_SERVER['REQUEST_URI'];
            $this->error(lang('NO_LOGIN'), url(SYS_PATH.'/User/Login', array('doUrl' => urlencode($string_request_uri))), 1);
        } else {
            $this->admin = session(config('auth.USER_AUTH_KEY'));
            $this->assign('AdminSession', session(config('auth.USER_AUTH_KEY')));
        }
    }

}

?>