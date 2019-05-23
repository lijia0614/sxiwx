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
use app\admin\model\Links as LinksModel;

class Links extends Common {

    public function __construct() {
        parent::__construct();
    }

    /**
     * 友情链接管理
     * @author 四川挚梦科技有限公司
     * @date 2016-02-06
     */
    public function index() {
		$display_type = input("get.display_type/d", 0,"intval");
		$status = input("get.status/d", 3,"intval");
        $keyword = input("request.keyword", '');
        $where = array();
        if(!empty($keyword)){
			$where[]=['title','like','%'.urldecode($keyword).'%'];
         }		
		if($status!=3){
			$where[]=['status','=',$status];
        }			
		if($display_type){
			$where[]=['display_type','=',$display_type];
		}		
		
        $count = Db::name("Links")->where($where)->count();
        $this->assign("count", $count);
        $obj_page = $this->_Page($count, 10);
        $page = $obj_page->newshow();
        $ary_data = Db::name("Links")->where($where)->order('sort ASC,id desc')->limit($obj_page->firstRow, $obj_page->listRows)->select();
        $this->assign("list", $ary_data);
        $this->assign("filter", $ary_get);
        $this->assign("page", $page);
        return view();
    }

    /**
     * 添加友情链接
     * @author billow.wang
     * @date 2018-04-07
     */
    public function add() {
        if ($_POST) {
            $this->doSave();
            exit;
        }
        return view('edit');
    }

    /**
     * 编缉友情链接
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
		$LinksModel = new LinksModel();
		$data = $LinksModel::find($id);
        $this->assign("data", $data);
        return view();
    }

    /**
     * 保存友情链接
     * @author billow.wang
     * @date 2018-04-07
     */
    public function doSave($id = 0) {
        try {
            $ary_post = input("post.");
            $LinksModel = new LinksModel();
           $ary_result = $LinksModel->dataSave($id, $ary_post);
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
            $model = model("Links");
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
