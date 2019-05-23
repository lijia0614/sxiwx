<?php

/**
 * 有书网
 * 书籍输出接口
 */

namespace app\home\controller;

use think\Db;
use think\Json;

class Getbooks extends Common {

    public function __construct() {
        parent::__construct();
    }

    /**
     * 获取授权图书的id列表
     */
    public function index(){
        $cip = input('get.cip','','intval');

        if ($cip != 6){
            c_json(0, 'cip is error', '');
        }
        $books = Db::name('book')
            ->where('id','in','93,83,94,79,68,53,52,51,50,42,40,78,108')
            ->field('id as articleid,name as articlename')
            ->select();
        if ($books){
            c_json(200, 'success', $books);
        }else{
            c_json(0, 'error', '');
        }
    }

    /**
     * 获取图书信息
     */
    public function bookInfo(){
        // GET http://xxx.xxx.com?aid=1
        $url = $_SERVER['SERVER_NAME'];

        $id = input('get.aid','','intval');
        if (!$id){
            c_json(0, 'aid is error', '');
        }
        $book =  Db::name('book')
            ->where('is_del',0)
            ->where('status',1)
            ->where('id',$id)
            ->field('id,name as articlename,author,info as intro,image,is_end as fullflag,cid')
            ->find();

        $last = Db::name('chapter')
            ->where('b_id',$id)
            ->field('time,name')
            ->order('id desc')
            ->limit(1)
            ->find();
        switch ($book['cid']){
            case 15:
            case 19:
            case 7:
                $book['sex_type'] = 0;
                break;
            default:
                $book['sex_type'] = 1;
                break;
        }
        switch ($book['cid']){
            case 19:
                $book['Sortid'] = 8;
                break;
            case 11:
            case 8:
            case 7:
                $book['Sortid'] = 1;
                break;
            default:
                $book['Sortid'] = 3;
                break;
        }
        $book['lastupdate'] = $last['time'];
        $book['cover'] = $url.$book['image'];
        unset($book['image']);
        unset($book['cid']);
        if ($book){
            c_json(200, 'success', $book);
        }else{
            c_json(0, 'error', '');
        }
    }

    /**
     * 获取章节list
     */
    public function getChapters(){
        $id = input('get.aid','','intval');
        if (!$id){
            c_json(0, 'aid is error', '');
        }
        $chapters = Db::name('chapter')
            ->where('b_id',$id)
            ->where('is_del',0)
            ->where('status',1)
            ->field('id as chapterId,name as chaptername,time as lastupdate,content')
            ->order('id asc')
            ->select();
        foreach ($chapters as $k=>$v){
            $chapters[$k]['words'] = mb_strlen(DeleteHtml(strip_tags($v['content'])));
            unset($chapters[$k]['content']);
        }

        if ($chapters){
            c_json(200, 'success', $chapters);
        }else{
            c_json(0, 'error', '');
        }
    }

    /**
     * 获取章节内容
     */
    public function ChapterInfo(){
        // GET http://xxx.xxx.com?aid=1&cid=1
        $b_id = input('get.aid','','intval');
        $id = input('get.cid','','intval');
        if (!$id){
            c_json(0, 'cid is error', '');
        }
        if (!$b_id){
            c_json(0, 'aid is error', '');
        }
        $chapter = Db::name('chapter')
            ->where('b_id',$b_id)
            ->where('id',$id)
            ->field('b_id as articleid,name as chaptername,time as lastupdate,content')
            ->find();
        $chapter['words'] = mb_strlen(DeleteHtml(strip_tags($chapter['content'])));
        if ($chapter){
            c_json(200, 'success', $chapter);
        }else{
            c_json(0, 'error', '');
        }
    }
}



