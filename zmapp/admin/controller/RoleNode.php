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
use app\admin\model\RoleNode as RoleNodeModel;

class RoleNode extends Common {

    /**
     * 控制器初始化
     * @author billow.wang 
     * @date 2017-01-05
     */
    public function _initialize() {
        parent::_initialize();
    }

    /**
     * 展示节点列表
     * @author 四川挚梦科技有限公司
     * @date 2015-04-01
     */
    public function index() {
        $id = input('request.id', 0, "intval");
        $keyword = input('request.keyword');
        $this->assign('keyword', $keyword);
        $where = array();
		
        if(!empty($keyword)){
			$where[]=['a.action|a.action_name|a.module','like','%'.urldecode($keyword).'%'];
         }		
		if($status!=3){
			$where[]=['status','=',$status];
        }		
		
        $pagesize = input('request.pagesize', 10, 'intval');
        $count = Db('role_node')->field('a.*,b.name as nav_name')->alias("a")->join("role_nav b", "a.nav_id=b.id", "LEFT")->where("a.nav_id", $id)->count();
        $obj_page = $this->_Page($count, $pagesize);
        $obj_page->setConfig("header", "条");
        $obj_page->setConfig('theme', '&nbsp;%first%&nbsp;%upPage%&nbsp;%prePage%&nbsp;%linkPage%&nbsp;%nextPage%&nbsp;%downPage%&nbsp;%end%');
        $page = $obj_page->newshow();
        $this->assign('count', $count);
        $RoleNode = Db("role_node")->field('a.*,b.name as nav_name')->alias("a")->join("role_nav b", "a.nav_id=b.id", "LEFT")->limit($obj_page->firstRow, $obj_page->listRows)->order('sort','asc')->where("a.nav_id", $id)->select();
        $this->assign("filter", $pagesize);
        $this->assign("list", $RoleNode);
        $this->assign("page", $page);
        return view();
    }

    /**
     * 添加节点
     * @author 四川挚梦科技有限公司
     * @date 2017-01-12
     */
    public function add() {
        if ($_POST) {
            $this->doEdit();
            exit;
        }
        return view('edit');
    }

    /**
     * 编辑节点
     * @author 四川挚梦科技有限公司
     * @date 2017-01-12
     */
    public function edit() {
        if ($_POST) {
            $this->doEdit();
            exit;
        }
        $node_id = input('request.id', 0, 'intval');
        if (!$node_id) {
            JsonDie(0, "参数错误", '');
        }
        $vo = Db('RoleNode')->getById($node_id);
        $rolenav = Db("RoleNav");
        $ary_rolenav = $rolenav->where(array('status' => '1'))->select();
        $this->assign("data", $vo);
        $this->assign("rolenav", $ary_rolenav);
        return view();
    }

    /**
     * 处理编辑节点
     * @author四川挚梦科技有限公司
     * @date 2017-01-12
     */
    public function doEdit() {
        try {
            $ary_post = input("post.");
            $ary_post['module'] = ucfirst($ary_post['module']);
			$RoleNodeModel=new RoleNodeModel();
			$id=$ary_post['id'];
            if (isset($ary_post['id'])) {
				unset($ary_post['id']);
                $ary_result = $RoleNodeModel->allowField(true)->save($ary_post, array('id' =>$id));
				cache('childMenuCache_'.$ary_post['nav_id'],NULL);
            } else {
                $ary_result =$RoleNodeModel->allowField(true)->save($ary_post);
				cache('childMenuCache_'.$ary_post['nav_id'],NULL);
            }
            if (FALSE !== $ary_result) {
				cache('AdminMenus',null);
                JsonDie(1, '操作成功', 'no');
            } else {
                JsonDie(0, '操作失败', 'no');
            }
        } catch (\Exception $e) {
            JsonDie(0, '操作失败' . $e, 'no');
        }
    }

    /**
     * 禁用节点,配置权限将不显示
     * @author四川挚梦科技有限公司
     * @date 2017-01-12
     */
    public function doStatus() {
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
            $ary_result = Db("RoleNode")->data($data)->where("id", $id)->update();
            if ($ary_result) {
				cache('AdminMenus',null);
                JsonDie('1', "操作成功", 'yes');
            } else {
                JsonDie('0', "操作失败", 'no');
            }
        } catch (\Exception $e) {
            JsonDie(0, '操作失败' . $e, 'no');
        }
    }

    /**
     * 不显示到菜单，权限会显示
     * @author四川挚梦科技有限公司
     * @date 2017-01-12
     */
    public function doShow() {
        try {
            $id = input("request.id", 0, "intval");
            $value = input("request.value", 0, "intval");
            if (!$id) {
                JsonDie('0', "参数错误", 'yes');
            }
            if ($value == 0) {
                $data = array('is_show' => 1);
            } else {
                $data = array('is_show' => 0);
            }
            $ary_result = Db("RoleNode")->data($data)->where("id", $id)->update();
            if ($ary_result) {
				cache('AdminMenus',null);
                JsonDie('1', "操作成功", 'yes');
            } else {
                JsonDie('0', "操作失败", 'no');
            }
        } catch (\Exception $e) {
            JsonDie(0, '操作失败' . $e, 'no');
        }
    }

    /**
     * 删除节点
     * @author四川挚梦科技有限公司
     * @date 2017-01-12
     */
    public function doDelete() {
        $id = input("request.id", 0, 'intval');
        if (isset($id)) {
            $system = model("RoleNode");
            $ary_result = $system->where(array('id' => $id))->delete();
            if (FALSE !== $ary_result) {
                JsonDie(1, '操作成功', 'yes');
            } else {
                JsonDie(0, '操作失败', 'no');
            }
        } else {
            JsonDie(0, '非法参数', 'no');
        }
    }

}
