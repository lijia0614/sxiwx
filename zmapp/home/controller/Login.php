<?php

namespace app\home\controller;


use app\api\controller\WeixinLogin;
use think\Db;

class Login extends Common {

    public function __construct() {
        parent::__construct();
    }

    /**
     * 登录
     */
    public function login() {
        $back = input('get.back');
        $red = input('get.red');
        $id = input('get.id');
        $b_id = input('get.b_id');
        if ($id){
            $this->assign('id',$id);
            $this->assign('b_id',$b_id);
        }
        if ($red){
            $this->assign('red',$red);
        }
        if ($_POST){
            $post = input('post.','','trim');
            $where = [
                'phone' => $post['phone'],
                'password' => md5(md5($post['password'])),
            ];
            $res = Db::name('member')->where($where)->find();
            if ($res){
                session('user_id',$res['id']);
                session('phone',$res['phone']);
                session('username',$res['username']);
                if (strpos($_SERVER['HTTP_USER_AGENT'], 'MicroMessenger') !== false) {
                    $this->assign('back',$back);
                    $this->success('登陆成功','',2);
                }else{
                    $this->assign('back',$back);
                    $this->success('登陆成功','',1);
                }
            }else{
                $this->error('账号或密码错误，请重新登录');
            }
            exit();
        }

        $redirect_uri=urlencode('http://'.$_SERVER['HTTP_HOST'].$_SERVER['REQUEST_URI'].'/home/login/wxloginreturn');
        $this->assign('appid','wxcf37498f9c333e27');
        $this->assign('url',$redirect_uri);
        return view();
    }


    /**
     * 微信登录
     */
    public function wechatLogin(){
        $is_mobile = $this->is_mobile();
        $red = input('get.red');
        $id = input('get.id');
        $b_id = input('get.b_id');
        if ($is_mobile){
            // 手机
            $Wechat = new WeixinLogin();
            if (!isset($_GET['code'])){
                $appid='wxcf37498f9c333e27';
                $redirect_uri = urlencode('http://'.$_SERVER['HTTP_HOST'].$_SERVER['REQUEST_URI']);
//                c_print($redirect_uri);die;
                $url="https://open.weixin.qq.com/connect/oauth2/authorize?appid=$appid&redirect_uri=$redirect_uri&response_type=code&scope=snsapi_userinfo&state=1#wechat_redirect";
                header("Location:".$url);
                exit;
            }

            if ($Wechat->error) {
                $this->error($Wechat->error);
            }

            $code = input("request.code");

            if (!$code) {
                $this->error('Bad request');
            }
            $token = $Wechat->get_access_token($code);
            $Wechat->get_access_token($code);
            if (isset($token['errmsg'])) {
                $this->error($token['errmsg']);
            }
            $access_token = $token['access_token'];
            $openid = $token['openid'];
            $unionid = $token['unionid'];
            //检查数据库中是否有该openid
            $userinfo = $Wechat->get_user_info($access_token, $openid);
            $user = Db::name("member")->where(array('unionid' => $userinfo['unionid']))->find();

            if (!$user) {
                $data = [
                    'image' => $userinfo['headimgurl'],
                    'openid' => $openid,
                    'unionid' => $userinfo['unionid'],
                    'pen_name' => $userinfo['nickname'],
                    'time' => date('Y-m-d H:i:s',time()),
                    'sex' => $userinfo['sex'],
                    'address' => $userinfo['province'] . ' ' . $userinfo['city'],
                ];
                // 新增数据
                $user_id = Db::name('member')->insertGetId($data);
                session("user_id", $user_id);
                if (!empty($red)){
                    $this->redirect(url($red));
                }else{
                    $this->redirect(url('home/index/index'));
                }
                exit;
            }
            session("user_id", $user['id']);
            if ($b_id && $id){
                $this->redirect(url('home/read/read',['b_id'=>$b_id,'id'=>$id]));
                exit;
            }
            if (!empty($red)){
                $this->redirect(url($red));
            }else{
                $this->redirect(url('home/index/index'));
            }
            exit;
        }else{
            // 电脑微信登录
            $this->redirect('https://open.weixin.qq.com/connect/qrconnect?appid=wx8b4e2ae6b0a4909b&redirect_uri=http://'.$_SERVER['HTTP_HOST'].'/home/login/wxloginreturn&response_type=code&scope=snsapi_login&state='.$red.',id='.$id.'-b_id='.$b_id.'#wechat_redirect');
        }
    }


    /**
     * PC端微信登录操作
     */
    public function wxloginreturn(){
        $result = $this->oauth2();
        $red = input('get.state'); //获取返回上一页的地址
        if(strpos($red,'Home/') !== false){
            $arr = explode(",",$red);
            $red = $arr[0];
            $check = 2;
        }else{
            $arr = explode("-",$red);
            $id_arr = explode("=",$arr[0]);
            $b_id_arr = explode("=",$arr[1]);
            $id = $id_arr[1];
            $b_id = $b_id_arr[1];
            $check = 1;
        }
        if (!$result) {
            die('授权失败,请重试');
        }
        $user = Db('member')->where(['unionid' => $result['unionid']])->find();
        if ($user) {
            session_start();
            session('user_id',$user['id']);
            if (!empty($red)){
                if ($check == 2){
                    $this->redirect(url($red));
                }elseif ($check == 1){
                    if ($b_id){
                        $this->redirect(url('home/read/read',['b_id'=>$b_id,'id'=>$id]));
                        exit();
                    }
                    $this->redirect(url('home/index/index'));
                }
            }else{
                $this->redirect(url('home/index/index'));
            }
            exit;
        }
        //新增用户
        $get_user_info_url = "https://api.weixin.qq.com/sns/userinfo?access_token=".$result['access_token']."&openid=".$result['openid']."&lang=zh_CN";
        $userinfo = getJson($get_user_info_url);
        $data = [
            'unionid' => $result['unionid'],
            'pen_name' => $userinfo['nickname'],
            'image' => $userinfo['headimgurl'],
            'time' => date('Y-m-d H:i:s',time()),
            'sex' => $userinfo['sex'],
            'address' => $userinfo['province'] . ' ' . $userinfo['city'],
        ];
        $id = Db::name('member')->insertGetId($data);
        $user = Db('member')->where(['id' => $id])->find();
        session('user_id',$user['id']);
        $this->redirect(url('index/index'));
        exit;
    }

    function oauth2()
    {
        $code = input('get.code', '', 'trim');
        if (!$code) {
            return false;
        }
        $url = "https://api.weixin.qq.com/sns/oauth2/access_token?appid=wx8b4e2ae6b0a4909b&secret=9da7b1cb3c34655ff30b1d0aa5f5c642&code=" . $code . "&grant_type=authorization_code";
        $res = $this->httpRequest($url);

        $res = json_decode($res, true);
        if (!$res['openid']) {
            return false;
        }
        return $res;
    }

    public function is_mobile(){
        $useragent = $_SERVER['HTTP_USER_AGENT'];
        if (preg_match('/(android|bb\d+|meego).+mobile|avantgo|bada\/|blackberry|blazer|compal|elaine|fennec|hiptop|iemobile|ip(hone|od)|iris|kindle|lge |maemo|midp|mmp|mobile.+firefox|netfront|opera m(ob|in)i|palm( os)?|phone|p(ixi|re)\/|plucker|pocket|psp|series(4|6)0|symbian|treo|up\.(browser|link)|vodafone|wap|windows ce|xda|xiino/i', $useragent) || preg_match('/1207|6310|6590|3gso|4thp|50[1-6]i|770s|802s|a wa|abac|ac(er|oo|s\-)|ai(ko|rn)|al(av|ca|co)|amoi|an(ex|ny|yw)|aptu|ar(ch|go)|as(te|us)|attw|au(di|\-m|r |s )|avan|be(ck|ll|nq)|bi(lb|rd)|bl(ac|az)|br(e|v)w|bumb|bw\-(n|u)|c55\/|capi|ccwa|cdm\-|cell|chtm|cldc|cmd\-|co(mp|nd)|craw|da(it|ll|ng)|dbte|dc\-s|devi|dica|dmob|do(c|p)o|ds(12|\-d)|el(49|ai)|em(l2|ul)|er(ic|k0)|esl8|ez([4-7]0|os|wa|ze)|fetc|fly(\-|_)|g1 u|g560|gene|gf\-5|g\-mo|go(\.w|od)|gr(ad|un)|haie|hcit|hd\-(m|p|t)|hei\-|hi(pt|ta)|hp( i|ip)|hs\-c|ht(c(\-| |_|a|g|p|s|t)|tp)|hu(aw|tc)|i\-(20|go|ma)|i230|iac( |\-|\/)|ibro|idea|ig01|ikom|im1k|inno|ipaq|iris|ja(t|v)a|jbro|jemu|jigs|kddi|keji|kgt( |\/)|klon|kpt |kwc\-|kyo(c|k)|le(no|xi)|lg( g|\/(k|l|u)|50|54|\-[a-w])|libw|lynx|m1\-w|m3ga|m50\/|ma(te|ui|xo)|mc(01|21|ca)|m\-cr|me(rc|ri)|mi(o8|oa|ts)|mmef|mo(01|02|bi|de|do|t(\-| |o|v)|zz)|mt(50|p1|v )|mwbp|mywa|n10[0-2]|n20[2-3]|n30(0|2)|n50(0|2|5)|n7(0(0|1)|10)|ne((c|m)\-|on|tf|wf|wg|wt)|nok(6|i)|nzph|o2im|op(ti|wv)|oran|owg1|p800|pan(a|d|t)|pdxg|pg(13|\-([1-8]|c))|phil|pire|pl(ay|uc)|pn\-2|po(ck|rt|se)|prox|psio|pt\-g|qa\-a|qc(07|12|21|32|60|\-[2-7]|i\-)|qtek|r380|r600|raks|rim9|ro(ve|zo)|s55\/|sa(ge|ma|mm|ms|ny|va)|sc(01|h\-|oo|p\-)|sdk\/|se(c(\-|0|1)|47|mc|nd|ri)|sgh\-|shar|sie(\-|m)|sk\-0|sl(45|id)|sm(al|ar|b3|it|t5)|so(ft|ny)|sp(01|h\-|v\-|v )|sy(01|mb)|t2(18|50)|t6(00|10|18)|ta(gt|lk)|tcl\-|tdg\-|tel(i|m)|tim\-|t\-mo|to(pl|sh)|ts(70|m\-|m3|m5)|tx\-9|up(\.b|g1|si)|utst|v400|v750|veri|vi(rg|te)|vk(40|5[0-3]|\-v)|vm40|voda|vulc|vx(52|53|60|61|70|80|81|83|85|98)|w3c(\-| )|webc|whit|wi(g |nc|nw)|wmlb|wonu|x700|yas\-|your|zeto|zte\-/i',
                substr($useragent, 0, 4))) {
            // 手机
            return true;
        } else {
            // 电脑
            return false;
        }
    }


    public function wlogin(){

        return view();
    }

    /**
     * 注册短信
     */
    public function reg_sms(){
        $phone = input('post.phone','','trim');
        $is_reg = Db::name('member')->where('phone',$phone)->find();
        if ($is_reg){
            $this->error('该手机号码已注册');
        }
        $tpl_id = 20;
        $data = rand(100000,999999);
        session('reg_code', $data);
        session('reg_phone', $phone);
        $arr = [
            'code' => $data
        ];
        $code = json_encode($arr);

        $sendRes = sendSms($phone, $tpl_id, $code);
        c_print($sendRes);
    }

    /**
     * 找回密码短信
     */
    public function sendMsg(){
        $phone = input('post.phone','','trim');
        $check = Db::name('member')->where('phone',$phone)->find();
        if (!$check){
            $this->error('改手机还未注册');
        }
        $tpl_id = 21;
        $data = rand(1000,9999);
        session('send_code', $data);
        session('send_phone', $phone);
        $arr = [
            'code' => $data
        ];
        $code = json_encode($arr);
        $sendRes = sendSms($phone, $tpl_id, $code);
        $this->success('cg');
    }

    public function changePwd(){
        $post = input('post.','','trim');
        $data = [
            'password' => md5(md5($post['pwd'])),
        ];
        session_start();
        if ($_SESSION['zmcms']['send_code'] == $post['code'] && $_SESSION['zmcms']['send_phone'] == $post['phone']){
            $res = Db::name('member')->where('phone',$post['phone'])->update($data);
            if ($res){
                $this->success('修改成功，你可以登录了！');
            }else{
                $this->error('修改失败，请稍后再试');
            }
        }else{
            $this->error('手机验证码错误');
        }
    }

    /**
     * 注册
     */
    public function register(){
        if ($_POST){
            $post = input('post.','','trim');
            $data = [
                'phone' => $post['phone'],
                'password' => md5(md5($post['password'])),
                'time' => date('Y-m-d H:i:s')
            ];
            session_start();
            if ($_SESSION['zmcms']['reg_code'] == $post['code'] && $_SESSION['zmcms']['reg_phone'] == $post['phone']){
                $res = Db::name('member')->insert($data);
                if ($res){
                    $this->success('注册成功，你可以登录了！');
                }else{
                    $this->error('注册失败，请稍后再试');
                }
            }else{
                $this->error('手机验证码错误');
            }
        }
        return view();
    }

    /**
     * 找回密码
     */
    public function findpwd(){

        return view();
    }

    /**
     * 绑定手机号码
     */
    public function bindPhone(){
        session_start();
        $phone = input('post.phone');
        $pwd = input('post.pwd');
        $where = [
            'phone' => $phone,
            'password' => md5(md5($pwd)),
        ];
        $res = Db::name('member')->where($where)->find();
        if (!$res){
            $this->error('手机号码或者密码错误');
        }
        if (!empty($res['unionid'])){
            $this->error('该账号已经绑定了微信，不能再次绑定');
        }
        $unionid = session('unionid');
        if (!$unionid){
            $this->error('没有找到unionid');
        }
        $data = [
            'unionid' => $unionid,
        ];
        $bind = Db::name('member')->where($where)->update($data);
        if ($bind){
            $this->success('绑定成功');
        }else{
            $this->error('绑定失败，请稍后再试');
        }
    }

    /**
     * 微信创建新账号
     */
    public function create(){
        if ($_POST){
            $post = input('post.');
            c_print($post);die;
        }
        return view();
    }

    /**
     * 退出登录
     */
    public function loginOut(){
        $user_id = $this->user_id;
        session_start();
        if (!$user_id){
            $this->error('退出失败');
        }
        session('user_id',null);
        $this->success('已退出');
    }

    /**
     * CURL请求
     * @param $url 请求url地址
     * @param $method 请求方法 get post
     * @param null $postfields post数据数组
     * @param array $headers 请求header信息
     * @param bool|false $debug 调试开启 默认false
     * @return mixed
     */
    private function httpRequest($url, $method = "GET", $postfields = null, $headers = array(), $debug = false)
    {
        $method = strtoupper($method);
        $ci = curl_init();
        /* Curl settings */
        curl_setopt($ci, CURLOPT_HTTP_VERSION, CURL_HTTP_VERSION_1_0);
        curl_setopt($ci, CURLOPT_USERAGENT, "Mozilla/5.0 (Windows NT 6.2; WOW64; rv:34.0) Gecko/20100101 Firefox/34.0");
        curl_setopt($ci, CURLOPT_CONNECTTIMEOUT, 60); /* 在发起连接前等待的时间，如果设置为0，则无限等待 */
        curl_setopt($ci, CURLOPT_TIMEOUT, 7); /* 设置cURL允许执行的最长秒数 */
        curl_setopt($ci, CURLOPT_RETURNTRANSFER, true);
        switch ($method) {
            case "POST":
                curl_setopt($ci, CURLOPT_POST, true);
                if (!empty($postfields)) {
                    $tmpdatastr = is_array($postfields) ? http_build_query($postfields) : $postfields;
                    curl_setopt($ci, CURLOPT_POSTFIELDS, $tmpdatastr);
                }
                break;
            default:
                curl_setopt($ci, CURLOPT_CUSTOMREQUEST, $method); /* //设置请求方式 */
                break;
        }
        $ssl = preg_match('/^https:\/\//i', $url) ? TRUE : FALSE;
        curl_setopt($ci, CURLOPT_URL, $url);
        if ($ssl) {
            curl_setopt($ci, CURLOPT_SSL_VERIFYPEER, FALSE); // https请求 不验证证书和hosts
            curl_setopt($ci, CURLOPT_SSL_VERIFYHOST, FALSE); // 不从证书中检查SSL加密算法是否存在
        }
        //curl_setopt($ci, CURLOPT_HEADER, true); /*启用时会将头文件的信息作为数据流输出*/
        curl_setopt($ci, CURLOPT_FOLLOWLOCATION, 1);
        curl_setopt($ci, CURLOPT_MAXREDIRS, 2);/*指定最多的HTTP重定向的数量，这个选项是和CURLOPT_FOLLOWLOCATION一起使用的*/
        curl_setopt($ci, CURLOPT_HTTPHEADER, $headers);
        curl_setopt($ci, CURLINFO_HEADER_OUT, true);
        /*curl_setopt($ci, CURLOPT_COOKIE, $Cookiestr); * *COOKIE带过去** */
        $response = curl_exec($ci);
        $requestinfo = curl_getinfo($ci);
        $http_code = curl_getinfo($ci, CURLINFO_HTTP_CODE);
        if ($debug) {
            echo "=====post data=====\r\n";
            var_dump($postfields);
            echo "=====info===== \r\n";
            print_r($requestinfo);
            echo "=====response=====\r\n";
            print_r($response);
        }
        curl_close($ci);
        return $response;
//        return array($http_code, $response,$requestinfo);
    }

}
