<?php

/**
 * 落尘接口
 * 类型：输出
 * 书籍输出接口
 */

namespace app\api\controller;

use app\home\controller\Common;
use app\home\model\Config as SystemConfig;
use think\Db;
use think\Json;

class Lc extends Common {

    public function __construct() {
        parent::__construct();
        $cp_id = 1; // 落尘
        $ips = [
            '127.0.0.1',
            '222.211.206.220',
            '122.225.107.89',
            '122.96.93.156',
            '222.211.207.51',
            '222.209.34.60',
            '222.209.35.103' // 本地
        ];
        $ip = $_SERVER["REMOTE_ADDR"];
        $checkIp = in_array($ip,$ips);
        if (!$checkIp){
            c_json(0,'your IP is not authorized', '');
        }
        $res = Db::name('output_api')->where('cp_id',$cp_id)->find();
        if ($res['status'] != 1){
            c_json(0,'Interface has been closed', '');
        }

    }

    private $ids = [];

    public function check(){
        $ids = Db::name('output_api')->where('cp_id',1)->field('ids')->find();
        $this->ids = $ids['ids'];
        $books = Db::name('book')
            ->where('id','in',$this->ids)
            ->field('id,name')
            ->select();
        $chapter = Db::name('chapter')
            ->where('status',0)
            ->where('b_id',49)
            ->field('id,name,status,b_id as bookId')
            ->select();
        c_print($chapter);
    }

    /**
     * 获取授权图书的id列表
     */
    public function bookList(){
        $ids = Db::name('output_api')->where('cp_id',1)->field('ids')->find();
        $this->ids = $ids['ids'];
        $books = Db::name('book')
            ->where('id','in',$this->ids)
            ->field('id,name as booktitle,start_time as updatetime')
            ->select();
        $data = [];
        $data['books'] = $books;
        if ($books){
            c_json(1,'success',$data);
        }else{
            c_json(0,'error','');
        }
    }

    /**
     * 获取图书信息
     */
    public function bookInfo(){
        // GET http://xxx.xxx.com?bookId=1
        $url = $_SERVER['SERVER_NAME'];
        $id = input('get.bookId','','intval');

        if (!$id){
            c_json(0,'bookId is error', '');
        }

        $book =  Db::name('book')
            ->where('id',$id)
            ->field('id,name as title,author,info as summary,image,cid,is_end as isFull')
            ->find();
        $category = Db::name('book_category')->where('id',$book['cid'])->field('name')->find();
        $book['channel'] = 0;
        if ($book['cid'] == 15 || $book['cid'] == 19){
            $book['channel'] = 1;
        }
        $book['category'] = $category['name'];
        $book['tag'] = '';
        $book['cover'] = 'http://'.$url.$book['image'];
        $book['sort'] = '';
        $book['role'] = '';
        $book['isVip'] = '';
        $book['url'] = 'http://www.sxiwx.com/api/Lc/getChapters?bookId='.$id;
        unset($book['cid']);
        unset($book['image']);
        if ($book){
            c_json(1, 'success', $book);
        }else{
            c_json(0, 'error', '');
        }
    }

    /**
     * 获取章节list
     */
    public function getChapters(){
        $id = input('get.bookId','','intval');
        if (!$id){
            c_json(0, 'bookId is error', '');
        }

        $chapters = Db::name('chapter')
            ->where('b_id',$id)
            ->where('status',1)
            ->field('id,name as title,time,content')
            ->order('id asc')
            ->select();
        foreach ($chapters as $k => $v){
            $chapters[$k]['chapterOrder'] = $k + 1;
            $chapters[$k]['volume'] = '正文';
            $chapters[$k]['volumeOrder'] = '';
            $chapters[$k]['isVip'] = '';
            $chapters[$k]['chapterLength'] = mb_strlen(DeleteHtml(strip_tags($v['content'])));
            $chapters[$k]['updatetime'] = date('Y-m-d H:i:s',$v['time']);
            $chapters[$k]['url'] = 'http://www.sxiwx.com/api/Lc/chapterInfo?bookId='.$id.'&chapterId='.$v['id'];
            unset($chapters[$k]['content']);
            unset($chapters[$k]['time']);
        }

        if ($chapters){
            c_json(1, 'success', $chapters);
        }else{
            c_json(0, 'error', '');
        }
    }

    /**
     * 获取章节内容
     */
    public function chapterInfo(){

        $bookId = input('get.bookId','','intval');
        $chapterId = input('get.chapterId','','intval');
        if (!$bookId){
            c_json(0, 'bookId is error', '');
        }
        if (!$chapterId){
            c_json(0, 'chapterId is error', '');
        }

        $chapter = Db::name('chapter')
            ->where('b_id',$bookId)
            ->where('id',$chapterId)
            ->field('content')
            ->find();
        $chapter['content'] = trimHtml($chapter['content'],0,999999999);
        $chapter['content'] = str_replace("    ","\r\n",$chapter['content']);
        
        if ($chapter){
            c_json(1, 'success', $chapter);
        }else{
            c_json(0, 'error', '');
        }
    }


}



