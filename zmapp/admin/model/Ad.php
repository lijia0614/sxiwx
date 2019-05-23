<?php
namespace app\admin\model;
use think\Model;
/**
 * 广告模型
 * @package Model
 * @version 1.0
 * @author 四川挚梦科技有限公司
 * @date 2018-3-17
 */
class Ad extends Common{
	
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
	
}