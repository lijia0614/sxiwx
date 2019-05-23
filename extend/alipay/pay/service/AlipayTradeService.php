<?php
/* *
 * 功能：支付宝电脑网站支付
 * 版本：2.0
 * 修改日期：2017-05-01
 * 说明：
 * 以下代码只是为了方便商户测试而提供的样例代码，商户可以根据自己网站的需要，按照技术文档编写,并非一定要使用该代码。
 */

require_once dirname(dirname ( __FILE__ )).'/AopSdk.php';

class AlipayTradeService {

	//支付宝网关地址
	public $gateway_url = "https://openapi.alipay.com/gateway.do";

	//支付宝公钥
	public $alipay_public_key;

	//商户私钥
	public $private_key;

	//应用id
	public $appid;

	//编码格式
	public $charset = "UTF-8";

	public $token = NULL;

	//返回数据格式
	public $format = "json";

	//签名方式
	public $signtype = "RSA2";

	function __construct(){
		$this->appid = '2018103061906438';
		$this->private_key = 'MIIEpAIBAAKCAQEAxXMOfHjtY5Jbb0L8m0CoNceegr0mhYpp07AzMfKT37Wv65B3hsmm5LV+uRE1Jec5WnnoZrLpbcLagQLlkCa9Gwt87rTO3O5LjgoiutK6MYvuzSDZ0kD2jHORkt/bSBU7wCu0a0y9wIiMQVzI/gzoraWonS92vxAXT4ZatI/AqVNb8nZJcCFuZ4KJfo+0sXaph5Vu7JMeAMv9xTpcylKe8tZavCsAEiGygRM3Yp8+u93eEJLnkKCr6qaoiYr5TfyaeR1fiN9qVKNRf/cemgPSxJebMrS0zEv05FfpqKHI43cCr6NVk3D3DWxAckQo9u/z95xsR2FFnhh8JJSTz75iOwIDAQABAoIBAG3/QQy62ZTlDicXrF5ZUNxVDstK0NEIYRhbSsoCl7rDHvQekVf3sxAqxCQZoAAzplHvJDdCaKSLLus8T+NUkXkllz3sYGnYHyNMJjjp+GxtxmVkbbSiGDf6khi+uQyZN6ZBMsur/vHpoCkxpY9SZbWHWj3nGUIrlrDo6lM42l35ZPVLoeOkQ6H7XDTpUsBpbLjYAOuge1RlB76T7EOcmrAbCWx4SVmxirZyPVC+XuXfzDf4U3ad67wDFfER+UhAbZW4JWnPje5Lyb4dU1gWThtfXiq6Gb/YvWd6VUbkn5r9jLka4EiiCI7mX+tQ1QMX2mHgu709Xgj2S3+HqRh/fgECgYEA9gOmKuE2243Hpl9gpDAkXKLaUTuJYb6HM2q8FWvUvlN/nb7VcoTpx1C1jBGemTovswPRUfg0OWvStHvaf4IuXViAOy8cLMBkFVBNe8UY7FwX9u2Uj4aG4Twg370CMEVVkRzQ9qucwoOkmISXyP/ZxJzR21YQ12JtERJ2mRLYIoECgYEAzXbEZsGxzB74rHTCRagC4IR/BtXzxI3+TpzFW7h187evhlCxNk+tQ9T3u9C0BjmttGmEp+59kUqnkbDwKxSP1clq0UoXcJV0e3YNq30FOIviOwIwc59c5qsB7R8XL3/1NyH9tTIqYrmp7y8sDpnds6eeVqzJjqAMQv4gG0yqLrsCgYEAqEXItA3GMxjgVelpNgUD6iUuRV/+0U+8NKwuKEzQgLqmUKTGZQWKzl1jQIKQw+gr1junQnUOa7RXtEH/KzZFNm4hj9niYK3cB0QdK6qeKJW5gpnxAtcWjRtOtRsYUyIprA9U01SA7f+TZwtSsxZlwvktBeTxshFN3t6NJpjgI4ECgYEAu4Mv3WPawyJk6ucoQfACqCrjzzZF4dWBCPe0em/PXhz+mQNdp+Zxh51+di8TjTbom+VNBwH2ITpT0ff8SCTc3EyVKuqGl94eT2q/MQnJUQEA97+YvnzriSz6dhDQ1S3fenCQHeTpn+43861GdRDhr8tDC3FoBb11U1KftKp0Cm8CgYBpCnxr5kO82krJycMF8ERdym3Y4g3yyJpDFfGOux+2c887hxcZ/Rh5SKnRVXzT31cbwQIfysR6KnqxdaPVcgR937y2r32pm3diUqmc4sphW/4/byRrGqjqwONWQSZ/RhWaX0xV2Tl0qWBVE98B/b78P4NFn8H6hy0nu/l+yOZ01A==';
		$this->alipay_public_key = 'MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAtkT4akqyNKp0uWeGqB+z11zsVTrBGZL7d+hpouN9AMj2CrfsIWqarQWBaOu69F/LWfdRAVQG2hN6KUZ/fBJt5azgiRuZ8DTOraF3d9Dye1FQudhW8Ux84NhsD52Q/UXhOwQf6KPf/vKpq3kzKcm67gh4ez+O08OE/YrPm28etLB05ez01TLXHHNMY4J49b2ESUUxTWlLG8s/rR+DMqkgZMaMMLy+MMYGspH0BXJZigiTJbKOIezyWYv5B8Vt9nyZeSBEhjlCv7iVELkh27iF28EkRfFGcSR6BIjhhkkc7l59Qmmdf2h4BJly8u+iUAp9E8Xv0JT2anhHZsgBWj0mwQIDAQAB';

		if(empty($this->appid)||trim($this->appid)==""){
			throw new Exception("appid should not be NULL!");
		}
		if(empty($this->private_key)||trim($this->private_key)==""){
			throw new Exception("private_key should not be NULL!");
		}
		if(empty($this->alipay_public_key)||trim($this->alipay_public_key)==""){
			throw new Exception("alipay_public_key should not be NULL!");
		}
		if(empty($this->charset)||trim($this->charset)==""){
			throw new Exception("charset should not be NULL!");
		}
		if(empty($this->gateway_url)||trim($this->gateway_url)==""){
			throw new Exception("gateway_url should not be NULL!");
		}

	}

	/**
	 * alipay.trade.page.pay
	 * @param $builder 业务参数，使用buildmodel中的对象生成。
	 * @param $return_url 同步跳转地址，公网可以访问
	 * @param $notify_url 异步通知地址，公网可以访问
	 * @return $response 支付宝返回的信息
 	*/
	function pagePay($builder,$return_url,$notify_url) {

		$biz_content=$builder->getBizContent();
		//打印业务参数
		$this->writeLog($biz_content);

		$request = new AlipayTradePagePayRequest();

		$request->setNotifyUrl($notify_url);
		$request->setReturnUrl($return_url);
		$request->setBizContent ( $biz_content );

		// 首先调用支付api
		$response = $this->aopclientRequestExecute ($request,true);
		// $response = $response->alipay_trade_wap_pay_response;
		return $response;
	}

	/**
	 * sdkClient
	 * @param $request 接口请求参数对象。
	 * @param $ispage  是否是页面接口，电脑网站支付是页面表单接口。
	 * @return $response 支付宝返回的信息
 	*/
	function aopclientRequestExecute($request,$ispage=false) {

		$aop = new AopClient ();
		$aop->gatewayUrl = $this->gateway_url;
		$aop->appId = $this->appid;
		$aop->rsaPrivateKey =  $this->private_key;
		$aop->alipayrsaPublicKey = $this->alipay_public_key;
		$aop->apiVersion ="1.0";
		$aop->postCharset = $this->charset;
		$aop->format= $this->format;
		$aop->signType=$this->signtype;
		// 开启页面信息输出
		$aop->debugInfo=true;
		if($ispage)
		{
			$result = $aop->pageExecute($request,"post");
			echo $result;
		}
		else
		{
			$result = $aop->Execute($request);
		}

		//打开后，将报文写入log文件
		$this->writeLog("response: ".var_export($result,true));
		return $result;
	}

	/**
	 * alipay.trade.query (统一收单线下交易查询)
	 * @param $builder 业务参数，使用buildmodel中的对象生成。
	 * @return $response 支付宝返回的信息
 	*/
	function Query($builder){
		$biz_content=$builder->getBizContent();
		//打印业务参数
		$this->writeLog($biz_content);
		$request = new AlipayTradeQueryRequest();
		$request->setBizContent ( $biz_content );

		$response = $this->aopclientRequestExecute ($request);
		$response = $response->alipay_trade_query_response;
		return $response;
	}

	/**
	 * alipay.trade.refund (统一收单交易退款接口)
	 * @param $builder 业务参数，使用buildmodel中的对象生成。
	 * @return $response 支付宝返回的信息
	 */
	function Refund($builder){
		$biz_content=$builder->getBizContent();
		//打印业务参数
		$this->writeLog($biz_content);
		$request = new AlipayTradeRefundRequest();
		$request->setBizContent ( $biz_content );

		$response = $this->aopclientRequestExecute ($request);
		$response = $response->alipay_trade_refund_response;
		return $response;
	}

	/**
	 * alipay.trade.close (统一收单交易关闭接口)
	 * @param $builder 业务参数，使用buildmodel中的对象生成。
	 * @return $response 支付宝返回的信息
	 */
	function Close($builder){
		$biz_content=$builder->getBizContent();
		//打印业务参数
		$this->writeLog($biz_content);
		$request = new AlipayTradeCloseRequest();
		$request->setBizContent ( $biz_content );

		$response = $this->aopclientRequestExecute ($request);
		$response = $response->alipay_trade_close_response;
		return $response;
	}

	/**
	 * 退款查询   alipay.trade.fastpay.refund.query (统一收单交易退款查询)
	 * @param $builder 业务参数，使用buildmodel中的对象生成。
	 * @return $response 支付宝返回的信息
	 */
	function refundQuery($builder){
		$biz_content=$builder->getBizContent();
		//打印业务参数
		$this->writeLog($biz_content);
		$request = new AlipayTradeFastpayRefundQueryRequest();
		$request->setBizContent ( $biz_content );

		$response = $this->aopclientRequestExecute ($request);
		return $response;
	}
	/**
	 * alipay.data.dataservice.bill.downloadurl.query (查询对账单下载地址)
	 * @param $builder 业务参数，使用buildmodel中的对象生成。
	 * @return $response 支付宝返回的信息
	 */
	function downloadurlQuery($builder){
		$biz_content=$builder->getBizContent();
		//打印业务参数
		$this->writeLog($biz_content);
		$request = new alipaydatadataservicebilldownloadurlqueryRequest();
		$request->setBizContent ( $biz_content );

		$response = $this->aopclientRequestExecute ($request);
		$response = $response->alipay_data_dataservice_bill_downloadurl_query_response;
		return $response;
	}

	/**
	 * 验签方法
	 * @param $arr 验签支付宝返回的信息，使用支付宝公钥。
	 * @return boolean
	 */
	function check($arr){
		$aop = new AopClient();
		$aop->alipayrsaPublicKey = $this->alipay_public_key;
		$result = $aop->rsaCheckV1($arr, $this->alipay_public_key, $this->signtype);

		return $result;
	}

	/**
	 * 请确保项目文件有可写权限，不然打印不了日志。
	 */
	function writeLog($text) {
		// $text=iconv("GBK", "UTF-8//IGNORE", $text);
		//$text = characet ( $text );
		file_put_contents (RUNTIME_PATH.'/log.txt', date ( "Y-m-d H:i:s" ) . "  " . $text . "\r\n", FILE_APPEND );
	}
}

?>