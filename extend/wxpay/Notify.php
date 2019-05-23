<?php

namespace wxpay;

use app\admin\controller\update;
use think\Loader;
use think\Db;
use app\home\controller\Pay;

require_once 'lib/WxPayException.php';
require_once dirname(__FILE__) . DIRECTORY_SEPARATOR . 'lib/WxPayApi.php';
require_once dirname(__FILE__) . DIRECTORY_SEPARATOR . 'lib/WxPayNotify.php';

/**
 * 异步通知处理类
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
class Notify extends \WxPayNotify
{
    public $config = '';

    public function __construct($arrWxPayConf = '')
    {
        $this->config = $arrWxPayConf;
    }

    public function Handle()
    {
        parent::Handle($this->config['md5_key']);
        return true;
    }


    /**
     * 此为主函数, 即处理自己业务的函数, 重写后, 框架会自动调用
     *
     * @param array $data 微信传递过来的参数数组
     * @param string $msg 错误信息, 用于记录日志
     */
    public function NotifyProcess($data, &$msg)
    {
        // 一下均为实例代码
        // 1.校检参数
        if (!array_key_exists("transaction_id", $data)) {
            $msg = "输入参数不正确";
            return false;
        }

        // 2.微信服务器查询订单，判断订单真实性(可不需要)
        if ($data['trade_type'] != 'MWEB') {
            $this->config = [];
        }

        if (!$this->Queryorder($data["transaction_id"], $this->config)) {
            $msg = "订单查询失败";
            return false;
        }

        // 订单状态未修改情况下, 进行处理业务
        $result = $this->processOrder($data);
        if (!$result) {
            $msg = '订单处理失败';
            return false;
        }

        return true;
    }

    protected function processOrder($data)
    {
        $Pays = new Pay();
        $buy_info = $data['out_trade_no'];
        $total_fee = $data['total_fee'] / 100;
        $seller_id = $data['transaction_id'];
        $pay_success = $Pays->pay_success($buy_info, $total_fee, $seller_id);
        return $pay_success;
    }


    // 去微信服务器查询是否有此订单
    public function Queryorder($transaction_id, $config = '')
    {
        $input = new \WxPayOrderQuery();
        $input->SetTransaction_id($transaction_id);
        $result = \WxPayApi::orderQuery($input, 6, $config);

        if (array_key_exists("return_code", $result)
            && array_key_exists("result_code", $result)
            && $result["return_code"] == "SUCCESS"
            && $result["result_code"] == "SUCCESS"
        ) {
            return true;
        }
        return false;
    }

}

