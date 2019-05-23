<?php
namespace WeChat;

/**
 +------------------------------------------------------------------------------
 * 微信模板消息基类
 +------------------------------------------------------------------------------
 * @category   ORG
 * @package  ORG
 * @subpackage  Util
 * @author    四川挚梦科技有限公司
 +------------------------------------------------------------------------------
 */	 
 
class WeChatTemplate
{
    private $app_id = ''; //公众号appid
    private $app_secret = ''; //公众号app_secret


    public function __construct()
    {
        $webConfig = db('authorization')->where(array('id' => 1))->find();

        $config = json_decode($webConfig['a_value'], true);
        $this->app_id = $config['appid'];
        $this->app_secret = $config['AppSecret'];
        if (!$this->checkConf($config)) {
            return false;
        }
    }

    /**
     * 检查配置是否完整
     * @param array $config 全局配置参数
     * @Author: 四川挚梦科技有限公司
     */
    public function checkConf($config)
    {
        if (isset($config['appid']) && isset($config['AppSecret']) && isset($config['TOKEN'])) {
            if ($config['status'] == 1) {
                $mustConfig = array('appid', 'AppSecret', 'TOKEN', 'status');
                foreach ($mustConfig as $val) {
                    if (!isset($config[$val]) || $config[$val] == '') {
                        return false;
                    }
                }
                return true;
            } else {
                return false;
            }
        } else {
            return false;
        }
    }

    /**
     * 获取access_token
     * @Author: 四川挚梦科技有限公司
     * @param mixed $state 参数
     */
    public function getAccessToken()
    {
        $times = time();
        $access_token = cache('access_token');
        if ($access_token && ($access_token['create_time'] + 3600) > $times && $access_token['access_token']) {
            return $access_token['access_token'];
        }
        $token_url = "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid={$this->app_id}&secret={$this->app_secret}";
        $token_data = $this->http_post($token_url);
        if ($token_data[0] == 200) {
            $arr_token_data = json_decode($token_data[1], TRUE);
            cache('access_token', ['create_time' => $times, 'access_token' => $arr_token_data['access_token']]);
            return $arr_token_data['access_token'];
        }
        return FALSE;
    }

    /**
     * 发送微信消息
     * @Author: 四川挚梦科技有限公司
     * @param  $openid ,接收人的openid    $template_id,  微信模板id $url  , 点击微信消息跳转url    $data  消息内容模板格式如下图所示
     *
     * $data = [
     * 'first' => ['value' => '您有一份新订单，订单编号：' . 123123, 'color' => '#173177'],
     * 'keyword1' => ['value' => 12321, 'color' => '#173177'],    //函数传参过来的keyword1
     * 'keyword2' => ['value' => 12321, 'color' => '#173177'],        //函数传参过来的keyword2
     * 'keyword3' => ['value' => 123213, 'color' => '#173177'],   //函数传参过来的keyword3
     * 'keyword4' => ['value' => 123123, 'color' => '#173177'],   //函数传参过来的keyword4
     * 'remark' => ['value' => 1232132131, 'color' => '#173177'],//函数传参过来的remark
     * ];
     *
     */
    public function putWeiXinTemplate($openid, $template_id, $url = '', $data)
    {
        if (!$openid || !$template_id || !$data) {
            return false;
        }
        $template = [
            'touser' => $openid,
            'template_id' => $template_id,    //模板的id
            'url' => $url,
            'topcolor' => "#FF0000",
            'data' => $data,
        ];
        $json_template = json_encode($template);
        $url = "https://api.weixin.qq.com/cgi-bin/message/template/send?access_token=" . $this->getAccessToken();
        http_request($url, urldecode($json_template));
        return true;
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
}