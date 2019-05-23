<?php
namespace app\admin\model;
use think\Model;
/**
 * 短信接口模型
 * @package Model
 * @version 1.0
 * @author 四川挚梦科技有限公司
 * @date 2018-3-17
 */
class Sms extends Common{
	
	protected $resultSetType = 'collection';
    //模型初始化
    protected function initialize()
    {
        parent::initialize();
    }	
	
	

    /**
     * 保存支付方式
     * @author billow.wang<admin@ivears.com>
     * @date 2015-05-14
     * @param string $alias 别名
     * @param string $status 启用状态
     * @param string $value 详情配置
     */
    public function smsSave($alias,$value){
    	$find = $this->where(array('alias'=>$alias))->find();
    	if($find){
    		$data = array(
    			'value' => $value,
    			'update_time' => time()
    		);
			return $this->allowField(true)->save($data,array('alias'=>$alias));
    	}else{
    		$data = array(
    			'value' => $value,
    			'update_time' => time()
    		);
			return $this->allowField(true)->save($data);
    	}
    }	
	
	

	
	
    
}