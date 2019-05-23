<?php

namespace app\api\controller;

// +----------------------------------------------------------------------
// | 四川挚梦科技有限公司
// +----------------------------------------------------------------------
// | Copyright (c) 2016~2017 http://www.zhi-meng.cn All rights reserved.
// +----------------------------------------------------------------------
// | QQ : 905873908
// +----------------------------------------------------------------------
// | Author: billow.wang <905873908@qq.com>
// +----------------------------------------------------------------------
// 微信网页登录授权
class WeixinLogin {

    private $app_id = ''; //公众号appid
    private $app_secret = ''; //公众号app_secret
    private $redirect_uri = ''; //授权之后跳转地址
    public $error = false;

    public function __construct() {
        $this->redirect_uri = "http://" . $_SERVER['HTTP_HOST'] . "/home/login/wechatLogin";
        $config['appid'] = 'wxcf37498f9c333e27';
        $config['AppSecret'] = 'b2c4dd94398c52f336965eed129588d0';

        $this->app_id = $config['appid'];
        $this->app_secret = $config['AppSecret'];
        if (!$this->checkConf($config)) {
            $this->error = '配置参数填写不完整';
        }
    }

    /**
     * 检查配置是否完整
     * @param array $config 全局配置参数
     * @Author: 四川挚梦科技有限公司
     */
    public function checkConf($config) {
        if (isset($config['appid']) && isset($config['AppSecret'])) {
            $mustConfig = array('appid', 'AppSecret');
            foreach ($mustConfig as $val) {
                if (!isset($config[$val]) || $config[$val] == '') {
                    return false;
                }
            }
            return true;
        } else {
            return false;
        }
    }

    /**
     * 获取微信授权链接
     * @Author: 四川挚梦科技有限公司
     * @param string $redirect_uri 跳转地址
     * @param mixed $state 参数
     */
    public function get_authorize_url($state) {
        $redirect_uri = urlencode($this->redirect_uri);
        return "https://open.weixin.qq.com/connect/oauth2/authorize?appid={$this->app_id}&redirect_uri={$redirect_uri}&response_type=code&scope=snsapi_userinfo&state={$state}#wechat_redirect&r=".rand(1,9999999);
    }

    /**
     * 获取授权token
     * @Author: 四川挚梦科技有限公司
     * @param string $code 通过get_authorize_url获取到的code
     */
    public function get_access_token($code) {
        $token_url = "https://api.weixin.qq.com/sns/oauth2/access_token?appid={$this->app_id}&secret={$this->app_secret}&code={$code}&grant_type=authorization_code";
        $token_data = $this->http_post($token_url);
        if ($token_data[0] == 200) {
            return json_decode($token_data[1], TRUE);
        }
        return FALSE;
    }

    public function GET_REFRESH_TOKEN($REFRESH_TOKEN) {
        $url = "https://api.weixin.qq.com/sns/oauth2/refresh_token?appid={$this->app_id}&grant_type=refresh_token&refresh_token={$REFRESH_TOKEN}";
        $token_data = $this->http_post($url);
        if ($token_data[0] == 200) {
            return json_decode($token_data[1], TRUE);
        }
        return FALSE;
    }

    /*

     */

    public function check_token($ACCESS_TOKEN) {
        $url = "https://api.weixin.qq.com/sns/auth?access_token={$ACCESS_TOKEN}&openid={$this->app_id}";
        $token_data = $this->http_post($url);
        if ($token_data[0] == 200) {
            return json_decode($token_data[1], TRUE);
        }
        return FALSE;
    }

    /**
     * 获取授权后的微信用户信息
     * @Author: 四川挚梦科技有限公司
     * @param string $access_token
     * @param string $open_id
     */
    public function get_user_info($access_token, $open_id) {
        if ($access_token && $open_id) {
            $info_url = "https://api.weixin.qq.com/sns/userinfo?access_token={$access_token}&openid={$open_id}&lang=zh_CN";
            $info_data = $this->http_post($info_url);
            if ($info_data[0] == 200) {
                return json_decode($info_data[1], TRUE);
            }
        }
        return FALSE;
    }


    /**
     * CURL模拟POST提交
     * @Author: 四川挚梦科技有限公司
     * @param string $access_token
     * @param string $open_id
     */
    public function http_post($url, $method = "POST", $postfields = null, $headers = array(), $debug = false) {
        $ci = curl_init();
        /* Curl settings */
        curl_setopt($ci, CURLOPT_HTTP_VERSION, CURL_HTTP_VERSION_1_1);
        curl_setopt($ci, CURLOPT_CONNECTTIMEOUT, 30);
        curl_setopt($ci, CURLOPT_SSL_VERIFYPEER, FALSE);
        curl_setopt($ci, CURLOPT_SSL_VERIFYHOST, FALSE);
        curl_setopt($ci, CURLOPT_TIMEOUT, 30);
        curl_setopt($ci, CURLOPT_RETURNTRANSFER, true);
        switch ($method) {
            case 'POST':
                curl_setopt($ci, CURLOPT_POST, true);
                if (!empty($postfields)) {
                    curl_setopt($ci, CURLOPT_POSTFIELDS, $postfields);
                    $this->postdata = $postfields;
                }
                break;
        }
        curl_setopt($ci, CURLOPT_URL, $url);
        curl_setopt($ci, CURLOPT_HTTPHEADER, $headers);
        curl_setopt($ci, CURLINFO_HEADER_OUT, true);
        $response = curl_exec($ci);
        $http_code = curl_getinfo($ci, CURLINFO_HTTP_CODE);
        if ($debug) {
            echo "=====post data======\r\n";
            var_dump($postfields);
            echo '=====info=====' . "\r\n";
            print_r(curl_getinfo($ci));
            echo '=====$response=====' . "\r\n";
            print_r($response);
        }
        curl_close($ci);
        return array($http_code, $response);
    }


    public function getSignPackage()
    {
        $jsapiTicket = $this->getJsApiTicket();

        // 注意 URL 一定要动态获取，不能 hardcode.
        $protocol = (!empty($_SERVER['HTTPS']) && $_SERVER['HTTPS'] !== 'off' || $_SERVER['SERVER_PORT'] == 443) ? "https://" : "http://";
        $url = "$protocol$_SERVER[HTTP_HOST]$_SERVER[REQUEST_URI]";

        $timestamp = time();
        $nonceStr = $this->createNonceStr();

        // 这里参数的顺序要按照 key 值 ASCII 码升序排序
        $string = "jsapi_ticket=".$jsapiTicket."&noncestr=".$nonceStr."&timestamp=".$timestamp."&url=".$url;

        $signature = sha1($string);

        $signPackage = array(
            "appId"     => $this->app_id,
            "nonceStr"  => $nonceStr,
            "timestamp" => $timestamp,
            "url"       => $url,
            "signature" => $signature,
            "rawString" => $string,
        );
        return $signPackage;
    }

    private function createNonceStr()
    {
        $str = md5(mt_rand(1000000,9999999));
//        $chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
//        $str = "";
//        for ($i = 0; $i < $length; $i++) {
//            $str .= substr($chars, mt_rand(0, strlen($chars) - 1), 1);
//        }
        return $str;
    }

    private function getJsApiTicket()
    {
        // jsapi_ticket 应该全局存储与更新，以下代码以写入到文件中做示例
        $data = json_decode(file_get_contents("http://".$_SERVER['SERVER_NAME']."/jsapi_ticket.json"));
        if ($data->expire_time < time()) {
            $accessToken = $this->getAccessToken();
            // 如果是企业号用以下 URL 获取 ticket
            // $url = "https://qyapi.weixin.qq.com/cgi-bin/get_jsapi_ticket?access_token=$accessToken";
            $url = "https://api.weixin.qq.com/cgi-bin/ticket/getticket?type=jsapi&access_token=$accessToken";
            $res = json_decode($this->httpGet($url));
            $ticket = $res->ticket;
            if ($ticket) {
                $data->expire_time = time() + 3600;
                $data->jsapi_ticket = $ticket;
                $fp = fopen(WEB_PATH."/jsapi_ticket.json", "w");
                fwrite($fp, json_encode($data));
                fclose($fp);
            }
        } else {
            $ticket = $data->jsapi_ticket;
        }

        return $ticket;
    }

    private function getAccessToken()
    {
        // access_token 应该全局存储与更新，以下代码以写入到文件中做示例
        $data = json_decode(file_get_contents("http://".$_SERVER['SERVER_NAME']."/access_token.json"));
        if ($data->expire_time < time()) {
            // 如果是企业号用以下URL获取access_token
            // $url = "https://qyapi.weixin.qq.com/cgi-bin/gettoken?corpid=$this->appId&corpsecret=$this->appSecret";
            $url = "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=$this->app_id&secret=$this->app_secret";
            $res = json_decode($this->httpGet($url));
            $access_token = $res->access_token;
            if ($access_token) {
                $data->expire_time = time() + 3600;
                $data->access_token = $access_token;
                @file_put_contents(WEB_PATH."/access_token.json",json_encode($data));
            }
        } else {
            $access_token = $data->access_token;
        }
        return $access_token;
    }


    private function httpGet($url)
    {
        $curl = curl_init();
        curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($curl, CURLOPT_TIMEOUT, 500);
        curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt($curl, CURLOPT_SSL_VERIFYHOST, false);
        curl_setopt($curl, CURLOPT_URL, $url);

        $res = curl_exec($curl);
        curl_close($curl);

        return $res;
    }

}

?>