<?php

namespace app\home\controller;

use Monolog\Handler\IFTTTHandler;
use think\Controller;
use think\facade\Config;
use think\Db;
use think\facade\Env;
use think\facade\Validate;
use think\facade\Session;
use Upload\UploadFile;
use Payments\aliPay;
use Sms\aliyun;
use Excels\Excel;
use Oauths\qq;


class Recharge extends Common
{

    public function __construct()
    {

        parent::__construct();
    }

    /**
     * 首页
     * @author 四川挚梦科技有限公司
     * @date 2018-04-05
     */
    public function recharge()
    {
//        dump(MD5('shuangxiwenxue')) ;
        $this->isLogin();
        $user_id = $this->user_id;
        if ($user_id) {
            $user = Db::name('member')->where('id', $user_id)->find();
            $this->assign('user', $user);
        }
        return view();
    }


    public function goPay()
    {
        $data = input('get.');
        $type = input('get.type', '', 'intval');
        $amount = input('get.amount', '', 'intval');
        $order_num = $type . time() . rand('10000', '99999');
        if (!$type) {
            $this->error('请选择支付方式');
        }
        if (!$amount || $amount <= 0) {
            $this->error('请填写支付金额');
        }
        $data = [
            'u_id' => $this->user_id,
            'amount' => $amount,
            'order_num' => $order_num,
            'type' => $type, //1.微信   2.支付宝
            'create_time' => time(),
            'is_pay'=>2,//未支付
        ];
        $order_id = Db::name('recharge')->insertGetId($data);
        $this->redirect(url('home/pay/index', ['id' => $order_id]));
    }

    /**
     * 开通会员
     */
    public function openVip(){
        $this->isLogin();
        $user = Db::name('member')->where('id',$this->user_id)->field('is_vip,vip_create_time')->find();

        $cof = Db::name('config')->where('c_key','CUSTOMIZE_SITE')->field('c_value')->find();
        $config = json_decode($cof['c_value']);
        $arr  = $this->object_to_array($config);


        $t = strtotime($user['vip_create_time']);
        $deadline = date('Y-m-d H:i:s',$t+365*24*60*60); // 会员过期时间
        $now = date('Y-m-d H:i:s',time()); // 现在的时间

        if (strtotime($now) < strtotime($deadline)){
            $times = strtotime($deadline) - strtotime($now);
            $surplus = floor($times/(24*3600));

            echo "<script type='text/javascript'>alert('您已经是我们的会员了，无需再开通');</script>";
            exit();
        }else{
            $type = 5;
            $order_num = $type . time() . rand('10000', '99999');
            $data = [
                'u_id' => $this->user_id,
                'amount' => $arr['vip_price'],
                'order_num' => $order_num,
                'type' => $type, // 5 微信支付开通会员
                'create_time' => time(),
                'is_pay'=>2,//未支付
            ];

            $order_id = Db::name('recharge')->insertGetId($data);
            $this->redirect(url('home/pay/index', ['id' => $order_id]));
        }

    }

    private function jsonToArr($data)
    {
        return json_decode($data, true);
    }

    function object_to_array($obj) {
        $obj = (array)$obj;
        foreach ($obj as $k => $v) {
            if (gettype($v) == 'resource') {
                return;
            }
            if (gettype($v) == 'object' || gettype($v) == 'array') {
                $obj[$k] = (array)object_to_array($v);
            }
        }

        return $obj;
    }

    /**
     * CURL请求
     * @param $url 请求url地址
     * @param $method 请求方法 get post
     * @param null $postfields post数据数组
     * @param array $headers 请求header信息
     * @param bool|false $debug 调试开启 默认false
     * @return mixed
     */
    private function httpRequest($url, $method = "GET", $postfields = null, $headers = array(), $debug = false)
    {
        $method = strtoupper($method);
        $ci = curl_init();
        /* Curl settings */
        curl_setopt($ci, CURLOPT_HTTP_VERSION, CURL_HTTP_VERSION_1_0);
        curl_setopt($ci, CURLOPT_USERAGENT, "Mozilla/5.0 (Windows NT 6.2; WOW64; rv:34.0) Gecko/20100101 Firefox/34.0");
        curl_setopt($ci, CURLOPT_CONNECTTIMEOUT, 60); /* 在发起连接前等待的时间，如果设置为0，则无限等待 */
        curl_setopt($ci, CURLOPT_TIMEOUT, 7); /* 设置cURL允许执行的最长秒数 */
        curl_setopt($ci, CURLOPT_RETURNTRANSFER, true);
        switch ($method) {
            case "POST":
                curl_setopt($ci, CURLOPT_POST, true);
                if (!empty($postfields)) {
                    $tmpdatastr = is_array($postfields) ? http_build_query($postfields) : $postfields;
                    curl_setopt($ci, CURLOPT_POSTFIELDS, $tmpdatastr);
                }
                break;
            default:
                curl_setopt($ci, CURLOPT_CUSTOMREQUEST, $method); /* //设置请求方式 */
                break;
        }
        $ssl = preg_match('/^https:\/\//i', $url) ? TRUE : FALSE;
        curl_setopt($ci, CURLOPT_URL, $url);
        if ($ssl) {
            curl_setopt($ci, CURLOPT_SSL_VERIFYPEER, FALSE); // https请求 不验证证书和hosts
            curl_setopt($ci, CURLOPT_SSL_VERIFYHOST, FALSE); // 不从证书中检查SSL加密算法是否存在
        }
        //curl_setopt($ci, CURLOPT_HEADER, true); /*启用时会将头文件的信息作为数据流输出*/
        curl_setopt($ci, CURLOPT_FOLLOWLOCATION, 1);
        curl_setopt($ci, CURLOPT_MAXREDIRS, 2);/*指定最多的HTTP重定向的数量，这个选项是和CURLOPT_FOLLOWLOCATION一起使用的*/
        curl_setopt($ci, CURLOPT_HTTPHEADER, $headers);
        curl_setopt($ci, CURLINFO_HEADER_OUT, true);
        /*curl_setopt($ci, CURLOPT_COOKIE, $Cookiestr); * *COOKIE带过去** */
        $response = curl_exec($ci);
        $requestinfo = curl_getinfo($ci);
        $http_code = curl_getinfo($ci, CURLINFO_HTTP_CODE);
        if ($debug) {
            echo "=====post data=====\r\n";
            var_dump($postfields);
            echo "=====info===== \r\n";
            print_r($requestinfo);
            echo "=====response=====\r\n";
            print_r($response);
        }
        curl_close($ci);
        return $response;
    }
}
