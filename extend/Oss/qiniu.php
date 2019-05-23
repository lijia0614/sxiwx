<?php

namespace Oss;

use Qiniu\Storage\UploadManager;
use Qiniu\Auth as qinuiAuth;

class qiniu {

    public function __construct() {
        $config = Db("oss")->where("alias", "qiniu")->find();
        $config = json_decode($config['value'], true);
        $this->config = $config;
    }

    /**
     * 上传指定的本地文件内容
     *
     * @param string $key 上传到七牛云的路径
     * @param string $Path 本地文件路径
     * @return null
     */
    public function qnUpload($key, $Path) {
        $config = $this->config;
        $bucket = $config['Bucket']; //上传空间名称

        try {
            $auth = $this->NewOss();
            $token = $auth->uploadToken($bucket);  // 生成上传 Token
            $uploadMgr = new UploadManager();
            list($ret, $err) = $uploadMgr->putFile($token, $key, $Path);
            if ($err !== null) {
                return false;
            } else {

                if ($this->config['DOMAIN']) {
                    $url = $this->config['DOMAIN'] . $key;
                } else {
                    $url = "http://" . trim($this->config['ENDPOINT']) . "/" . $key;
                }
                return $url;
            }
        } catch (OssException $e) {
            return $e->getMessage();
        }
        return true;
    }

    /**
     * 实例化
     * @return object 实例化得到的对象
     * @return 此步作为共用对象，可提供给多个模块统一调用
     */
    public function NewOss() {
        $accessKey = $this->config['accessKey'];
        $secretKey = $this->config['secretKey'];
        $auth = new qinuiAuth($accessKey, $secretKey); //实例化认证 
        return $auth;
    }

}

?>