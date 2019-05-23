<?php

/**
 * 看书网输出接口文档
 * 和WL接口获取内容差不多
 * 书籍输出接口
 */

namespace app\api\controller;

use app\home\controller\Common;
use app\home\model\Config as SystemConfig;
use think\Db;
use think\Json;

class Ksw extends Common {

    public function __construct() {
        parent::__construct();
        $ips = [
            '123.57.206.161',
            '127.0.0.1',
            '222.209.34.18',
            // 本地ip
            '222.209.34.60'
        ];
        $ip = $_SERVER["REMOTE_ADDR"];

        $checkIp = in_array($ip,$ips);
        if (!$checkIp){
            c_json(0,'IP is not authorized', '');
        }
    }

    private $ids = [44,47,40,49,94,93,103,78,100,48,50,51,79,82,53,83,104,102,97,68,42,99,445,446,880,881,447,448,879,882,888,883,884,];


    public function getOtherIds(){
        $data = Db::name('book')
            ->where('status',1)
            ->where('is_del',0)
            ->where('type',4)
            ->field('id')
            ->select();
        $ids = $this->ids;
        $result = [];
        array_walk_recursive($data, function($value) use (&$result) {
            array_push($result, $value);
        });
        $id_ary = array_merge($ids,$result);

        c_print($id_ary);
    }

    /**
     * 获取授权图书的id列表
     */
    public function index(){
        $cip = input('get.cip','','intval');
        if ($cip != 6){
            c_json(0, 'cip is error', '');
        }

        $data = Db::name('book')
            ->where('status',1)
            ->where('is_del',0)
            ->where('type',4)
            ->field('id')
            ->select();
        $ids = $this->ids;
        $result = [];
        array_walk_recursive($data, function($value) use (&$result) {
            array_push($result, $value);
        });
        $id_ary = array_merge($ids,$result);

        $books = Db::name('book')
            ->where('id','in',$id_ary)
            ->field('id as bookId,name')
            ->select();
        if ($books){
            c_json(200,'success',$books);
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
            ->field('id as bookId,name,author,info as brief,image,node as startChargeChapter,is_end,words_num as wordCount,cid,start_time as publishTime,is_end as completeStatus,type')
            ->find();

        if ($book['is_end'] == 1){
            $book['completeStatus'] = 'Y';
        }else{
            $book['completeStatus'] = 'N';
        }
        switch ($book['cid']){
            case 19:
            case 15:
            case 14:
                $book['channel'] = 'M';
                break;
            default:
                $book['channel'] = 'W';
                break;
        }

        switch ($book['cid']){
            case 9:
            case 15:
                $book['categoryId'] = 9;
                break;
            case 8:
                $book['categoryId'] = 21;
                break;
            case 7:
                $book['categoryId'] = 5;
                break;
            case 5:
            case 10:
            case 18:
                $book['categoryId'] = 33;
                break;
            case 6:
            case 12:
                $book['categoryId'] = 35;
                break;
            case 11:
                $book['categoryId'] = 39;
                break;
            case 13:
            case 14:
                $book['categoryId'] = 29;
                break;
            case 19:
                $book['categoryId'] = 15;
                break;
            default:
                $book['categoryId'] = 51;
                break;
        }

        if ($book['type'] == 4 || $book['type'] == 3){
            $str = 'www.bqread.com';
            if(strpos($book['image'],$str) !== false){
                // 判断 $book['image'] 中是否有www.bqread.com,如果没有则说明改过image
                $book['cover'] = $book['image'];
            }else{
                $book['cover'] = $url.$book['image'];
            }

        }else{
            $book['cover'] = $url.$book['image'];
        }

        $book['price'] = 5;
        unset($book['image']);
        unset($book['cid']);
        unset($book['is_end']);
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
        $id = input('get.bookId','','intval');

        if (!$id){
            c_json(0, 'bookId is error', '');
        }
        $book = Db::name('book')->where('id',$id)->field('type,other_bookid')->find();

        if ($book['type'] == 3){
            $url = 'http://store.zhewenit.com/api/Shuangxige/structure?bookId='.$book['other_bookid'];
            $res = httpPost($url);
            if ($res['code'] != 0){
                return false;
            }
            $otherData = object_array($res['data']);
            $chapters = $otherData['books'];
            foreach ($chapters as $k => $v){
                unset($chapters[$k]['chaptersize']);
                unset($chapters[$k]['sort']);
            }
        }elseif($book['type'] == 4){
            $url = 'http://www.bqread.com/api/shuangxi/get_chapter_list.php?aid='.$book['other_bookid'];
            $res = httpPost($url);
            if ($res['code'] != 0){
                return false;
            }
            $chapters = object_array($res['data']);
            $str = '20181204212407';
            foreach ($chapters as $k => $v){
                unset($chapters[$k]['chaptertype']);
                unset($chapters[$k]['isvip']);
                unset($chapters[$k]['saleprice']);
                unset($chapters[$k]['postdate']);
                unset($chapters[$k]['words']);
                $chapters[$k]['lastupdate'] = strtotime($v['lastupdate']);
            }
        }else{
            $chapters = Db::name('chapter')
                ->where('b_id',$id)
                ->where('status',1)
                ->field('id as chapterid,name as chaptername,time as lastupdate')
                ->order('id asc')
                ->select();
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
    public function chapterInfo(){

        $bookId = input('get.bookId','','intval');
        $chapterId = input('get.chapterId','','intval');
        $book = Db::name('book')->where('id',$bookId)->field('type,other_bookid')->find();

        if (!$bookId){
            c_json(0, 'bookId is error', '');
        }
        if (!$chapterId){
            c_json(0, 'chapterId is error', '');
        }
        if ($book['type'] == 4){
            $get_content_url = 'http://www.bqread.com/api/shuangxi/get_chapter_content.php?aid='.$book['other_bookid'].'&chapterid='.$chapterId;
            $r = httpPost($get_content_url);
            $chapter = object_array($r['data']);
            $chapter['bookId'] = $book['other_bookid'];
            unset($chapter['chaptertype']);
            unset($chapter['words']);
            unset($chapter['postdate']);
            unset($chapter['isvip']);
            unset($chapter['saleprice']);
            $chapter['lastupdate'] = strtotime($chapter['lastupdate']);
        }else{
            $chapter = Db::name('chapter')
                ->where('b_id',$bookId)
                ->where('id',$chapterId)
                ->field('id as chapterid,b_id as bookId,name as chaptername,time as lastupdate,content')
                ->find();
        }
        if ($chapter){
            c_json(200, 'success', $chapter);
        }else{
            c_json(0, 'error', '');
        }
    }
}



