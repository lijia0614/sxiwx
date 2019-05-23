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

class Api extends Common {

    public function __construct() {
        parent::__construct();
    }

    /**
     * 编缉多图上传
     * @author 四川挚梦科技有限公司
     * @date 2016-02-06
     */
    public function multiImages() {
        $module=input("request.module",0,'trim');//获取模块名
		$module_id=input("request.module_id",0,'trim');//获取模块的id
		$fileds_name=input("request.fileds_name",0,'trim');//获取模块的字段名
        $images = Db("images")->where("module",ucfirst($module))->where("module_id",$module_id)->where("fileds_name",$fileds_name)->order('id','asc')->select();
		$data=array();
		foreach($images as $key=>$one){
			$data[]=array("image"=>$one['image']);
		}
        $this->assign("list", $images);
		$html=$this->fetch();
		$result=array('data'=>$data,'html'=>$html);
		die(json_encode($result));
    }

  

}
