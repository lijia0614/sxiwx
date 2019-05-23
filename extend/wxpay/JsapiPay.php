<?php

namespace wxpay;

use think\Loader;

require_once dirname ( __FILE__ ).DIRECTORY_SEPARATOR.'lib/WxPayJsPay.php';


class JsapiPay extends WxPayBase
{
    /**
     * 获取支付参数
     * @param  array $params 订单数组
     * @param  string $code 登录凭证(公众号支付无需, 小程序支付需要)
     *
     * 小程序支付, 如果已将openId存入数据库, 可以直接调用 getParams($params, $openId)进行支付, 无需去服务器请求获取openID
     */
    public function getPayParams($params, $code = '', $config)
    {
        $tools = new \WxPayJsPay();
        $openId = $tools->GetOpenid($code);
        return $this->getParams($params, $openId, $config);
    }

    /**
     * 获取预支付信息
     *
     * @param array $params 订单信息
     * @param string $params ['body'] 商品简单描述
     * @param string $params ['out_trade_no'] 商户订单号, 要保证唯一性
     * @param string $params ['total_fee'] 标价金额, 请注意, 单位为分!!!!!
     *
     * @param string $openId 用户身份标识
     *
     * @return array 预支付信息
     */
    public function getParams($params, $openId = '', $config)
    {
        // 1.校检参数
        $that = new self();
        $that->checkParams($params);
        // 2.组装参数
        $input = $that->getPostData($params, $openId, $config);
        // 3.获取预支付信息
        $order = \WxPayApi::unifiedOrder($input,$config);
        // 4.进行结果检验
        $that->checkResult($order);
        // 5.组装支付参数
        $tools = new \WxPayJsPay();
        $jsApiParameters = $tools->GetJsApiParameters($order);

        // 6.返回支付参数
        return $jsApiParameters;
    }


    // 组装请求参数
    private function getPostData($params, $openId, $config)
    {
        $input = new \WxPayUnifiedOrder();
        $input->SetOpenid($openId);
        $input->SetTrade_type("JSAPI");
        // $input->SetGoods_tag("test");
        $input->SetBody($params['body']);
        $input->SetTotal_fee($params['total_fee']);
        $input->SetNotify_url($config['notify_url']);
        $input->SetOut_trade_no($params['out_trade_no']);
        return $input;
    }
}
