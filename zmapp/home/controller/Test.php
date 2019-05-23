<?php
namespace app\home\controller;

use think\Db;
use think\Queue;
use think\queue\Job;

class Test{
    public function index(){
        $jobHandlerClassName="app\home\Test\hello";
        $data="qsfsdfsd";
        Queue::push( $jobHandlerClassName , $data , 'hello');
    }

    public function test(){
        try {
            $book = Db::name('chapter')
                ->where('status','neq',1)
                ->field('id,b_id,name,status')
                ->select();
            c_print($book);
        } catch (\Exception $e) {
            return json($e->getMessage());
        }
    }

    /**
     * 测试队列action
     */
    public function actionWithHelloJob(){
        // 1.当前任务将由哪个类来负责处理。
        // 当轮到该任务时，系统将生成一个该类的实例，并调用其 fire 方法
        $jobHandlerClassName  = 'app\home\Test\fire';
        // 2.当前任务归属的队列名称，如果为新队列，会自动创建
        $jobQueueName     = "helloJobQueue";
        // 3.当前任务所需的业务数据 . 不能为 resource 类型，其他类型最终将转化为json形式的字符串
        // ( jobData 为对象时，需要在先在此处手动序列化，否则只存储其public属性的键值对)
        $jobData          = [ 'name' => 'test'.rand(), 'password'=>rand()] ;
        // 4.将该任务推送到消息队列，等待对应的消费者去执行
        $time2wait = strtotime('2019-01-01 00:00:00') - strtotime('now');  // 定时执行
        $isPushed = Queue::later($time2wait, $jobHandlerClassName , $jobData , $jobQueueName );
        // database 驱动时，返回值为 1|false  ;   redis 驱动时，返回值为 随机字符串|false
        if( $isPushed !== false ){
            echo date('Y-m-d H:i:s') . " a new Hello Job is Pushed to the MQ"."<br>";
        }else{
            echo 'Oops, something went wrong.';
        }
    }


    /**
     * fire方法是消息队列默认调用的方法
     * @param Job            $job      当前的任务对象
     * @param array|mixed    $data     发布任务时自定义的数据
     */
    public function fire(Job $job,$data){

        // 如有必要,可以根据业务需求和数据库中的最新数据,判断该任务是否仍有必要执行.
        $isJobStillNeedToBeDone = $this->checkDatabaseToSeeIfJobNeedToBeDone($data);
        if(!$isJobStillNeedToBeDone){
            $job->delete();
            return;
        }
        $isJobDone = $this->doHelloJob($data);

        if ($isJobDone) {
            //如果任务执行成功， 记得删除任务
            $job->delete();
        }else{
            if ($job->attempts() > 3) {
                //通过这个方法可以检查这个任务已经重试了几次了
                $job->delete();
                // 也可以重新发布这个任务
                //$job->release(2); //$delay为延迟时间，表示该任务延迟2秒后再执行
            }
        }
    }

    /**
     * 有些消息在到达消费者时,可能已经不再需要执行了
     * @param array|mixed    $data     发布任务时自定义的数据
     * @return boolean                 任务执行的结果
     */
    private function checkDatabaseToSeeIfJobNeedToBeDone($data){
        return true;
    }

    /**
     * 根据消息中的数据进行实际的业务处理
     * @param array|mixed    $data     发布任务时自定义的数据
     * @return boolean                 任务执行的结果
     */
    private function doHelloJob($data) {
        // 根据消息中的数据进行实际的业务处理...
        // test
        Db::name('product')->insert([
            'title'=>$data['name'],
            'content'=>$data['password']
        ]);
        return true;
    }

}