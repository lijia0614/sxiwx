<?php

namespace app\admin\controller;

use think\Controller;
use think\facade\Config;
use think\facade\Request;
use think\facade\Session;
use think\Db;
use Auths\Auth;
use Pages\Page;
use IpLocation\IpLocation;
use app\common\controller\AppCommon;
use app\admin\model\RoleNav;
use app\admin\model\OperationLog;
use app\admin\model\Admin as AdminModel;

class System extends Common {

    /**
     * 控制器初始化
     * @author 四川挚梦科技有限公司
     * @date 2017-01-09
     */
    public function _initialize() {
        parent::_initialize();
    }

    /**
     * 默认控制器
     * @author 四川挚梦科技有限公司
     * @date 2017-01-09
     */
    public function index() {
        $ary_get = input("get.");
        $ary_get['pageall'] = input('pageall', '10');
        $admin_access = model('Config')->getCfgByModule('ADMIN_ACCESS');

        $join = array(array(config('database.prefix') . 'role b', "a.role_id=b.id", "LEFT"));
        $count = Db('admin')->field("b.name,a.*")->alias('a')->join($join)->count();

        $obj_page = $this->_Page($count, $ary_get['pageall']);

        $page = $obj_page->newshow();
        $ary_data = Db('admin')->field("b.name,a.*")->alias('a')->join($join)->limit($obj_page->firstRow, $obj_page->listRows)->select();
        $this->assign("list", $ary_data);
        $this->assign("count", $count);
        $this->assign("admin", $admin_access);
        $this->assign("filter", $ary_get);
        $this->assign("page", $page);
        return view();
    }

    /**
     * 修改管理员信息
     * @author 四川挚梦科技有限公司
     * @date 2017-01-09
     * 
     */
    public function edit() {
        if ($_POST) {
            $this->doSaveAdmin();
            exit;
        }
        $admin_access = model('Config')->getCfgByModule('ADMIN_ACCESS');
        $uid = input('id/d');
        if (!empty($uid) && $uid > 0) {
            $ary_result = Db("admin")->find($uid);
            $ary_role = Db("Role")->where(array('status' => '1'))->select();
        } else {
            $this->error("用户不存在，请重试！");
        }
        $this->assign("admin", $admin_access);
        $this->assign("data", $ary_result);
        $this->assign("role", $ary_role);
        return view('edit');
    }

    /**
     * 添加管理员信息
     * @author 四川挚梦科技有限公司
     * @date 2017-01-09
     */
    public function add() {
        if ($_POST) {
            $this->doSaveAdmin();
            exit;
        }
        $admin_access = model('Config')->getCfgByModule('ADMIN_ACCESS');
        $role = Db("Role");
        $ary_role = $role->where(array('status' => '1'))->select();
        $this->assign("admin", $admin_access);
        $this->assign("role", $ary_role);
        return view('edit');
    }

    /**
     * 保存管理员信息
     * @author 四川挚梦科技有限公司
     * @date 2017-01-09
     */
    public function doSaveAdmin() {

        try {
            $ary_post = input("post.");
            if ($ary_post['confirm_password'] != $ary_post['u_password']) {
                JsonDie(0, '输入的两次密码不一致', 'no');
            }

            unset($ary_post['confirm_password']);
            if (!empty($ary_post['u_password'])) {
                $ary_post['u_passwd'] = md5(trim($ary_post['u_password']));
            }
            if ($ary_post['id'] == 2 && $ary_post['status'] == 0) {
                JsonDie(0, '超级管理员不能禁用', 'no');
            }
            $adminModel = new AdminModel();
            if (isset($ary_post['id'])) {
                $ary_result = $adminModel->adminSave(intval($ary_post['id']), $ary_post);
            } else {
                $ary_result = Db("Admin")->where(array('u_name' => $ary_post['u_name']))->find();
                if (isset($ary_result)) {
                    JsonDie(0, '用户名已存在', 'no');
                }
                $ary_result = $adminModel->adminSave(intval($ary_post['id']), $ary_post);
            }
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
     * 删除管理员
     * @author 四川挚梦科技有限公司
     * @date 2017-01-09
     */
    public function doDelete() {
        $id = input("get.id");
        if (isset($id)) {
            $system = model("Admin");
            if ($id == 2) {
                JsonDie(0, '超级管理员不能删除', 'yes');
            }
            $ary_result = $system->where(array('u_id' => $id))->delete();
            if (FALSE !== $ary_result) {
                JsonDie(1, '管理员删除成功', 'yes');
            } else {
                ;
                JsonDie(0, '管理员删除失败', 'no');
            }
        } else {
            JsonDie(0, '非法参数', 'no');
        }
    }

    public function doUploadAdmin() {
        return view();
    }

    /**
     * 通用更改状态,1为启用，0为禁用
     * @author 四川挚梦科技有限公司
     * @date 2017-01-12
     */
    public function dostatus() {
        try {
            $id = input("request.id", 0, "intval");
            $value = input("request.value", 0, "intval");
            if (!$id) {
                JsonDie('0', "参数错误", 'yes');
            }
            if ($value == 1) {
                $data = array('status' => 0);
            } else {
                $data = array('status' => 1);
            }
            if ($id == 2 && $data['status'] == 0) {
                JsonDie('0', "超级管理员不能禁用！", 'no');
            }
            $ary_result = model('Admin')->allowField(true)->save($data, array('u_id' => $id));
            if ($ary_result) {
                JsonDie('1', "操作成功!", 'yes');
            } else {
                JsonDie('0', "操作失败!", 'no');
            }
        } catch (\Exception $e) {
            JsonDie(0, '操作失败' . $e, 'no');
        }
    }

    /**
     * 管理员登陆日志
     * @author 四川挚梦科技有限公司
     * @date 2016-02-06
     */
    public function loglist() {
        $ary_get = input("request.");
        $ary_get['pageall'] = 10;
        $Ip = new IpLocation(); // 实例化类

        $where = "1=1";
        $count = Db("AdminLog")->where($where)->count();
        $this->assign('count', $count);
        $obj_page = $this->_Page($count, $ary_get['pageall']);
        $page = $obj_page->newshow();
        $ary_data = Db("AdminLog")->where($where)->limit($obj_page->firstRow, $obj_page->listRows)->order('create_time','desc')->select();

        if (!empty($ary_data) && is_array($ary_data)) {
            foreach ($ary_data as $k => $v) {
                $ary_data[$k]['ip_location'] = $Ip->getlocation($v['log_ip']);
            }
        }
        $this->assign("list", $ary_data);
        $this->assign("filter", $ary_get);
        $this->assign("page", $page);
        return view();
    }

}
