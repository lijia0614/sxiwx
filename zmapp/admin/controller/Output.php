<?php

namespace app\admin\controller;

use think\Controller;
use think\facade\Config;
use think\facade\Request;
use think\facade\Session;
use think\Db;
use Auths\Auth;
use Pages\Page;
use Dir\Dir;

class Output extends Common {

    public function __construct() {
        parent::__construct();
    }

    /**
     * 落尘
     * 输出接口
     */
    public function luoChen(){
        $list = Db::name('book')
            ->where([
                'status' => 1,
                'is_del' => 0,
                'type' => [1,5],
            ])
            ->field('id,name')
            ->select();
        if ($_POST){
            $this->doSaveLc();
        }
        $outputBookIds = Db::name('output_api')->where('cp_id',1)->field('ids,status')->find();
        $ids = explode(',',$outputBookIds['ids']);
        $this->assign('ids',$ids);
        $this->assign('status',$outputBookIds['status']);
        $this->assign('list',$list);
        return view();
    }

    /**
     * 黑岩
     * 输出接口
     */
    public function heiYan(){
        $list = Db::name('book')
            ->where('type',1)
            ->where('status',1)
            ->where('is_del',0)
            ->field('id,name')
            ->select();
        if ($_POST){
            $this->doSaveHy();
        }
        $outputBookIds = Db::name('output_api')->where('cp_id',2)->field('ids,status')->find();
        $ids = explode(',',$outputBookIds['ids']);
        $this->assign('ids',$ids);
        $this->assign('status',$outputBookIds['status']);
        $this->assign('list',$list);
        return view();
    }


    /**
     * 万维
     * 输出接口
     */
    public function wanWei(){
        $list = Db::name('book')
            ->where('type',1)
            ->where('status',1)
            ->where('is_del',0)
            ->field('id,name')
            ->select();
        if ($_POST){
            $this->doSaveWw();
        }
        $outputBookIds = Db::name('output_api')->where('cp_id',3)->field('ids,status')->find();
        $ids = explode(',',$outputBookIds['ids']);
        $this->assign('ids',$ids);
        $this->assign('status',$outputBookIds['status']);
        $this->assign('list',$list);
        return view();
    }


    /**
     * 快看
     * 输出接口
     */
    public function kuaiKan(){
        $list = Db::name('book')
            ->where('type',1)
            ->where('status',1)
            ->where('is_del',0)
            ->field('id,name')
            ->select();
        if ($_POST){
            $this->doSaveKk();
        }
        $outputBookIds = Db::name('output_api')->where('cp_id',4)->field('ids,status')->find();
        $ids = explode(',',$outputBookIds['ids']);
        $this->assign('ids',$ids);
        $this->assign('status',$outputBookIds['status']);
        $this->assign('list',$list);
        return view();
    }

    /**
     * 追书
     * 输出接口
     */
    public function zhuiShu(){
        $list = Db::name('book')
            ->where(
                [
                    'status' => 1,
                    'is_del' => 0,
                    'type' => [1,2,5,6], // 5是公主书城 6云景
                ]
            )
            ->field('id,name')
            ->select();
        if ($_POST){
            $this->doSaveZs();
        }
        $outputBookIds = Db::name('output_api')->where('cp_id',6)->field('ids,status')->find();
        $ids = explode(',',$outputBookIds['ids']);
        $this->assign('ids',$ids);
        $this->assign('status',$outputBookIds['status']);
        $this->assign('list',$list);
        return view();
    }

    /**
     * 启梦
     * 输出接口
     */
    public function qiMeng(){
        $list = Db::name('book')
            ->where(
                [
                    'status' => 1,
                    'is_del' => 0,
                    'type' => [1,2,4,5,6], // 5是公主书城 6云景
                ]
            )
            ->field('id,name')
            ->select();
        if ($_POST){
            $this->doSaveQm();
        }
        $outputBookIds = Db::name('output_api')->where('cp_id',7)->field('ids,status')->find();
        $ids = explode(',',$outputBookIds['ids']);
        $this->assign('ids',$ids);
        $this->assign('status',$outputBookIds['status']);
        $this->assign('list',$list);
        return view();
    }

    /**
     * 头条
     * 输出接口
     */
        public function touTiao(){
        $list = Db::name('book')
            ->where(
                [
                    'status' => 1,
                    'is_del' => 0,
                    'type' => [1,2,4,5,6], // 5是公主书城 6云景
                ]
            )
            ->field('id,name')
            ->select();
        if ($_POST){
            $this->doSaveTt();
        }
        $outputBookIds = Db::name('output_api')->where('cp_id',5)->field('ids,status')->find();
        $ids = explode(',',$outputBookIds['ids']);
        $this->assign('ids',$ids);
        $this->assign('status',$outputBookIds['status']);
        $this->assign('list',$list);
        return view();
    }

    /**
     * 推宝
     * 输出接口
     */
    public function tuiBao(){
        $list = Db::name('book')
            ->where(
                [
                    'status' => 1,
                    'is_del' => 0,
                    'type' => [1,2,5,6], // 5是公主书城 6云景
                ]
            )
            ->field('id,name')
            ->select();
        if ($_POST){
            $this->doSaveTb();
        }
        $outputBookIds = Db::name('output_api')->where('cp_id',8)->field('ids,status')->find();
        $ids = explode(',',$outputBookIds['ids']);
        $this->assign('ids',$ids);
        $this->assign('status',$outputBookIds['status']);
        $this->assign('list',$list);
        return view();
    }


    /**
     * 掌阅
     * 输出接口
     */
    public function zhangYue(){
        $list = Db::name('book')
            ->where(
                [
                    'status' => 1,
                    'is_del' => 0,
                    'type' => [1,2,5,6], // 5是公主书城 6云景
                ]
            )
            ->field('id,name')
            ->select();
        if ($_POST){
            $this->doSaveZy();
        }
        $outputBookIds = Db::name('output_api')->where('cp_id',9)->field('ids,status')->find();
        $ids = explode(',',$outputBookIds['ids']);
        $this->assign('ids',$ids);
        $this->assign('status',$outputBookIds['status']);
        $this->assign('list',$list);
        return view();
    }


    /**
     * 微阅云
     * 输出接口
     */
    public function weiYueYun(){
        $list = Db::name('book')
            ->where(
                [
                    'status' => 1,
                    'is_del' => 0,
                    'type' => [1,2,5,6], // 5是公主书城 6云景
                ]
            )
            ->field('id,name')
            ->select();
        if ($_POST){
            $this->doSaveWyy();
        }
        $outputBookIds = Db::name('output_api')->where('cp_id',10)->field('ids,status')->find();
        $ids = explode(',',$outputBookIds['ids']);
        $this->assign('ids',$ids);
        $this->assign('status',$outputBookIds['status']);
        $this->assign('list',$list);
        return view();
    }


    /**
     * 米读
     * 输出接口
     */
    public function miDu(){
        $list = Db::name('book')
            ->where(
                [
                    'status' => 1,
                    'is_del' => 0,
                    'type' => [1,2,5,6], // 5是公主书城 6云景
                ]
            )
            ->field('id,name')
            ->select();
        if ($_POST){
            $this->doSaveMd();
        }
        $outputBookIds = Db::name('output_api')->where('cp_id',11)->field('ids,status')->find();
        $ids = explode(',',$outputBookIds['ids']);
        $this->assign('ids',$ids);
        $this->assign('status',$outputBookIds['status']);
        $this->assign('list',$list);
        return view();
    }


    /**
     * 淘小说
     * 输出接口
     */
    public function taoXs(){
        $list = Db::name('book')
            ->where(
                [
                    'status' => 1,
                    'is_del' => 0,
                    'type' => [1,2,5,6], // 5是公主书城 6云景
                ]
            )
            ->field('id,name')
            ->select();
        if ($_POST){
            $this->doSaveTsx();
        }
        $outputBookIds = Db::name('output_api')->where('cp_id',12)->field('ids,status')->find();
        $ids = explode(',',$outputBookIds['ids']);
        $this->assign('ids',$ids);
        $this->assign('status',$outputBookIds['status']);
        $this->assign('list',$list);
        return view();
    }


    /**
     * 落尘
     * 保存接口操作
     */
    public function doSaveLc(){
        $post = input('post.');
        $cp_id = 1; // 落尘
        $data = [
            'ids' => $post['ids'],
            'update_time' => time()
        ];
        $check = Db::name('output_api')->where('cp_id',$cp_id)->find();
        if ($check){
            $res = Db::name('output_api')->where('cp_id',$cp_id)->update($data);
        }else{
            $data['cp_id'] = $cp_id;
            $res = Db::name('output_api')->insert($data);
        }
        if ($res){
            $this->success('操作成功');
        }else{
            $this->error('操作失败');
        }
    }

    /**
     * 黑岩
     * 保存接口操作
     */
    public function doSaveHy(){
        $post = input('post.');
        $cp_id = 2; // 黑岩
        $data = [
            'ids' => $post['ids'],
            'update_time' => time()
        ];
        $check = Db::name('output_api')->where('cp_id',$cp_id)->find();
        if ($check){
            $res = Db::name('output_api')->where('cp_id',$cp_id)->update($data);
        }else{
            $data['cp_id'] = $cp_id;
            $res = Db::name('output_api')->insert($data);
        }
        if ($res){
            $this->success('操作成功');
        }else{
            $this->error('操作失败');
        }
    }

    /**
     * 万维
     * 保存接口操作
     */
    public function doSaveWw(){
        $post = input('post.');
        $cp_id = 3; // 万维
        $data = [
            'ids' => $post['ids'],
            'update_time' => time()
        ];
        $check = Db::name('output_api')->where('cp_id',$cp_id)->find();
        if ($check){
            $res = Db::name('output_api')->where('cp_id',$cp_id)->update($data);
        }else{
            $data['cp_id'] = $cp_id;
            $res = Db::name('output_api')->insert($data);
        }
        if ($res){
            $this->success('操作成功');
        }else{
            $this->error('操作失败');
        }
    }

    /**
     * 快看
     * 保存接口操作
     */
    public function doSaveKk(){
        $post = input('post.');
        $cp_id = 4; // 快看
        $data = [
            'ids' => $post['ids'],
            'update_time' => time()
        ];
        $check = Db::name('output_api')->where('cp_id',$cp_id)->find();
        if ($check){
            $res = Db::name('output_api')->where('cp_id',$cp_id)->update($data);
        }else{
            $data['cp_id'] = $cp_id;
            $res = Db::name('output_api')->insert($data);
        }
        if ($res){
            $this->success('操作成功');
        }else{
            $this->error('操作失败');
        }
    }

    /**
     * 追书
     * 保存接口操作
     */
    public function doSaveZs(){
        $post = input('post.');
        $cp_id = 6; // 追书
        $data = [
            'ids' => $post['ids'],
            'update_time' => time()
        ];
        $check = Db::name('output_api')->where('cp_id',$cp_id)->find();
        if ($check){
            $res = Db::name('output_api')->where('cp_id',$cp_id)->update($data);
        }else{
            $data['cp_id'] = $cp_id;
            $res = Db::name('output_api')->insert($data);
        }
        if ($res){
            $this->success('操作成功');
        }else{
            $this->error('操作失败');
        }
    }


    /**
     * 启梦
     * 保存接口操作
     */
    public function doSaveQm(){
        $post = input('post.');
        $cp_id = 7; // 追书
        $data = [
            'ids' => $post['ids'],
            'update_time' => time()
        ];
        $check = Db::name('output_api')->where('cp_id',$cp_id)->find();
        if ($check){
            $res = Db::name('output_api')->where('cp_id',$cp_id)->update($data);
        }else{
            $data['cp_id'] = $cp_id;
            $res = Db::name('output_api')->insert($data);
        }
        if ($res){
            $this->success('操作成功');
        }else{
            $this->error('操作失败');
        }
    }


    /**
     * 头条
     * 保存接口操作
     */
    public function doSaveTt(){
        $post = input('post.');
        $cp_id = 5; // 头条
        $data = [
            'ids' => $post['ids'],
            'update_time' => time()
        ];
        $check = Db::name('output_api')->where('cp_id',$cp_id)->find();
        if ($check){
            $res = Db::name('output_api')->where('cp_id',$cp_id)->update($data);
        }else{
            $data['cp_id'] = $cp_id;
            $res = Db::name('output_api')->insert($data);
        }
        if ($res){
            $this->success('操作成功');
        }else{
            $this->error('操作失败');
        }
    }

    /**
     * 推宝
     * 保存接口操作
     */
    public function doSaveTb(){
        $post = input('post.');
        $cp_id = 8;
        $data = [
            'ids' => $post['ids'],
            'update_time' => time()
        ];
        $check = Db::name('output_api')->where('cp_id',$cp_id)->find();
        if ($check){
            $res = Db::name('output_api')->where('cp_id',$cp_id)->update($data);
        }else{
            $data['cp_id'] = $cp_id;
            $res = Db::name('output_api')->insert($data);
        }
        if ($res){
            $this->success('操作成功');
        }else{
            $this->error('操作失败');
        }
    }


    /**
     * 掌阅
     * 保存接口操作
     */
    public function doSaveZy(){
        $post = input('post.');
        $cp_id = 9;
        $data = [
            'ids' => $post['ids'],
            'update_time' => time()
        ];
        $check = Db::name('output_api')->where('cp_id',$cp_id)->find();
        if ($check){
            $res = Db::name('output_api')->where('cp_id',$cp_id)->update($data);
        }else{
            $data['cp_id'] = $cp_id;
            $res = Db::name('output_api')->insert($data);
        }
        if ($res){
            $this->success('操作成功');
        }else{
            $this->error('操作失败');
        }
    }


    /**
     * 微阅云
     * 保存接口操作
     */
    public function doSaveWyy(){
        $post = input('post.');
        $cp_id = 10;
        $data = [
            'ids' => $post['ids'],
            'update_time' => time()
        ];
        $check = Db::name('output_api')->where('cp_id',$cp_id)->find();
        if ($check){
            $res = Db::name('output_api')->where('cp_id',$cp_id)->update($data);
        }else{
            $data['cp_id'] = $cp_id;
            $res = Db::name('output_api')->insert($data);
        }
        if ($res){
            $this->success('操作成功');
        }else{
            $this->error('操作失败');
        }
    }

    /**
     * 米读
     * 保存接口操作
     */
    public function doSaveMd(){
        $post = input('post.');
        $cp_id = 11;
        $data = [
            'ids' => $post['ids'],
            'update_time' => time()
        ];
        $check = Db::name('output_api')->where('cp_id',$cp_id)->find();
        if ($check){
            $res = Db::name('output_api')->where('cp_id',$cp_id)->update($data);
        }else{
            $data['cp_id'] = $cp_id;
            $res = Db::name('output_api')->insert($data);
        }
        if ($res){
            $this->success('操作成功');
        }else{
            $this->error('操作失败');
        }
    }


    /**
     * 淘小说
     * 保存接口操作
     */
    public function doSaveTsx(){
        $post = input('post.');
        $cp_id = 12;
        $data = [
            'ids' => $post['ids'],
            'update_time' => time()
        ];
        $check = Db::name('output_api')->where('cp_id',$cp_id)->find();
        if ($check){
            $res = Db::name('output_api')->where('cp_id',$cp_id)->update($data);
        }else{
            $data['cp_id'] = $cp_id;
            $res = Db::name('output_api')->insert($data);
        }
        if ($res){
            $this->success('操作成功');
        }else{
            $this->error('操作失败');
        }
    }


    /**
     * 落尘
     * 修改接口状态
     */
    public function editStatus(){
        $status = input('post.status','','intval');
        $data = [
            'status' => $status,
            'update_time' => time()
        ];
        $res = Db::name('output_api')->where('cp_id',1)->update($data);
        if ($res){
            if ($status == 1){
                $this->success('接口开启成功！');
            }else{
                $this->success('接口关闭成功');
            }
        }else{
            $this->error('没有改变状态');
        }
    }

    /**
     * 黑岩
     * 修改接口状态
     */
    public function editStatusHy(){
        $status = input('post.status','','intval');
        $data = [
            'status' => $status,
            'update_time' => time()
        ];
        $res = Db::name('output_api')->where('cp_id',2)->update($data);
        if ($res){
            if ($status == 1){
                $this->success('接口开启成功！');
            }else{
                $this->success('接口关闭成功');
            }
        }else{
            $this->error('没有改变状态');
        }
    }


    /**
     * 修改接口状态
     */
    public function editStatusWw(){
        $status = input('post.status','','intval');
        $data = [
            'status' => $status,
            'update_time' => time()
        ];
        $res = Db::name('output_api')->where('cp_id',3)->update($data);
        if ($res){
            if ($status == 1){
                $this->success('接口开启成功！');
            }else{
                $this->success('接口关闭成功');
            }
        }else{
            $this->error('没有改变状态');
        }
    }

    /**
     * 修改接口状态
     */
    public function editStatusKk(){
        $status = input('post.status','','intval');
        $data = [
            'status' => $status,
            'update_time' => time()
        ];
        $res = Db::name('output_api')->where('cp_id',4)->update($data);
        if ($res){
            if ($status == 1){
                $this->success('接口开启成功！');
            }else{
                $this->success('接口关闭成功');
            }
        }else{
            $this->error('没有改变状态');
        }
    }


    /**
     * 修改接口状态
     */
    public function editStatusZs(){
        $status = input('post.status','','intval');
        $data = [
            'status' => $status,
            'update_time' => time()
        ];
        $res = Db::name('output_api')->where('cp_id',6)->update($data);
        if ($res){
            if ($status == 1){
                $this->success('接口开启成功！');
            }else{
                $this->success('接口关闭成功');
            }
        }else{
            $this->error('没有改变状态');
        }
    }


    /**
     * 修改接口状态
     */
    public function editStatusQm(){
        $status = input('post.status','','intval');
        $data = [
            'status' => $status,
            'update_time' => time()
        ];
        $res = Db::name('output_api')->where('cp_id',7)->update($data);
        if ($res){
            if ($status == 1){
                $this->success('接口开启成功！');
            }else{
                $this->success('接口关闭成功');
            }
        }else{
            $this->error('没有改变状态');
        }
    }


    /**
     * 头条
     * 修改接口状态
     */
    public function editStatusTt(){
        $status = input('post.status','','intval');
        $data = [
            'status' => $status,
            'update_time' => time()
        ];
        $res = Db::name('output_api')->where('cp_id',5)->update($data);
        if ($res){
            if ($status == 1){
                $this->success('接口开启成功！');
            }else{
                $this->success('接口关闭成功');
            }
        }else{
            $this->error('没有改变状态');
        }
    }


    /**
     * 推宝
     * 修改接口状态
     */
    public function editStatusTb(){
        $status = input('post.status','','intval');
        $data = [
            'status' => $status,
            'update_time' => time()
        ];
        $res = Db::name('output_api')->where('cp_id',8)->update($data);
        if ($res){
            if ($status == 1){
                $this->success('接口开启成功！');
            }else{
                $this->success('接口关闭成功');
            }
        }else{
            $this->error('没有改变状态');
        }
    }

    /**
     * 掌阅
     * 修改接口状态
     */
    public function editStatusZy(){
        $status = input('post.status','','intval');
        $data = [
            'status' => $status,
            'update_time' => time()
        ];
        $res = Db::name('output_api')->where('cp_id',9)->update($data);
        if ($res){
            if ($status == 1){
                $this->success('接口开启成功！');
            }else{
                $this->success('接口关闭成功');
            }
        }else{
            $this->error('没有改变状态');
        }
    }

    /**
     * 掌阅
     * 修改接口状态
     */
    public function editStatusWyy(){
        $status = input('post.status','','intval');
        $data = [
            'status' => $status,
            'update_time' => time()
        ];
        $res = Db::name('output_api')->where('cp_id',10)->update($data);
        if ($res){
            if ($status == 1){
                $this->success('接口开启成功！');
            }else{
                $this->success('接口关闭成功');
            }
        }else{
            $this->error('没有改变状态');
        }
    }

    /**
     * 米读
     * 修改接口状态
     */
    public function editStatusMd(){
        $status = input('post.status','','intval');
        $data = [
            'status' => $status,
            'update_time' => time()
        ];
        $res = Db::name('output_api')->where('cp_id',11)->update($data);
        if ($res){
            if ($status == 1){
                $this->success('接口开启成功！');
            }else{
                $this->success('接口关闭成功');
            }
        }else{
            $this->error('没有改变状态');
        }
    }


    /**
     * 淘小说
     * 修改接口状态
     */
    public function editStatusTxs(){
        $status = input('post.status','','intval');
        $data = [
            'status' => $status,
            'update_time' => time()
        ];
        $res = Db::name('output_api')->where('cp_id',12)->update($data);
        if ($res){
            if ($status == 1){
                $this->success('接口开启成功！');
            }else{
                $this->success('接口关闭成功');
            }
        }else{
            $this->error('没有改变状态');
        }
    }
}










