<?php

namespace app\admin\controller;

use think\Controller;
use think\facade\Config;
use think\facade\Request;
use think\Db;
use Auths\Auth;
use think\facade\Session;
use think\facade\Env;

class Index extends Common {

    public function __construct() {
        parent::__construct();
		$users=Session::get(config("auth.USER_AUTH_KEY"));

		$data['role']=Db::name("role")->where("id",$users['role_id'])->find();
		$lastLoginFind=$this->lastLogin($users['u_id']);
		$this->assign("users",$users);
		$data['lastLoginFind']=$lastLoginFind;		//上次登录查询
		$data['newsCount']=Db::name("article")->count();
		$data['productCount']=Db::name("product")->count();
       //$data['userCount']=Db::name("members")->count();
        $data['linkCount']=Db::name("links")->count();
        $data['adCount']=Db::name("ad")->count();
        $data['mysql_version']=$this->_mysql_version();

        $beginToday = mktime(0,0,0,date('m'),date('d'),date('Y'));
        $endToday = mktime(0,0,0,date('m'),date('d')+1,date('Y'))-1;
        $this->assign('lastLogin',$data['lastLoginFind']);


        /**
         * 累计订阅
         */
        $dy = Db::name('reward')
            ->alias('a')
            ->join('book b','a.b_id = b.id')
            ->join('member d','a.u_id = d.id')
            ->field('SUM(a.price) as price')
            ->find();

        $this->assign('dy',$dy);

        /**
         * 今日订阅
         */
        $todayDy = Db::name('reward')
            ->alias('a')
            ->join('book b','a.b_id = b.id')
            ->join('member d','a.u_id = d.id')
            ->field('SUM(a.price) as price')
            ->where('a.time','>=', $beginToday)
            ->where('a.time','<=', $endToday)
            ->find();
        $this->assign('todayDy',$todayDy);

        /**
         * 累计打赏
         */
        $reward = Db::name('gift')
            ->alias('a')
            ->join('member b','b.id = a.u_id')
            ->join('book c','c.id = a.b_id')
            ->field('SUM(a.total) as total')
            ->find();
        $this->assign('reward',$reward);

        /**
         * 今日打赏
         */
        $todayReward = Db::name('gift')
            ->alias('a')
            ->join('member b','b.id = a.u_id')
            ->join('book c','c.id = a.b_id')
            ->field('SUM(a.total) as total')
            ->where('a.time','>=', $beginToday)
            ->where('a.time','<=', $endToday)
            ->find();
        $this->assign('todayReward',$todayReward);

        /**
         * 今日注册用户
         */
        $todayUser = Db::name('member')
            ->where('time','>=', date('Y-m-d H:i:s',$beginToday))
            ->where('time','<=', date('Y-m-d H:i:s',$endToday))
            ->count();
//        c_print($todayUser);die;
        $this->assign('todayUser',$todayUser);
        $this->assign('start_date',date('Y-m-d H:i:s',$beginToday));
        $this->assign('end_date',date('Y-m-d H:i:s',$endToday));

        /**
         * 累计用户注册
         */
        $user = Db::name('member')
            ->count();
        $this->assign('user',$user);

        /**
         * 累计未审核章节
         */
        $chapter = Db::name('chapter')
            ->alias('a')
            ->join('book b','a.b_id = b.id')
            ->where('a.is_del','=',0)
            ->where('a.status','=',0)
            ->where('a.pub','=',1)
            ->count();
        $this->assign('chapter',$chapter);

        /**
         * 今日未审核章节
         */
        $todayChapter = Db::name('chapter')
            ->alias('a')
            ->join('book b','a.b_id = b.id')
            ->where('a.is_del','=',0)
            ->where('a.status','=',0)
            ->where('a.pub','=',1)
            ->where('a.time','>=', $beginToday)
            ->where('a.time','<=', $endToday)
            ->count();
        $this->assign('todayChapter',$todayChapter);

        /**
         * 累计充值
         */

        $recharge = Db::name('recharge_log')->field('SUM(total_fee) as total')->find();

        $this->assign('recharge',$recharge);

        /**
         * 今日充值数量
         */
        $todayRecharge =Db::name('recharge_log')
            ->where('create_time','>=', date('Y-m-d H:i:s',$beginToday))
            ->where('create_time','<=', date('Y-m-d H:i:s',$endToday))
            ->field('SUM(total_fee) as total')
            ->find();

        $this->assign('todayRecharge',$todayRecharge);


		$this->assign($data);
    }
	
	
	public function lastLogin($uid){
		$idarr=Db::name('admin_log')->field("max(id) as id")
			->whereNotIn('id', function ($query) use($uid) {
				$query->table(config("database.prefix").'admin_log')->field("max(id) as id")->where('u_id',$uid)->select();
			})->find();
		if($idarr){
			$lastLoginFind=Db::name("admin_log")->where("id",$idarr['id'])->find();
			return $lastLoginFind;
		}
		return false;
	}

    /**
     * 获取mysql版本号
     * @author 四川挚梦科技有限公司
     * @date 2018-04-29
     */	
    private function _mysql_version()
    {
        $version = model("config")->query("select version() as ver");
        return $version[0]['ver'];
    }
	
	
    public function index() {
        return view();
    }

    public function main() {

        /**
         * 查询待审核章节
         */

        return view();
    }

}
