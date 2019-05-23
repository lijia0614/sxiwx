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

class Role extends Common {

    /**
     * 控制器初始化
     * @author 四川挚梦科技有限公司
     * @date 2017-01-11
     */
    public function _initialize() {
        parent::_initialize();
    }

    /**
     * 首页控制器
     * @author 四川挚梦科技有限公司
     * @date 2017-01-11
     */
    public function index() {
        $id = input('request.id');
        if ($id) {
            $where = array('nav_id' => $id);
        }
        $ary_get['pageall'] = input('request.pageall');
        $count = Db('role')->count();
        $this->assign('count', $count);
        $obj_page = $this->_Page($count, $ary_get['pageall']);
        $page = $obj_page->newshow();
        $ary_data = Db('role')->limit($obj_page->firstRow, $obj_page->listRows)->select();
        $this->assign("list", $ary_data);
        $this->assign("page", $page);
        $this->assign("filter", $ary_get);
        return view();
    }

    /**
     * 添加角色
     * @author billow.wang <admin@zhimengcms.com>
     * @date 2015-04-01
     */
    public function add() {

        if ($_POST) {
            $this->doAdd();
            exit;
        }
        $nodeLists = $this->nodeLists(); //返回所有菜单以及节点
        $this->assign("nodeLists", json_encode($nodeLists));
        return view('edit');
    }

    /**
     * 处理添加角色
     * @author billow.wang <admin@zhimengcms.com>
     * @date 2015-04-01
     */
    public function doAdd() {
        try {
            //保存当前数据对象
            $data = input('request.');
            $data['update_time'] = time();
            $role = model('role');
            $result = $role->allowField(true)->save($data);
            $role_id = $role->id;
            if (false !== $result) {
                $node_ids = $data["access_node"];
                if (isset($node_ids) && is_array($node_ids)) {
                    $access = array();
                    foreach ($node_ids as $node_id) {
                        $access[] = array('role_id' => $role_id, 'node_id' => $node_id);
                    }
                    $result = model('RoleAccess')->saveAll($access);
                    if ($result) {
						$this->clsNodeListCache($role_id);//清除角色节点缓存
                        JsonDie(1, '数据添加成功', 'yes');
                    }
                } else {
                    JsonDie(0, '请选择控制权限', 'no');
                }
            } else {
                JsonDie(0, '数据添加失败', 'no');
            }
        } catch (\Exception $e) {
            JsonDie(0, '操作失败' . $e, 'no');
        }
    }

    /**
     * 返回所有菜单以及节点
     * @author 四川挚梦科技有限公司
     * @date 2015-04-01
     */
    public function nodeLists() {
        $modules = Db("role_nav")->field("id,pid,name")->where("status", 1)->where("pid", 0)->order('sort','asc')->select();
        $arr = array();
        foreach ($modules as $key => $one) {
            $arr[] = array("id" => $one['id'], "pId" => 0, "name" => $one['name'], "open" => 'true');
            $arr = $this->menuSecond($one['id'], $arr);
        }
        return $arr;
    }

    /**
     * 返回所有有效第二级菜单
     * @author 四川挚梦科技有限公司
     * @date 2015-04-01
     */
    private function menuSecond($pid, &$arr) {
        if (!$pid)
            return;
        $child = Db("role_nav")->field("id,pid,name")->where("status", 1)->where("pid", $pid)->order('sort','asc')->select();
        if ($child) {
            foreach ($child as $ckey => $cone) {
                $arr[] = array("id" => $cone['id'], "pId" => $cone['pid'], "name" => $cone['name'], "open" => 'false');
                $arr = $this->menuNodeLists($cone['id'], $arr); //返回二级菜单下所有节点
            }
        }
        return $arr;
    }

    /**
     * 返回二级菜单下所有有效节点
     * @author 四川挚梦科技有限公司
     * @date 2015-04-01
     */
    private function menuNodeLists($nav_id, &$arr) {
        if (!$nav_id)
            return;
        $nodes = Db("role_node")->field("id,nav_id,action_name")->where("status", 1)->where("nav_id", $nav_id)->order('sort','asc')->select();
        if ($nodes) {
            foreach ($nodes as $ckey => $cone) {
                $arr[] = array("id" => $cone['id'], "pId" => $cone['nav_id'], "name" => $cone['action_name']);
            }
        }
        return $arr;
    }

    /**
     * 获取角色已有的授权节点id
     * @author billow.wang <admin@zhimengcms.com>
     * @date 2015-04-01
     */
    public function getRoleAccessLists($role_id) {
        if (!$role_id)
            return;
        $role_access = Db("RoleAccess")->field("node_id")->where("role_id=" . $role_id)->select();
        $node_ids = array();
        if (!empty($role_access) && is_array($role_access)) {
            foreach ($role_access as $access) {
                array_push($node_ids, $access['node_id']);
            }
        }
        return $node_ids;
    }

    /**
     * 编缉角色时已授权节点默认选中状态
     * @author 四川挚梦科技有限公司
     * @date 2017-04-04
     */
    public function checkNodesAccess($nodeLists, $node_ids) {

        foreach ($nodeLists as $ak => $action) {
            if (in_array($action['id'], $node_ids)) {
                $nodeLists[$ak]['checked'] = 'true';
            }
        }
        return $nodeLists;
    }

    /**
     * 编辑角色
     * @author billow.wang <admin@zhimengcms.com>
     * @date 2015-04-01
     */
    public function edit() {
        if ($_POST) {
            try {
                $this->doEdit();
                exit;
            } catch (\Exception $e) {
                JsonDie(0, '操作失败' . $e, 'no');
            }
        }
        $role_id = input("request.id", 0, "intval");
        $ary_get = input('request.');
        $vo = Db('role')->getById($ary_get['id']);
        $this->assign("vo", $vo);
        $nodeLists = $this->nodeLists(); //返回所有菜单以及节点
        $node_ids = $this->getRoleAccessLists($role_id); //获取角色已获授权节点
        $nodeLists = $this->checkNodesAccess($nodeLists, $node_ids);
        $this->assign("nodeLists", json_encode($nodeLists));
        $this->assign('data', $vo);
        return view('edit');
    }

    /**
     * 处理编辑角色
     * @author 四川挚梦科技有限公司
     * @date 2017-01-11
     */
    public function doEdit() {
        try {
            $ary_request = input('request.');
            $role_id = intval($ary_request['id']);
            //保存当前数据对象
            $ary_request['update_time'] = time();
            $result = model("role")->allowField(true)->save($ary_request, array('id' => $role_id));
            if (false !== $result) {
                model('roleAccess')->destroy(array('role_id' => $role_id));
                $node_ids = isset($ary_request['access_node']) ? $ary_request['access_node'] : '';
                if (isset($node_ids) && is_array($node_ids)) {
                    $access = array();
                    foreach ($node_ids as $node_id) {
                        $access[] = array('role_id' => $role_id, 'node_id' => $node_id);
                    }
                    $ary_result = model('roleAccess')->saveAll($access);
					$this->clsNodeListCache($role_id);//清除角色节点缓存
                    JsonDie(1, '更新成功', 'yes');
                } else {
                    JsonDie(0, '请选择控制权限', 'no');
                }
            } else {
				$this->clsNodeListCache($role_id);//清除角色节点缓存
                JsonDie(0, '更新失败', 'no');
            }
        } catch (\Exception $e) {
            JsonDie(0, '操作失败' . $e, 'no');
        }
    }
    /**
     * 清除角色节点缓存
     * @author 四川挚梦科技有限公司
     * @date 2018-04-13
     */
	public function clsNodeListCache($role_id){
			$users=Db("admin")->where('role_id',$role_id)->select();
			if(!$users){return false;}
			foreach($users as $key=>$one){
				cache('userNodesList_'.$one['u_id'],NULL);
				cache('NodesList_'.$one['u_id'],NULL);	
			}		
	}

    public function doDelete() {
        $id = intval(input('request.id'));
        if (isset($id) && $id > 0) {
            $count = Db('role')->alias('a')->join("admin b", "a.id=b.role_id", "LEFT")->where("b.role_id", $id)->where("b.status", 1)->count();
            if ($count > 0) {
                JsonDie(0, '角色已经被使用,不能删除', 'no');
            }
            $result = model('role')->destroy(array('id' => $id));
            if (false !== $result) {
                model("RoleAccess")->destroy(array('role_id' => $id));
                JsonDie(1, '操作成功', 'yes');
            } else {
                JsonDie(0, '删除失败', 'no');
            }
        } else {
            JsonDie(0, '数据错误', 'no');
        }
    }

}
