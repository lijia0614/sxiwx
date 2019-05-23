<?php

namespace app\admin\controller;

use think\Controller;
use think\facade\Config;
use think\facade\Request;
use think\facade\Session;
use think\Db;
use Auths\Auth;
use Pages\Page;
use app\common\controller\AppCommon;
use app\admin\model\RoleNav as RoleNavModel;
use app\admin\model\OperationLog;

class RoleNav extends Common {

    /**
     * 控制器初始化
     * @author billow.wang 
     * @date 2017-01-05
     */
    public function _initialize() {
        parent::_initialize();
    }

    /**
     * 默认控制器
     * @author billow.wang 
     * @date 2017-01-05
     */
    public function index() {
        $ary_get['pageall'] = input("request.pageall");
        $keyword = input("request.keyword");
        $where = array();
        if(!empty($keyword)){
			$where[]=['name','like','%'.urldecode($keyword).'%'];
         }		
	
		
        $count = Db("RoleNav")->where($where)->count();
        $this->assign("count", $count);
        $obj_page = $this->_Page($count, $ary_get['pageall']);
        $page = $obj_page->newshow();
        $ary_data = Db("RoleNav")->where("pid", '0')->where($where)->order('sort','asc')->limit($obj_page->firstRow, $obj_page->listRows)->select();
        if ($ary_data) {
            foreach ($ary_data as $key => $one) {
                $childMenu = Db("RoleNav")->where("pid", $one['id'])->order('sort',"asc")->select();
                $ary_data[$key]['childMenu'] = $childMenu;
            }
        }
        $this->assign("list", $ary_data);
        $this->assign("filter", $ary_get);
        $this->assign("page", $page);
        return view();
    }

    /**
     * 菜单列表
     * @author billow.wang 
     * @date 2015-01-22
     */
    public function pageList() {
        $rolenav = Db("RoleNav");
        $ary_get['pageall'] = input("request.pageall");
        $count = $rolenav->where()->count();

        $obj_page = new Page($count, $ary_get['pageall']);
        $obj_page->setConfig("header", "条");
        $obj_page->setConfig('theme', '<li class="pageSelect">共%totalRow%%header%&nbsp;%nowPage%/%totalPage%页&nbsp;%first%&nbsp;%upPage%&nbsp;%prePage%&nbsp;%linkPage%&nbsp;%nextPage%&nbsp;%downPage%&nbsp;%end%</li>');
        $page = $obj_page->newshow();

        $ary_data = $rolenav->where()->limit($obj_page->firstRow, $obj_page->listRows)->select();
        $this->assign("data", $ary_data);
        $this->assign("filter", $ary_get);
        $this->assign("page", $page);
        return view();
    }

    /**
     * 添加菜单
     * @author billow.wang
     * @date 2015-3-29
     */
    public function addRoleNav() {
        $menus = Db("RoleNav")->where("pid", '0')->order('sort','asc')->select();
        $this->assign("menus", $menus);
        if ($_POST) {
            $this->saveRoleNav();
            exit;
        }
        return view('edit');
    }

    /**
     * 保存菜单
     * @author billow.wang
     * @date 2016-3-29
     */
    public function saveRoleNav() {
        try {
            $ary_post = input("request.");
            if (isset($ary_post['name'])) {
                $id = isset($ary_post['id']) ? intval($ary_post['id']) : '';
                try {
                    $model = model('RoleNav'); //实例化模型
                    if ($id) {
                        $ary_post['update_time'] = date('Y-m-d H:i:s');
                        $result = $model->allowField(true)->save($ary_post, array('id' => $id));
                    } else {
                        $ary_post['create_time'] = date('Y-m-d H:i:s');
                        $ary_post['update_time'] = date('Y-m-d H:i:s');
                        $result = $model->allowField(true)->save($ary_post);
                    }
					cache('AdminMenus',null);
                    $data = array('status' => 1, 'msg' => '操作成功!', 'hidden' => 'yes');
                    die(json_encode($data));
                } catch (\Exception $e) {
                    $data = array('status' => 0, 'msg' => '操作失败!' . $e, 'hidden' => 'yes');
                    die(json_encode($data));
                }
            }
        } catch (\Exception $e) {
            JsonDie(0, '操作失败' . $e, 'no');
        }
    }

    /**
     * 删除菜单
     * @author billow.wang
     * @date 2015-3-29
     */
    public function doDelete() {
        $ary_get = input("request.id");
        if (isset($ary_get)) {
            $model = model("RoleNav");
            $ary_result = $model->destroy($ary_get);
            if (FALSE !== $ary_result) {
                $data = array('status' => 1, 'msg' => '删除成功!');
                return $data;
            } else {
                $data = array('status' => 0, 'msg' => '删除失败!');
                return $data;
            }
        } else {
            $data = array('status' => 0, 'msg' => '菜单不存在!');
            return $data;
        }
    }

    /**
     * 修改菜单
     * @author billow.wang
     * @date 2015-3-26
     * 
     */
    public function editRoleNav() {

        $menus = Db("RoleNav")->where("pid", '0')->order('sort','asc')->select();
        $this->assign("menus", $menus);
        try {
            if ($_POST) {
                $this->saveRoleNav();
                exit;
            }
            $ary_get = input('request.');
            if (!empty($ary_get['id']) && isset($ary_get['id'])) {
                $rolenav = Db("RoleNav");
                $where = array();
                $where['id'] = $ary_get['id'];
                $ary_rolenav = $rolenav->where($where)->find();
            } else {
                $this->ajaxReturn(array('status' => 0, 'msg' => '菜单不存在，请重试！!'));
            }
            $this->assign("data", $ary_rolenav);
            return view('edit');
        } catch (\Exception $e) {
            JsonDie(0, '操作失败' . $e, 'no');
        }
    }

    /**
     * 更改状态
     * @author billow.wang
     * @date 2017-01-06
     * 
     */
    public function dostatus() {
        try {
            $id = input("request.id", 0, "intval");
            $value = input("request.value", 0, "intval");
            if (!$id) {
                JsonDie('0', "参数错误", 'yes');
            }
            if ($value == 0) {
                $data = array('status' => 1);
            } else {
                $data = array('status' => 0);
            }
            $ary_result = Db("RoleNav")->data($data)->where("id", $id)->update();
            if ($ary_result) {
				cache('AdminMenus',null);//清除之前的缓存
                JsonDie('1', "操作成功", 'yes');
            } else {
                JsonDie('0', "操作失败", 'no');
            }
        } catch (\Exception $e) {
            JsonDie(0, '操作失败' . $e, 'no');
        }
    }

}
