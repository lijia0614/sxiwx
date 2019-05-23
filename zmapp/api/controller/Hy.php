<?php

/**
 * 黑岩接口
 * 类型：输出
 * 书籍输出接口
 */

namespace app\api\controller;

use app\home\controller\Common;
use app\home\model\Config as SystemConfig;
use think\Db;
use think\Json;

class Hy extends Common {

    public function __construct() {
        parent::__construct();
        $ips = [
            '118.194.246.215',
            '121.43.198.56',
            '121.43.197.183',
            '121.43.199.34',
            '120.55.242.4',
            '115.29.185.73',
            '120.26.57.190',
            '112.124.124.84',
            '120.26.99.128',
            '127.0.0.1',
            '222.209.34.18',
            '222.211.204.239',
            '222.211.204.239',
            '222.211.206.220' // 本地
        ];
        $ip = $_SERVER["REMOTE_ADDR"];
        $cp_id = 2;
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
    public function index(){
        $ids = Db::name('output_api')->where('cp_id',2)->field('ids')->find();
        $this->ids = $ids['ids'];
        $books = Db::name('book')
            ->where('id','in',$this->ids)
            ->field('id')
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
            ->field('id,name,author,info as introduce,image as icon,cid,is_end as finish')
            ->find();
        $book['introduce'] = trimHtml($book['introduce'],0,100000);
        $book['tags'] = '';

        switch ($book['cid']){
            case 15:
                $book['sort'] = 25;
                break;
            case 5:
                $book['sort'] = 4;
                break;
            case 6:
                $book['sort'] = 21;
                break;
            case 14:
                $book['sort'] = 28;
                break;
            case 10:
                $book['sort'] = 13;
                break;
            case 11:
                $book['sort'] = 1;
                break;
            case 8:
                $book['sort'] = 17;
                break;
            case 13:
                $book['sort'] = 37;
                break;
            case 18:
                $book['sort'] = 39;
                break;
            default:
                $book['sort'] = 54;
                break;
        }
        $lastChapter = Db::name('chapter')->where('b_id',$id)->order('id desc')->limit(1)->field('time')->find();
        $book['finishTime'] = $lastChapter['time'];
        $book['updateTime'] = $lastChapter['time'];
        $book['icon'] = 'http://'.$url.$book['icon'];
        unset($book['cid']);
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
            ->field('id as chapterId')
            ->order('id asc')
            ->select();
        foreach ($chapters as $k => $v){
            $chapters[$k]['chapterNumber'] = $k + 1;
        }

        $data['volumes'] = [
             ['volumeId' => 0,
                'volumeTitle' => '全部章节',
                'volumeNumber' => 1,
                'chapters' => $chapters
             ]
        ];
        if ($chapters){
            c_json(1, 'success', $data);
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
        $book = Db::name('book')->where('id',$bookId)->field('node')->find();

        if (!$bookId){
            c_json(0, 'bookId is error', '');
        }
        if (!$chapterId){
            c_json(0, 'chapterId is error', '');
        }

        $chapter = Db::name('chapter')
            ->where('b_id',$bookId)
            ->where('id',$chapterId)
            ->field('id,name,time as publishTime,content')
            ->find();
        $num = Db::name('chapter')  // 统计当前是第多少章
        ->where('b_id',$bookId)
            ->where('id','<=',$chapterId)
            ->where('status',1)
            ->count('id');
        $chapter['content'] = trimHtml($chapter['content'],0,999999999);
        if($num > ($book['node']-1)){
            $chapter['free'] = 0;
        }else{
            $chapter['free'] = 1;
        }
        if ($chapter){
            c_json(1, 'success', $chapter);
        }else{
            c_json(0, 'error', '');
        }
    }


}



