<?php
namespace app\admin\controller;

use think\Controller;
use think\facade\Config;
use think\facade\Request;
use think\facade\Session;
use think\Db;
use app\common\controller\AppCommon;
use app\admin\model\AuthConfig as AuthConfig;
use Auths\Auth;
use Pages\Page;
use Dir\Dir;

class Auths extends Common
{
	
    public function __construct(){
		parent::__construct();	
    }	
	
    public function index()
    {
        $ary_get['pageall'] = input("request.pageall",10,'intval');
        $count = Db("auth_config")->count();
		$this->assign("count",$count);
        $obj_page = $this->_Page($count, $ary_get['pageall']);
        $page = $obj_page->newshow();
        $ary_data = Db("auth_config")->select();
        $this->assign("list",$ary_data);
        $this->assign("filter",$ary_get);
        $this->assign("page",$page);		
		return view();
    }
	
    public function _empty() {
		if($_POST){
			$this->doSave(ACTION);	
		}
		$auth_config=db("auth_config")->where('module',ACTION)->find();
		if($auth_config){
			$this->assign("data",json_decode($auth_config['value'],true));
			$this->assign("status",$auth_config['status']);
		}
        $path = config("template.view_path") . strtolower(CONTROLLER) . "/" . strtolower(ACTION) . "." . config("template.view_suffix");
        if (file_exists($path)) {
            return view();
        } else {
            $path = config("template.view_path") . "public/" . strtolower(ACTION) . "." . config("template.view_suffix");
            return view($path);
        }
    }	
	
	
    
    /**
     * 保存登录参数配置
     * @author 四川挚梦科技有限公司
     * @date 2017-01-09
     */
    public function doSave($module) {
        try {
            $ary_post = input("post.");
			$status=$ary_post['status'];
            unset($ary_post['status']);
            unset($ary_post['dialogid']);
            unset($ary_post['dosubmit']);
            $value = json_encode($ary_post);
            $AuthConfig = new AuthConfig();
            $ary_result = $AuthConfig->authsSave($module, $value,$status);
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
     * 删除
     * @author billow.wang
     * @date 2015-3-29
     */
    public function doDelete(){
		try{
				
        	$data = input("request.");
			if(!isset($data['id'])){
					JsonDie(0,'请选择要删除的数据','yes');	
			}
			$ids=$data['id'];
			$model = model("AuthConfig");
			$ary_result = $model->destroy($ids);
			if(FALSE !== $ary_result){
						JsonDie(1,'删除成功','yes');
			}
			JsonDie(0,'删除失败','no');
			
		}catch (\Exception $e) {
				JsonDie(0,'操作失败'.$e,'yes');
		}
    }	
	
    /**
     * 通用更改状态,1为启用，0为禁用
     * @author四川挚梦科技有限公司
     * @date 2017-01-12
     */		
	public function dostatus(){
		try{
			$id=input("request.id",0,"intval");
			$value=input("request.value",0,"intval");
			if(!$id){JsonDie('0',"参数错误",'yes');	}
			if($value==0){
				$data=array('status'=>1);	
			}else{
				$data=array('status'=>0);	
			}
			
			$ary_result = model('AuthConfig')->allowField(true)->save($data,array('id'=>$id));	
			if($ary_result){
				JsonDie('1',"操作成功",'yes');
			}else{
				JsonDie('0',"操作失败",'no');	
			}
		}catch (\Exception $e) {
				JsonDie(0,'操作失败'.$e,'no');
		}
	}	
	
	
	
}
