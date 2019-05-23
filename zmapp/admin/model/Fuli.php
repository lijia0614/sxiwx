<?php
namespace app\admin\model;
use think\Model;
class Fuli extends Common{

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