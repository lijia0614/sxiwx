<?php
namespace Payments;
class weixinPay {
    public function __construct() {
        $config = Db("oss")->where("alias", "aliyun")->find();
        $config = json_decode($config['value'], true);
        $this->config = $config;
    }
	
}
?>
