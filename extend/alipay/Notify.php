<?php

namespace alipay;


require_once dirname(__FILE__) . DIRECTORY_SEPARATOR . 'pay/service/AlipayTradeService.php';

class Notify
{
    /**
     * 异步通知校检, 包括验签和数据库信息与通知信息对比
     *
     * @param array $params 数据库中查询到的订单信息
     * @param string $params ['out_trade_no'] 商户订单
     * @param float $params ['total_amount'] 订单金额
     */
    public function check($app_id)
    {
        // 1.第一步校检签名
        $alipaySevice = new \AlipayTradeService();
        $signResult = $alipaySevice->check($_POST);
        if (!$signResult) {
            return false;
        }
        if ($app_id != $_POST['app_id']) {
            return false;
        }
        return true;
    }

}