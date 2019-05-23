<?php
namespace Share;

/**
 +------------------------------------------------------------------------------
 * 微信分享插件
 +------------------------------------------------------------------------------
 * @category   ORG
 * @package  ORG
 * @subpackage  Util
 * @author    四川挚梦科技有限公司
 +------------------------------------------------------------------------------
 */	 
 
class Wechat
{
    private $app_id = ''; //公众号appid
    private $app_secret = ''; //公众号app_secret
    public function __construct(){
        $webConfig = db('authorization')->where(array('id' => 1))->find();

        $config = json_decode($webConfig['a_value'], true);
        $this->app_id = $config['appid'];
        $this->app_secret = $config['AppSecret'];
        if (!$this->checkConf($config)) {
            return false;
        }
    }
	/**
	 * 微信分享
	 * @param number $length
	 * @return string
	 */
	public function share(){
		$APP_ID = "23232";
		$APP_SECRET = "ddd";
		$confinfo = $this->get_js_sdk($APP_ID, $APP_SECRET);
		return $confinfo;		
	}
	
	/**
	 * curl提交
	 * @param number $length
	 * @return string
	 */
	function curlSend($url,$post_data=""){
		$ch = curl_init();
		curl_setopt($ch, CURLOPT_URL,$url);
		if($post_data != ""){
			curl_setopt($ch,CURLOPT_POST,1);
			curl_setopt($ch,CURLOPT_POSTFIELDS,$post_data);
		}
	
		curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
		curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, false);
		curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
		$result = curl_exec($ch);
		curl_close($ch);
		return $result;
	}

	/**
	 * 获取随机字符串
	 * @param number $length
	 * @return string
	 */
	public function createNonceStr($length = 16) {
		$chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
		$str = "";
		for ($i = 0; $i < $length; $i++) {
			$str .= substr($chars, mt_rand(0, strlen($chars) - 1), 1);
		}
		return $str;
	}

	/**
	 * 获取微信TOKEN
	 * 默认缓存 7000 秒
	 * @param unknown $APP_ID
	 * @param unknown $APP_SECRET
	 * @return Ambigous <mixed, \Think\mixed, object>
	 */
	public function get_access_token($APP_ID,$APP_SECRET){
		$file = 'access_token.php';
		if(!is_file($file)){
			$url = "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=".$APP_ID."&secret=".$APP_SECRET;
			$json = curlSend($url);
			$data=json_decode($json,true);
			
			$cache = array();
			$cache['expire_time'] = time() + 7000;
			$cache['access_token'] = $data['access_token'];
			file_put_contents($file, json_encode($cache));
			return $data['access_token'];
		}
		
		$olddata = json_decode(file_get_contents($file));
		if($olddata['expire_time'] < time()){
			$url = "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=".$APP_ID."&secret=".$APP_SECRET;
			$json = curlSend($url);
			$data=json_decode($json,true);
			
			$cache = array();
			$cache['expire_time'] = time() + 7000;
			$cache['access_token'] = $data['access_token'];
			file_put_contents($file, json_encode($cache));
			return $data['access_token'];
		}
		return $olddata['access_token'];
	}

	/**
	 * 微信分享代码
	 * @param unknown $APP_ID
	 * @param unknown $APP_SECRET
	 * @return multitype:unknown string number Ambigous <mixed, \Think\mixed, object>
	 */
	public function get_js_sdk($APP_ID,$APP_SECRET){
		$protocol = (!empty($_SERVER['HTTPS']) && $_SERVER['HTTPS'] !== 'off' || $_SERVER['SERVER_PORT'] == 443) ? "https://" : "http://";
		$url = $protocol.$_SERVER["HTTP_HOST"].$_SERVER["REQUEST_URI"];
	
		$argu = array();
		$argu['appId'] = $APP_ID;
		$argu['url'] = $url;
		$argu['nonceStr'] = createNonceStr();
		$argu['timestamp'] = time();
	
		$ACCESS_TOKEN = get_access_token($APP_ID,$APP_SECRET);
		$argu['jsapi_ticket'] = get_jsapi_ticket($ACCESS_TOKEN);
	
	
		$string = "jsapi_ticket=".$argu['jsapi_ticket']."&noncestr=".$argu['nonceStr']."&timestamp=".$argu['timestamp']."&url=".$argu['url'];
		$argu['signature'] = sha1(trim($string));
		return $argu;
	}	
	

}