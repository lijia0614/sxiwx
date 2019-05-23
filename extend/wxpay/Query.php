<?php

namespace wxpay;

use think\Loader;

require_once 'lib/WxPayException.php';
require_once dirname ( __FILE__ ).DIRECTORY_SEPARATOR.'lib/WxPayApi.php';

/**
* 订单查询
*
* 用法:
* 调用 \wxpay\Query::exec($query_no) 即可
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
class Query
{
    // 商户订单号(out_trade_no) or 微信订单号(transaction_id) 二选一, 建议优先使用微信订单号
    const QUERY_TYPE = 'out_trade_no';

    /**
     * 执行请求
     *
     * @param  string $query_no 微信订单号或者商户订单号, 二选一
     * @return array           订单信息
     */
    public function exec($query_no)
    {
        // 1.组装请求数组
        $input = new \WxPayOrderQuery();

        if (self::QUERY_TYPE == 'transaction_id') {
            $input->SetTransaction_id($query_no);
        } else {
            $input->SetOut_trade_no($query_no);
        }

        // 2.进行请求
        $result = \WxPayApi::orderQuery($input);

        return $result;
    }
}
