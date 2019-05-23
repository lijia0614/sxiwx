<?php

namespace wxpay;

use think\Loader;

require_once dirname(__FILE__) . DIRECTORY_SEPARATOR . 'lib/WxPayNativePay.php';

/**
 * H5支付
 *
 * 调用 \wxpay\WapPay::getPayUrl($params, $redirect_url) 即可
 *
 *
 * ----------------- 求职 ------------------
 * 姓名: zhangchaojie      邮箱: zhangchaojie_php@qq.com  应届生
 * 期望职位: PHP初级工程师   地点: 深圳(其他城市亦可)
 * 能力:
 *     1.熟悉小程序开发, 前后端皆可
 *     2.后端, PHP基础知识扎实, 熟悉ThinkPHP5框架, 用TP5做过CMS, 商城, API接口
 *     3.MySQL, Linux都在进行进一步学习
 */
class WapPay extends WxPayBase
{
    /**
     * 获取预支付链接
     *
     * @param array $params 订单信息
     * @param string $params ['body'] 商品简单描述
     * @param string $params ['out_trade_no'] 商户订单号, 要保证唯一性
     * @param string $params ['total_fee'] 标价金额, 请注意, 单位为分!!!!!
     *
     * @param string $redirect_url 用户支付完成后会返回至发起支付的页面，如需返回至指定页面, 请传入 $redirect_url
     */
    public function getPayUrl($params, $redirect_url = '')
    {
        // 1.校检参数
        $that = new self();
        $that->checkParams($params);

        // 2.组装参数
        $input = $that->getPostData($params);

        // 3.获取预支付信息
        $order = \WxPayApi::unifiedOrder($input, 6, $params['md5_key']);

        // 4.预支付信息结果检验
        $that->checkResult($order);

        // 5.返回支付参数URL等到支付
        return $order['mweb_url'] .'&redirect_url='. urlencode($redirect_url);
    }

    // 组装请求参数
    private function getPostData($params)
    {
        $input = new \WxPayUnifiedOrder();
        $input->SetAppid($params['appid']);
        $input->SetMch_id($params['mch_id']);
        $input->SetBody($params['body']);
        $input->SetOut_trade_no($params['out_trade_no']);
        $input->SetTotal_fee($params['total_fee']);
        $input->SetNotify_url($params['notify_url']);
        $input->SetTrade_type('MWEB');
        return $input;
    }
}