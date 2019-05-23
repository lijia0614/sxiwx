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
use app\admin\model\AdPostion;
use app\admin\model\Ad as AdModel;

class Welfare extends Common {

    public function __construct() {
        parent::__construct();
    }

    /**
     * 签约模式
     */
    public function mode(){
        $data = Db::name('fuli')
            ->where('type',1)
            ->find();
        $this->assign('data',$data);
        return view();
    }

    /**
     * 新书签约
     */
    public function newBook(){
        $data = Db::name('fuli')
            ->where('type',2)
            ->find();
        $this->assign('data',$data);
        return view();
    }

    /**
     * 完本续签
     */
    public function keep(){
        $data = Db::name('fuli')
            ->where('type',3)
            ->find();
        $this->assign('data',$data);
        return view();
    }

    /**
     * 第三方平台收入增值
     */
    public function others(){
        $data = Db::name('fuli')
            ->where('type',4)
            ->find();
        $this->assign('data',$data);
        return view();
    }

    /**
     * 衍生推荐
     */
    public function recommend(){
        $data = Db::name('fuli')
            ->where('type',5)
            ->find();
        $this->assign('data',$data);
        return view();
    }

    public function edit(){
        if ($_POST){
            $this->doSave();
            exit();
        }
        $id = input('get.id');
        $data = Db::name('fuli')
            ->where('id',$id)
            ->find();
        $this->assign('id',$id);
        $this->assign('data',$data);
        return view();
    }

    public function doSave(){
        $post = input('post.');
        $id = input('post.id');
        $data = [
            'title' => $post['title'],
            'image' => $post['image'],
            'content' => $post['content']
        ];
        $res = Db::name('fuli')->where('id',$id)->update($data);
        if (FALSE !== $res) {
            JsonDie(1, '操作成功', 'yes');
        } else {
            JsonDie(1, '操作失败', 'no');
        }
    }

    /**
     * 签约模式的模式管理
     */
    public function mosi(){
        $data = Db::name('mosi_c')->where('status',1)->select();
        $this->assign('data',$data);
        return view();
    }

    public function addMosi(){
        if ($_POST){
            $post = input('post.');
            $data = [
                'title' => $post['title'],
                'content' => $post['content'],
                'image' => $post['image'],
                'type' => $post['type']
            ];
            $res = Db::name('mosi_c')->insert($data);
            if (FALSE !== $res) {
                JsonDie(1, '操作成功', 'yes');
            } else {
                JsonDie(1, '操作失败', 'no');
            }
        }
        return view();
    }

    public function delMosi(){
        $id = input('get.id');
        $res = Db::name('mosi_c')->where('id',$id)->delete();
        if (FALSE !== $res) {
            JsonDie(1, '操作成功', 'yes');
        } else {
            JsonDie(1, '操作失败', 'no');
        }
    }

    public function mosiEdit(){
        if ($_POST){
            $post = input('post.');
            $id = input('post.id');
            $data = [
                'title' => $post['title'],
                'content' => $post['content'],
                'image' => $post['image'],
                'type' => $post['type']
            ];
            $res = Db::name('mosi_c')->where('id',$id)->update($data);
            if (FALSE !== $res) {
                JsonDie(1, '操作成功', 'yes');
            } else {
                JsonDie(1, '操作失败', 'no');
            }
        }
        $id = input('get.id');
        $data = Db::name('mosi_c')->where('id',$id)->find();
        $this->assign('data',$data);
        return view();
    }


    /**
     * 完本续约类型
     */
    public function keepC(){
        $data = Db::name('keep_c')->where('status',1)->select();
        $this->assign('data',$data);
        return view();
    }

    public function addKeep(){
        if ($_POST){
            $post = input('post.');
            $data = [
                'title' => $post['title'],
                'info' => $post['info'],
                'type' => 2
            ];
            $res = Db::name('keep_c')->insert($data);
            if (FALSE !== $res) {
                JsonDie(1, '操作成功', 'yes');
            } else {
                JsonDie(1, '操作失败', 'no');
            }
        }
        return view();
    }

    public function keepEdit(){
        if ($_POST){
            $post = input('post.');
            $id = input('post.id');
            $data = [
                'title' => $post['title'],
                'info' => $post['info']
            ];
            $res = Db::name('keep_c')->where('id',$id)->update($data);
            if (FALSE !== $res) {
                JsonDie(1, '操作成功', 'yes');
            } else {
                JsonDie(1, '操作失败', 'no');
            }
        }
        $id = input('get.id');
        $data = Db::name('keep_c')->where('id',$id)->find();
        $this->assign('data',$data);
        return view();
    }

    public function delkeep(){
        $id = input('get.id');
        $res = Db::name('keep_c')->where('id',$id)->delete();
        if (FALSE !== $res) {
            JsonDie(1, '操作成功', 'yes');
        } else {
            JsonDie(1, '操作失败', 'no');
        }
    }

}
