<?php

/**
 * 快看接口
 * 类型：输出
 * 书籍输出接口
 */

namespace app\api\controller;

use app\home\controller\Common;
use app\home\model\Config as SystemConfig;
use PhpOffice\PhpSpreadsheet\Reader\Xls\MD5;
use think\Db;
use think\Json;

class Kuaikan extends Common {

    private $key = '910d12dd24260de8b61d423c69bbb6aa';
    private $c_id = 254;

    public function __construct() {
        parent::__construct();
        $client_id = input('get.client_id',0,'intval');
        if ($client_id != $this->c_id){
            c_json(1,'client_id error', '');
        }
        $cp_id = 4;
        $res = Db::name('output_api')->where('cp_id',$cp_id)->find();
        if ($res['status'] != 1){
            c_json(0,'Interface has been closed', '');
        }
    }



    /**
     * 获取授权图书的id列表
     */
    public function getBookList(){
        $client_id = input('get.client_id',0,'intval');
        $key = $this->key;
        $s = md5($client_id.$key); // d3267ce706db11f08bbad77edd948d9d
        $sign = input('get.sign','','trim');
        if ($sign != $s){
            c_json(1,'sign error', '');
        }
        $ids = Db::name('output_api')->where('cp_id',4)->field('ids')->find();
        $this->ids = $ids['ids'];
        $books = Db::name('book')
            ->where('id','in',$this->ids)
            ->field('id,name')
            ->select();
        $data = [];
        $data['books'] = $books;
        if ($books){
            m_json($data['books']);
        }else{
            c_json(5,'no information','');
        }
    }

    /**
     * 获取图书信息
     */
    public function bookInfo(){
        $url = $_SERVER['SERVER_NAME'];
        $id = input('get.book_id','','intval');
        $client_id = input('get.client_id',0,'intval');
        $sign = input('get.sign','','trim');
        if (!$id){
            c_json(4,'bookId is error', '');
        }
        // Md5(client_id+key+book_id)
        $key = $this->key;
        $s = md5($client_id.$key.$id); // 969b7e3f6dec1a87cd26dfbaa643f9eb
        if ($sign != $s){
            c_json(1,'sign error', '');
        }
        $book =  Db::name('book')
            ->where('id',$id)
            ->field('id,name,author,info,image,cid as category,is_end as complete_status')
            ->find();
        $book['brief'] = trimHtml($book['info'],0,100000);
        $book['tags'] = '';
        $book['cover'] = 'http://'.$url.$book['image'];
        unset($book['info']);
        unset($book['image']);
        if ($book){
            m_json($book);
        }else{
            c_json(5, 'no data', '');
        }
    }

    /**
     * 获取章节list
     */
    public function getChapters(){
        $id = input('get.book_id','','intval');
        $client_id = input('get.client_id',0,'intval');
        $sign = input('get.sign','','trim');
        if (!$id){
            c_json(4,'bookId is error', '');
        }
        // Md5(client_id+key+book_id)
        $key = $this->key;
        $s = md5($client_id.$key.$id); // 969b7e3f6dec1a87cd26dfbaa643f9eb
        if ($sign != $s){
            c_json(1,'sign error', '');
        }

        $chapters = Db::name('chapter')
            ->where('b_id',$id)
            ->where('status',1)
            ->field('id,name')
            ->order('id asc')
            ->select();

        $data['volumes'] = [
             [
                'id' => 0,
                'name' => '全部章节',
                'chapterlist' => $chapters
             ]
        ];
        if ($chapters){
            m_json($data['volumes']);
        }else{
            c_json(5, 'no data', '');
        }
    }

    /**
     * 获取章节内容
     */
    public function chapterInfo(){

        $bookId = input('get.book_id','','intval');

        $chapterId = input('get.chapter_id','','intval');
        $client_id = input('get.client_id',0,'intval');
        $sign = input('get.sign','','trim');
        if (!$bookId){
            c_json(4,'bookId is error', '');
        }
        // Md5(client_id+key+book_id+chapter_id)
        $key = $this->key;
        $s = md5($client_id.$key.$bookId.$chapterId); // dc646158e3926ad7091355b45d08827e

        if ($sign != $s){
            c_json(1,'sign error', '');
        }

        $chapter = Db::name('chapter')
            ->where('b_id',$bookId)
            ->where('id',$chapterId)
            ->field('id,name,content')
            ->find();
        $chapter['content'] = trimHtml($chapter['content'],0,999999999);

        if ($chapter){
            m_json($chapter);
        }else{
            c_json(5, 'no data', '');
        }
    }


    /**
     * 获取分类
     */
    public function categoryList(){
        $client_id = input('get.client_id',0,'intval');
        $key = $this->key;

        $s = md5($client_id.$key); // d3267ce706db11f08bbad77edd948d9d
        $sign = input('get.sign','','trim');
        if ($sign != $s){
            c_json(1,'sign error', '');
        }
        $category = Db::name('book_category')
            ->field('id,name')
            ->select();
        $data = [];
        $data['category'] = $category;
        if ($category){
            m_json($data);
        }else{
            c_json(5,'no information','');
        }
    }

}



