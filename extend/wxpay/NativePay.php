<?php

namespace wxpay;

use think\Loader;

require_once dirname(__FILE__) . DIRECTORY_SEPARATOR . 'lib/WxPayNativePay.php';

require_once dirname(__FILE__) . DIRECTORY_SEPARATOR . 'phpqrcode/phpqrcode.php';

/**
 * 扫码支付
 *
 * 用法:
 * 调用 \wxpay\NativePay::getPayImage($params) 即可
 */
class NativePay extends WxPayBase
{
    /**
     * 获取扫码支付的二维码图片
     *
     * @param array $params 订单信息
     * @param string $params ['body'] 商品简单描述
     * @param string $params ['out_trade_no'] 商户订单号, 要保证唯一性
     * @param string $params ['total_fee'] 标价金额, 请注意, 单位为分!!!!!
     * @param string $params ['product_id'] 商品ID
     *
     * @param string $width 二维码宽
     * @param string $height 二维码长
     *
     * @return string img标签
     */
    public function getPayImage($params, $width = 150, $height = 150, $redirect_url = '')
    {
        // 1.校检参数
        $that = new self();
        $that->checkParams($params);

        // 2.组装参数
        $input = $that->getPostData($params, $redirect_url);

        // 3.进行请求
        $tools = new \WxPayNativePay();
        $result = $tools->GetPayUrl($input);

        // 4.进行结果检验
        $that->checkResult($result);

        // 5.返回支付二维码图片
        $url = $result["code_url"];
        return $url;
    }

    public function qrcode()
    {
        $url = input('get.data', '', 'trim');
        if (substr($url, 0, 6) == "weixin") {
            \QRcode::png($url);
        } else {
            header('HTTP/1.1 404 Not Found');
        }
    }

    // 组装请求参数
    private function getPostData($params, $redirect_url)
    {
        $input = new \WxPayUnifiedOrder();
        $input->SetBody($params['body']);
        $input->SetOut_trade_no($params['out_trade_no']);
        $input->SetTotal_fee($params['total_fee']);
        // $input->SetGoods_tag("test");
        $input->SetNotify_url($redirect_url);
        $input->SetTrade_type("NATIVE");
        $input->SetProduct_id($params['product_id']);
        return $input;
    }
}