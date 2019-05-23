<?php

/**
 * 应用公共文件
 * 公共函数库。
 * @author      四川挚梦科技有限公司
 */
function sendMail($address, $tpl_id, $parseArray = array())
{
    $smtp = new smtp\SendMail();
    if ($error = $smtp->getError()) {
        JsonDie(0, $error, 'no');
    } else {
        if (!empty($address)) {
            $tpl = Db("message_tpl")->where("id", $tpl_id)->find();
            if ($tpl) {
                $title = loadParseTpl($tpl['name'], $parseArray);
                $content = loadParseTpl($tpl['content'], $parseArray); //替换模板里面的变量
            }
            if ($smtp->send($address, $title, $content)) {

                return true;
            } else {
                return false;
            }
        } else {
            return false;
        }
    }
}

function checkVip($u_id){
    $user = Db::name('member')
        ->where('id',$u_id)
        ->field('is_vip,vip_create_time')
        ->find();
    if ($user['is_vip'] != 1){
        return false;
    }

    $t = strtotime($user['vip_create_time']);
    $deadline = date('Y-m-d H:i:s',$t+365*24*60*60); // 会员过期时间
    $now = date('Y-m-d H:i:s',time()); // 现在的时间

    if (strtotime($now) > strtotime($deadline)) {
        return false;
    }
    return true;
}

function getJson($url)
{
    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, $url);
    curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, FALSE);
    curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, FALSE);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
    $output = curl_exec($ch);
    curl_close($ch);
    return json_decode($output, true);
}

function DeleteHtml($str)
{
//    $str = trim($str); //清除字符串两边的空格
    $str = preg_replace("/\t/", "", $str); //使用正则表达式替换内容，如：空格，换行，并将替换为空。
    $str = preg_replace("/\r\n/", "", $str);
    $str = preg_replace("/\r/", "", $str);
    $str = preg_replace("/\n/", "", $str);
    $str = preg_replace("/ /", "", $str);
    $str = preg_replace("/  /", "", $str);  //匹配html中的空格
    return trim($str); //返回字符串
}


function c_print($mix)
{
    if (is_object($mix) && method_exists($mix, 'toArray')) {
        //	$mix=$mix->toArray();
    }
    static $isPrint = false;
    if (!$isPrint) {
        echo '<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">';
        $isPrint = true;
    }
    echo "<pre>";
    print_r($mix);
    echo "</pre>";
}

function c_dump($mix)
{
    static $isPrint = false;
    if (!$isPrint) {
        echo '<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">';
        $isPrint = true;
    }
    echo "<pre>";
    var_dump($mix);
    echo "</pre>";
}

/**
 * sendSms
 * 发送手机验证码
 * @param    $mobile  手机号码
 * @param    $tpl_id  模板ID
 * @param    $data  要替换的模板变量
 * @return      string
 */
function sendSms($mobile, $tpl_id, $data)
{
    $config = Db("Sms")->where("status", 1)->find();
    if ($config['alias'] == 'aliyun') {//阿里云短信
        $sms = new Sms\aliyun();
        $result = $sms->sendSms($mobile, $tpl_id, $data);
    } else if ($config['alias'] == 'ucpaas') {
        $sms = new \Sms\ucpaas();
        $uid = time();
        $str = implode(",", $data);
        $result = $sms->SendSms($tpl_id, $str, $mobile, $uid);
    } else if ($config['alias'] == 'netease') {//网易云短信
        $sms = new \Sms\netease();
        $result = $sms->sendSms($tpl_id, $data, $mobile);
    } else {
        return false;
    }
    if ($result != 'OK') {
        return $result;
    }
    return true;
}

function object_to_array($obj) {
    $obj = (array)$obj;
    foreach ($obj as $k => $v) {
        if (gettype($v) == 'resource') {
            return;
        }
        if (gettype($v) == 'object' || gettype($v) == 'array') {
            $obj[$k] = (array)object_to_array($v);
        }
    }

    return $obj;
}

/**
 * stdClass Object转array
 * @param $array
 * @return array
 */
function object_array($array) {
    if(is_object($array)) {
        $array = (array)$array;
    } if(is_array($array)) {
        foreach($array as $key=>$value) {
            $array[$key] = object_array($value);
        }
    }
    return $array;
}

/**
 * downExcel
 * 导出Excel表格
 * @param    $title  标题字段
 * @param    $data  数据字段
 * @return      string
 */
function downExcel($filename, $title, $data)
{
    $excel = new \Excels\Excel();
    $excel->download($filename, $title, $data);
}

/**
 * loadParseTpl
 * 替换字符串中的变量
 * @param    content string 替换的字符串
 * @param    config  array 数组，所有要替换的变量,key值为模板定义的,value为要替换的值
 * @return array
 */
function loadParseTpl($content, $config)
{
    if (!$config)
        return $content;
    foreach ($config as $key => $one) {
        $content = str_replace($key, $one, $content);
    }
    return $content;
}

/**
 * paramFilter
 * 过滤参数非法字符
 * @param  array 需要检测过滤的参数数组
 * @since 1.0
 * @return array
 */
function paramFilter($paramData)
{
    $paramData['id'] = isset($paramData['id']) ? intval($paramData['id']) : 0;
    $paramData['cid'] = isset($paramData['cid']) ? intval($paramData['cid']) : 0;
    $paramData['p'] = isset($paramData['p']) ? intval($paramData['p']) : 1;
    $paramData['page'] = isset($paramData['p']) ? intval($paramData['p']) : 1;
    $paramData['keyword'] = isset($paramData['keyword']) ? preg_replace("/ or|select|inert|update|delete|\/\*|\*|\.\.\/|\.\/|UNION|into|load_file|outfile|\'|\"|%|\(|\)/is", '', $paramData['keyword']) : '';
    return $paramData;
}

/**
 * JsonDie
 * 打印json字符串
 * @param  array 需要检测过滤的参数数组
 * @return json
 */
function JsonDie($status, $message, $hidden = 'yes', $data = '')
{
    if ($message) {
        die(json_encode(array('status' => $status, 'msg' => $message, 'hidden' => $hidden, 'data' => $data)));
    } else {
        die(json_encode(array('status' => 0, 'msg' => 'json传输状态status和message必填', 'hidden' => 'no', 'data' => $data)));
    }
}

function c_json($code, $message,  $data = '')
{
    if ($message) {
        die(json_encode(array('code' => $code, 'msg' => $message,  'data' => $data)));
    } else {
        die(json_encode(array('code' => 0, 'msg' => 'json传输状态code和message必填', 'data' => $data)));
    }
}

function z_json($code, $message,  $data = '')
{
    if ($message) {
        die(json_encode(array('code' => $code, 'message' => $message,  'result' => $data)));
    } else {
        die(json_encode(array('code' => 0, 'message' => 'json传输状态code和message必填', 'result' => $data)));
    }
}

function m_json($data)
{
    if ($data) {
        die(json_encode($data));
    } else {
        die(json_encode(array('code' => 0, 'msg' => 'json传输状态code和message必填', 'data' => $data)));
    }
}

/**
 * 过滤html标签
 * @author 四川挚梦科技有限公司
 * @date 2017-01-11
 */
function trimHtml($str, $start = 0, $end = 30, $isk = false)
{
    if ($isk) {
        $length = strlen($str);
        if ($length > ($end - $start)) {
            return mb_substr(str_replace('&nbsp;', '', strip_tags($str)), $start, $end, 'utf-8') . "...";
        } else {
            return mb_substr(str_replace('&nbsp;', '', strip_tags($str)), $start, $end, 'utf-8');
        }
    } else {
        return mb_substr(str_replace('&nbsp;', '', strip_tags($str)), $start, $end, 'utf-8');
    }
}


/**
 * 判断客户端访问类型，PC或者移动端
 * @author 四川挚梦科技有限公司
 * @date 2018-04-06
 */
function is_mobile_request()
{
    $_SERVER['ALL_HTTP'] = isset($_SERVER['ALL_HTTP']) ? $_SERVER['ALL_HTTP'] : '';
    $mobile_browser = '0';
    if (preg_match('/(up.browser|up.link|mmp|symbian|smartphone|midp|wap|phone|iphone|ipad|ipod|android|xoom)/i', strtolower($_SERVER['HTTP_USER_AGENT'])))
        $mobile_browser++;
    if ((isset($_SERVER['HTTP_ACCEPT'])) and (strpos(strtolower($_SERVER['HTTP_ACCEPT']), 'application/vnd.wap.xhtml+xml') !== false))
        $mobile_browser++;
    if (isset($_SERVER['HTTP_X_WAP_PROFILE']))
        $mobile_browser++;
    if (isset($_SERVER['HTTP_PROFILE']))
        $mobile_browser++;
    $mobile_ua = strtolower(substr($_SERVER['HTTP_USER_AGENT'], 0, 4));
    $mobile_agents = array(
        'w3c ', 'acs-', 'alav', 'alca', 'amoi', 'audi', 'avan', 'benq', 'bird', 'blac',
        'blaz', 'brew', 'cell', 'cldc', 'cmd-', 'dang', 'doco', 'eric', 'hipt', 'inno',
        'ipaq', 'java', 'jigs', 'kddi', 'keji', 'leno', 'lg-c', 'lg-d', 'lg-g', 'lge-',
        'maui', 'maxo', 'midp', 'mits', 'mmef', 'mobi', 'mot-', 'moto', 'mwbp', 'nec-',
        'newt', 'noki', 'oper', 'palm', 'pana', 'pant', 'phil', 'play', 'port', 'prox',
        'qwap', 'sage', 'sams', 'sany', 'sch-', 'sec-', 'send', 'seri', 'sgh-', 'shar',
        'sie-', 'siem', 'smal', 'smar', 'sony', 'sph-', 'symb', 't-mo', 'teli', 'tim-',
        'tosh', 'tsm-', 'upg1', 'upsi', 'vk-v', 'voda', 'wap-', 'wapa', 'wapi', 'wapp',
        'wapr', 'webc', 'winw', 'winw', 'xda', 'xda-'
    );
    if (in_array($mobile_ua, $mobile_agents))
        $mobile_browser++;
    if (strpos(strtolower($_SERVER['ALL_HTTP']), 'operamini') !== false)
        $mobile_browser++;

    if (strpos(strtolower($_SERVER['HTTP_USER_AGENT']), 'windows') !== false)
        $mobile_browser = 0;

    if (strpos(strtolower($_SERVER['HTTP_USER_AGENT']), 'windows phone') !== false)
        $mobile_browser++;
    if ($mobile_browser > 0) {
        return true;
    } else {
        return false;
    }
}

/**
 * 模拟POST提交
 * @author 四川挚梦科技有限公司
 * @date 2018-04-26
 */
function httpPost($url, $method = "POST", $postfields = null, $headers = array(), $debug = false)
{
//    header('uniqueKey:83c4f75249dc12b4f3316427ea654d11');
//    c_print($headers);die;
    $ci = curl_init();
    /* Curl settings */
    curl_setopt($ci, CURLOPT_HTTP_VERSION, CURL_HTTP_VERSION_1_1);
    curl_setopt($ci, CURLOPT_CONNECTTIMEOUT, 30);
    curl_setopt($ci, CURLOPT_SSL_VERIFYPEER, FALSE);
    curl_setopt($ci, CURLOPT_SSL_VERIFYHOST, FALSE);
    curl_setopt($ci, CURLOPT_TIMEOUT, 30);
    curl_setopt($ci, CURLOPT_RETURNTRANSFER, true);
    switch ($method) {
        case 'POST':
            curl_setopt($ci, CURLOPT_POST, true);
            if (!empty($postfields)) {
                curl_setopt($ci, CURLOPT_POSTFIELDS, $postfields);
            }
            break;
    }
    curl_setopt($ci, CURLOPT_URL, $url);
    curl_setopt($ci, CURLOPT_HTTPHEADER, $headers);
    curl_setopt($ci, CURLINFO_HEADER_OUT, true);
    $response = curl_exec($ci);
    $http_code = curl_getinfo($ci, CURLINFO_HTTP_CODE);
    if ($debug) {
        echo "=====post data======\r\n";
        var_dump($postfields);
        echo '=====info=====' . "\r\n";
        print_r(curl_getinfo($ci));
        echo '=====$response=====' . "\r\n";
        print_r($response);
    }
    curl_close($ci);
    $response = (array)json_decode($response);
    return $response;
}

/**
 * 检测函数是否支持启用
 * @author 四川挚梦科技有限公司
 * @date 2018-04-29
 */
function isfun($funName = '')
{
    if (!$funName || trim($funName) == '' || preg_match('~[^a-z0-9\_]+~i', $funName, $tmp))
        return '错误';
    return (false !== function_exists($funName)) ? '支持' : '不支持';
}

/**
 * 客户端输入自动验证函数
 * @author 四川挚梦科技有限公司
 * @date 2017-01-15
 */
function htmlvlidate($v, $msg = '请填写')
{
    if ($v['verify'] == 0) {
        return;
    }
    $type = $v['verify_type'];
    $str = 'datatype="';
    switch ($type) {
        case 'required'://不可为空验证
            $str .= '*';
            break;
        case 'email'://邮件验证
            $str .= "e";
            break;
        case 'number'://数字验证
            $str .= "n";
            break;
        case 'mobile'://手机号码验证
            $str .= "m";
            break;
        case 'price'://价格金额验证
            $str .= "/^-?[1-9]+(\.\d+)?$|^-?0(\.\d+)?$|^-?[1-9]+[0-9]*(\.\d+)?$/";
            break;
        case 'url'://验证是否为url
            $str .= "url";
            break;
        case 'Echeck'://只能英文字母
            $str .= "/\w/i";
            break;
        default:
            $str .= "";
            break;
    }
    $str .= '" nullmsg="' . $msg . '"';
    return $str;
}

function Fields_to_select($vl, $name, $nowval, $type = 1)
{//所有选项，select name,当前选中项
    $fval = explode("\r\n", $vl);
    if ($type == 1) {
        $str = '<cite>';
        $d_val = empty($nowval) ? 0 : 1;
        foreach ($fval as $value) {
            $tem = explode('|', $value);
            $selected = '';
            if ($nowval == $tem[1] || $d_val == 0) {
                $selected = 'checked="checked"';
                $d_val = 1;
            }
            $str .= '<input type="radio" ' . $selected . ' name="' . $name . '" value="' . $tem[1] . '">&nbsp;' . $tem[0] . "&nbsp;";
        }
        $str .= '</cite>';
    } else if ($type == 2) {
        $str = '<cite>';
        foreach ($fval as $value) {
            $tem = explode('|', $value);
            $selected = '';
            $val_arr = explode(",", $nowval);
            if (in_array($tem[1], $val_arr)) {
                $selected = 'checked="checked"';
            }
            $str .= '<input type="checkbox" ' . $selected . ' name="checkbox[' . $name . '][]" value="' . $tem[1] . '">&nbsp;' . $tem[0] . "&nbsp;";
        }
        $str .= '</cite>';
    } else {
        $str = '<div class="vocation"><select name="' . $name . '" class="select"><option  value="">请选择所属信息</option>';
        foreach ($fval as $value) {
            $tem = explode('|', $value);
            $selected = '';
            if ($nowval == $tem[1]) {
                $selected = "selected=selected";
            }
            $str = $str . "<option " . $selected . " value='" . $tem[1] . "'>" . $tem[0] . "</option>";
        }
        $str = $str . "</select></div>";
    }
    return $str;
}

function Fields_link_table_toselect($fields, $current_value = null)
{
    if (!isset($fields['link_table_name'])) {
        return false;
    }
    if (!isset($fields['fields'])) {
        return false;
    }
    if (!isset($fields['link_table_fields'])) {
        return false;
    }
    if (!isset($fields['link_table_fields_display_name'])) {
        return false;
    }
    $where = "1=1 ";
    if (!empty($fields['link_table_where'])) {
        $where .= "and " . $fields['link_table_where'];
    }
    $data = Db($fields['link_table_name'])->where($where)->select();
    $selected = "";
    $vlidate = htmlvlidate($fields);
    $str = '<div class="vocation"><select ' . $vlidate . ' name="' . $fields['fields'] . '" id="' . $fields['fields'] . '" class="select"><option  value="">请选择' . $fields['title'] . '</option>';
    if ($data) {
        foreach ($data as $key => $one) {
            if (isset($current_value) && $current_value == $one[$fields['link_table_fields']]) {
                $selected = "selected=selected";
            } else {
                $selected = "";
            }
            $str = $str . "<option " . $selected . " value='" . $one[$fields['link_table_fields']] . "'>" . $one[$fields['link_table_fields_display_name']] . "</option>";
        }
    }
    $str = $str . "</select></div>";
    return $str;
}

function Fields_link_table_tocheckbox($fields, $id)
{
    if (!isset($fields['deputy_table'])) {
        return false;
    }
    if (!isset($fields['table_name'])) {
        return false;
    }
    if (!isset($fields['link_table_name'])) {
        return false;
    }
    $where = "1=1 ";
    if (!empty($fields['link_table_where'])) {
        $where .= "and " . $fields['link_table_where'];
    }
    $data = Db($fields['link_table_name'])->where($where)->select();
    $selected = "";
    $vlidate = AdminHtmlvlidate($fields);
    $str = '<div class="vocation">';

    $checkbox_value = Db($fields['deputy_table'])->where(array(strtolower($fields['table_name'] . "_id") => $id))->select(); //中间表
    $current_checkbox = array();
    if ($checkbox_value) {
        foreach ($checkbox_value as $key => $one) {
            $current_checkbox[] = $one[strtolower($fields['link_table_name'] . "_id")];
        }
    }
    if ($data) {
        foreach ($data as $key => $one) {
            if (in_array($one['id'], $current_checkbox)) {
                $checked = "checked=checked";
            } else {
                $checked = "";
            }
            $str = $str . "<input type='checkbox' name='" . $fields['fields'] . "[]' id='" . $fields['fields'] . "[]' " . $checked . " value='" . $one[$fields['link_table_fields']] . "'>&nbsp;" . $one[$fields['link_table_fields_display_name']] . "&nbsp;";
        }
    }
    $str = $str . "<input type='hidden' name='deputy_table[" . $fields['deputy_table'] . "]' value='" . $fields['fields'] . "'></div>";
    return $str;
}

function authcode($string, $operation = 'DECODE', $key = '5a89766f0d243c4090da06a19d888551', $expiry = 0)
{
    if ($operation == 'DECODE') {
        $string = str_replace('aFY6cEa', '+', $string);
        $string = str_replace('aFY6cEb', '&', $string);
        $string = str_replace('aFY6cEc', '/', $string);
    }
    $ckey_length = 4;
    $key = md5($key ? $key : 'livcmsencryption ');
    $keya = md5(substr($key, 0, 16));
    $keyb = md5(substr($key, 16, 16));
    $keyc = $ckey_length ? ($operation == 'DECODE' ? substr($string, 0, $ckey_length) : substr(md5(microtime()), -$ckey_length)) : '';
    $cryptkey = $keya . md5($keya . $keyc);
    $key_length = strlen($cryptkey);
    $string = $operation == 'DECODE' ? base64_decode(substr($string, $ckey_length)) : sprintf('%010d', $expiry ? $expiry + time() : 0) . substr(md5($string . $keyb), 0, 16) . $string;
    $string_length = strlen($string);
    $result = '';
    $box = range(0, 255);
    $rndkey = array();
    for ($i = 0; $i <= 255; $i++) {
        $rndkey[$i] = ord($cryptkey[$i % $key_length]);
    }
    for ($j = $i = 0; $i < 256; $i++) {
        $j = ($j + $box[$i] + $rndkey[$i]) % 256;
        $tmp = $box[$i];
        $box[$i] = $box[$j];
        $box[$j] = $tmp;
    }
    for ($a = $j = $i = 0; $i < $string_length; $i++) {
        $a = ($a + 1) % 256;
        $j = ($j + $box[$a]) % 256;
        $tmp = $box[$a];
        $box[$a] = $box[$j];
        $box[$j] = $tmp;
        $result .= chr(ord($string[$i]) ^ ($box[($box[$a] + $box[$j]) % 256]));
    }
    if ($operation == 'DECODE') {
        if ((substr($result, 0, 10) == 0 || substr($result, 0, 10) - time() > 0) && substr($result, 10, 16) == substr(md5(substr($result, 26) . $keyb), 0, 16)) {

            return substr($result, 26);
        } else {
            return '';
        }
    } else {
        $ustr = $keyc . str_replace('=', '', base64_encode($result));
        $ustr = str_replace('+', 'aFY6cEa', $ustr);
        $ustr = str_replace('&', 'aFY6cEb', $ustr);
        $ustr = str_replace('/', 'aFY6cEc', $ustr);
        return $ustr;
    }
}

/**
 * php下载远程文件
 * *
 * $url 文件所在地址
 * $path 保存的路径
 * $filename 自定义命名
 * $type 使用什么方式下载  0:curl方式,1:readfile方式,2file_get_contents方式
 * return 文件名
 */

function getFile($url, $path = '', $filename = '', $type = 0)
{
    if ($url == '') {
        return false;
    }
    //获取远程文件数据
    if ($type === 0) {
        $ch = curl_init();
        $timeout = 10;
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, $timeout);
        $img = curl_exec($ch);
        curl_close($ch);
    }
    if ($type === 1) {
        ob_start();
        readfile($url);
        $img = ob_get_contents();
        ob_end_clean();
    }
    if ($type === 2) {
        $img = file_get_contents($url);
    }
    //判断下载的数据 是否为空 下载超时问题
    if (empty($img)) {
        throw new \Exception("下载错误,无法获取下载文件！");
    }

    //没有指定路径则默认当前路径
    if ($path === '') {
        $path = "./";
    }
    //如果命名为空
    if ($filename === "") {
        $filename = md5($img);
    }
    //防止"/"没有添加
    $path = rtrim($path, "/") . "/";
    //var_dump($path.$filename);die();
    $fp2 = @fopen($path . $filename, 'a');

    fwrite($fp2, $img);
    fclose($fp2);
    //echo "finish";
    return $filename;
}


/**
 * 防注入函数
 * @author 四川挚梦科技有限公司
 * @date 2017-01-15
 */
function ZmCMS_Sql_Replace($str)
{
    $str = str_replace("%", "％", $str);
    $str = str_replace("<=", "≤", $str);
    $str = str_replace(">=", "≥", $str);
    $str = str_replace("+", "＋", $str);
    $str = str_replace("*", "×", $str);
    $str = str_replace(",", "，", $str);
    $str = str_replace("'%", "‘％", $str);
    $str = str_replace("'", "’", $str);
    $str = str_replace("or(", "\or〔", $str);
    $str = str_replace(")or", "〕\or", $str);
    $str = str_replace("or(", "\or〔", $str);
    $str = str_replace(")or", "〕\or", $str);
    return $str;
}

/**
 * 防注入函数
 * @author 四川挚梦科技有限公司
 * @date 2017-01-15
 */
function ZmCMS_Sql_Replace_Inject($sql_str)
{
    return preg_replace('/select|inert|update|\/\*|\*|\.\.\/|\.\/|UNION|into|load_file|outfile/is', ' ', $sql_str);
}

function ZmCMS_RemoveXSS($val)
{
    $val = preg_replace('/([\x00-\x08,\x0b-\x0c,\x0e-\x19])/', '', $val);
    $search = 'abcdefghijklmnopqrstuvwxyz';
    $search .= 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    $search .= '1234567890!@#$%^&*()';
    $search .= '~`";:?+/={}[]-|\'\\';
    for ($i = 0; $i < strlen($search); $i++) {
        $val = preg_replace('/(&#[xX]0{0,8}' . dechex(ord($search[$i])) . ';?)/i', $search[$i], $val);
        $val = preg_replace('/(&#0{0,8}' . ord($search[$i]) . ';?)/', $search[$i], $val);
    }

    $ra1 = array('javascript', 'vbscript', 'expression', 'applet', 'meta', 'xml', 'blink', 'object', 'ilayer', 'layer', 'bgsound', 'base', 'alert');
    $ra2 = array('onabort', 'onactivate', 'onafterprint', 'onafterupdate', 'onbeforeactivate', 'onbeforecopy', 'onbeforecut', 'onbeforedeactivate', 'onbeforeeditfocus', 'onbeforepaste', 'onbeforeprint', 'onbeforeunload', 'onbeforeupdate', 'onblur', 'onbounce', 'oncellchange', 'onchange', 'onclick', 'oncontextmenu', 'oncontrolselect', 'oncopy', 'oncut', 'ondataavailable', 'ondatasetchanged', 'ondatasetcomplete', 'ondblclick', 'ondeactivate', 'ondrag', 'ondragend', 'ondragenter', 'ondragleave', 'ondragover', 'ondragstart', 'ondrop', 'onerror', 'onerrorupdate', 'onfilterchange', 'onfinish', 'onfocus', 'onfocusin', 'onfocusout', 'onhelp', 'onkeydown', 'onkeypress', 'onkeyup', 'onlayoutcomplete', 'onload', 'onlosecapture', 'onmousedown', 'onmouseenter', 'onmouseleave', 'onmousemove', 'onmouseout', 'onmouseover', 'onmouseup', 'onmousewheel', 'onmove', 'onmoveend', 'onmovestart', 'onpaste', 'onpropertychange', 'onreadystatechange', 'onreset', 'onresize', 'onresizeend', 'onresizestart', 'onrowenter', 'onrowexit', 'onrowsdelete', 'onrowsinserted', 'onscroll', 'onselect', 'onselectionchange', 'onselectstart', 'onstart', 'onstop', 'onsubmit', 'onunload');
    $ra = array_merge($ra1, $ra2);

    $found = true;
    while ($found == true) {
        $val_before = $val;
        for ($i = 0; $i < sizeof($ra); $i++) {
            $pattern = '/';
            for ($j = 0; $j < strlen($ra[$i]); $j++) {
                if ($j > 0) {
                    $pattern .= '(';
                    $pattern .= '(&#[xX]0{0,8}([9ab]);)';
                    $pattern .= '|';
                    $pattern .= '|(&#0{0,8}([9|10|13]);)';
                    $pattern .= ')*';
                }
                $pattern .= $ra[$i][$j];
            }
            $pattern .= '/i';
            $replacement = substr($ra[$i], 0, 2) . '<x>' . substr($ra[$i], 2);
            $val = preg_replace($pattern, $replacement, $val);
            if ($val_before == $val) {
                $found = false;
            }
        }
    }
    return $val;
}



function is_weixin()
{
    if (strpos($_SERVER['HTTP_USER_AGENT'], 'MicroMessenger') !== false) {
        return true;
    }
    return false;
}






