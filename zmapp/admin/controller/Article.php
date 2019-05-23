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
use app\admin\model\Images as imagesModel;
use app\admin\model\Article as ArticleModel;
class Article extends Common {

    public function __construct() {
        parent::__construct();
        $this->modelFields(); //获取模型字段
    }

    public function index() {
        $cid = input("get.cid/d", 0,"intval");
        $status = input("get.status/d", 3,"intval");
        $ary_get['pageall'] = input("request.pageall", 10, 'intval');
        $keyword = input("request.keyword", '');

        $where = array();
        if (!empty($keyword)) {
			$where[]=['a.title|a.id','like','%'.urldecode($keyword).'%'];
        }
        if($status!=3){
			$where[]=['a.status','=',$status];
        }
		if($cid){
			$cidarr=$this->GetCategoryid($cid);
			$instr=implode(",",$cidarr);
			$where[]=['a.cid','in',$instr];
			$category=model("category")->where("id",$cid)->find();
			$this->assign("category",$category);
		}

        $fields = 'b.title as category_name,a.*';
        $count = Db::name("Article")->alias('a')->field($fields)->join('category b','b.id=a.cid',"LEFT")->where($where)->count();
        $this->assign("count", $count);
        $obj_page = $this->_Page($count, $ary_get['pageall']);
        $page = $obj_page->newshow();
        $ary_data = Db::name("Article")->alias('a')->field($fields)->where($where)->join('category b','b.id=a.cid',"LEFT")->order(['sort'=>'asc','id'=>'desc'])->limit($obj_page->firstRow, $obj_page->listRows)->select();
        $this->assign("list", $ary_data);
        $this->assign("filter", $ary_get);
        $this->assign("page", $page);
        $categoryList = $this->getLiSelect($cid);
        $this->assign('categoryList', $categoryList);
        return view();
    }

    public function edit() {
        if ($_POST) {
            $this->doSave();
            exit;
        }
        $id = input('request.id', 0, 'intval');
		if(!$id){
			JsonDie(0, '参数出错', 'yes');
		}
        $data = Db::name('article')->where(array('id' => $id))->find();
        $category = $this->getSelect($data['cid']);
        $this->assign('category', $category);
        $this->assign('data', $data);
        return view();
    }

    public function add() {
        $category = $this->getSelect();
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
     * 保存信息
     * @author 四川挚梦科技有限公司
     * @date 2017-01-09
     */
    public function doSave() {
        try {
            $ary_post = input("post.");
            $id = input('request.id', 0, 'intval');
            $ArticleModel=new ArticleModel();
            if (isset($ary_post['id'])) {
                $ary_result = $ArticleModel->allowField(true)->save($ary_post, array('id' => intval($id)));
                $this->multImages($ary_post,$id);//判断是否有多图上传
            } else {
                $ary_result = $ArticleModel->allowField(true)->save($ary_post);
                $id= $ArticleModel->id;//获取当前新增主键值
                $this->multImages($ary_post,$id);//判断是否有多图上传

            }
            if (FALSE !== $ary_result) {
                JsonDie(1, '操作成功', 'yes');
            } else {
                JsonDie(0, '操作失败', 'no');
            }
        } catch (\Exception $e) {
            JsonDie(0, '操作失败' . $e, 'no');
        }
    }

    /**
     * 通用删除
     * @author billow.wang
     * @date 2018-04-07
     */
    public function doDelete() {
        $id = input("get.id");
        if (isset($id)) {
            $ArticleModel=new ArticleModel();
            $ary_result = $ArticleModel->destroy($id);
            if (FALSE !== $ary_result) {
                JsonDie(1, '操作成功', 'yes');
            } else {
                ;
                JsonDie(0, '操作失败', 'no');
            }
        } else {
            JsonDie(0, '非法参数', 'no');
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
            $result=Db('article')->delete($ids);
            if($result){
                JsonDie(1,'操作成功','no');
            }else {
                JsonDie(0,'操作失败','no');
            }
        }catch (\Exception $e) {
            JsonDie(0,'操作失败'.$e,'no');
        }
    }


	


}
