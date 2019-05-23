<?php

namespace app\admin\controller;

use think\Controller;
use think\facade\Config;
use think\facade\Request;
use think\facade\Session;
use think\Db;
use Auths\Auth;
use Pages\Page;
use Dir\Dir;
use app\admin\model\AdPostion;
use app\admin\model\Ad as AdModel;

class Ad extends Common {

    public function __construct() {
        parent::__construct();
    }

    /**
     * 广告列表管理
     * @author 四川挚梦科技有限公司
     * @date 2016-02-06
     */
    public function lists() {
        $ary_get = input("request.");
		$postion_id = input("get.postion_id/d", 0,"intval");
        $ary_get['pageall'] = 10;
		
		$keyword = input("request.keyword", '');
        $where = array();
        if (!empty($keyword)) {
			$where[]=['a.name','like','%'.urldecode($keyword).'%'];
        }
		if($postion_id){
			$where[]=['a.postion_id','=',$postion_id];
		}		
        $count = Db::name("ad")->field("a.*,b.name as postion_name")->where($where)->alias("a")->join('ad_postion b','b.id = a.postion_id',"LEFT")->count();
        $this->assign('count', $count);
        $obj_page = $this->_Page($count, $ary_get['pageall']);
        $page = $obj_page->newshow();
        $ary_data = Db::name("ad")->field("a.*,b.name as postion_name")->where($where)->alias("a")->join('ad_postion b','b.id = a.postion_id',"LEFT")->limit($obj_page->firstRow, $obj_page->listRows)->order('id','desc')->select();
        $this->assign("list", $ary_data);
        $this->assign("filter", $ary_get);
        $this->assign("page", $page);
        return view();
    }

    /**
     * 添加广告
     * @author billow.wang
     * @date 2018-04-07
     */
    public function add() {
        if ($_POST) {
            $this->doSave();
            exit;
        }
        $ad_postion=Db::name("ad_postion")->order('sort',"asc")->select();
        $this->assign("ad_postion",$ad_postion);
        return view('edit');
    }

    /**
     * 编缉广告
     * @author billow.wang
     * @date 2018-04-07
     */
    public function edit() {
        $id = input('id/d');
        if ($_POST) {
            $this->doSave($id);
            exit;
        }
        if (!$id) {
            JsonDie(0, '非法操作', 'no');
        }
        $ad_postion=Db::name("ad_postion")->order('sort',"asc")->select();
        $this->assign("ad_postion",$ad_postion);
		$AdModel = new AdModel();
		$data = $AdModel::find($id);
        $this->assign("data", $data);
        return view();
    }

    /**
     * 保存广告
     * @author billow.wang
     * @date 2018-04-07
     */
    public function doSave($id = 0) {
        try {
            $ary_post = input("post.");
            $AdModel = new AdModel();
           $ary_result = $AdModel->dataSave($id, $ary_post);
            if (FALSE !== $ary_result) {
                JsonDie(1, '操作成功', 'yes');
            } else {
                JsonDie(1, '操作失败', 'no');
            }
        } catch (\Exception $e) {
            JsonDie(0, '操作失败' . $e, 'no');
        }
    }

    /**
     * 删除广告
     * @author billow.wang
     * @date 2018-04-07
     */
    public function doDelete() {
        $ary_get = input("request.id");
        if (isset($ary_get)) {
            $model = model("ad");
            $ary_result = $model->destroy($ary_get);
            if (FALSE !== $ary_result) {
                JsonDie(1, '操作成功', 'yes');
            } else {
                JsonDie(0, '操作失败', 'yes');
            }
        } else {
            JsonDie(0, '未找到数据', 'yes');
        }
    }

}
