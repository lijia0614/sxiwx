<?php
namespace app\admin\model;
use think\Model;
/**
 * 整站配置模型
 * @package Model
 * @version 1.0
 * @author 四川挚梦科技有限公司
 * @date 2018-3-17
 */
class Config extends Common{
	
	protected $resultSetType = 'collection';
    //模型初始化
    protected function initialize()
    {
        parent::initialize();
    }	
	
  	/**
     * 从系统配置表中取出模块相关配置
     * @author 四川挚梦科技有限公司
     * @date 2018-3-25
     * @return array
     */
    public function getCfgByModule($module_name){
		
		$result=$this->where('c_key', $module_name)->select();		
		$data=$result->toArray();
		$return = array();
        foreach($data as $v){
            $return[$v['c_key']] = $v['c_value'];
        }
        return $return;
    }
    
    /**
     * 保存配置
     * @author billow.wang<admin@ivears.com>
     * @date 2015-05-14
     * @param string $key 配置项
     * @param string $value 配置值
     * @param string $desc 配置项描述，为空则不修改描述。修改配置项时一般不用修改描述的
     */
    public function setConfig($key,$value,$desc='',$ctype='system',$status=1){
    	$cfg = $this->where(array('c_key'=>$key))->find();
    	if($cfg){
    		$data = array(
    			'c_key' => $key,
    			'c_value' => $value,
    			'c_value_desc' => $desc,
				'c_type'=>$ctype,
				'status'=>$status,
    			'c_update_time' => time()
    		);
            if(empty($desc)){
                unset($data['c_value_desc']);
            }
			return $this->allowField(true)->save($data,array('id'=>intval($cfg['id'])));
    	}else{
    		$data = array(
    			'c_key' => $key,
    			'c_value' => $value,
    			'c_value_desc' => $desc,
				'c_type'=>$ctype,
				'status'=>$status,
    			'c_create_time' => time(),
				'c_update_time' => time()
    		);
            if(empty($desc)){
                unset($data['c_value_desc']);
            }
			return $this->allowField(true)->save($data);
    	}
    }
    /**
     * 获取上传设置
     * @author billow.wang<admin@ivears.com>
     */
	public function getImgSet(){
		$list=$this->where("c_type",'imgset')->select()->toArray();
		if($list){
			foreach($list as $key=>$one){
				$list[$key]['data']	=json_decode($one['c_value'],true);
			}	
		}
		return $list;
		
	}
    /**
     * 获取验证码设置
     * @author billow.wang<admin@ivears.com>
     */
    public function getCodeSet(){
        $list=$this->where("c_type",'codeset')->select()->toArray();
        if($list){
            foreach($list as $key=>$one){
                $list[$key]['data']	=json_decode($one['c_value'],true);
            }
        }
        return $list;

    }

	
	
    
}