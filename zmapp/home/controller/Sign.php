<?php

namespace app\home\controller;


use think\Db;

class Sign extends Common {

    /**
     * 公众号用户签到
     * 每天可以签到一次，赠送10书币，一周失效
     */
    public function __construct() {
        parent::__construct();
        if (!$this->user_id){
            $this->error('请先登录');
        }
    }



    /**
     * 签到送书币
     */
    public function index(){
        // 检查今日是否已经签到
        $checkSign = $this->checkSign();
        if ($checkSign){
            $this->error('今天已经签过到了，明天再来吧！');
        }
        $data = [
            'u_id' => $this->user_id,
            'money' => 10,
            'status' => 1, // 1未使用，2使用
            'create_time' => time()
        ];

        $res = Db::name('sign')->insert($data); // 签名记录
        if ($res){
            $this->success('签到成功，已领取10书币');
        }else{
            $this->error('签到失败，请稍后再试');
        }
    }

    /**
     * 签到明细
     */
    public function jilu(){
        $list = Db::name('sign')
            ->where('u_id',$this->user_id)
            ->order('id desc')
            ->select();
        $week = strtotime('-1week'); // 一周前的时间戳
        foreach ($list as $k => $v){
            if ($week > $v['create_time']){
                $list[$k]['type'] = '已过期';
            }else{
                $times = $v['create_time'] - $week;
                $now_time = floor($times/(24*3600)); // 向下取整得出还剩多少天过期
                $list[$k]['type'] = '还有'.$now_time.'天过期';
            }
        }

        $this->assign('list',$list);
        return view();
    }


    /**
     * 检查今日是否已经签到
     * @return boolean
     */
    public function checkSign(){
        $beginToday = mktime(0,0,0,date('m'),date('d'),date('Y'));
        $endToday = mktime(0,0,0,date('m'),date('d')+1,date('Y'))-1;
        $checkSign = Db::name('sign')
            ->where('u_id',$this->user_id)
            ->where('create_time','>=', $beginToday)
            ->where('create_time','<=', $endToday)
            ->select();
        return $checkSign;
    }

    /**
     * 使用未过期的签到金币消费
     * status:1未使用；2已使用
     * @param $price
     * @return bool|int|string
     */
    public function signBuy($price){
        $week = strtotime('-1week'); // 一周前的时间戳

        $count = Db::name('sign')
            ->where('u_id',$this->user_id)
            ->where('create_time','>',$week)
            ->where('status',1)
            ->sum('money');
        if ($count < $price){
            return false;
        }
        $a = ceil($price/10);
        $update = Db::name('sign')
            ->where('u_id',$this->user_id)
            ->where('status',1)
            ->where('create_time','>',$week)
            ->order('id asc')
            ->limit($a)
            ->update(['status'=>2]);
        return $update;
    }

}
