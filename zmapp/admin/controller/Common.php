<?php

namespace app\admin\controller;

use think\Controller;
use think\facade\Config;
use think\facade\Request;
use think\facade\Session;
use think\Db;
use app\common\controller\AppCommon;
use app\admin\model\RoleNav;
use app\admin\model\OperationLog;
use Auths\Auth;
use Pages\Page;
use Tree\Tree;
use app\admin\model\Images as imagesModel;

class Common extends AppCommon {

    /**
     * 基类初始化操作
     * @author 四川挚梦科技有限公司
     * @date 2018-03-17
     */
    public function __construct() {
        parent::__construct();
        self::setThemes(); //设置后台风格目录
		$this->setSysPath();//设置后台入口别名
        self::doCheckLogin(); //检查用户是否登录
        $this->checkAuth(); //检查是否拥有模块访问权限
        $this->getLeftMenu(); //获取后台左侧菜单列表
        self::setAssign(); //设置所有参数到模板变量
		
    }
	


    /**
     * 设置后台风格目录
     * @author 四川挚梦科技有限公司
     * @date 2018-03-17
     */
    static function setThemes() {
        config('template.view_path', WEB_PATH . "/theme/Admin/Default/");
        config('template.view_suffix', "tpl");
    }

    /**
     * 获取左侧菜单列表
     * @author 四川挚梦科技有限公司
     * @date 2018-03-17
     */
    public function getLeftMenu() {
        $getAccessListArr = session::get('getAccessListArr');
        $session = session::get();
        $config = config("database.");
        $auth_id = $session[config('auth.USER_AUTH_KEY')]['u_id'];
        $RoleNav = new RoleNav();
        $menus = $RoleNav->parentMenu(); //获取后台一级菜单
        if ($menus) {
            foreach ($menus as $key => $one) {
                $child_menu = $this->getMenuAction($one['childMenu']); //获取第二级菜单下的所有ACTION
                if ($auth_id != 2 && $auth_id != 1000) {
                    foreach ($child_menu as $ckey => $cone) {
                        $returnArray = array();
                        $returnArray = $this->checkAccessListArr($cone['actionLists']); //检查是否有权限，如果没有权限则隐藏该子菜单
                        if (count($returnArray) <= 0) {//如果二级菜单下没有ACTION，则取消显示二级菜单
                            unset($child_menu[$ckey]);
                        } else {
                            $child_menu[$ckey]['actionLists'] = $returnArray;
                        }
                    }
                } else {
                    foreach ($child_menu as $ckey => $cone) {
                        if (count($cone['actionLists']) == 0) {
                            unset($child_menu[$ckey]);
                        }
                    }
                }
                if (count($child_menu) > 0) {
                    $menus[$key]['childMenu'] = $child_menu;
                } else {
                    unset($menus[$key]);
                }
            }
        }
        $this->assign('menus', $menus);
    }

    /**
     * 获取菜单ACTION
     * @author 四川挚梦科技有限公司
     * @date 2018-03-17
     */
    private function getMenuAction($childMenu) {
        if (is_array($childMenu)) {
            foreach ($childMenu as $key => $one) {
                $childMenuCache = cache('childMenuCache_'.$one['id']);
                if ($childMenuCache) {//如果有缓存，直接返回
                    $childMenu[$key]['actionLists'] = $childMenuCache;
                }else{
                    $fields = "b.id,b.action," . "b.action_name," . "b.module," . "a.name," . "a.image";
                    $actionLists = Db::name("role_nav")->alias("a")->field($fields)
                        ->join("role_node b", 'b.nav_id = a.id', "LEFT")
                        ->where('b.nav_id', $one['id'])->where('b.is_show', 1)
                        ->order('b.sort',"asc")->select();
                    $childMenu[$key]['actionLists'] = $actionLists;
                    cache('childMenuCache_'.$one['id'],$actionLists);
                }
            }
        }
        return $childMenu;
    }
	
    /**
     * 设置后台入口别名
     * @author 四川挚梦科技有限公司
     * @date 2018-03-17
     */
	public function setSysPath(){
		$sys_path=config("admin.adminPath");
		if($sys_path){
			define("SYS_PATH",config("admin.adminPath"));
		}else{
			define("SYS_PATH","sys");
		}
		$this->assign("sys_path",$sys_path);
	}	

    /**
     * 检查模块和方法是否有访问权限
     * @author 四川挚梦科技有限公司
     * @date 2018-03-17
     */
    public function checkAccessListArr($actionLists) {
        $returnArray = array();
        if (!$actionLists) {
            return $returnArray;
        }
        $getAccessListArr = session::get('getAccessListArr');

        foreach ($actionLists as $key => $one) {
            foreach ($getAccessListArr as $ckey => $cone) {
                if (strtolower($one['module']) == strtolower($cone['module']) && strtolower($one['action']) == strtolower($cone['action'])) {
                    $returnArray[] = $one; //赋值
                }
            }
        }
        return $returnArray;
    }



    /**
     * 检查权限
     * @author:四川挚梦科技有限公司
     * @date 2018-03-18
     */
    public function checkAuth() {
        $session = Session::get();
        $Auth = new Auth;
        $uid = $session[config("auth.USER_AUTH_KEY")]['u_id'];
        if (!$uid) {
            $this->error("未登录或者登录已失效", 'Admin/User/Login');
        }
        $getAccessListArr = $Auth->getAccessListArr($uid);
        Session::set('getAccessListArr', $getAccessListArr);
        if (config('auth.USER_AUTH_ON') && !in_array(CONTROLLER, explode(',', config('auth.NOT_AUTH_MODULE')))) {
            if (!$Auth->AccessDecision()) { //检查认证识别号
                if (!$session [config('auth.USER_AUTH_KEY')]) {
                    redirect(config('auth.USER_AUTH_GATEWAY')); //跳转到认证网关
                }
                JsonDie('0', "没有权限", 'no'); // 没有权限 抛出错误
            }
        }
    }

    /**
     * 获取模型配置
     * @author 四川挚梦科技有限公司
     * @date 2018-03-18
     */
    public function getModule($table) {
        if (!$table) {
            JsonDie(0, '参数非法', 'no');
        }
        $module = Db::name('module')->where(array('table' => ucfirst($table)))->find();
        return $module;
    }

    /**
     * 获取表的字段
     * @author 四川挚梦科技有限公司
     * @date 2017-01-09
     */
    public function modelFields($table = null) {
        if (!$table) {
            $table = CONTROLLER;
        }
        $listFields = Db::name('moduleFields')->where(array('table_name' => $table, 'is_show' => 1))->order('sort','asc')->select();
        $this->assign("moduleFields", $listFields);
    }

    /**
     * 获取当前数据库的表名信息
     * @author 四川挚梦科技有限公司
     * @date 2017-01-09
     */
    public function getTables() {
        $tableData = Db::query("show tables;");
        $tables = array();
        if (isset($tableData) && is_array($tableData)) {
            foreach ($tableData as $key => $one) {
                $tables[] = str_replace(config("database.prefix"), '', $one['Tables_in_' . strtolower(config("database.database"))]);
            }
        }
        return $tables;
    }

    /**
     * 根据POST内容判断是否要添加副表数据
     * @author 四川挚梦科技有限公司
     * @date 2017-01-09
     */
    public function deputy_table_data($ary_post, $insertid = 0) {
        try {
            if (!empty($ary_post['deputy_table'])) {
                $tables = $this->getTables();
                foreach ($ary_post['deputy_table'] as $key => $one) {
                    if ($insertid) {//如果没有insertid
                        Db($key)->where(array(strtolower(CONTROLLER . "_id") => $insertid))->delete();
                    }
                    if (in_array($key, $tables)) {
                        $link_table_rows = Db("fields")->where(array('table_name' => CONTROLLER, 'fields' => $one))->find();
                        $attrs = $ary_post[$one];
                        if (is_array($attrs)) {
                            foreach ($attrs as $value) {
                                $data = array(strtolower(CONTROLLER . "_id") => $insertid, strtolower($link_table_rows['link_table_name'] . "_id") => $value);
                                Db($key)->insert($data);
                            }
                        }
                    }
                }
            }
        } catch (\Exception $e) {
            JsonDie(0, '添加副表数据时出错' . $e, 'no');
        }
    }

    public function _empty($name) {
        $path = config("template.view_path") . strtolower(CONTROLLER) . "/" . strtolower(ACTION) . "." . config("template.view_suffix");
        if (file_exists($path)) {
            return view();
        } else {
            $path = config("template.view_path") . "public/" . strtolower(ACTION) . "." . config("template.view_suffix");
            return view($path);
        }
    }

    /**
     * 普通用户判断授权节点
     * @author 四川挚梦科技有限公司
     * @date 2016-01-18
     */
    public function UserModeNode($menuid) {
        $session = session::get();
        $UserModeNode_cache = cache('UserModeNode_' . $session[config('auth.USER_AUTH_KEY')]['u_id'] . '_cache_' . $menuid);
        if ($UserModeNode_cache) {
            session::set('menu_' . $menuid . '_' . $session[config('auth.USER_AUTH_KEY')]['u_id'], $UserModeNode_cache);
            return $UserModeNode_cache;
            exit;
        }
        $menus = array();
        $id = intval($menuid);
        $parent_arr = Db("role_nav")->where(array('id' => $id))->find();
        $no_modules = explode(',', strtoupper(config('auth.NOT_AUTH_MODULE'))); //获取不用授权模块
        $node_list = Db("role_nav")->where(array('status' => 1, 'pid' => $parent_arr['pid']))->order(array('sort' => 'asc'))->select(); //得到当前节点下所有二级栏目
        if ($node_list) {
            foreach ($node_list as $key => $one) {
                $role_node_arr = Db("role_node")->where(array('nav_id' => $one['id'], 'is_show' => 1))->order('sort','asc')->select(); //获取节点列表
                foreach ($role_node_arr as $ckey => $cone) {
                    if (in_array($cone['id'], $this->role_access)) {
                        $menus[$cone['nav_id']]['nodes'][] = $cone;
                        $menus[$cone['nav_id']]['name'] = $one['name'];
                    }
                }
            }
        }
        session('menu_' . $id . '_' . $session[config('auth.USER_AUTH_KEY')]['u_id'], $menus);
        cache('UserModeNode_' . $session[config('auth.USER_AUTH_KEY')]['u_id'] . '_cache_' . $menuid, $menus);
        return $menus;
    }

    /**
     * 超级用户节点
     * @author 四川挚梦科技有限公司
     * @date 2016-01-18
     */
    public function SuperUserNode($menuid) {
        $session = session::get();
        $SuperUserNode_cache = cache('SuperUserNode_cache_' . $menuid);
        if ($SuperUserNode_cache) {
            session::set('menu_' . $menuid . '_' . $session[config('auth.USER_AUTH_KEY')]['u_id'], $SuperUserNode_cache);
            return $SuperUserNode_cache;
            exit;
        }
        $menus = array();
        $id = intval($menuid);
        $parent_arr = Db::name("role_nav")->where(array('id' => $id))->find();
        $where = array();
        $where['status'] = '1';
        $where['pid'] = $parent_arr['pid'];
        $no_modules = explode(',', strtoupper(config('auth.NOT_AUTH_MODULE')));
        $node_list = Db("role_nav")->where($where)->order(array('sort' => 'asc'))->select();
        if (!empty($node_list) && is_array($node_list)) {
            $i = 0;
            foreach ($node_list as $key => $node) {
                $role_node_arr = Db("role_node")->where(array('nav_id' => $node['id'], 'is_show' => 1))->order('sort','asc')->select(); //获取节点列表
                foreach ($role_node_arr as $ckey => $cone) {
                    $first_role_node = D("role_node")->where(array('nav_id' => $node['id']))->order('sort','asc')->find(); //获取第一个节点名称
                    $menus[$cone['nav_id']]['nodes'][] = array_unique($cone);
                    $menus[$cone['nav_id']]['name'] = $node['name'];
                    if ((isset($access_list[strtoupper($cone['module'])]['MODULE']) || isset($access_list[strtoupper($cone['module'])][strtoupper($cone['action'])])) || $_SESSION['administrator'] || in_array(strtoupper($cone['module']), $no_modules)) {
                        if (!in_array($node['id'], $menus[$cone['nav_id']]['nodes'][$i])) {
                            $menus[$cone['nav_id']]['nodes'][] = array_unique($cone);
                        }
                        $menus[$cone['nav_id']]['name'] = $node['name'];
                    }
                    $i = $i + 1;
                }
            }
        }
        session::set('menu_' . $id . '_' . $session[config('auth.USER_AUTH_KEY')]['u_id'], $menus);
        cache('SuperUserNode_cache_' . $menuid, $menus);
        return $menus;
    }

    /**
     * 赋值所有接收到的参数到模板变量
     * @author 四川挚梦科技有限公司
     * @date 2018-03-18
     */
    private function setAssign() {
        $arr = input('request.'); //get,post,cookies等请求参数
        $request = request();
        $param = $request->param(); //请求参数
        $this->assign($arr); //赋值到模板
        $this->assign($param);
		$this->assign("sys_path",SYS_PATH);
    }

    /**
     * 判断用户是否登陆
     * @author 四川挚梦科技有限公司
     * @date 2018-03-18
     */
    public function doCheckLogin() {
        if (!session(config('auth.USER_AUTH_KEY'))) {
            $int_port = "";
            if ($_SERVER["SERVER_PORT"] != 80) {
                $int_port = ':' . $_SERVER["SERVER_PORT"];
            }
            $string_request_uri = "http://" . $_SERVER["SERVER_NAME"] . $int_port . $_SERVER['REQUEST_URI'];
            $this->error(lang('NO_LOGIN'), url(SYS_PATH.'/User/Login', array('doUrl' => urlencode($string_request_uri))), 1);
        } else {
            $this->admin = session(config('auth.USER_AUTH_KEY'));
            $this->assign('AdminSession', session(config('auth.USER_AUTH_KEY')));
        }
    }

    /**
     * 分页
     * @author:四川挚梦科技有限公司
     * @date 2017-01-12
     */
    public function _Page($count, $pagesize) {
        $page = new Page($count, $pagesize);
        $page->setConfig("header", "条");
        $page->setConfig('theme', '<span>共%totalRow%%header%&nbsp;%nowPage%/%totalPage%页</span>&nbsp;%first%&nbsp;%upPage%&nbsp;%prePage%&nbsp;%linkPage%&nbsp;%nextPage%&nbsp;%downPage%&nbsp;%end%');
        return $page;
    }

    /**
     * 读取当前模块中的分类
     * @author 四川挚梦科技有限公司
     * @date 2017-01-12
     */
    public function getSelect($selectedid = 0, $selectname = 'cid') {
        $model = strtolower(CONTROLLER);
        $sReturn = '<select id="cid" name="' . $selectname . '" datatype="*" nullmsg="请选择"><option value="">-- 请选择 --</option>';
        $ary_category = Db::name("Category")->where(array('model' => $model))->order('sort','asc')->select();
        $sReturn .= $this->getOptions($ary_category, $selectedid);
        $sReturn .= '</select><span id="messageBox" for="title" generated="true" class="Validform_checktip onShow ">选择</span>';
        return $sReturn;
    }



    /**
     * 读取当前模块中的所有分类下的子分类
     * @author 四川挚梦科技有限公司
     * @date 2017-01-12
     */
    public function getOptions($category, $selectedid = 0, $pid = 0, $sublevelmarker = '') {
        $strHtml = '';
        if ($pid)
            $sublevelmarker .= '└─ ';
        foreach ($category as $value) {
            if ($pid == $value['pid']) {
                $strHtml .= '<option ';
                if (!$pid) {
                    $strHtml .= 'style="font-weight:bold;"';
                }
                $strHtml .= 'value="' . $value['id'] . '"';
                if ($selectedid == $value['id']) {
                    $strHtml .= 'selected';
                } else {
                    $strHtml .= '';
                }
                $strHtml .= '>' . $sublevelmarker . $value['title'] . '</option>';
                $strHtml .= $this->getOptions($category, $selectedid, $value['id'], $sublevelmarker);
            }
        }

        return $strHtml;
    }

    /**
     * 读取当前模块中的分类
     * @author 四川挚梦科技有限公司
     * @date 2017-01-12
     */
    public function getLiSelect($selectedid = 0, $selectname = 'cid') {
        $model = strtolower(CONTROLLER);
        $sReturn = '<li>全部</li>';
        $ary_category = Db::name("Category")->where(array('model' => $model))->order('sort','asc')->select();
        $sReturn .= $this->getLiOptions($ary_category, $selectedid);
        return $sReturn;
    }



    /**
     * 读取当前模块中的所有分类下的子分类
     * @author 四川挚梦科技有限公司
     * @date 2017-01-12
     */
    public function getLiOptions($category, $selectedid = 0, $pid = 0, $sublevelmarker = '') {
        $strHtml = '';
        if ($pid)
            $sublevelmarker .= '└─ ';
        foreach ($category as $value) {
            if ($pid == $value['pid']) {
                $strHtml .= '<li ';
                if (!$pid) {
                    $strHtml .= 'style="font-weight:bold;"';
                }
                $strHtml .= 'value="' . $value['id'] . '"';
                if ($selectedid == $value['id']) {
                    $strHtml .= 'selected';
                } else {
                    $strHtml .= '';
                }
                $strHtml .= '>' . $sublevelmarker . $value['title'] . '</li>';
                $strHtml .= $this->getLiOptions($category, $selectedid, $value['id'], $sublevelmarker);
            }
        }

        return $strHtml;
    }




    /**
     * 分类下拉函数
     * @author billow.wang<admin@zhi-meng.cn>
     * @date 2017-01-10
     */
    public function CateGetSelect($currentid, $selectedid = 0, $showzerovalue = 1, $selectname = 'pid') {
        $strHtml = '<select name="' . $selectname . '" class="select rounded">';
        if ($showzerovalue) {
            $strHtml .= '<option value="0">一级栏目</option>';
        }
        $model = strtolower(CONTROLLER);
        $where = array('model' => $model);
        $where['status'] = '1';
        $ary_category = Db::name("Category")->where($where)->order('sort','asc')->select();
        $strHtml .= $this->CateGetOption($ary_category, $currentid, $selectedid);
        $strHtml .= '</select>';
        return $strHtml;
    }

    /**
     * 分类选项列表函数
     * @author billow.wang<admin@zhi-meng.cn>
     * @date 2017-01-10
     */
    public function CateGetOption($category, $currentid = 0, $selectedid = 0, $pid = 0, $sublevelmarker = '') {
        $model = strtolower(CONTROLLER);
        if ($pid)
            $sublevelmarker .= '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├─ ';
        $strHtml = '';
        foreach ($category as $value) {
            if ($pid == $value['pid'] AND $value['id'] != $currentid) {
                $strHtml .= '<option ';
                if (!$pid) {
                    $strHtml .= 'style="font-weight:bold;"';
                }
                $strHtml .= 'value="' . $value['id'] . '"';
                if ($selectedid == $value['id']) {
                    $strHtml .= 'selected';
                } else {
                    $strHtml .= '';
                }
                $strHtml .= '>' . $sublevelmarker . $value['title'] . '</option>';
                $strHtml .= $this->CateGetOption($category, $currentid, $selectedid, $value['id'], $sublevelmarker);
            }
        }

        return $strHtml;
    }

    public function GetCategoryid($pid) {
        $arrid[] = $pid;
        $arrid = $this->GetCategoryCid($pid, $arrid);
        return $arrid;
    }

    public function GetCategoryCid($cid, &$arrid) {
        $where = array('pid' => $cid);
        $ary_data = Db::name('Category')->where($where)->cache(true, 60)->select();
        if ($ary_data) {
            foreach ($ary_data as $key => $one) {
                $arrid[] = $one['id'];
                $this->GetCategoryCid($one['id'], $arrid);
            }
        }
        return $arrid;
    }

    public function CategoryIndex() {
        $model = strtolower(CONTROLLER);
        $keyword = input('request.keyword', 0);
        $where = array();
		$where[]=['model','=',$model];
        if (!empty($keyword)) {
			
			$where[]=['title','like','%'.urldecode($keyword).'%'];
			$this->assign($keyword);
        }
	
		
        $count = Db::name("Category")->where($where)->count();
        $this->assign('count', $count);
        $obj_page = $this->_Page($count, 800);
        $page = $obj_page->newshow();
        $tree = new Tree();
        $tree->icon = array('│ ', '├─ ', '└─ ');
        $tree->nbsp = '&nbsp;&nbsp;&nbsp;';
        $ary_data = Db::name("category")->where($where)->limit($obj_page->firstRow, $obj_page->listRows)->order('sort','asc')->select();
        $array = array();
        if (!empty($ary_data) && is_array($ary_data)) {
            foreach ($ary_data as $vl) {
                $vl['str_status'] = '<img class="pointer" data-url="/'.SYS_PATH.'/category/dostatus" data-id="' . $vl['id'] . '" style="cursor: pointer;" data-field="status" data-value="' . $vl['status'] . '" src="/public/admin/default/images/icon_' . ($vl['status'] == 1 ? '1' : '0') . '.png" alt="' . ($vl['status'] == 1 ? '启用' : '停用') . '" title="' . ($vl['status'] == 1 ? '启用' : '停用') . '" />';
                $vl['parentid_node'] = ($vl['pid']) ? ' class="child-of-node-' . $vl['pid'] . '"' : '';
                $array[] = $vl;
            }
			$sys_path=SYS_PATH;
            $str = "<tr id='list_\$id' \$parentid_node>
                        <td class='fl'>
                            <input type='checkbox' value='\$id' name='ids[]' class='checkSon' data-xid='checkSon_x'/>
                        </td>
						<td>\$id</td>
                        <td class='fl'>\$spacer\$title</td>
                        <td>\$alias</td>
                        <td>\$sort</td>
                        <td>\$str_status</td>
                        <td><a href='javascript:void(0);' data-url='/$sys_path/$model/CategoryEdit.html?id=\$id' class='edit dialog' alt='编辑' title='编辑'>编缉</a>
                       <a href='javascript:void(0);' data-url='/$sys_path/$model/CategoryDelete.html?id=\$id' class='doDel remove del' title='删除'>删除</a>
                        </td>
						<td></td>
                    </tr>";
            $tree->init($array);
            $list = $tree->get_tree(0, $str);
            $this->assign('list', $list);
        }

        $this->assign("data", $ary_data);
        $this->assign("page", $page);

        $path = config("template.view_path") . strtolower(CONTROLLER) . "/" . strtolower(ACTION) . "." . config("template.view_suffix");
        if (file_exists($path)) {
            return view($path);
        } else {
            $path = config("template.view_path") . "public/" . strtolower(ACTION) . "." . config("template.view_suffix");
            return view($path);
        }
    }

    public function CategoryAdd() {

        if ($_POST) {
            $this->CategorySave();
            exit;
        }
        $category = $this->CateGetSelect(0);
        $this->assign("category", $category);

        $path = config("template.view_path") . strtolower(CONTROLLER) . "/categoryedit." . config("template.view_suffix");
        if (file_exists($path)) {
            return view($path);
        } else {
            $path =config("template.view_path") . "public/categoryedit." . config("template.view_suffix");
            return view($path);
        }
    }

    public function CategoryEdit() {
        if ($_POST) {
            $this->CategorySave();
            exit;
        }
        $id = input("id", 0, "intval");
        if ($id) {
            $ary_data = Db::name('Category')->where(array("id" => $id))->find();
            $category = $this->CateGetSelect($id, $ary_data['pid']);
            $this->assign('data', $ary_data);
            $this->assign("category", $category);
            $path = config("template.view_path") . strtolower(CONTROLLER) . "/categoryedit." . config("template.view_suffix");

            if (file_exists($path)) {
                return view($path);
            } else {
                $path = config("template.view_path") . "public/categoryedit." . config("template.view_suffix");

                return view($path);
            }
        } else {
            $this->error("请选择需要编辑的对象");
        }
    }

    public function CategorySave() {
        try {
            $ary_post = input("request.");
            $ary_request = input("request.");
            $pk = Db::name('Category')->getPk();
            if (isset($ary_post['id'])) {
                $id = $ary_request[$pk];
                $mod = Db('Category');
                $where = array('id' => $ary_post['id']);
                $ary_data = Db('Category')->where($where)->find();
                if ($ary_post['id'] == $ary_post['pid']) {
                    JsonDie(0, '不能选择自己为父分类', 'no');
                } else {
                    $result = model('category')->allowField(true)->save($ary_request, $where);
                    JsonDie(1, '操作成功', 'yes');
                }
            } else {
                if (!empty($ary_post) && is_array($ary_post)) {
                    $result = model('category')->allowField(true)->save($ary_post);
                    if (FALSE !== $result) {
                        JsonDie(1, '新增成功', 'yes');
                    } else {
                        JsonDie(0, '新增失败', 'no');
                    }
                } else {
                    JsonDie(1, '数据有误', 'no');
                }
            }
        } catch (\Exception $e) {
            JsonDie(0, '系统错误' . $e, 'no');
        }
    }

    public function CategoryDelete() {
        try {

            $data = input("request.");
            if (!isset($data['id'])) {
                JsonDie(0, '请选择要删除的数据', 'yes');
            }
            $ids = $data['id'];
            $ary_result = model("category")->destroy($ids);
            if (FALSE !== $ary_result) {
                JsonDie(1, '删除成功', 'yes');
            }
            JsonDie(0, '删除失败', 'no');
        } catch (\Exception $e) {
            JsonDie(0, '操作失败' . $e, 'yes');
        }
    }



    /**
     * 通用更改状态,1为启用，0为禁用
     * @author四川挚梦科技有限公司
     * @date 2017-01-12
     */
    public function doStatus(){
        try{
            $id=input("request.id",0,"intval");
            $value=input("request.value",0,"intval");
            if(!$id){JsonDie('0',"参数错误",'yes');	}
            if($value==0){
                $data=array('status'=>1);
            }else{
                $data=array('status'=>0);
            }

            $ary_result=Db::name(CONTROLLER)->where(array("id" => $id))->data($data)->update();
            if($ary_result){
                JsonDie('1',"操作成功",'yes');
            }else{
                JsonDie('0',"操作失败",'no');
            }
        }catch (\Exception $e) {
            JsonDie(0,'操作失败'.$e,'no');
        }
    }

    /**
     * 通用删除
     * @author billow.wang
     * @date 2018-04-07
     */
    public function doDelete() {
        try{
            $id = input("request.id");
            if (isset($id)) {
                $ary_result=Db::name(CONTROLLER)->delete($id);
                if (FALSE !== $ary_result) {
                    JsonDie(1,'操作成功','no');
                } else {
                    JsonDie(0,'操作失败','no');
                }
            } else {
                JsonDie(0,'参数错误','no');
            }
        }catch (\Exception $e) {
            JsonDie(0,'操作失败'.$e,'no');
        }
    }



    /**
     * 批量删除
     * @author billow.wang
     * @date 2018-04-07
     */
    public function listDelete(){
        try{
            $ids=input("request.ids/a");
            if(count($ids)<=0){
                JsonDie(0,'请选择要删除的数据!','no');
            }
            $result=Db::name(CONTROLLER)->delete($ids);
            if($result){
                JsonDie(1,'操作成功','no');
            }else {
                JsonDie(0,'操作失败','no');
            }
        }catch (\Exception $e) {
            JsonDie(0,'操作失败'.$e,'no');
        }
    }

    /**
     * 判断是否有多图上传
     * @author 四川挚梦科技有限公司
     * @date 2017-01-09
     */
    public function multImages($ary_post,$id=null){
        if (!empty($ary_post['encode_fields'])) {
            foreach ($ary_post['encode_fields'] as $key => $one) {
                $fileds_name=$key;
                $imagesModel=new imagesModel();
                $imagesModel->where('module_id',$id)->where('module',ucfirst(CONTROLLER))->where('fileds_name',$fileds_name)->delete();
                if(!empty($ary_post[$one])){
                    $addData=array();
                    foreach ($ary_post[$one] as $ckey=>$cone){
                        $addData[]=array('module'=>CONTROLLER,'module_id'=>$id,'fileds_name'=>$fileds_name,'image'=>$cone);
                    }
                    $imagesModel->allowField(true)->saveAll($addData);
                }

            }
        }
    }
	
	//传入数据和选中id获取select的option
    public function getoptiontree($data,$cate_id,$parent_id=0,$sublevelmarker=''){
        $strHtml = '';
        if ($parent_id){
            $sublevelmarker .= '└─ ';
        }
        foreach ($data as $value) {
            if ($parent_id == $value['parent_id']) {
                $strHtml .= '<option ';
                if (!$parent_id) {
                    $strHtml .= 'style="font-weight:bold;"';
                }
                $strHtml .= 'value="' . $value['id'] . '"';
                if ($cate_id == $value['id']) {
                    $strHtml .= 'selected';
                } else {
                    $strHtml .= '';
                }
                $strHtml .= '>' . $sublevelmarker . $value['title'] . '</option>';
                $strHtml .= $this->getoptiontree($data, $cate_id, $value['id'], $sublevelmarker);
            }
        }

        return $strHtml;
    }



    //传入数据和选中id获取ul的li
    public function getlitree($data,$cate_id,$parent_id=0,$sublevelmarker=''){
        $strHtml = '';
        if ($parent_id){
            $sublevelmarker .= '└─ ';
        }
        foreach ($data as $value) {
            if ($parent_id == $value['parent_id']) {
                $strHtml .= '<li ';
                if (!$parent_id) {
                    $strHtml .= 'style="font-weight:bold;"';
                }
                $strHtml .= 'value="' . $value['id'] . '"';
                if ($cate_id == $value['id']) {
                    $strHtml .= 'selected';
                } else {
                    $strHtml .= '';
                }
                $strHtml .= '>' . $sublevelmarker . $value['title'] . '</li>';
                $strHtml .= $this->getlitree($data, $cate_id, $value['id'], $sublevelmarker);
            }
        }

        return $strHtml;
    }

    //获取上传的图片（多图json，和一张单图）多图字段标题：$arr[0]，单图字段标题：$arr[1]
    //返回数据 array 每个单图和多图的数组的合集
    public function getimagejson($data,$arr){
        $result=array();
        foreach($arr as $k=>$v){
            $images=$data[$v[0]];
            
            $images=explode(',', $images);
            if(!empty($images)){
                $result[$v[1]]=$images[0];
                $images=json_encode($images);
                $result[$v[0]]=$images;
            }
        }
        return $result;
    }
	


}
