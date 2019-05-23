<?php
namespace app\admin\model;
use think\Model;
/**
 * 第三方登录插件模型
 * @package Model
 * @version 1.0
 * @author 四川挚梦科技有限公司
 * @date 2018-04-18
 */
class AuthConfig extends Common{
	
	protected $resultSetType = 'collection';
    protected $dateFormat = 'Y-m-d H:i:s';
	protected $autoWriteTimestamp = true;
    protected $type = array(
        'start_time'    =>  'timestamp',
        'end_time'    =>  'timestamp',
        'create_time'  =>  'timestamp',
		'end_time'  =>  'timestamp'
    );
    //模型初始化
    protected function initialize()
    {
        parent::initialize();
    }		
	
    /**
     * 保存
     * @author billow.wang<admin@ivears.com>
     * @date 2015-05-14
     * @param string $alias 别名
     * @param string $status 启用状态
     * @param string $value 详情配置
     */
    public function authsSave($module,$value,$status=0){
    	$find = $this->where(array('module'=>$module))->find();
    	if($find){
    		$data = array(
    			'value' => $value,
				'status'=>$status,
    			'update_time' => time()
    		);
			return $this->allowField(true)->save($data,array('module'=>$module));
    	}else{
    		$data = array(
    			'value' => $value,
				'status'=>$status,
    			'update_time' => time()
    		);
			return $this->allowField(true)->save($data);
    	}
    }			
	
}