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

class Fields extends Common {

    public function __construct() {
        parent::__construct();
        $tables = $this->getCurrentTables();
        $this->assign("tables", $tables);        
    }

    /**
     * 模型字段列表
     * @author 四川挚梦科技有限公司
     * @date 2018-04-09
     */
    public function index() {

        $keyword = input("request.keyword");
        $module_id = input("request.module_id", 0, 'intval');
		
        $where = array();
        if (!empty($keyword)) {
			$where[]=['title|fields','like','%'.urldecode($keyword).'%'];
        }

		if($cid){
			$cidarr=$this->GetCategoryid($cid);
			$instr=implode(",",$cidarr);
			$where[]=['a.cid','in',$instr];
			$category=model("category")->where("id",$cid)->find();
			$this->assign("category",$category);
		}
		$where[]=['module_id','=',$module_id];
        $this->assign('module_id', $module_id);
        $module = Db('module')->where('id',$module_id)->find();
        $fields = Db('module_fields')->where($where)->order('sort','asc')->select();
        $count = count($fields);
        $this->assign('count', $count);
        $this->assign('module', $module);
        $this->assign('list', $fields);
        return view();
    }

    /**
     * 添加字段
     * @author 四川挚梦科技有限公司
     * @date 2018-04-09
     */
    public function add() {
        if ($_POST) {
            $this->addSave();
            exit;
        }
        $module_id = input("request.module_id", 0, 'intval');
        $module = Db('module')->where(array('id' => $module_id))->find();
        $this->assign('module_id', $module_id);
        $this->assign('module', $module);
        return view('edit');
    }

    /**
     * 修改字段
     * @author 四川挚梦科技有限公司
     * @date 2018-04-09
     */
    public function edit() {
        if ($_POST) {
            $this->editSave(); //调用修改方法
        }
        $id = input('request.id', 0, 'intval');
        $field = Db('module_fields')->where(array('id' => $id))->find();
        $module = Db('module')->where(array('id' => $field['module_id']))->find();
        $this->assign('module_id', $field['module_id']);
        $this->assign('module', $module);
        $this->assign('data', $field);
        return view('edit');
    }

    /**
     * 获取表中已有字段
     * @author  四川挚梦科技有限公司
     * @date 2018-04-09
     */
    public function getFields($module_table) {
        if (!$module_table) {
            JsonDie(0, '表名参数错误', 'no');
        }
        $sql = "show COLUMNS from " . config("database.prefix") . $module_table;
        $result = Db::query($sql);
        $fields = array();
        if ($result) {
            foreach ($result as $key => $one) {
                $fields[] = $one['Field'];
            }
        }
        return $fields;
    }

    /**
     * 保存添加模型字段
     * @author  四*川*挚**梦*科*技*有*限*公*司
     * @date 2017-01-14
     */
    private function addSave() {
        try {
            $ary_post = input('request.');
            $field = input('request.fields', 0); //获取用户填写的字段名
            $fields_type = input('request.fields_type', 0);
            $module_id = input('request.module_id', 0, 'intval');
            $module = Db("module")->where(array('id' => $module_id))->find(); //查询模型表名
            $this->isConfigModel($ary_post, $module['table'], $id = null); //判断是否全局参数配置

            $tables = $this->getCurrentTables(); //查询当前数据库中的表名集合			

            if (!isset($module['table'])) {
                JsonDie(0, '没有表名', 'no');
            }
            if (!in_array(strtolower($module['table']), $tables)) {
                JsonDie(0, '没有找到该模型的数据表', 'no');
            }
            $module_table = $module['table']; //获取模型中的表名
            $table_fields = $this->getFields($module_table); //查询表中已有的字段
            $ary_post['table_name'] = $module_table;
            if (in_array($field, $table_fields)) {
                JsonDie(0, '表中已有该字段名', 'no');
            }

            if ($ary_post['deputy_table_status'] == 1) {//判断是否生成副表
                $module_table_id = $module['table'] . "_id"; //关联的表id
                $link_table_id = $ary_post['link_table_name'] . "_id"; //被关联的表id
                $deputy_table = $ary_post['deputy_table']; //副表名称	
                if (in_array(strtolower($deputy_table), $tables)) {
                    JsonDie(0, '请更换副表名', 'no');
                }
                $result = $this->CreateDeputyTable($deputy_table, $module_table_id, $link_table_id); //创建副表
                if ($result) {
                    $ary_post['update_time'] = time();
                    $ary_post['create_time'] = time();
                    $ary_post['fields_type'] = empty($ary_post['fields_type']) ? 'link_table' : trim($ary_post['fields_type']);
                    $ary_result = model("module_fields")->allowField(true)->save($ary_post);
                    JsonDie(1, '操作成功', 'no');
                }
            }
            $exeResult = $this->add_fields($module_table, $field, $fields_type); //添加数据库字段
            $ary_post['update_time'] = time();
            $ary_post['create_time'] = time();
            $ary_post['fields_type'] = empty($ary_post['fields_type']) ? 'link_table' : trim($ary_post['fields_type']);
            $ary_result = model("module_fields")->allowField(true)->save($ary_post);
            if ($ary_result) {
                JsonDie(1, '操作成功', 'no');
            }
        } catch (\Exception $e) {
            JsonDie(0, '操作失败' . $e, 'no');
        }
    }

    /**
     * 修改保存已有模型字段
     * @author  四川挚梦科技有限公司
     * @date 2018-04-09
     */
    public function editSave() {
        try {
            $ary_post = input('request.');
            $id = input('request.id', 0, 'intval');
            $fields_type = input('request.fields_type', 0);
            $fieldsArr = Db("module_fields")->where(array('id' => $id))->find();
            $oldfields = $fieldsArr['fields'];
            if (!$fieldsArr) {
                JsonDie(0, '未找到该字段', 'no');
            }
            //查询模型表名
            $module_id = $fieldsArr['module_id'];
            $module = Db("module")->where(array('id' => $module_id))->find();
            $module_table = $module['table']; //获取模型中的表名
            $this->isConfigModel($ary_post, $module['table'], $id); //判断是否全局参数配置
            $table_fields = $this->getFields($module_table); //查询表中已有的字段
            $field = input('request.fields', 0);
            if (!in_array($oldfields, $table_fields)) {
                JsonDie(0, '表中不存在该字段', 'no');
            }
            if ($field != $oldfields) {
                if (in_array($field, $table_fields)) {
                    JsonDie(0, '表中已有该字段!请更换!', 'no');
                }
            }
            if ($ary_post['deputy_table_status'] == 1) {//判断是否生成副表
                $module_table_id = $module['table'] . "_id"; //关联的表id
                $link_table_id = $ary_post['link_table_name'] . "_id"; //被关联的表id
                $deputy_table = $ary_post['deputy_table']; //副表名称	
                if (in_array(strtolower($deputy_table), $tables)) {
                    JsonDie(0, '请更换副表名', 'no');
                }
                $result = $this->CreateDeputyTable($deputy_table, $module_table_id, $link_table_id); //创建副表
                if ($result) {
                    $ary_post['update_time'] = time();
                    $ary_post['create_time'] = time();
                    $ary_post['fields_type'] = empty($ary_post['fields_type']) ? 'link_table' : trim($ary_post['fields_type']);
                    $ary_result = model("module_fields")->allowField(true)->save($ary_post);
                    JsonDie(1, '操作成功', 'no');
                }
            }
            $exeResult = $this->alter_fields($module_table, $field, $oldfields); //修改数据库字段名
            if (isset($_POST['link_table_status']) && $_POST['link_table_status'] == 1) {
                $ary_post['fields_type'] = 'link_table';
            } else {
                if (isset($_POST['fields_type_hidden']) && empty($ary_post['fields_type'])) {
                    $ary_post['fields_type'] = $_POST['fields_type_hidden'];
                }
            }
            $ary_result = model("module_fields")->allowField(true)->save($ary_post, array('id' => $id));
            if ($ary_result) {
                JsonDie(1, '操作成功', 'no');
            } else {
                JsonDie(0, '好像什么都没修改', 'no');
            }
        } catch (\Exception $e) {
            JsonDie(0, '操作失败' . $e, 'no');
        }
    }

    /**
     * 删除已有字段
     * @author  四川挚梦科技有限公司
     * @date 2018-04-09
     */
    public function doDelete() {
        try {
            $id = input('request.id', 0, 'intval');
            if (!$id) {
                JsonDie(0, '参数错误', 'no');
            }
            $field = Db('module_fields')->where(array('id' => $id))->find();
            if (!$field) {
                JsonDie(0, '没有找到该字段所属表名', 'no');
            }
            $table = strtolower($field['table_name']); //表名
            if (strtolower($table) != 'setting') {
                $fields = $field['fields']; //字段名
                Db::execute("alter table `" . config('database.prefix') . $table . "` drop column `" . $fields . "`;");
                $status = Db('module_fields')->where(array('id' => $id))->delete();
                if (!$status) {
                    JsonDie(0, '删除Fields记录时出错', 'no');
                } else {
                    JsonDie(1, '删除成功', 'no');
                }
            }
            $status = Db('module_fields')->where(array('id' => $id))->delete();
            if (!$status) {
                JsonDie(0, '删除Fields记录时出错', 'no');
            } else {
                JsonDie(1, '删除成功', 'no');
            }
        } catch (\Exception $e) {
            JsonDie(0, '操作失败' . $e, 'no');
        }
    }

    /**
     * 更新字段名
     * @author  四川挚梦科技有限公司
     * @date 2018-04-09
     */
    public function alter_fields($table, $field, $old_field) {
        try {
            $sql = 'alter table `' . config('database.prefix') . $table . '` change  `' . $old_field . '` `' . $field . '` varchar(500);';
            $result = Db::execute($sql);
            return $result;
        } catch (\Exception $e) {
            JsonDie(0, '执行修改错误' . $e, 'no');
        }
    }

    /**
     * 执行更改数据库字段
     * @author  四川挚梦科技有限公司
     * @date 2018-04-09
     */
    public function add_fields($table, $field, $fields_type) {
        try {
            switch ($fields_type) {
                case 'text':
                    $sql = 'alter table `' . config('database.prefix') . $table . '`add`' . $field . '` varchar(500);';
                    break;
                case 'price':
                    $sql = 'alter table `' . config('database.prefix') . $table . '`add`' . $field . '` decimal(10,2) DEFAULT 0.00;';
                    break;
                case 'textarea':
                    $sql = 'alter table `' . config('database.prefix') . $table . '`add`' . $field . '` varchar(1000);';
                    break;
                case 'editor':
                    $sql = 'alter table `' . config('database.prefix') . $table . '`add`' . $field . '`  mediumtext;';
                    break;
                case 'select':
                    $sql = 'alter table `' . config('database.prefix') . $table . '`add`' . $field . '` varchar(1000);';
                    break;
                case 'image':
                    $sql = 'alter table `' . config('database.prefix') . $table . '`add`' . $field . '` varchar(500);';
                    break;
                case 'images':
                    $sql = 'alter table `' . config('database.prefix') . $table . '`add`' . $field . '` varchar(1000);';
                    break;
                default:
                    $sql = 'alter table `' . config('database.prefix') . $table . '`add`' . $field . '` varchar(1000);';
                    break;
            }
            $result = Db::execute($sql);
            return $result;
        } catch (\Exception $e) {
            JsonDie(0, '执行修改错误' . $e, 'no');
        }
    }

    /**
     * 获取当前数据库的表名信息
     * @author  四川挚梦科技有限公司
     * @date 2018-04-09
     */
    public function getCurrentTables() {
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
     * 获取指定表名的字段列表，以select方式打印
     * @author  四川挚梦科技有限公司
     * @date 2018-04-09
     */
    public function getFieldsOptions() {
        $table = input("request.tablename", 0);
        if (!$table) {
            JsonDie(0, '参数错误', 'no');
        }
        $fileds = $this->getFields($table);
        $str = "<option value=''>请选择</option>";
        if ($fileds && is_array($fileds)) {
            foreach ($fileds as $one) {
                $str .= "<option value='" . $one . "'>" . $one . "</option>";
            }
        }
        $data = array("status" => 0, "data" => $str);
        die(json_encode($data));
    }

    /**
     * 判断是否全局设置的模型
     * @author  四川挚梦科技有限公司
     * @date 2018-04-09
     */
    public function isConfigModel($ary_post, $table, $id = null) {
        if ($table != 'setting') {
            return;
        }
        if ($id) {
            if ($table == 'setting') {
                $ary_post['table_name'] = 'setting';
                $ary_result = model("module_fields")->allowField(true)->save($ary_post, array('id' => $id));
                JsonDie(1, '操作成功', 'no');
            }
        } else {
            if ($table == 'setting') {
                $ary_post['table_name'] = 'setting';
                $ary_result = model("module_fields")->allowField(true)->save($ary_post);
                JsonDie(1, '操作成功', 'no');
            }
        }
    }


}
