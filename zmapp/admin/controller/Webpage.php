<?php
namespace app\admin\controller;

use think\Controller;
use think\facade\Config;
use think\facade\Request;
use think\facade\Session;
use think\Db;
use Auths\Auth;
use Pages\Page;
use Tree\Tree;
use Dir\Dir;

class Webpage extends Common {
	
    private $name;
	
    public function __construct() {
        parent::__construct();
        $this->modelFields(); //获取模型字段
		
    }
    public function index(){
		
		$keyword=input("request.keyword",0);
		$where=array();
        if(!empty($keyword)){
			$where[]=['title','like','%'.urldecode($keyword).'%'];
         }
        $count = Db::name('webpage')->where($where)->count();
		$this->assign('count',$count);
        $obj_page = $this->_Page($count,100);
        $page = $obj_page->newshow();
        $tree = new Tree();
        $tree->icon = array('│ ','├─ ','├─ ');
        $tree->nbsp = '&nbsp;&nbsp;&nbsp;';

        $ary_data = Db::name('webpage')->where($where)->limit($obj_page->firstRow, $obj_page->listRows)->order("sort",'asc')->select();
        $array = array();
        if(!empty($ary_data) && is_array($ary_data)){
            foreach($ary_data as $vl){
				$url=url(SYS_PATH."/webpage/dostatus");
                $vl['str_status'] = '<img class="pointer" data-url="'.$url.'" data-id="'.$vl['id'].'" style="cursor: pointer;" data-field="status" data-value="'.$vl['status'].'" src="/public/admin/default/images/icon_'. ($vl['status'] == 1 ? '1' : '0').'.png" alt="'. ($vl['status'] == 1 ? '启用' : '停用').'" title="'. ($vl['status'] == 1 ? '启用' : '停用').'" />';
                $vl['parentid_node'] = ($vl['pid'])? ' class="child-of-node-'.$vl['pid'].'"' : '';
				$vl['delurl']=url(SYS_PATH."/webpage/doDelete",array("id"=>$vl['id']));
				$vl['editurl']=url(SYS_PATH."/webpage/edit",array("id"=>$vl['id']));						
				if(!empty($vl['image'])){
					$vl['img']="<img src='".$vl['image']."' height='30' />";
				}else{
					$vl['img']="无";	
				}
				$vl['create_time']=date("Y-m-d H:i:s",$vl['create_time']);
				$vl['update_time']=date("Y-m-d H:i:s",$vl['update_time']);
				$array[] = $vl;
            }	
            $str = "<tr id='list_\$id' \$parentid_node>
                        <td style='text-align:center;'>\$id</td>
						<td class='fl'>\$spacer\$title</td>
						<td style='text-align:center;'>\$img</td>
						
						<td  style='text-align:center;'>\$click</td>
						<td  style='text-align:center;'>\$update_time</td>
                        
                        <td  style='text-align:center;'>\$sort</td>
                        
                        <td  style='text-align:center;'>\$str_status</td>
                        <td  style='text-align:center;'>
                            <div class='button-group'>
                                <a href='javascript:void(0);'  data-url='\$editurl' data-width='850px' data-height='500px'  class='dialog edit' alt='编辑' title='编辑'>编缉</a>
                                <a href='javascript:void(0);'  data-url='\$delurl' val='\$id' data-msg='确定要删除吗？' data-acttype='ajax' class='remove del doDel' title='删除'>删除</a>
                            </div>
                        </td>
						<td></td>
                    </tr>";
            
            $tree->init($array);
            $list = $tree->get_tree(0, $str);
            $this->assign('list', $list);
        }
        $this->assign("data", $ary_data);
        $this->assign("page", $page);
		return view();
    }


    
    public function add(){
		if($_POST){
			$this->dosave();
			exit;
		}
        $category = $this->getPageSelect(0);
        $this->assign("category",$category);
        return view('edit');
    }
	
	/*
		添加和编缉保存
	*/
	public function dosave(){
		try{
				$ary_post = input("post.");
				$id=input('request.id',0,'intval');
				$ary_post['content'] = input('post.content','','trim');
				if(isset($ary_post['id'])){
						$ary_result = model("webpage")->allowField(true)->save($ary_post,array('id'=>intval($id)));	
				}else{		
						$ary_result = model("webpage")->allowField(true)->save($ary_post);	
				}
				if(FALSE !== $ary_result){
						JsonDie(1,'操作成功','yes');
				}else{
						JsonDie(1,'操作失败','no');
				}
			}catch (\Exception $e) {
				JsonDie(0,'操作失败'.$e,'no');
			}
	}
    
    
    public function edit(){
		if($_POST){
			$this->dosave();
			exit;
		}
        $id = input('request.id',0,'intval');
        if ($id){
            $ary_data=Db('webpage')->where(array('id'=>$id))->find();
            $category = $this->getPageSelect($id,$ary_data['pid']);
            $this->assign('data',$ary_data);
            $this->assign("category",$category);
           	return view();
        }else{
			JsonDie(0,'请选择需要编辑的对象','no');
        }
    }
	
	
    function getPageSelect($currentid, $selectedid =0, $showzerovalue = 1, $selectname = 'pid'){
        $strHtml = '<select name="' . $selectname . '" class="select rounded">';
        if($showzerovalue){
            $strHtml .= '<option value="0">一级栏目</option>';
        }
        $where =array('status'=>1);
        $ary_category = Db("webpage")->where($where)->order('sort','asc')->select();
        $strHtml .= $this->CateGetOption($ary_category, $currentid, $selectedid);
        $strHtml .= '</select>';
        return $strHtml;
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
				$childCheck=Db("webpage")->where('pid',$id)->count();
				if($childCheck>0){
					JsonDie(0,'该栏目下有子栏目','no');
				}
                $ary_result=Db("webpage")->delete($id);
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
	
	
}
