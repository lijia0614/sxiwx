<?php
namespace Oauths;

use think\facade\Config;
use app\home\model\AuthConfig;

class wxchat{
	
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
		$result=$AuthConfig->getConfig('wxpc');
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
		config("wxpc.appid",$result['appid']);
		config("wxpc.AppSecret",$result['AppSecret']);
		config("wxpc.callback","http://".$_SERVER['HTTP_HOST']."/home/Oauth/wxCallback");//回调地址
	}
	
    /**
     +----------------------------------------------------------
     * 登录
     +----------------------------------------------------------
     * @access public
     +----------------------------------------------------------
     */	
	public function login(){
		$url="https://open.weixin.qq.com/connect/qrconnect?appid=";
		$url.=config("wxpc.appid")."&redirect_uri=".config("wxpc.callback")."&response_type=code&scope=snsapi_login&state=STATE#wechat_redirect";
		return $url;
	}
	
    /**
     +----------------------------------------------------------
     * 微信登录回调地址
     +----------------------------------------------------------
     * @access public
     +----------------------------------------------------------
     */		
	public function callBack(){
		$code=input('request.code', 0, 'trim');
		if(!$code){
			$this->error="bad request";
			return 0;
		}
		$postdata=array('appid'=>config("wxpc.appid"),'secret'=>config("wxpc.AppSecret"),'code'=>$code);//传入参数
		$url="https://api.weixin.qq.com/sns/oauth2/access_token?appid=";
		$url.=config("wxpc.appid")."&secret=".config("wxpc.AppSecret")."&code=$code&grant_type=authorization_code";	//构造请求url
		$result=$this->post($url,$postdata);
		$arrdata=json_decode($result,true);
		if($arrdata['errcode']){
			$this->error=$arrdata['errmsg'];
			return 0;
		}
		$userInfo=$this->wxUserinfo($arrdata['access_token'],$arrdata['openid']);//得到用户基本信息
		$result=$this->userWrite($arrdata['openid'],$arrdata['access_token'],$userInfo);//保存用户信息
		if($result){
				return true;
		}
		return false;
	}
	
    /**
     * 获取微信用户基本信息
     * @author 四川挚梦科技有限公司
     * @date 2017-01-09
     */
	public function wxUserinfo($ACCESS_TOKEN,$OPENID){
		$url="https://api.weixin.qq.com/sns/userinfo?access_token=$ACCESS_TOKEN&openid=$OPENID";	
		$postdata=array('access_token'=>$ACCESS_TOKEN,'openid'=>$OPENID);
		$result=$this->post($url,$postdata);
		$arrdata=json_decode($result,true);
		return $arrdata;
	}	
	
	
    /**
     * 保存用户信息
     * @author 四川挚梦科技有限公司
     * @date 2017-01-09
     */
	public function userWrite($openid,$access_token,$userInfo){
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
	}
	
    /**
     * 第一次登录的用户添加到用户主表
     * @author 四川挚梦科技有限公司
     * @date 2017-01-09
     */
	public function addMembers($userInfo){
			$data=array(
				'nickname'=>$userInfo['nickname'],
				'create_time'=>time(),
				'update_time'=>time()
			);
			$user_id=Db('members')->insertGetId($data);
			return $user_id;
	}
	
    /**
     * 第一次登录的用户添加到用户授权表
     * @author 四川挚梦科技有限公司
     * @date 2017-01-09
     */
	public function addMembersAuths($user_id,$openid,$access_token,$userInfo){
		$data=array(
					'user_id'=>$user_id,
					'type'=>'wxpc',
					'openid'=>$openid,
					'nickname'=>$userInfo['nickname'],
					'gender'=>$userInfo['sex'],
					'photo'=>$userInfo['headimgurl'],
					'token'=>$access_token,
					'login_time'=>time(),
					'create_time'=>time()
			);
		$members_auths_id=Db('members_auths')->insertGetId($data);
		return $members_auths_id;
	}
	
    /**
     * post
     * post方式请求资源
     * @param string $url       基于的baseUrl
     * @param array $keysArr    请求的参数列表
     * @param int $flag         标志位
     * @return string           返回的资源内容
     */
    public function post($url, $keysArr, $flag = 0){

        $ch = curl_init();
        if(! $flag) curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, FALSE);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, TRUE);
        curl_setopt($ch, CURLOPT_POST, TRUE);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $keysArr);
        curl_setopt($ch, CURLOPT_URL, $url);
        $ret = curl_exec($ch);

        curl_close($ch);
        return $ret;
    }		
	
	
	
}
?>