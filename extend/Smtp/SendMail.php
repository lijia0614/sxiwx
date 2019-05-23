<?php

namespace Smtp;

use PHPMailer\PHPMailer\PHPMailer;

class SendMail {

    private $config = array(); //邮件配置信息
    private $smtp = null;   //邮件发送对象
    private $error = '';     //错误信息

    //构造函数

    public function __construct($site_config = null) {
        if ($site_config == null) {
            $config = model('config'); //实例化模型
            $webConfig = $config->getCfgByModule('SMTP_CONFIG');
            $config = json_decode($webConfig['SMTP_CONFIG'], true);
            $this->config = $config;
        } else {
            $this->config = $site_config;
        }
        if ($this->checkEmailConf($this->config)) {
            //使用外部SMTP服务器发送
            $server = $this->config['smtp'];
            $port = $this->config['smtp_port'];
            $account = $this->config['smtp_user'];
            $password = $this->config['smtp_pwd'];
        } else {
            $this->error = '配置参数填写不完整';
        }
    }

    //获取错误信息
    public function getError() {
        return $this->error;
    }

    /**
     * @brief 检查邮件配置信息的合法性
     * @parms $site_config array 配置信息
     * @return bool true:成功;false:失败;
     */
    public function checkEmailConf($site_config) {

        $mustConfig = array('smtp', 'smtp_user', 'smtp_pwd', 'smtp_port');
        foreach ($mustConfig as $val) {
            if (!isset($site_config[$val]) || $site_config[$val] == '') {
                return false;
            }
        }
        return true;
    }

    /**
     * @brief 邮件发送
     * @parms  $to      string 收件人
     * @parms  $title   string 标题
     * @parms  $content string 内容
     * @parms  $bcc     string 抄送人(";"分号间隔的email地址)
     * @return bool true:成功;false:失败;
     */
    public function send($to, $title, $content, $attachment = false) {

        $mail = new PHPMailer(true);
        try {
            // 服务器设置
            $mail->SMTPDebug = false;                                    // 开启Debug
            $mail->isSMTP();                                        // 使用SMTP
            $mail->Timeout = 10;
            $mail->Host = $this->config['smtp'];                        // 服务器地址
            $mail->SMTPAuth = true;                                    // 开启SMTP验证
            $mail->Username = $this->config['smtp_user'];                // SMTP 用户名（你要使用的邮件发送账号）
            $mail->Password = $this->config['smtp_pwd'];                                // SMTP 密码
            if ($this->config['smtp_ssl'] == 1) {// 开启TLS 可选
                $mail->SMTPSecure = 'ssl';
            }
            $mail->Port = $this->config['smtp_port'];                                        // 端口
            // 收件人
            $mail->setFrom($this->config['mail_address'], $this->config['mail_name']);            // 来自
            $mail->addAddress($to);                        // 可以只传邮箱地址
            $mail->addReplyTo($this->config['mail_address'], $this->config['mail_name']);        // 回复地址
            // $mail->addCC('cc@example.com');
            // $mail->addBCC('bcc@example.com');
            // 附件
            if ($attachment) {
                if (is_array($attachment)) {
                    foreach ($attachment as $key => $one) {
                        $mail->addAttachment($one['path'], $one['name']);
                    }
                }
            }
            //$mail->addAttachment('/var/tmp/file.tar.gz');                // 添加附件
            //$mail->addAttachment('/tmp/image.jpg', 'new.jpg');            // 可以设定名字
            // 内容
            $mail->isHTML(true);                                        // 设置邮件格式为HTML
            $mail->Subject = $title;
            $mail->Body = $content;
            //$mail->AltBody = 'xxxxxx';
            $mail->send();
            return true;
        } catch (Exception $e) {
            return false;
            //return $mail->ErrorInfo;
            //echo '邮件发送失败。<br>';
            // echo 'Mailer Error: ' . $mail->ErrorInfo;
        }
    }

    //获取配置信息
    public function getConfigItem($key) {
        return isset($this->config[$key]) ? $this->config[$key] : null;
    }

}
