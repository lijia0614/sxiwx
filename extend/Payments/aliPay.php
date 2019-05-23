<?php
namespace Payments;
use Payment\Common\PayException;
use Payment\Client\Charge;
use Payment\Config;
class aliPay {
    public function __construct() {
		$data=Db('payment')->where(array('alias' => 'alipay'))->find();
		$config=json_decode($data['value'],true);
		$config['app_id']=$config['appid'];
		$config['use_sandbox']=false;//是否沙盒模式
		$config['sign_type']='RSA2';
		$config['notify_url']="http://".$_SERVER['HTTP_HOST']."/members/pay/alipayNotify";
		$config['return_url']="http://".$_SERVER['HTTP_HOST']."/members/pay/alipayReturn";
		$config['return_raw']=true;//回调时是否返回原始数据
        $this->config = $config;

    }
	public function payPc($payDatas){
		$payData = array(
			'body'    => $payDatas['body'],//订单描述
			'subject'    => $payDatas['subject'],//订单标题
			'order_no'    => $payDatas['order_no'],
			'timeout_express' => time() + 600,// 表示必须 600s 内付款
			'amount'    => $payDatas['amount'],// 单位为元 ,最小为0.01
			'return_param' => $payDatas['return_param'],//返回参数
			'goods_type' => '1',// 0—虚拟类商品，1—实物类商品
		);
		try {
			$url = Charge::run(Config::ALI_CHANNEL_WEB, $this->config, $payData);
		} catch (PayException $e) {
			echo $e->errorMessage();
			exit;
		}
		return $url;
	}
	
	public function payWap($payDatas){
		$payData = array(
			'body'    => $payDatas['body'],//订单描述
			'subject'    => $payDatas['subject'],//订单标题
			'order_no'    => $payDatas['order_no'],
			'timeout_express' => time() + 600,// 表示必须 600s 内付款
			'amount'    => $payDatas['amount'],// 单位为元 ,最小为0.01
			'return_param' => $payDatas['return_param'],//返回参数
			'goods_type' => '1',// 0—虚拟类商品，1—实物类商品
		);
		try {
			$url = Charge::run(Config::ALI_CHANNEL_WAP, $this->config, $payData);
		} catch (PayException $e) {
			echo $e->errorMessage();
			exit;
		}
		return $url;
	}	
	
	
	
}
?>
