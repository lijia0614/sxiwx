<?php

namespace app\home\controller;

use think\Controller;
use think\facade\Config;
use think\Db;
use think\facade\Env;
use think\facade\Validate;
use think\facade\Session;
use Upload\UploadFile;
use Payments\aliPay;
use Sms\aliyun;
use Excels\Excel;
use Oauths\qq;


class Users extends Common {

    public function __construct() {
        parent::__construct();
        $this->isLogin();
        $user = Db::name('member')->where('id',$this->user_id)->find();
        $this->assign('user',$user);
    }

    /**
     * 首页
     */
    public function home() {

        $user = Db::name('member')->where('id',$this->user_id)->find();
        if ($user['is_author'] == 0){
            return view('apply');
        }
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
        $count = Db::name('notice')
            ->where('type',1)
            ->where('u_id',$this->user_id)
            ->count();
        $this->assign('count',$count);
        $obj_page = $this->_Page($count,10);
        $page = $obj_page->newshow();
        $data = Db::name('notice')
            ->where('type',1)
            ->where('u_id',$this->user_id)
            ->limit($obj_page->firstRow, $obj_page->listRows)
            ->order('id desc')
            ->select();
        foreach ($data as $k=>$v){
            $data[$k]['time'] = strtotime($v['create_time']);
        }
        $time = time();
        $time1 = date("w",time( ));
        $array = ["周日","周一","周二","周三","周四","周五","周六"];
        $time1 = date("w",time( ));
        $this->assign('time1',$array[$time1]);
        $this->assign('time',$time);
        $this->assign('count',$count);
        $this->assign('page',$page);
        $this->assign('data',$data);
        return view();
    }
	
	/**
     * 日收入
     */
	public function day(){
	    $date = date('Y-m-d',time());
        $beginToday = mktime(0,0,0,date('m'),date('d'),date('Y'));
        $endToday = mktime(0,0,0,date('m'),date('d')+1,date('Y'))-1;

        $todayGift = Db::name('gift')
            ->alias('a')
            ->join('member b','a.u_id = b.id')
            ->join('book c','c.id = a.b_id')
            ->field('sum(a.total) as total,c.name as b_name,c.id as b_id')
            ->where('a.time','>=', $beginToday)
            ->where('a.time','<=', $endToday)
            ->where('c.u_id',$this->user_id)
            ->group('a.b_id')
            ->select();
//        echo Db::name('gift')->getLastSql();
        foreach ($todayGift as $k=>$v){
            $todayGift[$k]['type'] = '打赏';
        }
        $todayReward = Db::name('reward')
            ->alias('a')
            ->join('member b','a.u_id = b.id')
            ->join('book c','c.id = a.b_id')
            ->field('sum(a.price) as total,c.name as b_name,c.id as b_id')
            ->where('a.time','>=', $beginToday)
            ->where('a.time','<=', $endToday)
            ->where('c.u_id',$this->user_id)
            ->group('a.b_id')
            ->select();
        foreach ($todayReward as $k=>$v){
            $todayReward[$k]['type'] = '订阅';
        }
        $today = array_merge($todayGift,$todayReward);
        foreach ($today as $k=>$v){
            $today['count'] += $v['total'];
        }
        $this->assign('date',$date);
        $this->assign('today',$today);
	    return view();
    }

    /**
     * 按日期查询日报
     */
    public function daily(){
        $time = input('post.date');
        $begin = strtotime($time);
        $end = $begin + 3600*24;
        $todayGift = Db::name('gift')
            ->alias('a')
            ->join('member b','a.u_id = b.id')
            ->join('book c','c.id = a.b_id')
            ->field('sum(a.total) as total,c.name as b_name,c.id as b_id')
            ->where('a.time','>=', $begin)
            ->where('a.time','<=', $end)
            ->where('c.u_id',$this->user_id)
            ->group('a.b_id')
            ->select();
        foreach ($todayGift as $k=>$v){
            $todayGift[$k]['type'] = '打赏';
        }
        $todayReward = Db::name('reward')
            ->alias('a')
            ->join('member b','a.u_id = b.id')
            ->join('book c','c.id = a.b_id')
            ->field('sum(a.price) as total,c.name as b_name,c.id as b_id')
            ->where('a.time','>=', $begin)
            ->where('a.time','<=', $end)
            ->where('c.u_id',$this->user_id)
            ->group('a.b_id')
            ->select();
        foreach ($todayReward as $k=>$v){
            $todayReward[$k]['type'] = '订阅';
        }

        $today = array_merge($todayGift,$todayReward);
        $data  = [
            'book' => $today
        ];
        foreach ($today as $k=>$v){
            $data['count'] += $v['total'];
        }
        if ($today){
            return JsonDie(1,'success','yes',$data);
        }else{
            return JsonDie(0,'没有查询到相关数据','yes','');
        }

    }

    /**
     * 月报查询
     */
    public function monthly(){
        $time = input('post.date');
        $month_start = strtotime($time); //指定月份月初时间戳
        $month_end = mktime(23, 59, 59, date('m', strtotime($time))+1, 00); //指定月份月末时间戳
        $todayGift = Db::name('gift')
            ->alias('a')
            ->join('member b','a.u_id = b.id')
            ->join('book c','c.id = a.b_id')
            ->field('sum(a.total) as total,c.name as b_name,c.id as b_id')
            ->where('a.time','>=', $month_start)
            ->where('a.time','<=', $month_end)
            ->where('c.u_id',$this->user_id)
            ->group('a.b_id')
            ->select();
        foreach ($todayGift as $k=>$v){
            $todayGift[$k]['type'] = '打赏';
        }
        $todayReward = Db::name('reward')
            ->alias('a')
            ->join('member b','a.u_id = b.id')
            ->join('book c','c.id = a.b_id')
            ->field('sum(a.price) as total,c.name as b_name,c.id as b_id')
            ->where('a.time','>=', $month_start)
            ->where('a.time','<=', $month_end)
            ->where('c.u_id',$this->user_id)
            ->group('a.b_id')
            ->select();
        foreach ($todayReward as $k=>$v){
            $todayReward[$k]['type'] = '订阅';
        }

        $today = array_merge($todayGift,$todayReward);
        $data  = [
            'book' => $today
        ];
        foreach ($today as $k=>$v){
            $data['count'] += $v['total'];
        }
        if ($today){
            return JsonDie(1,'success','yes',$data);
        }else{
            return JsonDie(0,'没有查询到相关数据','yes','');
        }
    }

    /**
     * 月收入
     */
    public function month(){
        $date = date('Y-m',time());

        $month_start = strtotime($date); //指定月份月初时间戳
        $month_end = mktime(23, 59, 59, date('m', strtotime($date))+1, 00); //指定月份月末时间戳

        $todayGift = Db::name('gift')
            ->alias('a')
            ->join('member b','a.u_id = b.id')
            ->join('book c','c.id = a.b_id')
            ->field('sum(a.total) as total,c.name as b_name,c.id as b_id')
            ->where('a.time','>=', $month_start)
            ->where('a.time','<=', $month_end)
            ->where('c.u_id',$this->user_id)
            ->group('a.b_id')
            ->select();
        foreach ($todayGift as $k=>$v){
            $todayGift[$k]['type'] = '打赏';
        }
        $todayReward = Db::name('reward')
            ->alias('a')
            ->join('member b','a.u_id = b.id')
            ->join('book c','c.id = a.b_id')
            ->field('sum(a.price) as total,c.name as b_name,c.id as b_id')
            ->where('a.time','>=', $month_start)
            ->where('a.time','<=', $month_end)
            ->where('c.u_id',$this->user_id)
            ->group('a.b_id')
            ->select();
        foreach ($todayReward as $k=>$v){
            $todayReward[$k]['type'] = '订阅';
        }
        $today = array_merge($todayGift,$todayReward);
        foreach ($today as $k=>$v){
            $today['count'] += $v['total'];
        }

        $this->assign('date',$date);
        $this->assign('today',$today);


        $this->assign('date',$date);
        return view();
    }

    /**
     * 提现记录
     */
    public function extract(){

        return view();
    }

    public function info(){
        $id = input('post.id');
        return $msg = Db::name('message')
            ->alias('a')
            ->join('book b','a.b_id = b.id')
            ->join('member c','c.id = a.u_id')
            ->field('a.content,a.u_name,b.name,a.time')
            ->where('a.id',$id)
            ->find();
    }
    /**
     * 作者读评
     */
    public function comment(){
        $count = Db::name('message')
            ->alias('a')
            ->join('book b','a.b_id = b.id')
            ->join('member c','c.id = a.u_id')
            ->field('a.content,a.u_name,b.name,a.time')
            ->where('a.author_id',$this->user_id)
            ->count();
        $obj_page = $this->_Page($count,15);
        $page = $obj_page->newshow();
        $data = Db::name('message')
            ->alias('a')
            ->join('book b','a.b_id = b.id')
            ->join('member c','c.id = a.u_id')
            ->field('a.id,a.content,a.u_name,b.name,a.time')
            ->where('a.author_id',$this->user_id)
            ->limit($obj_page->firstRow, $obj_page->listRows)
            ->order('a.id desc')
            ->select();
        $this->assign('count',$count);
        $this->assign('data',$data);
        $this->assign("page", $page);
        return view();
    }


    /**
     * 站内信
     */
    public function message(){

        return view();
    }

    /**
     * 书籍管理
     */
    public function bookmanage(){
        $where = [
            'u_id' => $this->user_id,
            'is_del' => 0
        ];
        $book = Db::name('book')->where($where)->select();
        if ($book){
            $this->redirect('book/manage');
            exit();
        }
        return view();
    }

    /**
     * 作者信息
     */
    public function writerinfo(){
        $data = Db::name('member')->where('id',$this->user_id)->find();
        $this->assign('data',$data);
        return view();
    }

    /**
     * 修改作家资料
     */
    public function editWriter(){

        $data = Db::name('member')->where('id',$this->user_id)->find();

        if($_POST){
            $post = input('post.');
            $data = [
                'pen_name' => $post['pen_name'],
                'qq' => $post['qq'],
                'wechat' => $post['wechat'],
                'address' =>$post['address']
            ];
            $res = Db::name('member')->where('id',$this->user_id)->update($data);
            if ($res){
                JsonDie("1", '修改成功', '','');
            }else{
                JsonDie("0", '修改失败', '','');
            }
        }

        $this->assign('data',$data);
        return view();
    }

    /**
     * 创建作品
     */
    public function createbook(){
        if ($_POST){
            $post = input('post.');
            $author = Db::name('member')->where('id',$this->user_id)->field('pen_name')->find();
            $book = Db::name('book')->where('name',$post['name'])->field('name')->find();
            if (!empty($book['name'])){
                $this->error('该书已存在，请重新填写书名');
                exit();
            }
            if (!$author['pen_name']){
                $this->error('你还没有设置笔名，请先完善个人资料');
                exit();
            }
            $data = [
                'name' => $post['name'],
                'cid' => $post['cid'],
                'info' => $post['info'],
                'image' => $post['image'],
                'type' => $post['type'],
                'u_id' => $this->user_id,
                'author' => $author['pen_name'],
                'start_time' => date("Y-m-d H:i:s")
            ];
            $res = Db::name('book')->insert($data);
            $bookId = Db::name('book')->getLastInsID();
            if ($res){
                $this->success('添加成功','',$bookId);
            }else{
                $this->error('添加失败','',$bookId);
            }
        }
        return view();
    }

    public function succ()
    {
        return view();
    }

    /**
     * 申请作者
     */
    public function apply(){
        if ($_POST){
            $post = input('post.');
            $is_author = Db::name('member')->where('id_num',$post['id_num'])->find();
            if ($is_author){
                $this->error('该身份证号码已被申请');
            }
            $data = [
                'name' => $post['name'],
                'pen_name' => $post['pen_name'],
                'qq' => $post['qq'],
                'wechat' => $post['wechat'],
                'address' => $post['address'],
                'sex' => $post['sex'],
                'id_num' => $post['id_num'],
                'author_time' => date("Y-m-d H:i:s"),
                'is_author' => 1
            ];
            try{
                $res = Db::name('member')->where('id',$this->user_id)->update($data);
                if (FALSE !== $res) {
                    $this->success('申请成功');
                } else {
                    $this->error('申请失败');
                }
            }catch (\Exception $e){
                $this->success($e);
            }
        }
        return view();
    }

    /**
     * 上传书籍封面
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
     * 删除通知
     */
    public function delNotice(){
        $id = input('post.id');
        $res = Db::name('notice')->where('id',$id)->delete();
        if ($res){
            $this->success('删除成功');
        }else{
            $this->error('删除失败');
        }
    }

}
