<?php
namespace app\admin\model;
use think\Model;
/**
 * 操作日志模型
 * @package Model
 * @version 1.0
 * @author 四川挚梦科技有限公司
 * @date 2018-3-17
 */
class OperationLog extends Model{
	
	protected $resultSetType = 'collection';
    //模型初始化
    protected function initialize()
    {
        parent::initialize();
    }
}