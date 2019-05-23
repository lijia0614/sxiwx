<?php

namespace Sms;

/**
 * 阿里云短信验证码发送类
 * @author 四川挚梦科技有限公司
 */
class aliyun {

    public $error;
    private $accessKeyId = 'LTAIRegTFIguYlrQ';
    private $accessKeySecret = 'KBk9ywnCLWTbNIe2tlKdV5qIu5EcR9';
    private $signName = '';  // 签名
    private $templateCode = '';  // 模版ID

    public function __construct($config = array()) {
        if (!$config) {
            $data = Db("Sms")->where("status", 1)->where("id",1)->find();
            $config = json_decode($data['value'], true);
        }
        // 配置参数
//        $this->accessKeyId = $config ['accessKeyId'];
//        $this->accessKeySecret = $config ['accessKeySecret'];
        $this->signName = $config ['signName'];
    }

    private function percentEncode($string) {
        $string = urlencode($string);
        $string = preg_replace('/\+/', '%20', $string);
        $string = preg_replace('/\*/', '%2A', $string);
        $string = preg_replace('/%7E/', '~', $string);
        return $string;
    }

    /**
     * 签名
     * @param unknown $parameters            
     * @param unknown $accessKeySecret            
     * @return string
     */
    private function computeSignature($parameters, $accessKeySecret) {
        ksort($parameters);
        $canonicalizedQueryString = '';
        foreach ($parameters as $key => $value) {
            $canonicalizedQueryString .= '&' . $this->percentEncode($key) . '=' . $this->percentEncode($value);
        }
        $stringToSign = 'GET&%2F&' . $this->percentencode(substr($canonicalizedQueryString, 1));
        $signature = base64_encode(hash_hmac('sha1', $stringToSign, $accessKeySecret . '&', true));
        return $signature;
    }

    /**
     * 发送验证码 https://help.aliyun.com/document_detail/44364.html?spm=5176.doc44368.6.126.gSngXV
     * @param string $mobile    手机号
	 * @param int(11) $tpl_id   模板id            
     * @param unknown $verify_code            
     *
     */
    public function sendSms($mobile, $tpl_id,$data) {
		$tpl = Db("message_tpl")->where("id", $tpl_id)->find();
		$templateCode = $tpl['template_code'];
		if(!$templateCode){
				return '没有找到服务商短信模板ID';
		}
        $params = array(
            // 公共参数
            'Action' => 'SendSms', //固定参数
            'Version' => '2017-05-25', //固定版本号
            'RegionId' => 'cn-hangzhou', //固定参数
            'PhoneNumbers' => $mobile, //接收短信的手机号
            'SignName' => '双溪文学', //短信签名
            'TemplateCode' => $templateCode, //发送的模板id
            'AccessKeyId' => $this->accessKeyId,
            'Timestamp' => gmdate('Y-m-d\TH:i:s\Z'),
            'Format' => 'JSON', //可传xml
            'SignatureMethod' => 'HMAC-SHA1', //固定值
            'SignatureVersion' => '1.0', //固定值
            'SignatureNonce' => uniqid(), //防重攻击
            'TemplateParam' => $data//需要替换的消息模板变量
        );
		c_print($params);die;
        $params ['Signature'] = $this->computeSignature($params, $this->accessKeySecret); // 计算签名并把签名结果加入请求参数
        $url = 'https://dysmsapi.aliyuncs.com/?' . http_build_query($params); // 将参数组合到url中
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, FALSE);
        curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, FALSE);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_TIMEOUT, 10);
        $result = curl_exec($ch);

        curl_close($ch);
        $result = json_decode($result, true);
        if (isset($result ['Code'])) {
            return $this->getErrorMessage($result ['Code']);//返回信息
        }
        return true;
    }

    /**
     * 获取详细错误信息
     * @param unknown $status            
     */
    public function getErrorMessage($status) {
        $message = array(
            'OK' => 'OK', //发送成功
            'isp.RAM_PERMISSION_DENY' => 'RAM权限DENY',
            'isv.OUT_OF_SERVICE' => '业务停机',
            'isv.PRODUCT_UN_SUBSCRIPT' => '未开通云通信产品的阿里云客户',
            'isv.PRODUCT_UNSUBSCRIBE' => '产品未开通',
            'isv.ACCOUNT_NOT_EXISTS' => '账户不存在',
            'isv.ACCOUNT_ABNORMAL' => '账户异常',
            'isv.SMS_TEMPLATE_ILLEGAL' => '短信模板不合法',
            'isv.SMS_SIGNATURE_ILLEGAL' => '短信签名不合法',
            'isv.INVALID_PARAMETERS' => '参数异常',
            'isp.SYSTEM_ERROR' => '系统错误',
            'isv.MOBILE_NUMBER_ILLEGAL' => '非法手机号',
            'isv.MOBILE_COUNT_OVER_LIMIT' => '手机号码数量超过限制',
            'isv.TEMPLATE_MISSING_PARAMETERS' => '模板缺少变量',
            'isv.BUSINESS_LIMIT_CONTROL' => '业务限流',
            'isv.INVALID_JSON_PARAM' => 'JSON参数不合法，只接受字符串值',
            'isv.BLACK_KEY_CONTROL_LIMIT' => '黑名单管控',
            'isv.PARAM_LENGTH_LIMIT' => '参数超出长度限制',
            'isv.PARAM_NOT_SUPPORT_URL' => '不支持URL',
            'isv.AMOUNT_NOT_ENOUGH' => '账户余额不足',
			'InvalidAccessKeyId.NotFound'=>'AccessKeyId 找不到',
			'InvalidAccessKeyId.Inactive'=>'AccessKeyId 被禁用。',
			'InvalidTimeStamp.Format'=>'时间戳格式不对( Date 和 Timestamp)。',
			'InvalidTimeStamp.Expired'=>'用户时间和服务器时间超过15分钟。'
        );
        if (isset($message [$status])) {
            return $message [$status];
        }
        return $status;
    }

}
