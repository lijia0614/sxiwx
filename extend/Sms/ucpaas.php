<?php

namespace Sms;

/**
 * 云之讯短信验证码发送类
 * @author 四川挚梦科技有限公司
 */
class ucpaas
{

    //API请求地址
    const BaseUrl = "https://open.ucpaas.com/ol/sms/";

    //开发者账号ID。由32个英文字母和阿拉伯数字组成的开发者账号唯一标识符。
    private $accountSid;

    //开发者账号TOKEN
    private $token;

    private $appid;

    public function __construct($config = array())
    {
        if (!$config) {
            $data = Db("Sms")->where(['id' => 4, 'status' => 1])->find();
            $config = json_decode($data['value'], true);
        } else {
            throw new Exception("非法参数");
        }
        $this->appid = $config ['appid'];
        $this->accountSid = $config ['accountsid'];
        $this->token = $config ['token'];
    }

    private function getResult($url, $body = null, $method)
    {
        $data = $this->connection($url, $body, $method);
        if (isset($data) && !empty($data)) {
            $result = $data;
        } else {
            $result = '没有返回数据';
        }
        return $result;
    }

    /**
     * @param $url    请求链接
     * @param $body   post数据
     * @param $method post或get
     * @return mixed|string
     */

    private function connection($url, $body, $method)
    {
        if (function_exists("curl_init")) {
            $header = array(
                'Accept:application/json',
                'Content-Type:application/json;charset=utf-8',
            );
            $ch = curl_init($url);
            curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
            curl_setopt($ch, CURLOPT_HTTPHEADER, $header);
            if ($method == 'post') {
                curl_setopt($ch, CURLOPT_POST, 1);
                curl_setopt($ch, CURLOPT_POSTFIELDS, $body);
            }
            curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
            curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, false);
            $result = curl_exec($ch);
            curl_close($ch);
        } else {
            $opts = array();
            $opts['http'] = array();
            $headers = array(
                "method" => strtoupper($method),
            );
            $headers[] = 'Accept:application/json';
            $headers['header'] = array();
            $headers['header'][] = 'Content-Type:application/json;charset=utf-8';

            if (!empty($body)) {
                $headers['header'][] = 'Content-Length:' . strlen($body);
                $headers['content'] = $body;
            }

            $opts['http'] = $headers;
            $result = file_get_contents($url, false, stream_context_create($opts));
        }
        return $result;
    }

    /**
     * 单条发送短信的function，适用于注册/找回密码/认证/操作提醒等单个用户单条短信的发送场景
     * @param $mobile       接收短信的手机号码
     * @param $templateid   短信模板，可在后台短信产品→选择接入的应用→短信模板-模板ID，查看该模板ID
     * @param null $param 变量参数，多个参数使用英文逗号隔开（如：param=“a,b,c”）
     * @param $uid            用于贵司标识短信的参数，按需选填。
     * @return mixed|string
     * @throws Exception
     */
    public function SendSms($templateid, $param = null, $mobile, $uid)
    {
        $tpl = Db("message_tpl")->where("id", $templateid)->find();
        $templateCode = $tpl['template_code'];
        if (!$templateCode) {
            return '没有找到服务商短信模板ID';
        }
        $url = self::BaseUrl . 'sendsms';
        $body_json = array(
            'sid' => $this->accountSid,
            'token' => $this->token,
            'appid' => $this->appid,
            'templateid' => $templateCode,
            'param' => $param,
            'mobile' => $mobile,
            'uid' => $uid,
        );
        $body = json_encode($body_json);
        $data = $this->getResult($url, $body, 'post');
        $result = json_decode($data, true);
        if (isset($result ['code'])) {
            return $this->getErrorMessage($result ['code']);//正确返回OK,其他全部为错误信息提示
        }
        return false;
    }


    /**
     * 获取详细错误信息
     * @param unknown $status
     */
    private function getErrorMessage($status)
    {
        $message = array(
            '000000' => 'OK',
            '100001' => '账户余额/套餐包余额不足',
            '100005' => '发送请求的IP不在白名单内',
            '100008' => '手机号码不能为空',
            '100009' => '手机号为受保护的号码',
            '100015' => '号码不合法',
            '100016' => '账号余额被冻结',
            '100017' => '余额已注销',
            '100019' => '应用可用额度余额不足',
            '100699' => '系统内部错误',
            '101105' => '主账户sid存在非法字符',
            '101108' => '开发者账户已注销',
            '101109' => '主账户sid未激活',
            '101110' => '主账户sid已锁定',
            '101111' => '主账户sid不存在',
            '101112' => '主账户sid为空',
            '101117' => '缺少token参数或参数为空',
            '102100' => '应用appid为空',
            '102101' => '应用appid存在非法字符',
            '102102' => '应用appid不存在',
            '102103' => '应用未上线',
            '102105' => '应用appid不属于该主账号',
            '103126' => '未上线应用只能使用白名单中的号码',
            '105110' => '该appid下，此短信模板(templateid)不存在',
            '105111' => '短信模板(templateid)未审核通过',
            '105112' => '请求的参数(param)与模板上的变量数量不一致',
            '105113' => '短信模板(templateid)不能为空',
            '105115' => '短信类型(type)长度应为1个字符',
            '105117' => '短信模板(templateid)含非法字符',
            '105118' => '短信模板有替换内容，但缺少param参数或参数为空	',
            '105119' => '每个参数的长度不能超过100字',
            '105120' => '群发号码单次提交不能超过100个',
            '105121' => '短信模板(templateid)已删除',
            '105124' => '短信模板内容为空',
            '105125' => '创建短信模板失败',
            '105126' => '短信模板名称格式错误	',
            '105128' => '短信模板(templateid)不能为空',
            '105133' => '短信内容过长，超过500字',
            '105134' => '参数(param)中含有超过一对【】',
            '105135' => '参数(param)中含有特殊符号',
            '105136' => '签名长度应为2到12位',
            '105138' => '群发号码重复',
            '105140' => '账号未认证',
            '105141' => '主账号需为企业认证',
            '105142' => '模板被定时群发任务锁定暂无法修改',
            '105143' => '模板不属于该用户',
            '105144' => '创建验证码模板短信需带参数',
            '105145' => '签名(autograph)格式错误',
            '105146' => '短信类型(type)错误',
            '105147' => '对同个号码发送短信超过限定频率',
            '105150' => '短信发送频率过快',
            '105152' => '请求的参数(param)格式错误',
            '105153' => '手机号码格式错误',
            '105154' => '短信服务请求异常e100',
            '105155' => '缺少签名(autograph)参数或参数为空',
            '105156' => '查询短信类型错误',
            '105157' => '变量数量超过100个',
            '105158' => '接口不支持GET方式调用',
            '105159' => '接口不支持POST方式调用',
            '105161' => '开始时间错误',
            '105162' => '结束时间错误',
            '105163' => '超过可查询时间范围',
            '105164' => '页码错误',
            '105165' => '每页个数错误，限制访问(1-100)',
            '105166' => '请求频率过快',
            '105167' => 'uid格式错误或超过60位',
            '105168' => '参数sid或token错误',
            '105169' => '超过页码数',
            '300001' => '提交失败',
            '300002' => '未知',
            '300003' => '空号',
            '300004' => '黑名单',
            '300005' => '超频',
            '300006' => '系统忙',
        );
        if (isset($message [$status])) {
            return $message [$status];
        }
        return $status;
    }

    /**
     * 群发送短信的function，适用于运营/告警/批量通知等多用户的发送场景
     * @param $appid        应用ID
     * @param $mobileList   接收短信的手机号码，多个号码将用英文逗号隔开，如“18088888888,15055555555,13100000000”
     * @param $templateid   短信模板，可在后台短信产品→选择接入的应用→短信模板-模板ID，查看该模板ID
     * @param null $param 变量参数，多个参数使用英文逗号隔开（如：param=“a,b,c”）
     * @param $uid            用于贵司标识短信的参数，按需选填。
     * @return mixed|string
     * @throws Exception
     */
    public function SendSms_Batch($appid, $templateid, $param = null, $mobileList, $uid)
    {
        $url = self::BaseUrl . 'sendsms_batch';
        $body_json = array(
            'sid' => $this->accountSid,
            'token' => $this->token,
            'appid' => $appid,
            'templateid' => $templateid,
            'param' => $param,
            'mobile' => $mobileList,
            'uid' => $uid,
        );
        $body = json_encode($body_json);
        $data = $this->getResult($url, $body, 'post');
        return $data;
    }

}
