<?php

namespace Oss;

class aliyun {

    public function __construct() {
        $config = Db("oss")->where("alias", "aliyun")->find();
        $config = json_decode($config['value'], true);
        $this->config = $config;
    }

    /**
     * 上传指定的本地文件内容
     * @param string $object 上传到阿里QSS的存储路径
     * @param string $Path 本地文件路径
     * @return true
     */
    public function uploadFile($object, $Path) {
        $config = $this->config;
        $bucket = $config['Bucket']; //上传空间名称
        try {
            $ossClient = $this->newOss();
            $ossClient->uploadFile($bucket, $object, $Path); //uploadFile的上传方法
        } catch (OssException $e) {
            return $e->getMessage(); //如果出错这里返回报错信息
        }
        if ($this->config['DOMAIN']) {
            $url = $this->config['DOMAIN'] . $object;
        } else {
            $url = "http://" . $bucket . "." . trim($this->config['Endpoint']) . "/" . $object;
        }
        return $url;
    }

    /**
     * 实例化阿里云OSS
     * @return object 实例化得到的对象
     * @return 此步作为共用对象，可提供给多个模块统一调用
     */
 public  function newOss() {
        //获取配置项，并赋值给对象$config
        $config = $this->config;
        //实例化OSS
        $oss = new \OSS\OssClient($config['AccessKeyID'], $config['AccessKeySecret'], $config['Endpoint']);
        return $oss;
    }

}
