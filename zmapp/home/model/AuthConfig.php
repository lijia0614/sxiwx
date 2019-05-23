<?php
namespace app\home\Model;
use think\Model;
/**
 * 第三方登录插件模型
 * @version 1.0
 * @author 四川挚梦科技有限公司
 * @date 2018-3-17
 */
class AuthConfig extends Model{
	
	protected $resultSetType = 'collection';
    //模型初始化
    protected function initialize()
    {
        parent::initialize();
    }	
	
  	/**
     * 读取指定三方登录配置
     * @author 四川挚梦科技有限公司
     * @date 2018-3-25
     * @return array
     */
    public function getConfig($module){
		try{
			$result=$this->where('module', $module)->find();		
			$data=$result->toArray();
			if($data['status']){
				return json_decode($data['value'],true);
			}
            $this->error = '不存在或被禁用';
            return 0;
		}catch (\Exception $e) {
            $this->error = $e;
            return 0;
        }
    }   
	
	
    
}