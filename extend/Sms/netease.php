<?php
namespace Sms;

class netease{

    //网易云短信发送类
    public $config = array();
	
    public function __construct($config = array()) {
        if (!$config) {
            $data = Db("Sms")->where("status", 1)->where("id",1)->find();
            $config = json_decode($data['value'], true);
        }
		 $this->config = $config;
    }	

	public function sendSms($mobile,$tpl_id,$data){
		$tpl = db("message_tpl")->where("id", $tpl_id)->find();
		$templateCode = $tpl['template_code'];		
		if(!$templateCode){
				return '没有找到服务商短信模板ID';
		}		
        $template_id=$templateCode;
        $mobile = '["'. $mobile .'"]';
        $url = 'https://api.netease.im/sms/sendtemplate.action';
        $postData['templateid'] = $template_id;
        $postData['mobiles'] = $mobile;
        $postData['params'] = json_encode($data);
        $AppKey = $this->config['APP_KEY']; //系统配置中APP_KEY
        $AppSecret = $this->config['APP_SECRET']; //系统配置中APP_SECRET
        $Nonce = json_encode($data);
        $CurTime = time();
        $CheckSum = strtolower(sha1($AppSecret . $Nonce . $CurTime));
        $head_arr = array();
        $head_arr[] = 'Content-Type: application/x-www-form-urlencoded';
        $head_arr[] = 'charset: utf-8';
        $head_arr[] = 'AppKey:' . $AppKey;
        $head_arr[] = 'Nonce:' . $Nonce;
        $head_arr[] = 'CurTime:' . $CurTime;
        $head_arr[] = 'CheckSum:' . $CheckSum;
        $result = httpPost($url, $method = "POST", http_build_query($postData), $head_arr, $debug = false);
        if ($result['code'] == 200) {
            return true;
        } else {
            return $result['code'];
        }
    }    


}
