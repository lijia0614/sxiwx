<?php

namespace app\admin\model;

use think\Model;

/**
 * 后台菜单模型
 * @package Model
 * @version 1.0
 * @author 四川挚梦科技有限公司
 * @date 2018-3-17
 */
class RoleNav extends Common {

    protected $resultSetType = 'collection';

    //模型初始化
    protected function initialize() {
        parent::initialize();
    }
    /**
     * 从系统配置表中取出模块相关配置
     * @author 四川挚梦科技有限公司
     * @date 2018-03-20
     * @return array
     */
    public function getConfig($c_key) {
        try {
            $json_config = $this->getBycKey($c_key)->value("c_value");
            $config = json_decode($json_config, true);
            return $config;
        } catch (\Exception $e) {
            $this->error = $e;
            return false;
        }
    }

    /**
     * 获取后台一级菜单列表
     * @param  integer
     * @return array|integer 成功返回数组，失败-返回-1
     */
    public function parentMenu() {
		$AdminMenus=cache('AdminMenus');//获取后台缓存菜单
		if($AdminMenus){
			return $AdminMenus;
		}		
        $menuObj = $this->where('status', 1)->where("pid", '0')->order('sort','asc')->select();
        if ($menuObj) {
            $menus = $menuObj->toArray();
            if ($menus) {
                foreach ($menus as $key => $one) {
                    $childMenuObj = $this->where('status', 1)->where("pid", $one['id'])->order('sort','asc')->select();
                    $childMenu = $childMenuObj->toArray();
                    $menus[$key]['childMenu'] = $childMenu;
                }
            }
			cache('AdminMenus',$menus);
            return $menus;
        } else {
            $this->error = '没有找到数据';
            return -1;
        }
    }

    /**
     * 获取后台子类菜单
     * @param  integer
     * @return array|integer 成功返回数组，失败-返回-1
     */
    public function subMenu($pid) {
        if (!$pid) {
            $this->error = 'pid参数非法';
            return false;
        }
        $menu = $this->where('status', 1)->where("pid", $pid)->order('sort','asc')->select();
        if ($menu) {
            // 返回菜单数据
            return $menu->toArray();
        } else {
            $this->error = '没有找到数据';
            return -1;
        }
    }

}
