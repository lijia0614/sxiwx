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

class Collection extends Common {

   /**
     * 采集规则列表
     * @author billow.wang
     * @date 2017-05-17
     */
    public function index() {
        $ary_get['pageall'] = input("request.pageall", 10, 'intval');
        $keyword = input("request.keyword", '');
		$model = input("request.model");
        if ($model) {
            $model = strtolower($model);
            $where = "model='" . $model . "' and ";
        } else {
            $where = "model='article' and ";
        }
        if (!empty($keyword)) {
            $where = "a.`collect_title` like '%" . urldecode($keyword) . "%' AND ";
        }
        $where .= '1=1';
        $fields = 'a.*';
        $count = Db::name("collection")->alias('a')->field($fields)->where($where)->count();
        $this->assign("count", $count);
        $obj_page = $this->_Page($count, $ary_get['pageall']);
        $page = $obj_page->newshow();
        $ary_data = Db::name("collection")->alias('a')->field($fields)->where($where)->order('id desc')->limit($obj_page->firstRow, $obj_page->listRows)->select();
        $this->assign("lists", $ary_data);
        $this->assign("filter", $ary_get);
        $this->assign("page", $page);
		return view();
    }

    /**
     * 编缉采集规则
     * @author billow.wang
     * @date 2017-05-17
     */
    public function edit() {
		$model=input("request.model",'article');
        if ($_POST) {
            $this->doSave();
            exit;
        }
        $id = input('request.id', 0, 'intval');
        $data = Db::name('collection')->where(array('id' => $id))->find();
        if ($data) {
            $collect_data = json_decode($data['collect_data'], true);
        }
        $datas = array_merge($data, $collect_data);
        $category = $this->getSelect($data['category_id'],'cid',$model);
        $this->assign('category', $category);
        $this->assign('data', $datas);
		return view();
    }

    /**
     * 添加采集规则
     * @author billow.wang
     * @date 2017-05-17
     */
    public function add() {
		$model=input("request.model",'article');
        $category = $this->getSelect(0,'cid',$model);
        $this->assign('category', $category);
        if ($_POST) {
            $this->doSave();
            exit;
        }
        $data['cid'] = 0;
        $this->assign('data', $data);
		return view('edit');
    }
	
 /**
     * 保存采集规则
     * @author 四川挚梦科技有限公司
     * @date 2017-01-09
     */
    public function doSave() {
        try {
            $all_post = input("post.",0,'trim');
            $all_post['info']['is_remove_a'] = isset($all_post['info']['is_remove_a']) ? $all_post['info']['is_remove_a'] : 0;
            $all_post['info']['is_remove_script'] = isset($all_post['info']['is_remove_script']) ? $all_post['info']['is_remove_script'] : 0;
            $all_post['info']['is_remove_div'] = isset($all_post['info']['is_remove_div']) ? $all_post['info']['is_remove_div'] : 0;
            $all_post['info']['is_remove_p'] = isset($all_post['info']['is_remove_p']) ? $all_post['info']['is_remove_p'] : 0;
            $all_post['info']['is_remove_img'] = isset($all_post['info']['is_remove_img']) ? $all_post['info']['is_remove_img'] : 0;
            $all_post['info']['is_remove_input'] = isset($all_post['info']['is_remove_input']) ? $all_post['info']['is_remove_input'] : 0;
            $all_post['info']['is_remove_textarea'] = isset($all_post['info']['is_remove_textarea']) ? $all_post['info']['is_remove_textarea'] : 0;
            $all_post['info']['is_remove_from'] = isset($all_post['info']['is_remove_from']) ? $all_post['info']['is_remove_from'] : 0;
            $all_post['info']['is_remove_li'] = isset($all_post['info']['is_remove_li']) ? $all_post['info']['is_remove_li'] : 0;
            $all_post['info']['is_remove_span'] = isset($all_post['info']['is_remove_span']) ? $all_post['info']['is_remove_span'] : 0;
            $all_post['info']['is_remove_iframe'] = isset($all_post['info']['is_remove_iframe']) ? $all_post['info']['is_remove_iframe'] : 0;
            $all_post['info']['is_get_content_small_image'] = isset($all_post['info']['is_get_content_small_image']) ? $all_post['info']['is_get_content_small_image'] : 0;
            $all_post['info']['is_remove_mark'] = isset($all_post['is_remove_mark']) ? $all_post['is_remove_mark'] : 0;
            $ary_post = $all_post['info'];
            if ($ary_post['model']) {
                $ary_post['model'] = $ary_post['model'];
            } else {
                $ary_post['model'] = 'article';
            }
            $ary_post['category_id'] = $all_post['cid'];
            unset($all_post['info']);
            unset($all_post['dialogid']);
            unset($all_post['dosubmit']);
            unset($all_post['category_id']);
            unset($all_post['cid']);
            unset($all_post['id']);
            unset($all_post['is_remove_mark']);
            $ary_post['collect_data'] = json_encode($all_post);
            $id = input('request.id', 0, 'intval');
            if ($id) {
                $ary_post['update_time'] = date("Y-m-d H:i:s");
                $ary_result = model("collection")->allowField(true)->save($ary_post, array('id' => intval($id)));
            } else {
                $ary_post['update_time'] = date("Y-m-d H:i:s");
                $ary_post['create_time'] = date("Y-m-d H:i:s");
                $ary_result = model("collection")->allowField(true)->save($ary_post);
            }
            if (FALSE !== $ary_result) {
                JsonDie(1, '操作成功', 'no');
            } else {
                JsonDie(1, '操作失败', 'no');
            }
        } catch (\Exception $e) {
            JsonDie(0, '操作失败' . $e, 'no');
        }
    }

    /**
     * 删除采集规则
     * @author billow.wang
     * @date 2015-3-29
     */
    public function collectsDelete() {
        try {
            $ids = $_REQUEST['id'];
            if (is_array($ids)) {
                foreach ($ids as $key => $one) {
                    $ids[$key] = intval($one);
                }
            } else {
                $ids = intval($ids);
            }
            if (!$ids) {
                JsonDie(0, '请选择要删除的数据', 'yes');
            }
            $ary_result = Db::name('collection')->delete($ids);
            if (FALSE !== $ary_result) {
                JsonDie(1, '删除成功', 'yes');
            }
            JsonDie(0, '删除失败', 'no');
        } catch (\Exception $e) {
            JsonDie(0, '操作失败' . $e, 'yes');
        }
    }

    /**
     * 更新采集状态
     * @author四川挚梦科技有限公司
     * @date 2017-01-12
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

            $ary_result = model('collection')->allowField(true)->save($data, array('id' => $id));
            if ($ary_result) {
                JsonDie('1', "操作成功", 'yes');
            } else {
                JsonDie('0', "操作失败", 'no');
            }
        } catch (\Exception $e) {
            JsonDie(0, '操作失败' . $e, 'no');
        }
    }	
	

    /**
     * 复制一条采集规则
     * @author billow.wang
     * @date 2017-05-17
     */
    public function docopy() {
        $collect_id = input("request.collect_id", 0, "intval");
        if (!$collect_id) {
            JsonDie(0, '非法参数', 'no');
        }
        $collects = Db::name("collection")->where(array("id" => $collect_id))->find();
        if (!$collects) {
            JsonDie(0, '没有找到该规则', 'no');
        }
        $max_id = Db("collection")->field("max(id) as max_id")->find();
        $collects['id'] = $max_id['max_id'] + 1;
        $ary_result = model("collection")->allowField(true)->save($collects);
        if ($ary_result) {
            JsonDie(1, '操作成功', 'no');
        }
    }
	
 /**
     * 读取当前模块中的分类
     * @author 四川挚梦科技有限公司
     * @date 2017-01-12
     */
    public function getSelect($selectedid = 0, $selectname = 'cid',$model='article') {
        $model = strtolower($model);
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
	
	
}
?>