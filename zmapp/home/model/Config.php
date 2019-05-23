<?php
namespace app\home\Model;
use think\Model;
/**
 * 整站配置模型
 * @package Model
 * @version 1.0
 * @author 四川挚梦科技有限公司
 * @date 2018-3-17
 */
class Config extends Model{
	
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
	
    public function getCategoryid($pid) {
        $arrid[] = $pid;
        $arrid = $this->getCategoryCid($pid, $arrid);
        return $arrid;
    }

    public function getCategoryCid($cid, &$arrid) {
        $where = array('pid' => $cid);
        $ary_data = Db::name('category')->where($where)->select();
        if ($ary_data) {
            foreach ($ary_data as $key => $one) {
                $arrid[] = $one['id'];
                $this->getCategoryCid($one['id'], $arrid);
            }
        }
        return $arrid;
    }	
	
	
    
}