<?php

/**
 * @空控制器
 * @author 四川挚梦科技有限公司 
 * @date 2018-03-20
 * @copyright Copyright (C) 2016-2017, ChengDu ZhiMengCMS Co., Ltd.
 */

namespace app\home\controller;

use think\Db;
use think\Json;

class Info extends Common {

    public function __construct() {

        parent::__construct();
    }

    /**
     * 基本信息
     */
    public function baseInfo(){
        $user_id = $this->user_id;
        if ($user_id){
            $user = Db::name('member')->where('id',$user_id)->find();
            $this->assign('user',$user);
        }
        if ($_POST){
            $sex = input('post.sex','','intval');
            $pen_name = input('post.pen_name');
            $data = [
                'sex' => $sex,
                'pen_name' => $pen_name
            ];
            $res = Db::name('member')->where('id',$this->user_id)->update($data);
            if ($res){
                JsonDie("1", '修改成功', '');
            }else{
                JsonDie("0", '修改失败', '');
            }
        }
        return view();
    }

    /**
     * 绑定微信
     */
    public function bin_wx(){
        $this->redirect('https://open.weixin.qq.com/connect/qrconnect?appid=wx8b4e2ae6b0a4909b&redirect_uri=http://'.$_SERVER['HTTP_HOST'].'/home/info/wxloginreturn&response_type=code&scope=snsapi_login&state=STATE#wechat_redirect');
    }

    public function wxloginreturn(){
        $result = $this->oauth2();
        if (!$result) {
            die('授权失败,请重试');
        }

        $user = Db('member')->where(['unionid' => $result['unionid']])->find();
        if ($user['phone']){
            die('该账号已经绑定了手机号码');
        }
        $info = Db::name('member')
            ->where('id',$this->user_id)
            ->find();
        $data = [
            'unionid' => $user['unionid'],
        ];
        if ($user){
            $data['money'] = $user['money'] + $info['money'];
            if (!$info['pen_name']){
                $data['pen_name'] =  $user['pen_name'];
            }
            if (!$info['image']){
                $data['image'] = $user['image'];
            }
            $res = Db::name('member')->where('id',$this->user_id)->update($data);
            if ($res){
                $this->redirect(url('info/bind'));
            }else{
                die('绑定失败');
            }
            exit();
        }

        $get_user_info_url = "https://api.weixin.qq.com/sns/userinfo?access_token=".$result['access_token']."&openid=".$result['openid']."&lang=zh_CN";
        $userinfo = getJson($get_user_info_url);
        if (!$info['pen_name']){
            $data['pen_name'] =  $user['pen_name'];
        }
        if (!$info['image']){
            $data['image'] = $user['image'];
        }
        if (!$info['sex']){
            $data['sex'] = $user['sex'];
        }
        if (!$info['address']){
            $data['address'] = $userinfo['province'] . ' ' . $userinfo['city'];
        }
        $res = Db::name('member')->where('id',$this->user_id)->update($data);
        if ($res){
            $this->redirect(url('info/bind'));
        }else{
            die('绑定失败');
        }
        exit();
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

    /**
     * 手机端
     */
    public function mcenter(){
        $user_id = $this->user_id;
        $this->isLogin();
        if ($user_id){
            $user = Db::name('member')->where('id',$user_id)->find();
            $this->assign('user',$user);
        }

        $user = Db::name('member')->where('id',$this->user_id)->field('is_vip,vip_create_time')->find();

        $t = strtotime($user['vip_create_time']);
        $deadline = date('Y-m-d H:i:s',$t+365*24*60*60); // 会员过期时间
        $now = date('Y-m-d H:i:s',time()); // 现在的时间

        if ($user['is_vip'] == 1){
            if (strtotime($now) < strtotime($deadline)) {
                $times = strtotime($deadline) - strtotime($now);
                $surplus = floor($times / (24 * 3600));
                $str = "亲，您的会员还有".$surplus."天才到期哦！";
                $this->assign('str',$str);
            }
        }

        return view();
    }

    /**
     * 手机端：消费记录
     */
    public function mxiaofei(){
        $user_id = $this->user_id;
        if ($user_id){
            $user = Db::name('member')->where('id',$user_id)->find();
            $this->assign('user',$user);
        }

        $count1 = Db::name('gift')
            ->where('u_id',$this->user_id)
            ->count();
        $count2 = Db::name('gift')
            ->where('u_id',$this->user_id)
            ->count();
        $count = $count1 + $count2;
        $gift = Db::name('gift')
            ->where('u_id',$this->user_id)
            ->order('id desc')
            ->select();

        $reward = Db::name('reward')
            ->where('u_id',$this->user_id)
            ->order('id desc')
            ->select();
        $list = array_merge($gift,$reward);

        $this->assign('list',$list);
        return view();
    }

    /**
     * 手机端：充值
     */
    public function mcz(){
        $this->assign('u_id',$this->user_id);
        return view();
    }

    /**
     * 书架
     */
    public function bookShelf(){
        $user_id = $this->user_id;
        $this->isLogin();
        if ($user_id){
            $user = Db::name('member')->where('id',$user_id)->find();
            $this->assign('user',$user);
        }

        $data = Db::name('book')
            ->alias('a')
            ->join('take b','a.id = b.b_id')
            ->where('b.u_id',$user_id)
            ->where('a.status',1)
            ->field('a.id,name,author,is_end,image,type,other_bookid')
            ->select();
        $count = Db::name('book')
            ->alias('a')
            ->join('take b','a.id = b.b_id')
            ->where('b.u_id',$user_id)
            ->where('a.status',1)
            ->count();

        foreach ($data as $k=>$v){
            $bookId = $v['other_bookid'];
            if ($v['type'] == 3){
                $url = 'http://store.zhewenit.com/api/Shuangxige/structure?bookId='.$bookId;
                $res = httpPost($url);
                if ($res['code'] != 0){
                    return false;
                }
                $otherData = object_array($res['data']);
                $otherChapter = $otherData['books'];
                $otherNew = end($otherChapter); // 获取最后一章
                $otherFirst = reset($otherChapter); // 获取第一章

                $read_record = Db::name('read_record') // 查询阅读记录
                ->where('u_id',$this->user_id)
                    ->where('b_id',$v['id'])
                    ->find();

                $get_content_url = 'http://store.zhewenit.com/api/Shuangxige/chapterinfo?bookId='.$bookId.'&chapterId='.$read_record['chapter_id'];
                $r = httpPost($get_content_url);
                $c_info = object_array($r['data']);
                $rec = $c_info['books'];
                $data[$k]['res'] = $rec;
                $data[$k]['firt'] = $otherFirst;
                $data[$k]['end'] = $otherNew;
                $data[$k]['bookId'] = $bookId;
                $data[$k]['read_time'] = $this->transTime($read_record['time']);

                $this->assign('$rec',$rec);
            }elseif ($v['type'] == 4){
                $url = 'http://www.bqread.com/api/shuangxi/get_chapter_list.php?aid='.$bookId;
                $res = httpPost($url);
                if ($res['code'] != 0){
                    return false;
                }
                $otherChapter = object_array($res['data']);
                $otherNew = end($otherChapter); // 获取最后一章
                $otherNew['title'] = $otherNew['chaptername'];
                $otherFirst = reset($otherChapter); // 获取第一章
                $otherFirst['title'] = $otherFirst['chaptername'];
                $read_record = Db::name('read_record') // 查询阅读记录
                ->where('u_id',$this->user_id)
                    ->where('b_id',$v['id'])
                    ->find();
                $get_content_url = 'http://www.bqread.com/api/shuangxi/get_chapter_content.php?aid='.$bookId.'&chapterid='.$read_record['chapter_id'];
                $r = httpPost($get_content_url);
                $rec = object_array($r['data']);
                $rec['title'] = $rec['chaptername'];
                $data[$k]['res'] = $rec;
                $data[$k]['firt'] = $otherFirst;
                $data[$k]['end'] = $otherNew;
                $data[$k]['bookId'] = $bookId;
                $data[$k]['read_time'] = $this->transTime($read_record['time']);

                $this->assign('$rec',$rec);
            }
            $chapter = Db::name('chapter') // 查询最后一章
                ->where('b_id',$v['id'])
                ->where('status',1)
                ->field('id,name')
                ->order('id desc')
                ->limit(1)
                ->find();

            $first = Db::name('chapter') // 查询第一一章
                ->where('b_id',$v['id'])
                ->where('status',1)
                ->field('id,name')
                ->order('id asc')
                ->limit(1)
                ->find();
            $read_record = Db::name('read_record') // 查询阅读记录
                ->where('u_id',$this->user_id)
                ->where('b_id',$v['id'])
                ->find();

            $record = Db::name('chapter')
                ->where('id',$read_record['chapter_id'])
                ->field('id,name')
                ->find();

            $data[$k]['record'] = $record;
            $data[$k]['chapter'] = $chapter;
            $data[$k]['first'] = $first;
            $data[$k]['read_time'] = $this->transTime($read_record['time']); // 最后阅读时间
        }

        $this->assign('data',$data);
        $this->assign('count',$count);
        return view();
    }


    /**
     *  时间转换函数
     */
    function transTime($ustime) {
        $ytime = date("Y-m-d",$ustime);
        $rtime = date("n月j日",$ustime);
        $htime = date("H:i",$ustime);
        $time = time() - $ustime;
        $todaytime = strtotime("today");
        $time1 = time() - $todaytime;
        if($time < 60){
            $str = '刚刚';
        }else if($time < 60 * 60){
            $min = floor($time/60);
            $str = $min.'分钟前';
        }else if($time < $time1){
            $str = '今天'.$htime;
        }else{
            $str = $rtime;
        }
        return $str;
    }

    /**
     * 移出书架
     */
    public function moveOut() {
        $b_id = input('post.b_id','','intval');
        if($b_id){
            $res = Db::name('take')
                ->where('u_id',$this->user_id)
                ->where('b_id',$b_id)
                ->delete();
            if ($res){
                JsonDie("1", '移出成功', '');
            }else{
                JsonDie("0", '移出失败', '');
            }
        }else{
            JsonDie("0", '移出失败', '');
        }
    }


    /**
     * 钱包
     */
    public function wallet(){
        $user_id = $this->user_id;
        if ($user_id){
            $user = Db::name('member')->where('id',$user_id)->find();
            $this->assign('user',$user);
        }

        $count1 = Db::name('recharge')
            ->where('u_id',$this->user_id)
            ->where('is_pay',1)
            ->order('create_time','desc')
            ->count();
        $obj_page = $this->_Page($count1, 10);
        $page = $obj_page->newshow();
        // 查询充值记录
        $recharge_log = Db::name('recharge')
            ->where('u_id',$this->user_id)
            ->where('is_pay',1)
            ->limit($obj_page->firstRow, $obj_page->listRows)
            ->order('id desc')
            ->select();
//        c_print($recharge_log);
        $this->assign('page',$page);
        $this->assign('list',$recharge_log);
        return view();
    }

    /**
     * 消费
     */
    public function xiaofei(){
        $user_id = $this->user_id;
        if ($user_id){
            $user = Db::name('member')->where('id',$user_id)->find();
            $this->assign('user',$user);
        }

        $count1 = Db::name('gift')
            ->where('u_id',$this->user_id)
            ->count();
        $count2 = Db::name('gift')
            ->where('u_id',$this->user_id)
            ->count();
        $count = $count1 + $count2;
        $obj_page = $this->_Page($count, 10);
        $page = $obj_page->newshow();
        $gift = Db::name('gift')
            ->where('u_id',$this->user_id)
            ->limit($obj_page->firstRow, $obj_page->listRows)
            ->order('id desc')
            ->select();
//        c_print($gift);

        $reward = Db::name('reward')
            ->where('u_id',$this->user_id)
            ->limit($obj_page->firstRow, $obj_page->listRows)
            ->order('id desc')
            ->select();
        $list = array_merge($gift,$reward);
        $this->assign('page',$page);
        $this->assign('list',$list);
        return view();
    }

    /**
     * 我的私信
     */
    public function reply(){
        $user_id = $this->user_id;
        if ($_POST){
            $id = input('post.id');
            $msg = Db::name('notice')
                ->where('id',$id)
                ->find();
            // 修改状态为已读
            $d = [
                'status' => 2
            ];
            Db::name('notice')
                ->where('id',$id)
                ->update($d);
            if ($msg){
                return $msg;
            }
            exit();
        }
        if ($user_id){
            $user = Db::name('member')->where('id',$user_id)->find();
            $this->assign('user',$user);
        }
        $notice = Db::name('notice')
            ->where('type',3)
            ->select();
        $count = Db::name('notice')
            ->where('u_id',$user_id)
            ->where('u_del',0)
            ->where('type',2)
            ->count();
        $data = Db::name('notice')
            ->where('u_id',$user_id)
            ->where('u_del',0)
            ->where('type',2)
            ->select();
        $list = array_merge($notice,$data);

        foreach ($list as $k=>$v){
            $list[$k]['time'] = strtotime($v['create_time']);
        }
        $this->assign('data',$list);
        $this->assign('count',$count);
        return view();
    }

    /**
     * 修改头像
     */
    public function avatar(){
        $user_id = $this->user_id;
        if ($user_id){
            $user = Db::name('member')->where('id',$user_id)->find();
            $this->assign('user',$user);
        }
        if($_POST){
            $image = input('post.image');
            $res = Db::name('member')->where('id',$this->user_id)->update(['image'=>$image]);
            if ($res){
                JsonDie("1", '更新成功', '');
            }else{
                JsonDie("0", '更新失败', '');
            }
        }

        return view();
    }

    /**
     * 修改密码
     */
    public function updatePwd(){
        $user_id = $this->user_id;
        if ($user_id){
            $user = Db::name('member')->where('id',$user_id)->find();
            $this->assign('user',$user);
        }
        if($_POST){
            $old_pwd = input('post.old_pwd');
            $pwd = input('post.pwd');
            $user = Db::name('member')->where('id',$user_id)->field('password')->find();
            if (md5(md5($old_pwd)) != $user['password']){
                JsonDie("0", '原密码错误', '');
            }
            if (md5(md5($pwd)) == $user['password']){
                JsonDie("0", '新密码不能和原密码一样', '');
            }
            $res = Db::name('member')->where('id',$this->user_id)->update(['password'=>md5(md5($pwd))]);
            if ($res){
                JsonDie("1", '修改成功', '');
            }else{
                JsonDie("0", '修改失败', '');
            }
        }

        return view();
    }

    /**
     * 绑定账号
     */
    public function bind(){
        $user_id = $this->user_id;
        if ($user_id){
            $user = Db::name('member')->where('id',$user_id)->find();
            $this->assign('user',$user);
        }
        return view();
    }

    /**
     * 绑定手机号码
     */
    public function binMobile(){
        $user_id = $this->user_id;

        $user = Db::name('member')->where('id',$user_id)->find();
        $this->assign('user',$user);

        if ($_POST){
            $post = input('post.');
            session_start();
            if ($_SESSION['zmcms']['bind_code'] == $post['code'] && $_SESSION['zmcms']['bind_phone'] == $post['phone']){
                $find = Db::name('member')->where('phone',$post['phone'])->find(); // 查找绑定手机号码的信息
                if (!$find){
                    if (!$post['pwd']){
                        $this->error('未注册手机请输入登录密码');
                    }
                    $data = [
                        'phone' => $post['phone'],
                        'password' => md5(md5($post['pwd'])),
                    ];
                    $res = Db::name('member')->where('id',$this->user_id)->update($data);
                    if ($res){
                        $this->success('绑定成功');
                    }else{
                        $this->error('手机号码绑定失败');
                    }
                }else{
                    $data = [
                        'money' => $find['money'] + $user['money'],
                        'unionid' => $user['unionid']
                    ];
                    if (!$find['image']){
                        $data['image'] = $user['image'];
                    }
                    if (!$find['pen_name']){
                        $data['pen_name'] = $user['pen_name'];
                    }
                    $res = Db::name('member')->where('id',$find['id'])->update($data);
                    if ($res){
                        session_start();
                        session('user_id',$find['id']);
                        $this->success('绑定成功');
                    }else{
                        $this->error('手机号码绑定失败');
                    }
                }

            }else{
                $this->error('手机验证码错误');
            }

        }
        return view();
    }

    /**
     * 修改手机号
     */
    public function changeMobile(){
        $user_id = $this->user_id;
        if ($user_id){
            $user = Db::name('member')->where('id',$user_id)->find();
            $this->assign('user',$user);
        }
        if ($_POST){
            $data = input('post.');
            $is_reg = Db::name('member')->where('phone',$data['new_phone'])->find();
            if ($is_reg){
                $this->error('新手机号码已注册');
            }

            session_start();

            if ($_SESSION['zmcms']['update_code'] == $data['code'] && $_SESSION['zmcms']['update_phone'] == $user['phone']){
                $res = Db::name('member')->where('id',$user['id'])->update(['phone'=>$data['new_phone']]);
                if ($res){
                    $this->success('修改成功！');
                }else{
                    $this->error('修改失败，请稍后再试');
                }
            }else{
                $this->error('手机验证码错误');
            }
        }
        return view();
    }

    /**
     * 修改手机号码短信
     */
    public function sendMsg(){
        $phone = input('post.phone','','trim');
        $tpl_id = 22;
        $data = rand(1000,9999);
        session('update_code', $data);
        session('update_phone', $phone);
        $arr = [
            'code' => $data
        ];
        $code = json_encode($arr);
        $sendRes = sendSms($phone, $tpl_id, $code);
        $this->success('cg');
    }

    /**
     * 绑定手机号码短信
     */
    public function bindMsg(){
        $phone = input('post.phone','','trim');

        $tpl_id = 26;
        $data = rand(1000,9999);
        session('bind_code', $data);
        session('bind_phone', $phone);
        $arr = [
            'code' => $data
        ];
        $code = json_encode($arr);
        $sendRes = sendSms($phone, $tpl_id, $code);
        $this->success('cg');
    }

    /**
     * 上传头像
     */
    public function uplodePhoto()
    {
        $file = request()->file('uplodePhoto');
        // 移动到框架应用根目录/uploads/ 目录下
        $save_path = '/uploads/img/'; //上传路径

        $info = $file->validate(array('size' => 4096000, 'ext' => 'jpg,png,gif'))->move(WEB_PATH . $save_path); // 根目录/uploads下
        if ($info) {
            $filePath = $save_path . str_replace("\\", "/", $info->getSaveName()); //服务器上相对路径
            JsonDie(200, '上传成功', 'yes', $filePath);
        } else {
            // 上传失败获取错误信息
            JsonDie(0, $file->getError());
        }
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



