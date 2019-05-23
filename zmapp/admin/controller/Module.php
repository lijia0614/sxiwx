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

class Module extends Common {

    public function initialize() {
        parent::initialize();
        $tables = $this->getCurrentTables();
        $this->assign("tables", $tables);
    }

    /**
     * 模型首页列表信息
     * @author 四川 &挚梦&科技有限公司
     * @date 2017-01-09
     */
    public function index() {
        $module = model('module')->order('id','desc')->select();
        $count = model('module')->count();
        $this->assign('count', $count);
        $this->module = $module;
        $this->assign("list", $module);
        return view();
    }

    /**
     * 新建模型
     * @author 四川挚梦科技有限公司
     * @date 2017-01-09
     */
    public function add() {
        if ($_POST) {
            $this->doAdd();
        }
        return view('edit');
    }

    /**
     * 编缉模型
     * @author 四川挚梦科技有限公司
     * @date 2017-01-09
     */
    public function edit() {
        if ($_POST) {
            $this->doEdit();
            exit;
        }
        $id = input('request.id');
        $module = Db('module')->where(array('id' => $id))->find();
        $this->assign("data", $module);
        return view('edit');
    }

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
     * 获取当前数据库的表名信息
     * @author 四川挚梦科技有限公司
     * @date 2017-01-09
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
     * 修改模型数据
     * @author 四川挚梦科技有限公司
     * @date 2017-01-09
     */
    public function doEdit() {
        $data = input('request.');
        $id = $data['id'];
        $module = model('module');
        $savedata = array('title' => $data['title'], 'desc' => $data['desc'], 'seo_status'=>$data['seo_status'],'category_alias'=>$data['category_alias'],'category_status' => $data['category_status'], 'update_time' => time());
        $result = $module->save($savedata, array('id' => $id));
		if($data['category_status']==1){//如果修改为有分类
            Db::name('role_node')->where(array('module' => ucfirst($data['table']),'action'=>'categoryindex'))->data(array('status'=>1,'is_show'=>1))->update(); //更新显示分类管理
		}else{
			Db::name('role_node')->where(array('module' => ucfirst($data['table']),'action'=>'categoryindex'))->data(array('status'=>0,'is_show'=>0))->update(); //更新显示分类管理
		}
		cache('AdminMenus',null);
        if ($result) {
            JsonDie(1, '操作成功', 'yes');
        }
        JsonDie(0, '操作失败', 'no');
    }

    /**
     * 添加模型
     * @author 四*川*挚**梦*科*技*有*限*公*司
     * @date 2017-01-09
     */
    public function doAdd() {
        $data = input("request.");
        $tables = $this->getCurrentTables();
        if (!isset($data['table'])) {
            JsonDie(0, '参数必填', 'no');
        }
        if (in_array(strtolower($data['table']), $tables)) {
            JsonDie(0, '模型表名已经存在', 'no');
        }
        $mtable = strtolower($data['table']);
        $count = Db('module')->where(array('table' => $mtable))->count();
        if ($count != 0) {
            JsonDie(0, '模型表名已经存在', 'no');
        }
        $table_tag = config("database.prefix") . $mtable;
        $result = Db::execute("CREATE TABLE `" . $table_tag . "` (
															`id` int(11) NOT NULL AUTO_INCREMENT,
															`cid` int(11) NULL,
															`title` varchar(500) not null,
															`content` text not null,
															`sort` int(1) default '0',
															`status` int(1) default '1',
															`click` int(11) default '0', 
															`is_recommend` int(1) default '0',
															`is_seo` int(1) default '0',
															`seo_title` varchar(200) null,
															`seo_keywords` varchar(200) null,
															`seo_desc` varchar(200) null,														
															`create_time` int(10) null, 	
															`update_time` int(10) null,
															 PRIMARY KEY (`id`)) ENGINE=MyISAM DEFAULT CHARSET=utf8;");
        $data['update_time'] = time();
        $data['create_time'] = time();
        $module_id = model("module")->allowField(true)->save($data);
        if ($module_id) {
            $data['table'] = ucfirst($data['table']); //首字母转换为大写
            $this->add_model($data['table']);
            $this->add_role_node($data);
			cache('AdminMenus',null);
            JsonDie(1, '操作成功', 'yes');
        }
        JsonDie(0, '操作失败', 'no');
    }

    /**
     * 添加模型文件
     * @author 四川挚梦科技有限公司
     * @date 2017-04-23
     */
    private function add_model($table) {
        try {
            $table = ucfirst($table);
            $model_dir = WEB_PATH . "/zmapp/admin/model/";
            $default_model_file = $model_dir . "default_model.php";
            if (is_file($default_model_file)) {
                $c = file_get_contents($default_model_file);
                $c = str_replace("default_model", $table, $c);
                @file_put_contents($model_dir . $table . ".php", $c);
            } else {
                JsonDie(0, '复制模型文件出错' . $default_model_file, 'no');
            }
            return false;
        } catch (\Exception $e) {
            JsonDie(0, '操作失败' . $e, 'no');
        }
    }

    /**
     * 添加授权记录
     * @author  四川挚梦科技有限公司
     * @date 2018-05-11
     */
    private function add_role_node($data) {
        $sql[] = "INSERT INTO `" . config("database.prefix") . "role_node` VALUES ('', 'index', '" . $data['title'] . "', '" . $data['table'] . "',35, '1', '300', '0', '1');";
		$category_title=$data['category_alias']?$data['category_alias']:"分类管理";
        $sql[] = "INSERT INTO `" . config("database.prefix") . "role_node` VALUES ('', 'categoryindex', '" . $category_title . "', '" . $data['table'] . "',35,'".$data['category_status']."', '300', '0', '".$data['category_status']."');";
        try {
            foreach ($sql as $one) {
                Db::query($one);
            }
        } catch (\Exception $e) {
            JsonDie(0, '操作失败' . $e, 'no');
        }
    }

    /**
     * 删除模型，并删除表及字段记录
     * @author  四川挚梦科技有限公司
     * @date 2017-01-14
     */
    public function dodelete() {
        try {
            $id = input('request.id', 0, 'intval');
            $module = Db::name('module')->where(array('id' => $id))->find();
            if (!$module) {
                JsonDie(0, '数据库中没有找到该模型', 'no');
            }
            if ($module['system'] == 1) {
                JsonDie(0, '系统模型不能删除', 'no');
            }
            $tableName = $module['table'];
            $module_id = $module['id'];
            $sql = "DROP TABLE IF EXISTS `" . config('database.prefix') . $tableName . "`;";
            $result = Db::execute($sql);
            $status = model('module_fields')->where(array('module_id' => $module_id))->delete(); //删除模型自定义字段
            Db::name('module')->where(array('id' => $module_id))->delete(); //删除模型记录		
            Db::name('role_node')->where(array('module' => ucfirst($tableName)))->delete(); //删除授权模块
            Db::name('category')->where(array('model' => strtolower($tableName)))->delete(); //删除模型分类表中的分类
			@unlink(WEB_PATH."/zmapp/admin/model/".ucfirst($tableName).".php");//删除模型文件
			cache('AdminMenus',null);
            JsonDie(1, '操作成功', 'no');
        } catch (\Exception $e) {
            JsonDie(0, '操作失败' . $e, 'no');
        }
    }

    /**
     * 模型字段列表
     * @author  四*川*挚**梦*科*技*有*限*公*司
     * @date 2017-01-14
     */
    public function fields() {

        $keyword = input("request.keyword");
        $module_id = input("request.module_id", 0, 'intval');
        $where = "1=1 and ";
        if (!empty($keyword)) {
            $where .= "(`title` like '%" . urldecode($keyword) . "%' or " . "`fields` like '%" . urldecode($keyword) . "%') and ";
        }
        $where .= "module_id=" . $module_id;

        $this->assign('module_id', $module_id);
        $module = Db::name('module')->where(array('id' => $module_id))->find();
        $fields = Db::name('module_fields')->where($where)->order('sort','asc')->select();
        $count = count($fields);
        $this->assign('count', $count);
        $this->assign('module', $module);
        $this->assign('list', $fields);
        return view();
    }

    /**
     * 添加模型字段
     * @author  四*川*挚**梦*科*技*有*限*公*司
     * @date 2017-01-14
     */
    public function addFields() {
        if ($_POST) {
            $this->addFiledsSave();
            exit;
        }
        $module_id = input("request.module_id", 0, 'intval');
        $module = Db::name('module')->where(array('id' => $module_id))->find();
        $this->assign('module_id', $module_id);
        $this->assign('module', $module);
        return view('editfields');
    }

    /**
     * 保存添加模型字段
     * @author  四*川*挚**梦*科*技*有*限*公*司
     * @date 2017-01-14
     */
    private function addFiledsSave() {
        try {
            $ary_post = input('request.');
            $field = input('request.fields', 0); //获取用户填写的字段名
            $fields_type = input('request.fields_type', 0);
            $module_id = input('request.module_id', 0, 'intval');
            $module = Db::name("module")->where(array('id' => $module_id))->find(); //查询模型表名
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

            switch ($fields_type) {
                case 'text':
                    $result = Db::execute('alter table `' . config('database.prefix') . $module_table . '` add  `' . $field . '` varchar(500);');
                    break;
                case 'price':
                    $result = Db::execute('alter table `' . config('database.prefix') . $module_table . '` add  `' . $field . '` decimal(10,2) DEFAULT 0.00;');
                    break;
                case 'textarea':
                    $result = Db::execute('alter table `' . config('database.prefix') . $module_table . '` add  `' . $field . '` varchar(1000);');
                    break;
                case 'editor':
                    $result = Db::execute('alter table `' . config('database.prefix') . $module_table . '` add  `' . $field . '`  mediumtext;');
                    break;
                case 'select':
                    $result = Db::execute('alter table `' . config('database.prefix') . $module_table . '` add  `' . $field . '` varchar(1000);');
                    break;
                case 'image':
                    $result = Db::execute('alter table `' . config('database.prefix') . $module_table . '` add  `' . $field . '` varchar(500);');
                    break;
                case 'images':
                    $result = Db::execute('alter table `' . config('database.prefix') . $module_table . '` add  `' . $field . '` varchar(1000);');
                    break;
                default:
                    $result = Db::execute('alter table `' . config('database.prefix') . $module_table . '` add  `' . $field . '` varchar(1000);');
                    break;
            }
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
     * 创建副表
     * @author  四*川*挚**梦*科*技*有*限*公*司
     * @date 2017-06-17
     */
    public function CreateDeputyTable($tablename, $tbid1, $tbid2) {
        $table_tag = config("database.prefix") . $tablename;
        $sql = "CREATE TABLE `" . $table_tag . "` (`id` int(11) NOT NULL AUTO_INCREMENT,";
        $sql .= "`" . $tbid1 . "` int(11) default '0',";
        $sql .= "`" . $tbid2 . "` int(11) default '0',";
        $sql .= "`status` int(1) default '0',";
        $sql .= "PRIMARY KEY (`id`)) ENGINE=MyISAM DEFAULT CHARSET=utf8;";
        $result = Db::execute($sql);
        return $result;
    }

    /**
     * 判断是否全局设置的模型
     * @author  四*川*挚**梦*科*技*有*限*公*司
     * @date 2017-01-14
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

    /**
     * 获取表中已有字段
     * @author  四*川*挚**梦*科*技*有*限*公*司
     * @date 2017-01-14
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
     * 修改保存已有模型字段
     * @author  四*川*挚**梦*科*技*有*限*公*司
     * @date 2017-01-14
     */
    public function editFields() {
        if ($_POST) {
            $this->UpdateFields(); //调用修改方法
        }
        $id = input('request.id', 0, 'intval');
        $field = Db('module_fields')->where(array('id' => $id))->find();
        $module = Db('module')->where(array('id' => $field['module_id']))->find();
        $this->assign('module_id', $field['module_id']);
        $this->assign('module', $module);
        $this->assign('data', $field);
        return view('editfields');
    }

    /**
     * 修改保存已有模型字段
     * @author  四*川*挚**梦*科*技*有*限*公*司
     * @date 2017-01-14
     */
    public function UpdateFields() {
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
            switch ($fields_type) {
                case 'text':
                    $result = Db::execute('alter table `' . config('database.prefix') . $module_table . '` change  `' . $oldfields . '` `' . $field . '` varchar(500);');
                    break;
                case 'textarea':
                    $result = Db::execute('alter table `' . config('database.prefix') . $module_table . '` change  `' . $oldfields . '` `' . $field . '` varchar(1000);');
                    break;
                case 'editor':
                    $result = Db::execute('alter table `' . config('database.prefix') . $module_table . '` change  `' . $oldfields . '` `' . $field . '`  mediumtext;');
                    break;
                case 'select':
                    $result = Db::execute('alter table `' . config('database.prefix') . $module_table . '` change  `' . $oldfields . '` `' . $field . '` varchar(1000);');
                    break;
                case 'image':
                    $result = Db::execute('alter table `' . config('database.prefix') . $module_table . '` change  `' . $oldfields . '` `' . $field . '` varchar(500);');
                    break;
                case 'images':
                    $result = Db::execute('alter table `' . config('database.prefix') . $module_table . '` change  `' . $oldfields . '` `' . $field . '` varchar(1000);');
                    break;
                default:
                    $result = Db::execute('alter table `' . config('database.prefix') . $module_table . '` change  `' . $oldfields . '` `' . $field . '` varchar(1000);');
                    break;
            }
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

    /* @author  四*川*挚***梦*科*技*有*限*公*司 */

    /**
     * 删除已有字段
     * @author  四*川*挚***梦*科*技*有*限*公*司
     * @date 2017-01-14
     */
    public function deleteFields() {
        try {
            $id = input('request.id', 0, 'intval');
            if (!$id) {
                JsonDie(0, '参数错误', 'no');
            }
            $field = Db::name('module_fields')->where(array('id' => $id))->find();
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
            $status = Db::name('module_fields')->where(array('id' => $id))->delete();
            if (!$status) {
                JsonDie(0, '删除Fields记录时出错', 'no');
            } else {
                JsonDie(1, '删除成功', 'no');
            }
        } catch (\Exception $e) {
            JsonDie(0, '操作失败' . $e, 'no');
        }
    }

    /* @author  四*川*挚***梦*科*技*有*限*公*司 */
}

?>