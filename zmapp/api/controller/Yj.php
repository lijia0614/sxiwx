<?php
/**
 * 云景
 * type: 获取数据
 * Created by PhpStorm.
 * User: 李贾
 * Date: 2019/4/1
 * Time: 10:58
 */

namespace app\api\controller;


use app\home\controller\Common;
use think\Db;

class Yj extends Common
{
    public function __construct() {
        parent::__construct();
    }

    private  $address = 'www.yunzongwx.com'; // 59.110.124.41 测试环境
    private  $header = array('uniqueKey:83c4f75249dc12b4f3316427ea654d11');

    /**
     * 获取书籍列表
     */
    public function getBooks(){
        $n = input('get.n','','intval');
        $url = 'https://'.$this->address.'/novelapi/externalService/novelDetail/getNovelList';
        $res = httpPost($url,'GET','',$this->header);
        $data = object_to_array($res['data']);
        $arr = array_slice($data,$n,10);
        foreach ($arr as $key => $val){
            $bookId = $val['id'];
            $url_info = 'https://'.$this->address.'/novelapi/externalService/novelDetail/getNovelDetailInfo/'.$bookId;
            $res = httpPost($url_info,'GET','',$this->header);
            $bookData = object_to_array($res['data']);
            $book = [
                'other_bookid' => $bookData['id'],
                'u_id' => 2,
                'name' => $bookData['name'],
                'title' => $bookData['sort'],
                'author' => $bookData['author'],
                'info' => $bookData['summary'],
                'image' => $bookData['cover'],
                'is_end' => $bookData['isFinish'],
                'type' => 6,
                'words_num' =>$bookData['words']
            ];
            Db::name('book')->insert($book);
        }
        c_print($arr);
    }


    /**
     * 获取未完结书籍信息
     */
    public function bookStatus(){
        $n = input('get.n','','intval');
        $url = 'https://'.$this->address.'/novelapi/externalService/novelDetail/getNovelList';
        $res = httpPost($url,'GET','',$this->header);
        $data = object_to_array($res['data']);
        $book = [];
        foreach ($data as $key => $val){
            $bookId = $val['id'];
            $url_info = 'https://'.$this->address.'/novelapi/externalService/novelDetail/getNovelDetailInfo/'.$bookId;
            $res = httpPost($url_info,'GET','',$this->header);
            $bookData = object_to_array($res['data']);
            $arr[$key]['keywords'] = $bookData['keywords'];
            if ($bookData['isFinish'] != 1){
                $book[$key] = $bookData;
            }
        }
        c_print($book);
    }

    /**
     * 获取书籍详情
     */
    public function getBookInfo(){
        $n = input('get.n','','intval');
        $url = 'https://'.$this->address.'/novelapi/externalService/novelDetail/getNovelList';
        $res = httpPost($url,'GET','',$this->header);
        $data = object_to_array($res['data']);
        $arr = array_slice($data,$n,50);
        foreach ($arr as $key => $val){
            $bookId = $val['id'];
            $url_info = 'https://'.$this->address.'/novelapi/externalService/novelDetail/getNovelDetailInfo/'.$bookId;
            $res = httpPost($url_info,'GET','',$this->header);
            $bookData = object_to_array($res['data']);
            $arr[$key]['keywords'] = $bookData['keywords'];
        }
        c_print($arr);
    }

    /**
     * 显示章节列表
     */
    public function showChapters(){
        $bookId = input('get.bookId','',"intval");
        $url = 'https://'.$this->address.'/novelapi/externalService/chapter/getChapters?novelId='.$bookId;
        $res = httpPost($url,'GET','',$this->header);
        $data = object_to_array($res['data']);
        c_print($data);
    }

    /**
     * 获取章节列表
     */
    public function getChapters(){
        $n = input('get.n','','intval');
        $bookId = input('get.bookId','',"intval");
        $b_id = input('get.b_id','','intval');
        if (!$b_id){
            $this->error('请输入书籍id');
        }
        $url = 'https://'.$this->address.'/novelapi/externalService/chapter/getChapters?novelId='.$bookId;
        $res = httpPost($url,'GET','',$this->header);
        $data = object_to_array($res['data']);
        $arr = array_slice($data,$n,300);
        foreach ($arr as $key => $val){
            $chapter = [
                'other_id' => $val['id'],
                'other_book_id' => $bookId,
                'name' => $val['title'],
                'time' => time(),
                'b_id' => $b_id
            ];
            Db::name('chapter')->insert($chapter);
        }
        c_print($arr);
    }

    /**
     * 保存章节内容
     */
    public function saveContent(){
        $n = input('get.n','','intval');
        $bookId = input('get.bookId','',"intval");
        $b_id = input('get.b_id','','intval');
        if (!$b_id){
            $this->error('请输入书籍id');
        }
        $url = 'https://'.$this->address.'/novelapi/externalService/chapter/getChapters?novelId='.$bookId;
        $res = httpPost($url,'GET','',$this->header);
        $data = object_to_array($res['data']);
//        $arr = array_slice($data,83,17);
        $arr = array_slice($data,$n,50);
        foreach ($arr as $key => $val){
            $url_content = 'https://'.$this->address.'/novelapi/externalService/chapter/getChapterContent?chapterId='.$val['id'];
            $res = httpPost($url_content,'GET','',$this->header);
            $dataContent = object_to_array($res['data']);
            $dataContent['content'] = str_replace("\n","<br/>",$dataContent['content']);
            $content = [
                'content' => $dataContent['content'],
                'content_status' => 1
            ];
            $where = [
                'other_id' => $val['id'],
                'b_id' => $b_id
            ];
            Db::name('chapter')->where($where)->update($content);
        }
        c_print($arr);
    }

    /**
     * 获取章节内容
     */
    public function getChapterContent(){
        $chapterId = input('get.chapterId','',"intval");
        $url = 'https://'.$this->address.'/novelapi/externalService/chapter/getChapterContent?chapterId='.$chapterId;
        $res = httpPost($url,'GET','',$this->header);
        $data = object_to_array($res['data']);
        c_print($data);
    }
}