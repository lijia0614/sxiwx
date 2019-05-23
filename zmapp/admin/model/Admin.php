<?php
namespace app\admin\model;
use think\Model;
/**
 * 管理员表模型
 * @package Model
 * @version 1.0
 * @author 四川挚梦科技有限公司
 * @date 2018-3-17
 */
class Admin extends Common{
	
	protected $resultSetType = 'collection';
	protected $pk = 'u_id';//定义主键
    //模型初始化
    protected function initialize()
    {
        parent::initialize();
    }	
	
    public function adminSave($u_id,$postdata){
    	$find = $this->where(array('u_id'=>$u_id))->find();
    	if($find){
			return $this->allowField(true)->save($postdata,array('u_id'=>$u_id));
    	}else{
			return $this->allowField(true)->save($postdata);
		}
		
    }	
	
    
}