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
use app\admin\model\AdPostion as AdPostionModel;
use app\admin\model\Ad as AdModel;

class AdPostion extends Common {

    public function __construct() {
        parent::__construct();
    }   
    

    /**
     * 广告位置管理
     * @author 四川挚梦科技有限公司
     * @date 2016-02-06
     */
    public function postion() {
        $ary_get = input("request.");
        $ary_get['pageall'] = 10;
        $where = "1=1";
        $count = Db::name("ad_postion")->count();
        $this->assign('count', $count);
        $obj_page = $this->_Page($count, $ary_get['pageall']);
        $page = $obj_page->newshow();
        $ary_data = Db::name("ad_postion")->limit($obj_page->firstRow, $obj_page->listRows)->order('id',' desc')->select();
        $this->assign("list", $ary_data);
        $this->assign("filter", $ary_get);
        $this->assign("page", $page);
        return view();
    }

    /**
     * 添加广告位
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
     * 编缉广告位
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
        $data = Db("ad_postion")->where("id", $id)->find();
        $this->assign("data", $data);
        return view();
    }

    /**
     * 保存广告位
     * @author billow.wang
     * @date 2018-04-07
     */
    public function doSave($id = 0) {
        try {
            $ary_post = input("post.");
            $AdPostion = new AdPostionModel();
            $ary_result = $AdPostion->dataSave($id, $ary_post);
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
     * 删除广告位置
     * @author billow.wang
     * @date 2018-04-07
     */
    public function doDelete() {
        $ary_get = input("request.id");
        if (isset($ary_get)) {
            $model = model("ad_postion");
            $ary_result = $model->destroy($ary_get);
            if (FALSE !== $ary_result) {
                $data = array('status' => 1, 'msg' => '删除成功!');
                return $data;
            } else {
                $data = array('status' => 0, 'msg' => '删除失败!');
                return $data;
            }
        } else {
            $data = array('status' => 0, 'msg' => '广告位置不存在!');
            return $data;
        }
    }

}
