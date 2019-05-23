<?php
namespace Oauths;

use think\facade\Config;
use kuange\qqconnect\QC;
use app\home\model\AuthConfig;

class qq{
	
	public $error=0;
	
    /**
     +----------------------------------------------------------
     * 获取配置文件
     +----------------------------------------------------------
     * @access public
     +----------------------------------------------------------
     */	
    function __construct(){
		$AuthConfig=new AuthConfig();
		$result=$AuthConfig->getConfig('qqconnect');
		
		if(!$result){
			$this->error=$AuthConfig->getError();
		}else{
			$this->setConfig($result);
		}
    }
    /**
     +----------------------------------------------------------
     * 动态设置配置
     +----------------------------------------------------------
     * @access public
     +----------------------------------------------------------
     */	
	public function setConfig($result){
		config("qqconnect.appid",$result['appid']);
		config("qqconnect.appkey",$result['AppKey']);
		config("qqconnect.callback","http://".$_SERVER['HTTP_HOST']."/home/Oauth/qqCallback");//回调地址
		config("qqconnect.scope","get_user_info");//接口权限
		config("qqconnect.errorReport",true);	//是否开启错误调试
	}
	
    /**
     +----------------------------------------------------------
     * 登录
     +----------------------------------------------------------
     * @access public
     +----------------------------------------------------------
     */	
	public function login(){
		$qc = new QC();	
		$url=$qc->qq_login();//获取授权地址
		return $url;
	}
    /**
     +----------------------------------------------------------
     * 回调地址
     +----------------------------------------------------------
     * @access public
     +----------------------------------------------------------
     */		
	public function callBack(){
		try{	
			$qc = new QC();
			$access_token=$qc->qq_callback();    // access_token
			$openid=$qc->get_openid();     // openid
			$userInfo=$qc->get_userinfo();//获取用户基本信息，如头像，性别等
			$result=$this->userWrite($openid,$access_token,$userInfo);//保存用户信息
			if($result){
				return true;
			}
			return false;
		}catch (\Exception $e) {
				$this->error=$e;
				return 0;
		}			
	}
    /**
     * 保存用户信息
     * @author 四川挚梦科技有限公司
     * @date 2017-01-09
     */
	public function userWrite($openid,$access_token,$userInfo){
		try{		
			$user=Db("members_auths")->where("openid",$openid)->find();
			if(!$user){
				$user_id=$this->addMembers($userInfo);//写入用户主表
				$this->addMembersAuths($user_id,$openid,$access_token,$userInfo);//写入用户第三方登录授权表
				session("user_id",$user_id);
			}else{
				Db('members_auths')->where('openid',$openid)->update(array('token' => $access_token,'login_time'=>time()));				
				session("user_id",$user['user_id']);
			}
			if(session("user_id")){
				return true;	
			}
			return false;
		}catch (\Exception $e) {
				$this->error=$e;
				return 0;
		}
	}
	
    /**
     * 第一次登录的用户添加到用户主表
     * @author 四川挚梦科技有限公司
     * @date 2017-01-09
     */
	public function addMembers($userInfo){
		try{
			$data=array(
				'nickname'=>$userInfo['nickname'],
				'create_time'=>time(),
				'update_time'=>time()
			);
			$user_id=Db('members')->insertGetId($data);
			return $user_id;
		}catch (\Exception $e) {
			$this->error=$e;
			return 0;
        }
	}
	
    /**
     * 第一次登录的用户添加到用户授权表
     * @author 四川挚梦科技有限公司
     * @date 2017-01-09
     */
	public function addMembersAuths($user_id,$openid,$access_token,$userInfo){
		try{
			$data=array(
						'user_id'=>$user_id,
						'type'=>'qq',
						'openid'=>$openid,
						'nickname'=>$userInfo['nickname'],
						'gender'=>$userInfo['gender'],
						'photo'=>$userInfo['figureurl_qq_1'],
						'token'=>$access_token,
						'login_time'=>time(),
						'create_time'=>time()
				);
			$members_auths_id=Db('members_auths')->insertGetId($data);
			return $members_auths_id;
		}catch (\Exception $e) {
			$this->error=$e;
			return 0;
        }
	}	
	
	
	
}
?>