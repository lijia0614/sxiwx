<?php

namespace app\admin\model;

use think\Model;
use think\facade\Session;

/**
 * 公共控制模型配置
 * @package Model
 * @version 1.0
 * @author 四川挚梦科技有限公司
 * @date 2018-3-22
 */
class Common extends Model {

    protected $resultSetType = 'collection';
    protected $dateFormat = 'Y-m-d H:i:s';
	protected $autoWriteTimestamp = true;
    protected $type = [
        'start_time'    =>  'timestamp',
        'end_time'    =>  'timestamp',
        'create_time'  =>  'timestamp',
		'end_time'  =>  'timestamp'
    ];
    //模型初始化
    protected function initialize() {
        parent::initialize();
    }

    /**
     * 记录操作日志
     * @author 四川挚梦科技有限公司
     * @date 2018-04-08
     */
    protected static function init() {
        /**
         * 新增数据记录日志
         * @author billow.wang<admin@ivears.com>
         * @date 2015-05-14
         * @param string $id id唯一标识
         * @param array $postData 保存的数据数组
         */
        self::afterInsert(function($result) {
            $session = Session::get();
            $uid = $session[config("auth.USER_AUTH_KEY")]['u_id']; //操作用户id              
            $OperationLog = OperationLog::create(array(
                        'user_id' => $uid,
                        'controller' => CONTROLLER,
                        'remark' => $result,
                        'action' => 'add',
                        'action_time' => time()
            ));
        });
        /**
         * 删除数据记录日志
         * @author billow.wang<admin@ivears.com>
         * @date 2015-05-14
         * @param string $id id唯一标识
         * @param array $postData 保存的数据数组
         */
        self::afterDelete(function($result) {
            $session = Session::get();
            $uid = $session[config("auth.USER_AUTH_KEY")]['u_id']; //操作用户id              
            $OperationLog = OperationLog::create(array(
                        'user_id' => $uid,
                        'remark' => $result,
                        'controller' => CONTROLLER,
                        'action' => 'delete',
                        'action_time' => time()
            ));
        });
        /**
         * 修改数据记录日志
         * @author billow.wang<admin@ivears.com>
         * @date 2015-05-14
         * @param string $id id唯一标识
         * @param array $postData 保存的数据数组
         */
        self::afterUpdate(function($result) {
            $session = Session::get();
            $uid = $session[config("auth.USER_AUTH_KEY")]['u_id']; //操作用户id              
            $OperationLog = OperationLog::create(array(
                        'user_id' => $uid,
                        'remark' => $result,
                        'controller' => CONTROLLER,
                        'action' => 'update',
                        'action_time' => time()
            ));
        });
    }

    public function category() {
        return $this->hasOne('category', 'cid');
    }

    /**
     * 通用保存方法
     * @author billow.wang<admin@ivears.com>
     * @date 2015-05-14
     * @param string $id id唯一标识
     * @param array $postData 保存的数据数组
     */
    public function dataSave($id, $postData) {
        if ($id) {
            return $this->allowField(true)->save($postData, array('id' => $id));
        } else {
            return $this->allowField(true)->save($postData);
        }
    }

}
