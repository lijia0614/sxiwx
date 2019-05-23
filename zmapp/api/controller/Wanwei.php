<?php

/**
 * 中网万维
 * 类型：输出
 * 书籍输出接口
 */

namespace app\api\controller;

use app\home\controller\Common;
use app\home\model\Config as SystemConfig;
use think\Db;
use think\Json;

class Wanwei extends Common {

    public function __construct() {
        parent::__construct();
        $cp_id = 3;
        $ips = [
            '60.29.240.196-254',
            '60.28.209.228-254',
            '52.83.235.76',
            '52.83.194.6',
            '52.82.69.92',
            '52.83.112.172',
            '52.82.75.86',
            '52.82.94.227',
            '52.83.126.161',
            '52.83.143.185',
            '52.83.176.172',
            '52.83.185.109',
            '125.33.24.122',
            '124.204.49.114',

            //本地ip
            '127.0.0.1',
            '222.209.34.60'
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

    /**
     * 获取授权图书的id列表
     */
    public function bookList(){
        $ids = Db::name('output_api')->where('cp_id',3)->field('ids')->find();
        $this->ids = $ids['ids'];
        $books = Db::name('book')
            ->where('id','in',$this->ids)
            ->field('id as book_id')
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
            ->field('id as book_id,name as book_name,author as author_name,info as intro,image,cid,is_end,words_num as word_count,start_time as create_time')
            ->find();
        $last = Db::name('chapter')
            ->where('b_id',$id)
            ->field('time,name')
            ->order('id desc')
            ->limit(1)
            ->find();
        switch ($book['cid']){
            case 20:
                $book['category_id_1'] = 2600;
                break;
            case 19:
            case 14:
                $book['category_id_1'] = 3100;
                break;
            case 18:
            case 12:
            case 5:
                $book['category_id_1'] = 2300;
                break;
            case 16:
            case 6:
                $book['category_id_1'] = 2500;
                break;
            case 15:
            case 8:
                $book['category_id_1'] = 1200;
                break;
            case 13:
                $book['category_id_1'] = 2100;
                break;
            case 11:
                $book['category_id_1'] = 1800;
                break;
            case 10:
                $book['category_id_1'] = 2400;
                break;
            case 9:
                $book['category_id_1'] = 1200;
                break;
            case 7:
                $book['category_id_1'] = 1200;
                break;
            default:
                $book['channel'] = 3100;
                break;
        }
        $book['intro'] = trimHtml($book['intro'],0,99999);
        $book['last_chapter_time'] = date('Y-m-d H:i:s',$last['time']);
        $book['last_chapter_name'] = $last['name'];
        $book['book_status'] = 01;
        if ($book['is_end'] == 1){
            $book['book_status'] = 03;
        }
        $book['keyword'] = '';
        $book['short_intro'] = '';
        $book['update_time'] = '';
        $book['isbn'] = '';
        $book['publish'] = '';
        $book['img_url'] = 'http://'.$url.$book['image'];
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
            ->field('b_id as book_id,id as chapter_id,name as title,time,content')
            ->order('id asc')
            ->select();
        foreach ($chapters as $k => $v){
            $chapters[$k]['chapter_order'] = $k + 1;
            $chapters[$k]['is_vip'] = '';
            $chapters[$k]['word_count'] = mb_strlen(DeleteHtml(strip_tags($v['content'])));
            $chapters[$k]['create_time'] = date('Y-m-d H:i:s',$v['time']);
            $chapters[$k]['update_time'] = date('Y-m-d H:i:s',$v['time']);
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
            ->field('id as chapter_id,content')
            ->find();
        $chapter['content'] = trimHtml($chapter['content'],0,999999999);
        if ($chapter){
            c_json(1, 'success', $chapter);
        }else{
            c_json(0, 'error', '');
        }
    }


}



