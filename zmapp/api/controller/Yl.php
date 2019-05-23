<?php

/**
 * 优量
 * 书籍输出接口
 */

namespace app\api\controller;

use app\home\controller\Common;
use think\Db;
use think\Json;

class Yl extends Common {

    public function __construct() {
        parent::__construct();
        $ips = [
            '112.96.240.114',
            '101.200.40.75',
            '60.205.213.56',
            '222.209.34.18',
            '222.211.204.239',
            '112.96.240.226',
            '223.104.3.189'
        ];
        $ip = $_SERVER["REMOTE_ADDR"];
        $checkIp = in_array($ip,$ips);
        if (!$checkIp){
            c_json(0,'IP is not authorized', '');
        }
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
            ->where('id','in','44,47,40,49,94,93,103,78,100,48,50,51,79,82,53,83,104,102,97,68,42,99,445,446,880,881,447,448,879,882,888,883,884')
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
            ->field('id,name as articlename,author,info as intro,image,is_end as fullflag,cid,words_num')
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



