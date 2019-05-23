<?php


namespace app\home\controller;

use alipay\Pagepay;
use alipay\Refund;
use app\api\controller\Template;
use Pays\Alipay;
use think\Db;
use alipay\Wappay;
use alipay\Notify;
use alipay\ReturnRul;
use wxpay\JsapiPay;
use wxpay\NativePay;
use wxpay\Query;


class Pays extends Common
{
    static $alipay_config = array();

    public function __construct()
    {
        parent::__construct();
        self::alipay_config(); //获取支付宝参数配置
    }

    public function verify_point($recharge)
    {
        $orders_goods1 = Db::name('orders_goods')->field(['point_id', 'count(point_id) as count'])->where(['order_id' => $recharge['id']])->group('point_id')->select();

        foreach ($orders_goods1 as $value1) {
            $get_point = Db::name('point_trips')->alias('a')->field(['a.number', 'a.id'])->join([['point b', 'b.id=a.point_id']])->where([['a.combo_id', '=', $recharge['combo_id']], ['a.id', '=', $value1['point_id']]])->group('a.id')->find();
            $get_user_number = get_goods_count($value1['point_id']);
            if (($get_point['number'] - $get_user_number) < $value1['count']) {
                $this->error('您下单的订单团期已经满了');
            }
        }
    }

    protected function verify_repertory($recharge)
    {
        $data = Db::name('goods_order_goods')->alias('a')->where(['order_id' => $recharge['id']])->select();
        $is_stockout = '';
        foreach ($data as $value) {
            $get_cart_price = get_cart_price($value['storage_id'], $value['format_id']);

            if (!$get_cart_price['number'] || ($get_cart_price['number'] == 0) || ($get_cart_price['number'] < $value['number'])) {
                $is_stockout = 1;
            }
        }
        if ($is_stockout == 1) {
            return false;
        }
        return true;
    }

    public function index()
    {
        $type = input('get.type', 0, 'intval');
        $id = input('get.id', 0, 'intval');
        $orders = input('get.orders', 0, 'intval');
        if (!$id) {
            $this->error("订单不错在");
        }
        if (!$type) {
            $this->error("请选择支付方式");
        }
        if ($orders == 1) {
            //出行支付
            $recharge = Db::name('orders')->where([['id', '=', $id], ['user_id', '=', $this->user_id]])->find();

            $id = $recharge['order_sn'];
            $this->verify_point($recharge);

            $data['title'] = $recharge['title'] . '--' . $recharge['combo'] . '--' . date('Y-m-d', $recharge['time']);
            $data['body'] = $recharge['title'] . '--' . $recharge['combo'] . '--' . date('Y-m-d', $recharge['time']);
            $recharge['order_sn'] = 'buy_' . $recharge['order_sn'];
        } elseif ($orders == 3) {
            //商城支付
            $recharge = Db::name('goods_order')->where([['id', '=', $id], ['user_id', '=', $this->user_id]])->find();
            $id = $recharge['order_sn'];
            if (!$this->verify_repertory($recharge)) {
                $this->error("商品库存不足");
            }
            $data['title'] = '趣户外商城订单支付';
            $data['body'] = '趣户外商城订单支付';
            $recharge['order_sn'] = 'goods_' . $recharge['order_sn'];
        } else {
            $recharge = Db::name('order')->where([['id', '=', $id], ['user_id', '=', $this->user_id]])->find();
            switch ($recharge['pay_type']) {
                case 1:
                    $data['title'] = '充值金额';
                    $data['body'] = '充值金额';
                    $recharge['order_sn'] = 'charge_' . $recharge['order_sn'];
                    break;
                case 2:
                    $data['title'] = '购买会员';
                    $data['body'] = '购买会员';
                    $recharge['order_sn'] = 'user_' . $recharge['order_sn'];
                    break;
            }
        }
        if (!$recharge) {
            $this->error('支付失败,请重试');
        }
        $data['order_sn'] = $recharge['order_sn'];
        $data['total_fee'] = $recharge['amount'];
        $data['total_fee'] = 0.02;
        if ($type == 2 && !is_weixin()) {
            $type = 3;
        }
        $is_market = Db::name('members')->where(['id' => $this->user_id])->value('is_market');
        if ($is_market && ($type == 2 || $type == 3)) {
            $type = 4;
        }
        if ($is_market && ($type == 1)) {
            $type = 5;
        }
        switch ($type) {
            case 1:
                self::alipay_wap($data); //手机端支付
                break;
            case 2:
                //获取微信配置信息
                $arrWxPayConf = $this->weChatConfig();
                $jsApi = new JsapiPay($arrWxPayConf);
                $data = [
                    'body' => $data['body'],
                    'out_trade_no' => $data['order_sn'],
                    'total_fee' => $data['total_fee'] * 100,
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
                $this->assign('jsApiParameters', $jsApiParameters);
                $this->assign('id', $id);
                $this->assign('pay_type', $recharge['pay_type']);
                $this->assign('orders', $orders);

                return view(); //微信移动端支付
                break;
            case 3:
                //获取微信配置信息
                $arrWxPayConf = $this->weChatConfig();
                $jsApi = new \wxpay\WapPay();
                $data = [
                    'body' => $data['body'],
                    'out_trade_no' => $data['order_sn'],
                    'total_fee' => $data['total_fee'] * 100,
                    'appid' => $arrWxPayConf['app_id'],
                    'mch_id' => $arrWxPayConf['mch_id'],
                    'md5_key' => $arrWxPayConf['md5_key'],
                    'notify_url' => 'http://' . $_SERVER['HTTP_HOST'] . '/home/pays/notify_h5.html',
                ];
                $mweb_url = $jsApi->getPayUrl($data, 'http://' . $_SERVER['HTTP_HOST'] . url('members/orders/show', ['id' => $id]));
                header('location:' . $mweb_url);
                exit;
                break;
            case 4:
                //微信PC端支付
                $arrWxPayConf = $this->weChatConfig();
                $NativePay = new NativePay($arrWxPayConf);
                $params = [
                    'body' => $data['body'],
                    'out_trade_no' => $data['order_sn'],
                    'total_fee' => $data['total_fee'] * 100,
                ];
                $recharge['title'] = $data['title'];
                $code_url = $NativePay->getPayImage($params, '150', '150', $arrWxPayConf['notify_url']);
                $this->assign('code_url', $code_url);
                $this->assign('url', url('members/orders/show', ['id' => $id]));
                $this->assign('data', $recharge);
                return view('pc_pay');
                break;
            case 5:
                $alipay_config = self::$alipay_config; //获取配置
                $parameter = [];
                $parameter['out_trade_no'] = $data['order_sn'];
                $parameter['subject'] = $data['title'];
                $parameter['total_amount'] = $data['total_fee'];
                $parameter['body'] = $data['body'];
                $payRequestBuilder = new Pagepay();
                $payRequestBuilder->pays($parameter, $alipay_config);
                break;
        }

    }

    /**
     * 扫码支付
     */
    public function phpqrcode()
    {
        $NativePay = new NativePay();
        $NativePay->qrcode();
    }

    //订单查询
    public function orderquery()
    {
        $order_sn = input('get.order_sn', '', 'trim');
        $Query = new Query();
        $result = $Query->exec('buy_' . $order_sn);
        if ($result['trade_state'] == 'SUCCESS') {
            JsonDie(1, '支付成功');
        } else {
            die();
        }
    }

    public function pay()
    {
        return view();
    }

    public function part_refund($order_id, $pay_price, $id)
    {
        //判断订单是否存在优惠券
        $join = [
            ['orders b', 'b.id=a.order_id'],
            ['coupon c', 'c.id=b.coupon_id', 'left'],
            ['sale d', 'd.id=c.sale_id', 'left'],
        ];
        $ordersList = Db::name('orders_goods')->alias('a')->field(['b.preferential_price', 'b.amount', 'd.min_price', 'a.price', 'b.room_sharing', 'b.id', 'b.pay_price', 'c.id as coupon_id', 'b.pay_type', 'b.serial_id', 'b.order_sn', 'a.username', 'a.phone', 'a.number', 'b.product_id', 'a.price', 'b.user_id', 'a.order_id', 'a.members_price', 'b.return_premium'])->join($join)->where([['a.id', '=', $id], ['b.is_pay', '=', 1], ['b.status', '=', 7], ['a.is_delete', '=', 0], ['b.id', '=', $order_id]])->find();
        if (!$ordersList) {
            JsonDie(0, '订单不存在');
        }
        //判断订单是否还剩一个用户,如果还剩一个用户则直接取消订单
        $count = Db::name('orders_goods')->where([['order_id', '=', $ordersList['id']], ['is_delete', '=', 0]])->count();
        if ($count == 1) {
            $result = $this->common_refund($order_id, $pay_price);
            return $result;
        }
        if (!$ordersList) {
            JsonDie(0, '订单不符合退订条件');
        }

        if (($pay_price > $ordersList['pay_price'])) {
            JsonDie(0, '订单不符合退订条件');
        }
        $pay_price = floatval($pay_price);
        if (!$pay_price || $pay_price == 0) {
            JsonDie(0, '您的订单不符合退订条件');
        }
//        $refund_price = Db::name('refund')->where(['orders_id' => $ordersList['order_id'], 'type' => 2, 'is_refund' => 1])->select();
//        dump($refund_price);exit;
        $ordersList['pay_price'] = $ordersList['return_premium'] + $ordersList['pay_price'];

        $user_id = $ordersList['user_id'];
        $orders_number = orders_number();
        switch ($ordersList['pay_type']) {
            //支付宝支付
            case 1:
                $alipay_config = self::$alipay_config; //获取配置
                $alipay_config['trade_no'] = $ordersList['serial_id'];

                $alipay_config['refund_amount'] = $pay_price;
//                $alipay_config['refund_amount'] = 0.01;
                $alipay_config['out_request_no'] = 'refund_' . $orders_number;
//                self::alipay_refund($alipay_config); //手机端支付
                $Refund = new Refund();

                $data = $Refund->exec($alipay_config);
                if (!($data['msg'] == 'Success' && $data['code'] == '10000')) {
                    JsonDie(0, '退款失败');
                }
                $new_data = [
                    'refund_fee' => $data['refund_fee'],
                    'send_back_fee' => $data['send_back_fee'],
                    'transaction_id' => $data['trade_no'],
                    'out_trade_no' => $data['out_trade_no'],
                ];
                $result = $this->part_refund_verify($new_data, 1, $ordersList, $id, $user_id);
                if (!$result) {
                    JsonDie(0, '退款失败');
                }
                break;
            //微信
            case 2:
            case 3:
                $params = [
                    'transaction_id' => $ordersList['serial_id'],
                    'total_fee' => $ordersList['pay_price'] * 100,
                    'refund_fee' => $pay_price * 100,
//                    'refund_fee' => 0.01 * 100,
                    'out_trade_no' => 'buy_' . $ordersList['order_sn'],
                    'out_refund_no' => 'refund_' . $orders_number,
                ];
                $Refund = new \wxpay\Refund();
                $arrWxPayConf = $this->weChatConfig();
                if ($ordersList['pay_type'] == 2) {
                    $arrWxPayConf = [];
                }
                $data = $Refund->exec($params, $arrWxPayConf);
                if (!($data['return_msg'] == 'OK' && $data['result_code'] == 'SUCCESS')) {
                    JsonDie(0, '退款失败');
                }
                $new_data = [
                    'refund_fee' => $data['refund_fee'] / 100,
                    'send_back_fee' => $data['send_back_fee'] / 100,
                    'transaction_id' => $data['trade_no'],
                    'out_trade_no' => $data['out_trade_no'],
                ];
                $result = $this->part_refund_verify($new_data, $ordersList['pay_type'], $ordersList, $id, $user_id);
                if (!$result) {
                    JsonDie(0, '退款失败');
                }
//                $this->success('退款成功', url('members/orders/show', ['id' => $ordersList['id']]));
                break;
            case 4:
                //现金支付
                $new_data = [
                    'refund_fee' => $pay_price,
                    'send_back_fee' => $ordersList['pay_price'] - $pay_price,
                    'transaction_id' => $ordersList['serial_id'],
                    'out_trade_no' => 'buy_' . $ordersList['order_sn'],
                ];
                $result = $this->part_refund_verify($new_data, 4, $ordersList, $id, $user_id);
                if (!$result) {
                    JsonDie(0, '退款失败');
                }
                break;
            default:
                $result = false;
                break;
        }
        return $result;
    }

    public function part_refund_verify($result, $type, $orders_goods, $id, $user_id)
    {

        $out_trade_no = explode('_', $result['out_trade_no']);
        $out_trade_no = $out_trade_no[1];
        if (!$out_trade_no) {
            return false;
        }
//        $is_log = Db::name('members_paylog')->where([['order_sn', '=', $out_trade_no], ['type', '=', 5]])->find();
//        if ($is_log) {
//            return true;
//        }
        $orders_goods1 = Db::name('orders_goods')->where(['id' => $id])->find();

        // 启动事务
        Db::startTrans();
        try {
            //获取订单号
            $order = Db::name('orders')->alias('a')->field(['a.*', 'c.keywords1'])->join([['product c', 'c.id=a.product_id']])->where([['a.order_sn', '=', $out_trade_no]])->find();
            if (!$order) {
                return false;
            }
            $time = time();
            //生成支付日志
            $data = [
                "order_sn" => $out_trade_no,
                "user_id" => $user_id,
                'price' => $result['refund_fee'],
                'type' => 5,
                'status' => 1,
                'pay_id' => $result['transaction_id'],
                'pay_type' => $type,
                'create_time' => $time,
                'remark' => '订单部分退订,退订人姓名:' . $orders_goods['username'] . ';退订人电话' . $orders_goods['phone'] . ';退订人证件号码' . $orders_goods['number'] . ';剩余金额' . $result['send_back_fee'],
                'goods_id' => $id,
            ];
            $results = Db::name('members_paylog')->insert($data);
            if (!$results) {
                return false;
            }

            if ($orders_goods1['members_price'] > 0 || $orders_goods1['members_price'] === 0) {
                $point = intval($order['point'] - $result['refund_fee'] * 2);
            } else {
                $point = intval($order['point'] - $result['refund_fee']);
            }

            if (!$order['point']) {
                $point = 0;
            }
            Db::name('orders')->where([['id', '=', $orders_goods['id']]])->update(['pay_price' => ($order['pay_price'] - $orders_goods['price']), 'status' => 1, 'return_premium' => ($result['refund_fee'] + $order['return_premium']), 'point' => $point]);

            //删除订单商品
            Db::name('orders_goods')->where([['id', '=', $id]])->update(['is_delete' => 1]);

            //改变退款订单
            Db::name('refund')->where(['goods_id' => $id])->update(['is_refund' => 1, 'refund_type' => $type, 'refund_price' => $result['refund_fee'], 'refund_time' => time()]);

            //如果已经支付积分则扣除积分
            if ($order['point'] && ($order['is_use'] == 1)) {
                //验证用户是否是会员
                $result_refund_fee = $result['refund_fee'];
                if ($orders_goods1['members_price'] || $orders_goods1['members_price'] === 0) {
                    $result_refund_fee = $result_refund_fee * 2;
                }
                Db::name('members')->where([['id', '=', $order['user_id']]])->setDec('point', intval($result_refund_fee));
            }

        } catch (\Exception $e) {
            // 回滚事务
            Db::rollback();
            return false;
        }
        Db::commit();//关闭事务,并且执行sql

        //退保险
        $Insure = new Insure();
        $Insure->returnPremium($id);


        //发送退款短信
        $members = Db::name('members')->where(['id' => $order['user_id']])->find();
        if ($members['openid']) {
            $Template = new Template($members['openid']);
            $first = '您好，您的退款申请已通过审核';
            if (!$order['keywords1']) {
                $title = date('Y年m月d日', $order['time']) . '出发' . $order['title'] . ' ' . '一日游';
            } else {
                $title = date('Y年m月d日', $order['time']) . '出发' . $order['title'] . ' ' . daxie($order['keywords1']) . '日游';
            }
            $order_sn = $order['order_sn'];
            $type = '单人退款（' . $orders_goods1['username'] . '）';
            $amount = $result['refund_fee'] . '元';
            $jindu = '审核已通过';
            $content = '款项预计在1-5个工作日原路退回到原支付账户';
            $url = 'http://' . $_SERVER['HTTP_HOST'] . url('members/orders/show', ['id' => $order['id']]);
            $result = $Template->application_for_drawback($first, $title, $order_sn, $type, $amount, $jindu, $content, $url);
            if (!$result) {
                if (!$members['phone']) {
                    $members['phone'] = $orders_goods1['phone'];
                }
                $abbreviation = Db::name('product')->where(['id' => $order['product_id']])->value('abbreviation');
                if (!$abbreviation) {
                    $abbreviation = $order['title'];
                }
                return_premium(date('Y-m-d', $order['time']), $abbreviation, $result['refund_fee'], $members['phone']);
            }
        } else {
            if (!$members['phone']) {
                $members['phone'] = $orders_goods1['phone'];
            }
            $abbreviation = Db::name('product')->where(['id' => $order['product_id']])->value('abbreviation');
            if (!$abbreviation) {
                $abbreviation = $order['title'];
            }
            return_premium(date('Y-m-d', $order['time']), $abbreviation, $result['refund_fee'], $members['phone']);
        }
        return $order['id'];
    }

    protected function common_percent($product_id, $id)
    {
        $time = time();
        $data = Db::name('ticket')->where([['product_id', '=', $product_id]])->group('day desc')->select();

        $orders = Db::name('orders')->alias('a')->where([['id', '=', $id], ['user_id', '=', $this->user_id], ['is_pay', '=', 1], ['status', '=', 1]])->find();
        foreach ($data as $value) {
            $start_time = strtotime(date('Y-m-d', $orders['time'] - (24 * 3600 * $value['day'])) . ' ' . $value['time']);
            if ($value['cid'] == 1) {
                if ($start_time > $time) {
                    $percent = $value['percent'];
                    break;
                }
            } elseif ($value['cid'] == 2) {
                if ($start_time < $time) {
                    $percent = $value['percent'];
                    break;
                }
            } else {

            }
        }
        return $percent;
    }

    /**
     * 订单退款
     */
    public function common_refund($id, $pay_price)
    {
        $ordersList = Db::name('orders')->alias('a')->where([['id', '=', $id], ['is_pay', '=', 1], ['status', '=', 7]])->find();
        if (!$ordersList) {
            JsonDie(0, '订单不符合退订条件');
        }
        if ($pay_price > $ordersList['pay_price']) {
            JsonDie(0, '订单不符合退订条件');
        }
        if (!$pay_price || floatval($pay_price) == 0) {
            JsonDie(0, '您的订单不符合退订条件');
        }

        $refund_price = Db::name('refund')->where(['orders_id' => $ordersList['id'], 'type' => 2, 'is_refund' => 1])->sum('refund_price');

        $ordersList['pay_price'] = $ordersList['amount'];

        $refund_order = 'refund_' . orders_number();
        switch ($ordersList['pay_type']) {
            //支付宝支付
            case 1:
                $alipay_config = self::$alipay_config; //获取配置
                $alipay_config['trade_no'] = $ordersList['serial_id'];
                $alipay_config['out_trade_no'] = 'buy_' . $ordersList['order_sn'];
                $alipay_config['refund_amount'] = $pay_price;
                $alipay_config['out_request_no'] = $refund_order;
//                dump($alipay_config);exit;
//                self::alipay_refund($alipay_config); //手机端支付
                $Refund = new Refund();
                $data = $Refund->exec($alipay_config);
                if (!($data['msg'] == 'Success' && $data['code'] == '10000')) {
                    JsonDie(0, '退款失败');
                }
                $new_data = [
                    'refund_fee' => $data['refund_fee'],
                    'transaction_id' => $data['trade_no'],
                    'out_trade_no' => $data['out_trade_no'],
                ];
                $result = $this->refund_verify($new_data, 1);
                if (!$result) {
                    JsonDie(0, '退款失败');
                }
                return true;
                break;
            //微信公众号退款
            case 2:
                //微信H5支付
            case 3:
                $params = [
                    'transaction_id' => $ordersList['serial_id'],
                    'total_fee' => $ordersList['pay_price'] * 100,
                    'refund_fee' => $pay_price * 100,
                    'out_trade_no' => 'buy_' . $ordersList['order_sn'],
                    'out_refund_no' => $refund_order,
                ];
                $Refund = new \wxpay\Refund();
                $arrWxPayConf = $this->weChatConfig();
                if ($ordersList['pay_type'] == 2) {
                    $arrWxPayConf = [];
                }
                $data = $Refund->exec($params, $arrWxPayConf);
                if (!($data['return_msg'] == 'OK' && $data['result_code'] == 'SUCCESS')) {
                    JsonDie(0, '退款失败');
                }
                $new_data = [
                    'refund_fee' => $data['refund_fee'] / 100,
                    'send_back_fee' => $data['send_back_fee'] / 100,
                    'transaction_id' => $data['trade_no'],
                    'out_trade_no' => $data['out_trade_no'],
                ];
                $result = $this->refund_verify($new_data, 2);
                if (!$result) {
                    JsonDie(0, '退款失败');
                }
                return true;
                break;
            //现金支付
            case 4:
                $new_data = [
                    'refund_fee' => $pay_price,
                    'transaction_id' => $ordersList['serial_id'],
                    'out_trade_no' => 'buy_' . $ordersList['order_sn'],
                ];
                $result = $this->refund_verify($new_data, 4);
                if (!$result) {
                    JsonDie(0, '退款失败');
                }
                return true;
                break;
        }
    }


    /**
     * 订单退款
     */
    public function refund()
    {
        if (!$_SESSION['zmcms']['adminAuth']) {
            JsonDie(0, '权限不够');
        }
        $id = input('get.id', 0, 'intval');
        $goods_id = input('get.goods_id', 0, 'intval');
        $price = input('get.price', '', 'trim');
        if (!$id) {
            JsonDie(0, '退款订单不存在');
        }
        if (!$price) {
            JsonDie(0, '请输入退款金额');
        }
        if ($goods_id) {
            $result = $this->part_refund($id, $price, $goods_id);
        } else {
            $result = $this->common_refund($id, $price);
        }
        if (!$result) {
            JsonDie(0, '退款失败');
        }
        JsonDie(1, '退款' . $price . '成功');
    }


    private function refund_verify($result, $type)
    {
        $out_trade_no = explode('_', $result['out_trade_no']);
        $out_trade_no = $out_trade_no[1];
        if (!$out_trade_no) {
            return false;
        }
        $is_log = Db::name('members_paylog')->where([['order_sn', '=', $out_trade_no], ['type', '=', 4]])->find();
        if ($is_log) {
            return true;
        }
        // 启动事务
        Db::startTrans();
        try {
            //获取订单号
            $order = Db::name('orders')->alias('a')->field(['a.*', 'c.keywords1'])->join([['product c', 'c.id=a.product_id']])->where([['a.order_sn', '=', $out_trade_no]])->find();
            if (!$order) {
                return false;
            }
            //优惠券
            if ($order['coupon_id']) {
                //不扣除优惠券金额, 直接退支付金额,将优惠券从已使用改成未使用
                Db::name('coupon')->where(['id' => $order['coupon_id']])->update(['is_use' => 2]);
            }
            $time = time();
            //生成支付日志
            $data = [
                "order_sn" => $out_trade_no,
                "user_id" => $order['user_id'],
                'price' => $result['refund_fee'],
                'type' => 4,
                'status' => 1,
                'pay_id' => $result['transaction_id'],
                'pay_type' => $type,
                'create_time' => $time,
                'remark' => '整体订单退款,退款金额' . ($result['refund_fee']) . '扣除积分' . $order['point'],
                'point' => $order['point']
            ];
            $results = Db::name('members_paylog')->insert($data);
            if (!$results) {
                return false;
            }
            //改变订单状态
            $updateOrder = [
                'return_transaction' => $result['transaction_id'],//流水号
                'pay_time' => $time,//支付时间
                'is_pay' => 3, //退款
                'status' => 5,
                'pay_type' => $type,
                'return_premium' => $result['refund_fee'] + $order['return_premium'],
            ];
            $update = Db::name('orders')->where(['id' => $order['id']])->update($updateOrder);
            if (!$update) {
                return false;
            }
            //改变退款订单
            Db::name('refund')->where(['orders_id' => $order['id']])->update(['is_refund' => 1, 'refund_type' => $type, 'refund_price' => $result['refund_fee'], 'refund_time' => time()]);

            //如果已经支付积分则扣除积分
            if ($order['point'] && ($order['is_use'] == 1)) {
                Db::name('members')->where([['id', '=', $order['user_id']]])->setDec('point', $order['point']);
            }

        } catch (\Exception $e) {
            // 回滚事务
            Db::rollback();
            return false;
        }
        Db::commit();//关闭事务,并且执行sql

        //退保险
        $Insure = new Insure();
        $orders_goods = Db::name('orders_goods')->where(['order_id' => $order['id']])->select();
        foreach ($orders_goods as $value_goods) {
            if ($value_goods['is_delete'] == 1 || !$value_goods['orders_insurance']) {
                continue;
            }
            $Insure->returnPremium($value_goods['id']);
        }

        //发送退款短信
        $members = Db::name('members')->where(['id' => $order['user_id']])->find();
        if ($members['openid']) {
            $Template = new Template($members['openid']);
            $first = '您好，您的退款申请已通过审核';
            if (!$order['keywords1']) {
                $title = date('Y年m月d日', $order['time']) . '出发' . $order['title'] . ' ' . '一日游';
            } else {
                $title = date('Y年m月d日', $order['time']) . '出发' . $order['title'] . ' ' . daxie($order['keywords1']) . '日游';
            }
            $order_sn = $order['order_sn'];
            $type = '整单退款';
            $amount = $result['refund_fee'] . '元';
            $jindu = '审核已通过';
            $content = '款项预计在1-5个工作日原路退回到原支付账户';
            $url = 'http://' . $_SERVER['HTTP_HOST'] . url('members/orders/show', ['id' => $order['id']]);
            $result = $Template->application_for_drawback($first, $title, $order_sn, $type, $amount, $jindu, $content, $url);
            if (!$result) {
                $product = Db::name('product')->where(['id' => $order['product_id']])->find();
                if (!$product['abbreviation']) {
                    $product['abbreviation'] = $order['title'];
                }
                $members = Db::name('members')->where(['id' => $order['user_id']])->find();
                if ($members['phone']) {
                    return_premium(date('Y-m-d', $order['time']), $product['abbreviation'], $result['refund_fee'], $members['phone']);
                }
            }
        } else {
            $product = Db::name('product')->where(['id' => $order['product_id']])->find();
            if (!$product['abbreviation']) {
                $product['abbreviation'] = $order['title'];
            }
            $members = Db::name('members')->where(['id' => $order['user_id']])->find();
            if ($members['phone']) {
                return_premium(date('Y-m-d', $order['time']), $product['abbreviation'], $result['refund_fee'], $members['phone']);
            }
        }
        return $order['id'];
    }

    /**
     * 支付宝WAP端支付
     * @data 支付的参数
     */

    static function alipay_wap($data)
    {
        $alipay_config = self::$alipay_config; //获取配置
        $parameter = [];
        $parameter['out_trade_no'] = $data['order_sn'];
        $parameter['subject'] = $data['title'];
        $parameter['total_amount'] = $data['total_fee'];
        $parameter['body'] = $data['body'];
        $payRequestBuilder = new Wappay();
        $payRequestBuilder->pays($parameter, $alipay_config);
//        $alipaySubmit = new Alipay($alipay_config);
//        $html_text = $alipaySubmit->buildRequestForm($parameter, "get", "确认");
//        die($html_text);
    }


    /**
     * 微信异步回调
     * @author 四川挚梦科技有限公司
     * @date 2017-05-03
     */
    public function notify()
    {
        $Notify = new \wxpay\Notify();
        $Notify->Handle();
    }

    /**
     * 微信异步回调
     * @author 四川挚梦科技有限公司
     * @date 2017-05-03
     */
    public function notify_h5()
    {
        $arrWxPayConf = $this->weChatConfig();
        $Notify = new \wxpay\Notify($arrWxPayConf);
        $Notify->Handle();
    }


    /**
     * 同步回调
     */

    public function alipay_return()
    {
        $alipay_config = self::$alipay_config;
//        dump($alipay_config);exit;
        $alipay = new ReturnRul();
        $verify_result = $alipay->check($alipay_config);
        if ($verify_result) {
            $out_trade_no = input('get.out_trade_no', '', 'trim');//订单号
            $seller_id = input('get.trade_no', '', 'trim');//订单号
            $total_fee = input('get.total_amount', '', 'trim');//订单号
            $buy_info = explode("_", $out_trade_no);
            $orderList = Db::name('order')->where(['order_sn' => $buy_info[1]])->find();
            if ($orderList['is_pay'] == 1) {
                switch ($buy_info[0]) {
                    case 'charge':
                        $this->success('支付成功', url('members/capital/index'));
                        break;
                    case 'user':
                        $this->success('支付成功', url('members/Coupon/index'));
                        break;
                    case 'buy':
                        $this->redirect(url('members/orders/lists'));
                        break;
                    case 'goods':
                        $this->success('支付成功', url('members/goods/index'));
                }
            }
            $pay_success = '';
            switch ($buy_info[0]) {
                case 'charge':
                    $pay_success = $this->pay_success($buy_info[1], $total_fee, $seller_id, 1);
                    if ($pay_success) {
                        $this->success('支付成功', url('members/capital/index'));
                    }
                    break;
                case 'user':
                    $pay_success = $this->user_success($buy_info[1], $total_fee, $seller_id, 1);
                    if ($pay_success) {
                        $this->success('支付成功', url('members/Coupon/index'));
                    }
                    break;
                case 'buy':
                    $pay_success = $this->buy_success($buy_info[1], $total_fee, $seller_id, 1);
                    if ($pay_success) {
                        $this->redirect(url('home/orders/success_orders', ['id' => $buy_info[1]]));
                    }
                    break;
                case 'goods':
                    $pay_success = $this->goods_success($buy_info[1], $total_fee, $seller_id, 1);
                    if ($pay_success) {
                        $this->redirect(url('home/orders/success_goods', ['id' => $buy_info[1]]));
                    }
                    break;
            }
        }
        $this->error('支付失败', url('home/index/index'));

    }


    /**
     * 异步回调
     */

    public function alipay_notify()
    {
        $alipay_config = self::$alipay_config;
        $alipay = new Notify();
        $verify_result = $alipay->check($alipay_config);
        if ($verify_result) {
            if ($_POST['trade_status'] != 'TRADE_SUCCESS') {
                //业务处理
                die("fail");
            }
            $out_trade_no = input('post.out_trade_no', '', 'trim');//订单号
            $seller_id = input('post.trade_no', '', 'trim');//订单号
            $total_fee = input('post.total_amount', '', 'trim');//订单号
            $buy_info = explode("_", $out_trade_no);
            $pay_success = '';
            switch ($buy_info[0]) {
                case 'charge':
                    $pay_success = $this->pay_success($buy_info[1], $total_fee, $seller_id, 1);
                    break;
                case 'user':
                    $pay_success = $this->user_success($buy_info[1], $total_fee, $seller_id, 1);
                    break;
                case 'buy':
                    $pay_success = $this->buy_success($buy_info[1], $total_fee, $seller_id, 1);
                    break;
                case 'goods':
                    $pay_success = $this->goods_success($buy_info[1], $total_fee, $seller_id, 1);
                    break;

            }
            if ($pay_success) {
                die("success");
            } else {
                die("fail");
            }
        } else {
            die("fail");
        }
    }

    public function buy_success($out_trade_no, $money, $trade_no, $type)
    {
        if (!$out_trade_no) {
            return false;
        }
        $is_log = Db::name('members_paylog')->where([['order_sn', '=', $out_trade_no], ['type', '=', 3]])->find();
        if ($is_log) {
            return true;
        }
        // 启动事务
        Db::startTrans();
        try {
            //获取订单号
            $order = Db::name('orders')->where([['order_sn', '=', $out_trade_no]])->find();
            if (!$order) {
                return false;
            }
            $time = time();
            $members = Db::name('members')->alias('a')->field(['a.point', 'b.end_time'])->join([['contacts b', 'b.user_id=a.id']])->where([['a.id', '=', $order['user_id']]])->find();
            if ($members['end_time'] && $members['end_time'] > time()) {
                $point = intval($money) * 2;
            } else {
                $point = intval($money);
            }
            //生成支付日志
            $data = [
                "order_sn" => $out_trade_no,
                "user_id" => $order['user_id'],
                'price' => $money,
                'type' => 3,
                'status' => 1,
                'pay_id' => $trade_no,
                'pay_type' => $type,
                'create_time' => $time,
                'point' => $point,
            ];
            $result = Db::name('members_paylog')->insert($data);
            if (!$result) {
                return true;
            }

            //这里不增加用户积分, 订单完成后定时执行
//            Db::name('members')->where([['id', '=', $order['user_id']]])->update(['point' => ($members['point'] + $point)]);
            //改变订单状态
            $updateOrder = [
                'serial_id' => $trade_no,//流水号
                'pay_time' => $time,//支付时间
                'is_pay' => 1,
                'pay_type' => $type,
                'pay_price' => $money,
                'point' => $point,
            ];
            $update = Db::name('orders')->where(['id' => $order['id']])->update($updateOrder);
            if (!$update) {
                return false;
            }
        } catch (\Exception $e) {
            // 回滚事务
            Db::rollback();
            return false;
        }
        Db::commit();//关闭事务,并且执行sql
        get_success($out_trade_no);
        return $order['id'];
    }


    /*
     *  充值方法
     *  @out_trade_no 订单编号
     *  @user_id 用户id
     *  @money 金额
     * 	@type 类型
     *  @remark 备注
     */

    public function pay_success($out_trade_no, $money, $trade_no, $type)
    {
        if (!$out_trade_no) {
            return false;
        }
        $is_log = Db::name('members_paylog')->where(['order_sn' => $out_trade_no])->find();
        if ($is_log) {
            return true;
        }
        // 启动事务
        Db::startTrans();
        try {
            //获取订单号
            $order = Db::name('order')->where(['order_sn' => $out_trade_no])->find();
            if (!$order) {
                return false;
            }
            //获取金额变动前的余额
            $money_before = Db::name('members')->where(['id' => $order['user_id']])->value('money');
            Db::name('members')->where(['id' => $order['user_id']])->update(['money' => $money_before + $money]);
            //获取变动后的余额
            switch ($order['pay_type']) {
                case 1://充值
                    $money_after = $money + $money_before;
                    $update_user = Db::name('members')->where(['id' => $order['user_id']])->update(['money' => $money_after]);
                    break;
                case 2://余额购买

                    break;
                default:
                    return false;
                    break;
            }
            $time = time();
            //生成支付日志
            $data = [
                "order_sn" => $out_trade_no,
                "user_id" => $order['user_id'],
                'price' => $money,
                'type' => $type,
                'status' => 1,
                'pay_id' => $trade_no,
                'pay_type' => $order['pay_type'],
                'create_time' => $time,
            ];
            $result = Db::name('members_paylog')->insert($data);
            if (!$result) {
                return true;
            }
            //改变订单状态
            $updateOrder = [
                'pay_id' => $trade_no,//流水号
                'pay_time' => $time,//支付时间
                'pay_price' => $money,
                'is_pay' => 1
            ];
            $update = Db::name('order')->where(['id' => $order['id']])->update($updateOrder);
            if (!$update) {
                return false;
            }
        } catch (\Exception $e) {
            // 回滚事务
            Db::rollback();
            return false;
        }
        Db::commit();//关闭事务,并且执行sql
        return true;
    }


    /*
 *  充值方法
 *  @out_trade_no 订单编号
 *  @user_id 用户id
 *  @money 金额
 * 	@type 类型
 *  @remark 备注
 */

    public function user_success($out_trade_no, $money, $trade_no, $type)
    {
        if (!$out_trade_no) {
            return false;
        }
        $is_log = Db::name('members_paylog')->where(['order_sn' => $out_trade_no])->find();
        if ($is_log) {
            return true;
        }
        // 启动事务
        Db::startTrans();
        try {
            //获取订单号
            $order = Db::name('order')->where(['order_sn' => $out_trade_no])->find();
            if (!$order) {
                return false;
            }
            $end_time = strtotime('+' . $order['time'] . ' month');
            //生成会员日期
            Db::name('contacts')->where(['id' => $order['plus_id']])->update(['end_time' => $end_time, 'is_use' => 0, 'type' => 0, 'is_sharing' => 0]);
            $time = time();
            //生成支付日志
            $data = [
                "order_sn" => $out_trade_no,
                "user_id" => $order['plus_id'],
                'price' => $money,
                'type' => $type,
                'status' => 1,
                'pay_id' => $trade_no,
                'pay_type' => $order['pay_type'],
                'create_time' => $time,
            ];
            $result = Db::name('members_paylog')->insert($data);
            if (!$result) {
                return true;
            }
            //改变订单状态
            $updateOrder = [
                'pay_id' => $trade_no,//流水号
                'pay_price' => $money,
                'pay_time' => $time,//支付时间
                'is_pay' => 1
            ];
            $update = Db::name('order')->where(['id' => $order['id']])->update($updateOrder);
            //发放3张200元的现金券
            $time = time();
            $saleList = Db::name('sale')->where([['type_id', '=', 1], ['issue', '=', 1], ['start_time', '<=', $time], ['end_time', '>', $time], ['sale_id', '=', 2]])->select();
            $data_coupon = [];
            foreach ($saleList as $value) {
                $data_coupon[] = [
                    'user_id' => $order['user_id'],
                    'sale_id' => $value['id'],
                    'is_use' => 2,
                    'get_time' => $time,
                    'type' => 2,
                    'create_time' => $time,
                    'expire_time' => time() + 2592000 * $value['validity']
                ];
            }
            Db::name('coupon')->insertAll($data_coupon);
            if (!$update) {
                return false;
            }
        } catch (\Exception $e) {
            // 回滚事务
            Db::rollback();
            return false;
        }
        Db::commit();//关闭事务,并且执行sql
        $contacts = Db::name('contacts')->alias('a')->field(['a.username', 'a.phone', 'b.openid', 'c.number'])->join([['members b', 'b.phone=a.phone', 'left'], ['contacts_type c', 'c.contacts_id=a.id']])->where(['a.id' => $order['plus_id']])->find();
        if ($contacts['openid']) {
            $Template = new Template($contacts['openid']);
            $username = $contacts['username'] . '(' . trimHtml($contacts['number'], 0, 6) . '******' . trimHtml($contacts['number'], 14, 4) . ')';
            $url = 'http://' . $_SERVER['HTTP_HOST'] . url('members/coupon/index');
            $result = $Template->user_plus($username, $url);
            if (!$result) {
                user_msg($contacts['phone'], $contacts['username'], date('Y-m-d', $end_time));
            }
        } else {
            user_msg($contacts['phone'], $contacts['username'], date('Y-m-d', $end_time));
        }
        return true;
    }


    public function goods_success($out_trade_no, $money, $trade_no, $type)
    {
        if (!$out_trade_no) {
            return false;
        }
        $is_log = Db::name('members_paylog')->where([['order_sn', '=', $out_trade_no], ['type', '=', 6]])->find();
        if ($is_log) {
            return true;
        }
        // 启动事务
        Db::startTrans();
        try {
            //获取订单号
            $order = Db::name('goods_order')->where([['order_sn', '=', $out_trade_no], ['is_pay', '=', 2]])->find();
            if (!$order) {
                return false;
            }
            $time = time();
            $members = Db::name('members')->alias('a')->field(['a.point', 'b.end_time'])->join([['contacts b', 'b.user_id=a.id']])->where([['a.id', '=', $order['user_id']]])->find();
            if ($members['end_time'] && $members['end_time'] > time()) {
                $point = intval($money) * 2;
            } else {
                $point = intval($money);
            }
            //生成支付日志
            $data = [
                "order_sn" => $out_trade_no,
                "user_id" => $order['user_id'],
                'price' => $money,
                'type' => 6,
                'status' => 1,
                'pay_id' => $trade_no,
                'pay_type' => $type,
                'create_time' => $time,
                'point' => $point,
            ];
            $result = Db::name('members_paylog')->insert($data);
            if (!$result) {
                return true;
            }

            //这里不增加用户积分, 订单完成后定时执行
//            Db::name('members')->where([['id', '=', $order['user_id']]])->update(['point' => ($members['point'] + $point)]);
            //改变订单状态
            $updateOrder = [
                'serial_id' => $trade_no,//流水号
                'pay_time' => $time,//支付时间
                'is_pay' => 1,
                'pay_type' => $type,
                'pay_price' => $money,
                'status' => 2,
                'point' => $point,
            ];
            $update = Db::name('goods_order')->where(['id' => $order['id']])->update($updateOrder);
            if (!$update) {
                return false;
            }
        } catch (\Exception $e) {
            // 回滚事务
            Db::rollback();
            return false;
        }
        Db::commit();//关闭事务,并且执行sql
        return $order['id'];
    }

    /**
     * 获取支付宝配置参数
     * return array
     */

    static function alipay_config()
    {

        $alipays = Db("payment")->where([["id", '=', 1]])->find();
        $alipay_config = json_decode($alipays['value'], true);
        $data = [];
        $data['app_id'] = $alipay_config['appid'];
        $data['alipay_public_key'] = $alipay_config['ali_public_key'];
        $data['merchant_private_key'] = $alipay_config['rsa_private_key'];
        $data['charset'] = 'UTF-8';
        $data['sign_type'] = 'RSA2';
        $data['gatewayUrl'] = 'https://openapi.alipay.com/gateway.do';
        $data['notify_url'] = 'http://' . $_SERVER['HTTP_HOST'] . '/home/Pays/alipay_notify.html'; //异步通知页面
        $data['return_url'] = 'http://' . $_SERVER['HTTP_HOST'] . '/home/Pays/alipay_return.html'; //支付成功跳转页面
        self::$alipay_config = $data;
    }


    /**
     * 获取微信支付配置参数
     * return array
     */

    private function weChatConfig()
    {
        $alipays = Db("payment")->where([["id", '=', 3]])->find();
        $weixin_config = json_decode($alipays['value'], true);
        $weixin_config['notify_url'] = 'http://' . $_SERVER['HTTP_HOST'] . '/home/pays/notify.html'; //异步通知页面
        $weixin_config['return_url'] = 'http://' . $_SERVER['HTTP_HOST'] . '/home/Pays/return.html'; //支付成功跳转页面
        $weixin_config['JS_API_CALL_URL'] = urlencode('http://' . $_SERVER['HTTP_HOST'] . $_SERVER['REQUEST_URI']);
        return $weixin_config;
    }






    //用户商品退款


    /**
     * 订单退款
     */
    public function refund_goods()
    {
        if (!$_SESSION['zmcms']['adminAuth']) {
            JsonDie(0, '权限不够');
        }
        $id = input('get.id', 0, 'intval');
        $goods_id = input('get.goods_id', 0, 'intval');
        $price = input('get.price', '', 'trim');
        if (!$id) {
            JsonDie(0, '退款订单不存在');
        }
        if (!$price) {
            JsonDie(0, '请输入退款金额');
        }
        $refund = Db::name('refund1')->where(['id' => $id, 'goods_id' => $goods_id])->find();
        if ($refund['type'] == 2) {
            $result = $this->common_part_refund_goods($refund['orders_id'], $price, $goods_id);
        } else {
            $result = $this->common_refund_goods($refund['orders_id'], $price);
        }
        if (!$result) {
            JsonDie(0, '退款失败');
        }
        JsonDie(1, '退款' . $price . '成功');
    }

    public function common_part_refund_goods($order_id, $pay_price, $id)
    {
        //判断订单是否存在优惠券
        $join = [
            ['goods_order b', 'b.id=a.order_id'],
            ['coupon c', 'c.id=b.coupon_id', 'left'],
            ['sale d', 'd.id=c.sale_id', 'left'],
        ];
        $ordersList = Db::name('goods_order_goods')->alias('a')->field(['b.*', 'd.min_price', 'a.price', 'c.id as coupon_id', 'a.number', 'a.order_id'])->join($join)->where([['a.id', '=', $id], ['b.is_pay', '=', 1], ['b.status', 'in', [8, 10]], ['a.is_delete', '=', 0], ['b.id', '=', $order_id]])->find();
        if (!$ordersList) {
            JsonDie(0, '订单不存在');
        }
        //判断订单是否还剩一个用户,如果还剩一个用户则直接取消订单
        $count = Db::name('orders_goods')->where([['order_id', '=', $ordersList['id']], ['is_delete', '=', 0]])->count();
        if ($count == 1) {
            $result = $this->common_refund_goods($order_id, $pay_price);
            return $result;
        }
        if (!$ordersList) {
            JsonDie(0, '订单不符合退订条件');
        }

        if (($pay_price > $ordersList['pay_price'])) {
            JsonDie(0, '订单不符合退订条件');
        }
        $pay_price = floatval($pay_price);
        if (!$pay_price || $pay_price == 0) {
            JsonDie(0, '您的订单不符合退订条件');
        }
//        $refund_price = Db::name('refund')->where(['orders_id' => $ordersList['order_id'], 'type' => 2, 'is_refund' => 1])->select();
//        dump($refund_price);exit;
        $ordersList['pay_price'] = $ordersList['return_premium'] + $ordersList['pay_price'];

        $user_id = $ordersList['user_id'];
        $orders_number = orders_number();
        switch ($ordersList['pay_type']) {
            //支付宝支付
            case 1:
                $alipay_config = self::$alipay_config; //获取配置
                $alipay_config['trade_no'] = $ordersList['serial_id'];

                $alipay_config['refund_amount'] = $pay_price;
//                $alipay_config['refund_amount'] = 0.01;
                $alipay_config['out_request_no'] = 'refund_' . $orders_number;
//                self::alipay_refund($alipay_config); //手机端支付
                $Refund = new Refund();

                $data = $Refund->exec($alipay_config);
                if (!($data['msg'] == 'Success' && $data['code'] == '10000')) {
                    JsonDie(0, '退款失败');
                }
                $new_data = [
                    'refund_fee' => $data['refund_fee'],
                    'send_back_fee' => $data['send_back_fee'],
                    'transaction_id' => $data['trade_no'],
                    'out_trade_no' => $data['out_trade_no'],
                ];
                $result = $this->part_refund_verify_goods($new_data, 1, $ordersList, $id, $user_id);
                if (!$result) {
                    JsonDie(0, '退款失败');
                }
                break;
            //微信
            case 2:
            case 3:
                $params = [
                    'transaction_id' => $ordersList['serial_id'],
                    'total_fee' => $ordersList['pay_price'] * 100,
                    'refund_fee' => $pay_price * 100,
//                    'refund_fee' => 0.01 * 100,
                    'out_trade_no' => 'buy_' . $ordersList['order_sn'],
                    'out_refund_no' => 'refund_' . $orders_number,
                ];
                $Refund = new \wxpay\Refund();
                $arrWxPayConf = $this->weChatConfig();
                if ($ordersList['pay_type'] == 2) {
                    $arrWxPayConf = [];
                }
                $data = $Refund->exec($params, $arrWxPayConf);
                if (!($data['return_msg'] == 'OK' && $data['result_code'] == 'SUCCESS')) {
                    JsonDie(0, '退款失败');
                }
                $new_data = [
                    'refund_fee' => $data['refund_fee'] / 100,
                    'send_back_fee' => $data['send_back_fee'] / 100,
                    'transaction_id' => $data['trade_no'],
                    'out_trade_no' => $data['out_trade_no'],
                ];
                $result = $this->part_refund_verify_goods($new_data, $ordersList['pay_type'], $ordersList, $id, $user_id);
                if (!$result) {
                    JsonDie(0, '退款失败');
                }
//                $this->success('退款成功', url('members/orders/show', ['id' => $ordersList['id']]));
                break;
            case 4:
                //现金支付
                $new_data = [
                    'refund_fee' => $pay_price,
                    'send_back_fee' => $ordersList['pay_price'] - $pay_price,
                    'transaction_id' => $ordersList['serial_id'],
                    'out_trade_no' => 'buy_' . $ordersList['order_sn'],
                ];
                $result = $this->part_refund_verify_goods($new_data, 4, $ordersList, $id, $user_id);
                if (!$result) {
                    JsonDie(0, '退款失败');
                }
                break;
            default:
                $result = false;
                break;
        }
        return $result;
    }

    public function ceshi()
    {
        $id = '50';
        $order_id = '56';
        $user_id = '19728';
        $join = [
            ['goods_order b', 'b.id=a.order_id'],
            ['coupon c', 'c.id=b.coupon_id', 'left'],
            ['sale d', 'd.id=c.sale_id', 'left'],
        ];
        $ordersList = Db::name('goods_order_goods')->alias('a')->field(['b.*', 'd.min_price', 'a.price', 'c.id as coupon_id', 'a.number', 'a.order_id'])->join($join)->where([['a.id', '=', $id], ['b.is_pay', '=', 1], ['b.status', 'in', [8, 10]], ['a.is_delete', '=', 0], ['b.id', '=', $order_id]])->find();
        $new_data = [
            'refund_fee' => 0.01,
            'send_back_fee' => 0.00,
            'transaction_id' => '2018120422001404091010009681',
            'out_trade_no' => 'goods_2018120418260710210152',
        ];
        $result = $this->part_refund_verify_goods($new_data, 1, $ordersList, $id, $user_id);
        dump($result);
        exit;
    }

    public function part_refund_verify_goods($result, $type, $orders_goods, $id, $user_id)
    {

        $out_trade_no = explode('_', $result['out_trade_no']);
        $out_trade_no = $out_trade_no[1];
        if (!$out_trade_no) {
            return false;
        }
//        $is_log = Db::name('members_paylog')->where([['order_sn', '=', $out_trade_no], ['type', '=', 8]])->find();
//        if ($is_log) {
//            return true;
//        }
        $orders_goods1 = Db::name('goods_order_goods')->where(['id' => $id])->find();

        if ($orders_goods1['is_delete'] == 1) {
            return false;
        }
        // 启动事务
        Db::startTrans();
        try {
            //获取订单号
            $order = Db::name('goods_order')->alias('a')->where([['a.order_sn', '=', $out_trade_no]])->find();
            if (!$order) {
                return false;
            }
            $time = time();

            //生成支付日志
            $data = [
                "order_sn" => $out_trade_no,
                "user_id" => $user_id,
                'price' => $result['refund_fee'],
                'type' => 8,
                'status' => 1,
                'pay_id' => $result['transaction_id'],
                'pay_type' => $type,
                'create_time' => $time,
                'remark' => '订单部分退订,退订人姓名:' . $orders_goods['username'] . ';退订人电话' . $orders_goods['phone'] . ';退款商品' . $orders_goods1['title'] . ' ' . $orders_goods1['format_title'],
                'goods_id' => $id,
            ];
            $results = Db::name('members_paylog')->insert($data);
            if (!$results) {
                return false;
            }

            //扣除积分
            $end_time = Db::name('contacts')->field(['id'])->where([['user_id', '=', $order['user_id']]])->value('end_time');
            if ($end_time > time()) {
                $is_user = 1;
                $point = intval($order['point'] - $result['refund_fee'] * 2);
            } else {
                $is_user = 0;
                $point = intval($order['point'] - $result['refund_fee']);
            }

            if (!$order['point']) {
                $point = 0;
            }
            if ($order['status'] == 10) {
                $evaluate = Db::name('evaluate')->where(['orders_id' => $order['id']])->find();
                if ($evaluate) {
                    $updateOrderStatus = 5;
                } else {
                    $updateOrderStatus = 4;
                }
                $is_refund = 5;
            } else {
                $updateOrderStatus = 2;
                $is_refund = 8;
            }
            Db::name('goods_order')->where([['id', '=', $order['id']]])->update(['pay_price' => ($order['pay_price'] - $orders_goods['price']), 'status' => $updateOrderStatus, 'return_premium' => ($result['refund_fee'] + $order['return_premium']), 'point' => $point]);

            //删除订单商品
            Db::name('goods_order_goods')->where([['id', '=', $id]])->update(['is_delete' => 1]);

            //改变退款订单
            Db::name('refund1')->where(['goods_id' => $id])->update(['is_refund' => $is_refund, 'refund_type' => $type, 'refund_price' => $result['refund_fee'], 'refund_time' => time()]);

            //如果已经支付积分则扣除积分
            if ($order['point'] && ($order['is_use'] == 1)) {
                //验证用户是否是会员
                $result_refund_fee = $result['refund_fee'];
                if ($is_user == 1) {
                    $result_refund_fee = $result_refund_fee * 2;
                }
                Db::name('members')->where([['id', '=', $order['user_id']]])->setDec('point', intval($result_refund_fee));
            }

        } catch (\Exception $e) {
            // 回滚事务
            Db::rollback();
            return false;
        }
        Db::commit();//关闭事务,并且执行sql

        return $order['id'];
    }


    /**
     * 订单退款
     */
    public function common_refund_goods($id, $pay_price)
    {
        $ordersList = Db::name('goods_order')->alias('a')->where([['id', '=', $id], ['is_pay', '=', 1], ['status', 'in', [8, 10]]])->find();
        if (!$ordersList) {
            JsonDie(0, '订单不符合退订条件');
        }
        if ($pay_price > $ordersList['pay_price']) {
            JsonDie(0, '订单不符合退订条件');
        }
        if (!$pay_price || floatval($pay_price) == 0) {
            JsonDie(0, '您的订单不符合退订条件');
        }

        $ordersList['pay_price'] = $ordersList['amount'];

        $refund_order = 'refund_' . orders_number();
        switch ($ordersList['pay_type']) {
            //支付宝支付
            case 1:
                $alipay_config = self::$alipay_config; //获取配置
                $alipay_config['trade_no'] = $ordersList['serial_id'];
                $alipay_config['out_trade_no'] = 'buy_' . $ordersList['order_sn'];
                $alipay_config['refund_amount'] = $pay_price;
                $alipay_config['out_request_no'] = $refund_order;
//                dump($alipay_config);exit;
//                self::alipay_refund($alipay_config); //手机端支付
                $Refund = new Refund();
                $data = $Refund->exec($alipay_config);
                if (!($data['msg'] == 'Success' && $data['code'] == '10000')) {
                    JsonDie(0, '退款失败');
                }
                $new_data = [
                    'refund_fee' => $data['refund_fee'],
                    'transaction_id' => $data['trade_no'],
                    'out_trade_no' => $data['out_trade_no'],
                ];
                $result = $this->refund_verify_goods($new_data, 1);
                if (!$result) {
                    JsonDie(0, '退款失败');
                }
                return true;
                break;
            //微信公众号退款
            case 2:
                //微信H5支付
            case 3:
                $params = [
                    'transaction_id' => $ordersList['serial_id'],
                    'total_fee' => $ordersList['pay_price'] * 100,
                    'refund_fee' => $pay_price * 100,
                    'out_trade_no' => 'buy_' . $ordersList['order_sn'],
                    'out_refund_no' => $refund_order,
                ];
                $Refund = new \wxpay\Refund();
                $arrWxPayConf = $this->weChatConfig();
                if ($ordersList['pay_type'] == 2) {
                    $arrWxPayConf = [];
                }
                $data = $Refund->exec($params, $arrWxPayConf);
                if (!($data['return_msg'] == 'OK' && $data['result_code'] == 'SUCCESS')) {
                    JsonDie(0, '退款失败');
                }
                $new_data = [
                    'refund_fee' => $data['refund_fee'] / 100,
                    'send_back_fee' => $data['send_back_fee'] / 100,
                    'transaction_id' => $data['trade_no'],
                    'out_trade_no' => $data['out_trade_no'],
                ];
                $result = $this->refund_verify_goods($new_data, 2);
                if (!$result) {
                    JsonDie(0, '退款失败');
                }
                return true;
                break;
            //现金支付
            case 4:
                $new_data = [
                    'refund_fee' => $pay_price,
                    'transaction_id' => $ordersList['serial_id'],
                    'out_trade_no' => 'buy_' . $ordersList['order_sn'],
                ];
                $result = $this->refund_verify_goods($new_data, 4);
                if (!$result) {
                    JsonDie(0, '退款失败');
                }
                return true;
                break;
        }
    }

    private function refund_verify_goods($result, $type)
    {
        $out_trade_no = explode('_', $result['out_trade_no']);
        $out_trade_no = $out_trade_no[1];
        if (!$out_trade_no) {
            return false;
        }
        $is_log = Db::name('members_paylog')->where([['order_sn', '=', $out_trade_no], ['type', '=', 7]])->find();
        if ($is_log) {
            return true;
        }
        // 启动事务
        Db::startTrans();
        try {
            //获取订单号
            $order = Db::name('goods_order')->alias('a')->where([['a.order_sn', '=', $out_trade_no]])->find();
            if (!$order) {
                return false;
            }
            //优惠券
            if ($order['coupon_id']) {
                //不扣除优惠券金额, 直接退支付金额,将优惠券从已使用改成未使用
                Db::name('coupon')->where(['id' => $order['coupon_id']])->update(['is_use' => 2]);
            }
            $time = time();
            //生成支付日志
            $data = [
                "order_sn" => $out_trade_no,
                "user_id" => $order['user_id'],
                'price' => $result['refund_fee'],
                'type' => 7,
                'status' => 1,
                'pay_id' => $result['transaction_id'],
                'pay_type' => $type,
                'create_time' => $time,
                'remark' => '整体订单退款,退款金额' . ($result['refund_fee']) . '扣除积分' . $order['point'],
                'point' => $order['point']
            ];
            $results = Db::name('members_paylog')->insert($data);
            if (!$results) {
                return false;
            }
            //改变订单状态
            $updateOrder = [
                'return_transaction' => $result['transaction_id'],//流水号
                'return_time' => $time,//支付时间
                'is_pay' => 3, //退款
                'pay_type' => $type,
                'return_premium' => $result['refund_fee'] + $order['return_premium'],
            ];
            if ($order['status'] == 10) {
                $updateOrder['status'] = 11;
                $is_refund = 5;
            } else {
                $updateOrder['status'] = 6;
                $is_refund = 8;
            }

            $update = Db::name('goods_order')->where(['id' => $order['id']])->update($updateOrder);
            if (!$update) {
                return false;
            }
            //改变退款订单
            Db::name('refund1')->where(['orders_id' => $order['id']])->update(['is_refund' => $is_refund, 'refund_type' => $type, 'refund_price' => $result['refund_fee'], 'refund_time' => time()]);

            //如果已经支付积分则扣除积分
            if ($order['point'] && ($order['is_use'] == 1)) {
                Db::name('members')->where([['id', '=', $order['user_id']]])->setDec('point', $order['point']);
            }

        } catch (\Exception $e) {
            // 回滚事务
            Db::rollback();
            return false;
        }
        Db::commit();//关闭事务,并且执行sql
        return $order['id'];
    }

}