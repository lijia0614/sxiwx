<?php

namespace app\home\controller;

use alipay\Pagepay;
use alipay\ReturnRul;
use alipay\Wappay;
use think\Db;
use wxpay\JsapiPay;
use wxpay\NativePay;
use wxpay\Query;
use wxpay\Notify;



class Pay extends Common
{

    public $app_id;
    public $wechat_redirect_url;
    public $ali_redirect_url;
    public $alipay_notify_redirect_url;
    public $notify_url;
    static $alipay_config = array();

    public function __construct()
    {
        parent::__construct();
        self::alipay_config(); //获取支付宝参数配置
        $this->wechat_redirect_url = 'http://' . $_SERVER['HTTP_HOST'] . '/home/pay/redirect_url.html';
        $this->ali_redirect_url = 'http://' . $_SERVER['HTTP_HOST'] . '/home/pay/alipay_return.html';
        $this->alipay_notify_redirect_url = 'http://' . $_SERVER['HTTP_HOST'] . '/home/pay/alipay_notify.html';
        $this->app_id = '2018103061906438';
        $this->notify_url = 'http://' . $_SERVER['HTTP_HOST'] . '/home/pay/notify_url.html';

    }

    public function pay(){
        return view();
    }


    /**
     * 支付入口
     */
    public function index()
    {
        $id = input('get.id', 0, 'intval');
        if (!$id) {
            $this->error('用户信息错误');
        }
        $recharge = Db::name('recharge')
            ->where([['u_id', '=', $this->user_id], ['id', '=', $id], ['is_pay', '=', 2]])
            ->find();
        if (!$recharge) {
            $this->error('订单不存在，或者已经支付');
        }

        if (is_weixin()){
            if($recharge['type'] == 1){ // 微信
                $recharge['type'] = 3;
            }
            if($recharge['type'] == 2){ // 支付宝
                $recharge['type'] = 4;
            }
        }

        switch ($recharge['type']) {
            case 1:
                //微信二维码支付
                $NativePay = new NativePay();
                $params = [
                    'out_trade_no' => $recharge['order_num'],
                    'body' => '书币充值',
                    'total_fee' => intval($recharge['amount'] * 100),
                    'product_id' => $recharge['id'],
                ];
                $getPayImage = $NativePay->getPayImage($params, 150, 150, $this->wechat_redirect_url);
                $this->assign('order_sn', $recharge['order_num']);
                $this->assign('code_url', $getPayImage);
                $this->assign('data', $recharge);
                return view();
                break;
            case 2:
                //支付宝支付
                //$recharge['amount'] = 0.01;
                $params = [
                    'out_trade_no' => $recharge['order_num'],
                    'subject' => '书币充值',
                    'total_amount' => intval($recharge['amount']),
                    'body' => '支付宝充值书币',
                ];
                $config = [
                    'return_url' => $this->ali_redirect_url,
                    'notify_url' => $this->alipay_notify_redirect_url,
                    'pid' => '2088331285396695',
                    'md5key' => 'we36626lnbo7cd0vg9zl79p8lfn3rlgd'
                ];
                $Pagepay = new Pagepay();
                $Pagepay->pays($params,$config);
                break;
            case 3:
                //获取微信配置信息
                $arrWxPayConf = $this->weChatConfig();

                $jsApi = new JsapiPay($arrWxPayConf);
//                $recharge['amount'] = 0.01;
                $data = [
                    'out_trade_no' => $recharge['order_num'],
                    'body' => '书币充值',
                    'total_fee' => intval($recharge['amount'] * 100),
                    'product_id' => $recharge['id'],
                ];

                $code = input('get.code', '', 'trim');

                if (empty($code)) {
                    //触发微信返回code码
                    $baseUrl = urlencode('http://' . $_SERVER['HTTP_HOST'] . $_SERVER['REQUEST_URI'] . $_SERVER['QUERY_STRING']);
                    $WxPayJsPay = new \WxPayJsPay();
                    $url = $WxPayJsPay->CreateOauthUrlForCode($baseUrl);
                    header("Location: $url");
                    exit();
                }
                $jsApiParameters = $jsApi->getPayParams($data, $code, $arrWxPayConf);
//                $jsdata = json_decode($jsApiParameters);
//                c_print($jsdata);die;
                $this->assign('jsApiParameters', $jsApiParameters);
                $this->assign('order_id', $recharge['id']);
                $this->assign('pay_type', $recharge['pay_type']);
                return view('mobile'); //微信移动端支付
                break;
            case 5:
                // 充值会员
                $arrWxPayConf = $this->weChatConfig();

                $jsApi = new JsapiPay($arrWxPayConf);
//                $recharge['amount'] = 0.01;
                $data = [
                    'out_trade_no' => $recharge['order_num'],
                    'body' => '充值会员',
                    'total_fee' => intval($recharge['amount'] * 100),
                    'product_id' => $recharge['id'],
                ];
//                c_print($data);die;
                $code = input('get.code', '', 'trim');

                if (empty($code)) {
                    //触发微信返回code码
                    $baseUrl = urlencode('http://' . $_SERVER['HTTP_HOST'] . $_SERVER['REQUEST_URI'] . $_SERVER['QUERY_STRING']);
                    $WxPayJsPay = new \WxPayJsPay();
                    $url = $WxPayJsPay->CreateOauthUrlForCode($baseUrl);
                    header("Location: $url");
                    exit();
                }
                $jsApiParameters = $jsApi->getPayParams($data, $code, $arrWxPayConf);

                $this->assign('jsApiParameters', $jsApiParameters);
                $this->assign('order_id', $recharge['id']);
                $this->assign('pay_type', $recharge['pay_type']);
                return view('mobile'); //微信移动端支付
                break;
            case 4:
                // 公众号支付宝支付
                $data = [
                    'out_trade_no' => $recharge['order_num'],
                    'subject' => '书币充值',
                    'total_amount' => intval($recharge['amount']),
                    'body' => '支付宝充值书币',
                ];
                self::alipay_wap($data); //手机端支付
                break;
            default:
                $this->error('未知错误');
                break;
        }
        return view();
    }


    /**
     * 支付宝WAP端支付
     * @data 支付的参数
     */

    static function alipay_wap($data)
    {
        $alipay_config = self::$alipay_config; //获取配置

        $parameter = [];
        $parameter['out_trade_no'] = $data['out_trade_no'];
        $parameter['subject'] = $data['subject'];
        $parameter['total_amount'] = $data['total_amount'];
        $parameter['body'] = $data['body'];
        $payRequestBuilder = new Wappay();
        $payRequestBuilder->pays($parameter, $alipay_config);
    }


    /**
     * 获取支付宝配置参数
     * return array
     */

    static function alipay_config()
    {
        $data = [];
        $data['app_id'] = '2018103061906438';
        $data['alipay_public_key'] = 'MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAtkT4akqyNKp0uWeGqB+z11zsVTrBGZL7d+hpouN9AMj2CrfsIWqarQWBaOu69F/LWfdRAVQG2hN6KUZ/fBJt5azgiRuZ8DTOraF3d9Dye1FQudhW8Ux84NhsD52Q/UXhOwQf6KPf/vKpq3kzKcm67gh4ez+O08OE/YrPm28etLB05ez01TLXHHNMY4J49b2ESUUxTWlLG8s/rR+DMqkgZMaMMLy+MMYGspH0BXJZigiTJbKOIezyWYv5B8Vt9nyZeSBEhjlCv7iVELkh27iF28EkRfFGcSR6BIjhhkkc7l59Qmmdf2h4BJly8u+iUAp9E8Xv0JT2anhHZsgBWj0mwQIDAQAB';
        $data['merchant_private_key'] = 'MIIEpAIBAAKCAQEAxXMOfHjtY5Jbb0L8m0CoNceegr0mhYpp07AzMfKT37Wv65B3hsmm5LV+uRE1Jec5WnnoZrLpbcLagQLlkCa9Gwt87rTO3O5LjgoiutK6MYvuzSDZ0kD2jHORkt/bSBU7wCu0a0y9wIiMQVzI/gzoraWonS92vxAXT4ZatI/AqVNb8nZJcCFuZ4KJfo+0sXaph5Vu7JMeAMv9xTpcylKe8tZavCsAEiGygRM3Yp8+u93eEJLnkKCr6qaoiYr5TfyaeR1fiN9qVKNRf/cemgPSxJebMrS0zEv05FfpqKHI43cCr6NVk3D3DWxAckQo9u/z95xsR2FFnhh8JJSTz75iOwIDAQABAoIBAG3/QQy62ZTlDicXrF5ZUNxVDstK0NEIYRhbSsoCl7rDHvQekVf3sxAqxCQZoAAzplHvJDdCaKSLLus8T+NUkXkllz3sYGnYHyNMJjjp+GxtxmVkbbSiGDf6khi+uQyZN6ZBMsur/vHpoCkxpY9SZbWHWj3nGUIrlrDo6lM42l35ZPVLoeOkQ6H7XDTpUsBpbLjYAOuge1RlB76T7EOcmrAbCWx4SVmxirZyPVC+XuXfzDf4U3ad67wDFfER+UhAbZW4JWnPje5Lyb4dU1gWThtfXiq6Gb/YvWd6VUbkn5r9jLka4EiiCI7mX+tQ1QMX2mHgu709Xgj2S3+HqRh/fgECgYEA9gOmKuE2243Hpl9gpDAkXKLaUTuJYb6HM2q8FWvUvlN/nb7VcoTpx1C1jBGemTovswPRUfg0OWvStHvaf4IuXViAOy8cLMBkFVBNe8UY7FwX9u2Uj4aG4Twg370CMEVVkRzQ9qucwoOkmISXyP/ZxJzR21YQ12JtERJ2mRLYIoECgYEAzXbEZsGxzB74rHTCRagC4IR/BtXzxI3+TpzFW7h187evhlCxNk+tQ9T3u9C0BjmttGmEp+59kUqnkbDwKxSP1clq0UoXcJV0e3YNq30FOIviOwIwc59c5qsB7R8XL3/1NyH9tTIqYrmp7y8sDpnds6eeVqzJjqAMQv4gG0yqLrsCgYEAqEXItA3GMxjgVelpNgUD6iUuRV/+0U+8NKwuKEzQgLqmUKTGZQWKzl1jQIKQw+gr1junQnUOa7RXtEH/KzZFNm4hj9niYK3cB0QdK6qeKJW5gpnxAtcWjRtOtRsYUyIprA9U01SA7f+TZwtSsxZlwvktBeTxshFN3t6NJpjgI4ECgYEAu4Mv3WPawyJk6ucoQfACqCrjzzZF4dWBCPe0em/PXhz+mQNdp+Zxh51+di8TjTbom+VNBwH2ITpT0ff8SCTc3EyVKuqGl94eT2q/MQnJUQEA97+YvnzriSz6dhDQ1S3fenCQHeTpn+43861GdRDhr8tDC3FoBb11U1KftKp0Cm8CgYBpCnxr5kO82krJycMF8ERdym3Y4g3yyJpDFfGOux+2c887hxcZ/Rh5SKnRVXzT31cbwQIfysR6KnqxdaPVcgR937y2r32pm3diUqmc4sphW/4/byRrGqjqwONWQSZ/RhWaX0xV2Tl0qWBVE98B/b78P4NFn8H6hy0nu/l+yOZ01A==';
        $data['charset'] = 'UTF-8';
        $data['sign_type'] = 'RSA2';
        $data['gatewayUrl'] = 'https://openapi.alipay.com/gateway.do';
        $data['notify_url'] = 'http://' . $_SERVER['HTTP_HOST'] . '/home/pay/alipay_notify.html'; //异步通知页面
        $data['return_url'] = 'http://' . $_SERVER['HTTP_HOST'] . '/home/pay/alipay_return.html'; //支付成功跳转页面
        self::$alipay_config = $data;
    }


    /**
     * 获取微信支付配置参数
     * return array
     */
    private function weChatConfig()
    {
        $weixin_config['app_id'] = 'wxcf37498f9c333e27' ;
        $weixin_config['mch_id'] = '1518808251' ;
        $weixin_config['md5_key'] = '971559dc30511ec04a74895239cb5a2f' ;
        $weixin_config['APPSECRET'] = 'b2c4dd94398c52f336965eed129588d0' ;
        $weixin_config['notify_url'] = 'http://' . $_SERVER['HTTP_HOST'] . '/home/pay/redirect_url.html';                  //异步通知页面
        $weixin_config['return_url'] = 'http://' . $_SERVER['HTTP_HOST'] . '/home/Pay/return.html'; //支付成功跳转页面
        $weixin_config['JS_API_CALL_URL'] = urlencode('http://' . $_SERVER['HTTP_HOST'] . $_SERVER['REQUEST_URI']);
        return $weixin_config;
    }

    /**
     * 生成微信支付二维码
     */
    public function phpqrcode()
    {
        $NativePay = new NativePay();
        $NativePay->qrcode();
    }

    /**
     * 查询微信二维码支付
     */
    public function orderquery()
    {
        $order_sn = input('get.order_sn', '', 'trim');
        $Query = new Query();
        $result = $Query->exec($order_sn);
        //[trade_state] => NOTPAY
        //判断该订单是否支付，如果支付则自动跳回到成功支付页面，如果未支付，则不管
        if ($result['trade_state'] == 'SUCCESS'){
            $this->success('支付成功');
        }
        exit;
    }


    /**
     * 微信成功回调地址
     * 异步通知
     */
    public function redirect_url()
    {
        $Notify = new Notify();
        $Notify->Handle();
    }

    /**
     * 支付成功之后处理订单
     */
    public function pay_success($buy_info, $total_fee, $seller_id)
    {

        $u = Db::name('recharge')->where('order_num', $buy_info)->find();

        if($u['is_pay'] == 1){
            return true;
        }

        if (!$u) {
            $return_result = [
                'msg' => '订单没找到',
                'seller_id' => $seller_id,
                'create_time' => date('Y-m-d H:i:s')
            ];
            Db::name('error_log')->insert($return_result);
            return false;
        }
        $log = Db::name('recharge_log')->where(['order_num' => $buy_info])->find();
        if ($log) {
            return true;
        }

        Db::startTrans();
        try{
            $data_log = [
                'order_num' => $buy_info,
                'seller_id' => $seller_id,
                'total_fee' => $total_fee,
                'u_id' => $u['u_id'],
                'create_time' => date('Y-m-d H:i:s', time())
            ];

            // 增加充值日志
            Db::name('recharge_log')->insert($data_log);

            //修改订单状态
            $order_data = [
                'pay_time' => time(),
                'seller_id' => $seller_id,
                'is_pay' => 1,
            ];
            Db::name('recharge')->where('id', $u['id'])->update($order_data);
            $user = Db::name('Member')->where('id', $u['u_id'])->field('id,money,is_vip,vip_create_time')->find();
            if ($u['type'] == 5) {
                // 充值会员
                if ($user['is_vip'] == 1){ // 充值过会员
                    $data = [
                        'vip_create_time' => date('Y-m-d H:i:s',time())
                    ];
                }else{ // 没有充值过会员
                    $data = [
                        'is_vip' => 1,
                        'vip_create_time' => date('Y-m-d H:i:s',time())
                    ];
                }
            }else{
                // 修改用户书币余额
                $now = intval($user['money'] + intval($u['amount']*100));
                $data = [
                    'money' => $now
                ];
            }
            Db::name('Member')->where('id', $u['u_id'])->update($data);

            // 提交事务
            Db::commit();
            return true;
        } catch (\Exception $e) {
            // 回滚事务
            Db::rollback();
            return false;
        }

    }


    public function vip(){
        $u_id = 2;
        $user = Db::name('Member')->where('id', $u_id)->field('id,money,is_vip,vip_create_time')->find();
        $time = time(); // 现在的时间戳
        if ($user['is_vip'] == 1){ // 充值过会员
            $vip = date("Y-m-d H:i:s",strtotime("+1months",strtotime($user['vip_create_time'])));//上次会员过期日期

            $vipTime = strtotime($vip);
            if ($time > $vipTime){ // 已过期
                $data = [
                    'vip_create_time' => date('Y-m-d H:i:s',time())
                ];
            }else{ // 还没有过期

                $out_time = date("Y-m-d H:i:s",strtotime($vip));

                $data = [
                    'vip_create_time' => $out_time
                ];
            }
        }else{ // 没有充值过会员
            $data = [
                'is_vip' => 1,
                'vip_create_time' => date('Y-m-d H:i:s',time())
            ];
        }
        $res = Db::name('Member')->where('id', $u_id)->update($data);
        return $res;
    }

    /**
     * 支付宝同步回调
     */
    public function alipay_return()
    {
        $alipay = new ReturnRul();
        $verify_result = $alipay->check($this->app_id);
        if ($verify_result) {
            $out_trade_no = input('get.out_trade_no', '', 'trim');//订单号
            $seller_id = input('get.trade_no', '', 'trim');
            $total_fee = input('get.total_amount', '', 'trim');
            $pay_success = $this->pay_success($out_trade_no, $total_fee, $seller_id);

            if ($pay_success) {
                $this->success('支付成功', url('home/info/wallet'));
            }
            exit();
        }
        $this->error('支付失败', url('home/index/index'));

    }


    /**
     * 支付宝异步回调
     */

    public function alipay_notify()
    {
        $alipay = new \alipay\Notify();
        $verify_result = $alipay->check($this->app_id);

        if ($verify_result) {
            if($_POST['trade_status'] != 'TRADE_SUCCESS' ){
                //业务处理
                die("fail");
            }
            $out_trade_no = input('post.out_trade_no', '', 'trim');//订单号
            $seller_id = input('post.trade_no', '', 'trim');//订单号
            $total_fee = input('post.total_amount', '', 'trim');//订单号
            $pay_success = $this->pay_success($out_trade_no, $total_fee, $seller_id);
            if ($pay_success) {
                die("success");
            }
            die("fail");
        } else {
            die("fail");
        }
    }

    public function assi21123gn()
    {
        $verify_result= [
            'out_trade_no' => '2154345865855750',
            'trade_no' => '2018112922001490761009543821',
            'total_amount' => '0.01',
            'trade_status' => 'TRADE_SUCCESS'
        ];

        if ($verify_result) {
            if($verify_result['trade_status'] != 'TRADE_SUCCESS' ){
                //业务处理
                die("fail");
            }
            $out_trade_no = $verify_result['out_trade_no'];//订单号
            $seller_id = $verify_result['trade_no'];
            $total_fee = $verify_result['total_amount'];

            $pay_success = $this->pay_success($out_trade_no, $total_fee, $seller_id);
            if ($pay_success) {
                $this->success('支付成功', url('home/info/wallet'));
            }
            exit();
        } else {
            die("fail");
        }
    }

    function is_weixin(){
        if ( strpos($_SERVER['HTTP_USER_AGENT'],'MicroMessenger') !== false ) {
            return true;
        }
        return false;
    }


}


