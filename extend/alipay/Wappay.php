<?php

namespace alipay;

require_once dirname ( __FILE__ ).DIRECTORY_SEPARATOR.'pay/service/AlipayWapPayTradeService.php';
require_once dirname ( __FILE__ ).DIRECTORY_SEPARATOR.'pay/buildermodel/AlipayTradeWapPayContentBuilder.php';

class Wappay
{
    /**
     * 主入口
     * @param array $params 支付参数, 具体如下
     * @param string $params ['subject'] 订单标题
     * @param string $params ['out_trade_no'] 订单商户号
     * @param float $params ['total_amount'] 订单金额
     */
    public function pays($params, $alipay_config)
    {
        // 1.校检参数
        self::checkParams($params);

        // 2.构造参数
        $payRequestBuilder = new \AlipayTradeWapPayContentBuilder();
        $payRequestBuilder->setSubject($params['subject']);
        $payRequestBuilder->setBody($params['body']);
        $payRequestBuilder->setOutTradeNo($params['out_trade_no']);
        $payRequestBuilder->setTotalAmount($params['total_amount']);
        $payRequestBuilder->setTimeExpress('1m');

        // 3.获取配置

        $payResponse = new \AlipayWapPayTradeService($alipay_config);

        // 4.进行请求
        $result = $payResponse->wapPay($payRequestBuilder, $alipay_config['return_url'], $alipay_config['notify_url']);
        return $result;
    }


    /**
     * 校检参数
     */
    private function checkParams($params)
    {
//        c_print($params);die;
        if (empty(trim($params['out_trade_no']))) {
            self::processError('商户订单号(out_trade_no)必填');
        }

        if (empty(trim($params['subject']))) {
            self::processError('商品标题(subject)必填');
        }

        if (floatval(trim($params['total_amount'])) <= 0) {
            self::processError('退款金额(total_amount)为大于0的数');
        }
    }

    /**
     * 统一错误处理接口
     * @param  string $msg 错误描述
     */
    private static function processError($msg)
    {
        throw new \think\Exception($msg);
    }
}