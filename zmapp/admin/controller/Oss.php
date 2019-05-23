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
use app\common\controller\AppCommon;
use app\admin\model\Oss as ossModel;

class Oss extends Common {

    public function __construct() {
        parent::__construct();
    }

    public function index() {
        $ary_get['pageall'] = input("request.pageall", 10, 'intval');
        $count = Db("Oss")->count();
        $this->assign("count", $count);
        $obj_page = $this->_Page($count, $ary_get['pageall']);
        $page = $obj_page->newshow();
        $ary_data = Db("Oss")->select();
        $this->assign("list", $ary_data);
        $this->assign("filter", $ary_get);
        $this->assign("page", $page);
        return view();
    }

    /**
     * 编缉阿里云存储参数
     * @author 四川挚梦科技有限公司
     * @date 2017-01-09
     */
    public function aliyun() {
        if ($_POST) {
            $this->doSave('aliyun');
            exit;
        }
        $data = Db('oss')->where(array('alias' => 'aliyun'))->find();
        $cvalue = json_decode($data['value'], true);
        $cvalue['name'] = $data['name'];
        $this->assign('data', $cvalue);
        return view();
    }	
    
    /**
     * 编缉七牛云存储参数
     * @author 四川挚梦科技有限公司
     * @date 2018-04-06
     */
    public function qiniu() {
        if ($_POST) {
            $this->doSave('qiniu');
            exit;
        }
        $data = Db('oss')->where(array('alias' => 'qiniu'))->find();
        $cvalue = json_decode($data['value'], true);
        $cvalue['name'] = $data['name'];
        $this->assign('data', $cvalue);
        return view();
    }    

    /**
     * 保存云存储参数
     * @author 四川挚梦科技有限公司
     * @date 2017-01-09
     */
    public function doSave($alias) {
        try {
            $ary_post = input("post.");
            unset($ary_post['status']);
            unset($ary_post['dialogid']);
            unset($ary_post['dosubmit']);
            $value = json_encode($ary_post);
            $ossModel = new ossModel();
            $ary_result = $ossModel->ossSave($alias, $value);
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
     * 更改短信接口
     * @author四川挚梦科技有限公司
     * @date 2017-01-12
     */
    public function doSetting() {
        try {
            $dataid = input("request.dataid", 0, "trim");
            $oss = Db("oss")->where("alias", $dataid)->find();
            if (!$oss) {
                JsonDie('0', "非法操作", 'no');
            }
            $result = Db("oss")->where(array("status" => 1))->data(array('status' => 0))->update();
            if (!$result) {
                JsonDie('0', "设置失败", 'no');
            }
            $update = Db("oss")->where(array("alias" => $dataid))->data(array('status' => 1))->update();
            if ($update) {
                JsonDie('1', "操作成功", 'yes');
            }
            JsonDie('0', "更新失败", 'yes');
        } catch (\Exception $e) {
            JsonDie(0, '操作失败' . $e, 'no');
        }
    }

}
