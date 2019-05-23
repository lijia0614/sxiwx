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

class Emptys extends Common
{

    public function __construct()
    {
        parent::__construct();
        $modules = $this->getModule(CONTROLLER); //获取模型配置 
        $this->assign("modules", $modules);
        $this->modelFields($modules['table']);
    }

    /**
     * 空控制器下首页方法
     * @author 四川挚梦科技有限公司
     * @date 2017-04-23
     */
    public function index()
    {
        $name = CONTROLLER;
        $ary_get['pageall'] = input("request.pageall", 10, 'intval');	
        $keyword = input("request.keyword", '');

        $where = array();
        if (!empty($keyword)) {
			$where[]=['a.title','like','%'.urldecode($keyword).'%'];
        }	
		
        $cid = input("request.cid", 0, "intval");
        if ($cid) {
            $cidarr = $this->GetCategoryid($cid);
            $instr = implode(",", $cidarr);
			$where[]=['a.cid','in',$instr];
        }
        $fields = 'b.title as category_name,a.*';
        $count = Db::name(CONTROLLER)->alias('a')->field($fields)->join('category b', 'b.id = a.cid', "LEFT")->where($where)->count();
        $this->assign("count", $count);
        $obj_page = $this->_Page($count, $ary_get['pageall']);
        $page = $obj_page->newshow();
        $ary_data = Db::name(CONTROLLER)->alias('a')->field($fields)
            ->where($where)
            ->join('category b', 'b.id = a.cid', "LEFT")
            ->order("sort asc,id desc")
            ->limit($obj_page->firstRow, $obj_page->listRows)
            ->select();
        $this->assign("list", $ary_data);
        $this->assign("filter", $ary_get);
        $this->assign("page", $page);
        $Tplpath = $this->currentTplPath();
        $category = $this->getSelect($cid);
        $this->assign('category', $category);
        return view($Tplpath);
    }

    /**
     * 判断模板文件并显示
     * @author billow.wang<admin@zhi-meng.cn>
     * @date 2017-04-23
     */
    public function currentTplPath()
    {
        if (strtolower(ACTION) == 'add') {
            $path = config("template.view_path") . strtolower(CONTROLLER) . "/edit." . config("template.view_suffix");
            if (file_exists($path)) {
                return $path;
            } else {
                $path = config("template.view_path") . "public/edit." . config("template.view_suffix");
                return $path;
            }
        } else {
            $path = config("template.view_path") . strtolower(CONTROLLER) . "/" . strtolower(ACTION) . "." . config("template.view_suffix");
            if (file_exists($path)) {
                return $path;
            } else {
                $path = config("template.view_path") . "public/" . strtolower(ACTION) . "." . config("template.view_suffix");
                return $path;
            }
        }
    }

    public function add()
    {

        $tag = CONTROLLER;
        if ($_POST) {
            $this->doSave();
            exit;
        }
        $category = $this->getSelect();
        $this->assign("category", $category);
        $Tplpath = $this->currentTplPath();
        return view($Tplpath);
    }

    public function edit()
    {
        $tag = CONTROLLER;
        if ($_POST) {
            $this->doSave();
            exit;
        }
        $id = input("request.id", 0, 'intval');
        if (!$id) {
            JsonDie(0, '未找到数据', 'no');
        }
        $data = Db::name($tag)->where(array('id' => $id))->find();
        $category = $this->getSelect($data['cid']);
        $this->assign("category", $category);
        $this->assign("data", $data);
        $Tplpath = $this->currentTplPath();
        return view($Tplpath);
    }

    /**
     * 保存信息，并自动判断新增或者修改
     * @author 四川挚梦科技有限公司
     * @date 2017-04-23
     */
    public function doSave()
    {
        try {
            $ary_post = input("post.");
            $id = input('request.id', 0, 'intval');
            if (isset($ary_post['id'])) {
                $ary_result = model(CONTROLLER)->allowField(true)->save($ary_post, array('id' => intval($id)));
				$this->multImages($ary_post,$id);//判断是否有多图上传
            } else {
                $ary_result = model(CONTROLLER)->allowField(true)->save($ary_post);
                $id= model(CONTROLLER)->id;//获取当前新增主键值				
				$this->multImages($ary_post,$id);//判断是否有多图上传
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


}
