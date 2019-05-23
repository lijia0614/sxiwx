<?php

namespace app\admin\controller;

use think\Controller;
use think\facade\Config;
use think\facade\Request;
use think\facade\Session;
use think\Db;
use Auths\Auth;
use StringFile\Images;
use think\captcha\Captcha;
use app\admin\model\Config as ConfigModel;
use app\common\controller\AppCommon;

class User extends AppCommon
{

    public $code_config = array();

    public function __construct()
    {
        parent::__construct();
        $config = model('config')->getCfgByModule("MANAGE_CODE");//获取验证码配置
        $c_value = json_decode($config['MANAGE_CODE'], true);
        $this->code_config = $c_value;
        $this->codeStatus = $this->code_config['status'];
        $this->assign("codeStatus", $this->codeStatus);
		$this->setSysPath();
    }

    public function login()
    {
        if ($_POST) {
            //如果后台开启了验证码
            if ($this->checkCodeStatus()) {
                self::doCodeCheck();//验证码是否正确
            }
            self::doUserCheck(); //验证用户名和密码
            $this->success("登录成功", url(SYS_PATH."/index/index"));
        }
        return view();
    }

    /**
     * 设置后台入口别名
     * @author 四川挚梦科技有限公司
     * @date 2018-03-17
     */
	public function setSysPath(){
		$sys_path=config("admin.adminPath");
		if($sys_path){
			define("SYS_PATH",config("admin.adminPath"));
		}else{
			define("SYS_PATH","sys");
		}
		$this->assign("sys_path",$sys_path);
	}

    /**
     * 后台安全退出，销毁session
     * @author 四川*挚梦*科技*有限公司
     * @date 2018-04-03
     */
    public function doLogout()
    {
        $Admin = Session::get(config("auth.USER_AUTH_KEY"));
        Session::set(config("auth.USER_AUTH_KEY"), 0);
        session_destroy();
        $this->success("退出成功");
    }

    /**
     * 验证用户登录
     * @author 四川*挚梦*科技*有限公司
     * @date 2018-03-18
     */
    private function doUserCheck()
    {
        $ary_post = input("post.");
        $map = array(); //生成认证条件
        $map['u_name'] = $ary_post['username'];
        $map["status"] = 1;
        $Auth = new Auth;
        $auth_info = $Auth->authenticate($map);
        if (empty($auth_info)) {
            $this->error(lang('ACCOUNT_EXIT_DISABLED'));
        }
        if ($auth_info['u_passwd'] != md5($ary_post['passwd'])) {
            $this->error(lang('PASSWD_ERROR'));
        }
        Session::set(config("auth.USER_AUTH_KEY"), $auth_info); //设置登录session
        if ($auth_info['u_id'] == 2) {
            Session::set(config("auth.ADMIN_AUTH_KEY"), true); //超级管理员用户标识
        }
        $Auth->saveAccessList(); // 缓存访问权限	
        self::addlog($auth_info); //记录登录日志
    }


    /**
     * 验证码是否正确
     * @author 四川挚梦*科技有限*公司
     * @date 2018-03-18
     */
    private function doCodeCheck()
    {
        $captcha = input("post.code", "trim");
        if (!captcha_check($captcha)) {
            $this->error(lang('CODE_ERROR'));
            exit;
        }
        return true;
    }

    /**
     * 验证码
     * @author 四*川*挚*梦*科技有*限公司
     * @date 2018-03-18
     */
    public function verify()
    {
        $captcha = new Captcha();
        $captcha->fontSize = 16;
        $captcha->length = $this->code_config['code_length'];
        $captcha->imageW = $this->code_config['code_width'];
        $captcha->imageH = $this->code_config['code_height'];
        $captcha->useNoise = true;
        $captcha->useCurve = true;
        $captcha->fontttf = '4.ttf';
        $captcha->codeSet = $this->codeType($this->code_config['code_type']);
        return $captcha->entry();
    }

    /**
     * 检测验证码状态是否开启
     * @author 四*川*挚*梦*科技有*限公司
     * @date 2018-03-18
     */
    public function checkCodeStatus()
    {
        if ($this->code_config['status'] == 1) {
            return true;
        }
        return false;
    }

    /**
     * 检测验证码类型
     * @author 四*川*挚*梦*科技有*限公司
     * @date 2018-03-18
     */
    public function codeType($type)
    {
        switch ($type) {
            case 0:
                return 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';
                break;
            case 1:
                return '0123456789';
                break;
            case 2:
                return 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
                break;
            case 3:
                return 'abcdefghijklmnopqrstuvwxyz';
                break;
            default:
                return '0123456789';
                break;
        }
    }


    /**
     * 记录用户登陆日志
     * @author 四*川*挚*梦*科技有限公*司
     * @date 2016-12-27
     */
    private function addlog($auth_info)
    {
        try {
            $ary_data = array();
            $ip = request()->ip();
            $ary_data['u_id'] = $auth_info['u_id'];
            $ary_data['u_name'] = $auth_info['u_name'];
            $ary_data['log_ip'] = $ip;
            $ary_data['create_time'] = time();
            Db::name('AdminLog')->insert($ary_data);
            return true;
        } catch (\Exception $e) {
            $this->error("写入日志失败");
        }
    }

}
