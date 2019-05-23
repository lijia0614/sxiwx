<?php
/**
 * 公主书城
 * type: 获取数据
 * Created by PhpStorm.
 * User: 李贾
 * Date: 2019/3/20
 * Time: 16:48
 */

namespace app\api\controller;


use app\home\controller\Common;
use think\Db;

class Gzsc extends Common
{
    public function __construct() {
        parent::__construct();
    }

    private  $key = 'mnds8y3nkh98e';
    private  $sid = 45;
    // 举例：key=abcd ，接口参数要求 sid=1&zz=2&aa=3&sign=xxx
    // 实际：sign=MD5('aa=3&sid=1&zz=2&key=abcd');

    /**
     * 获取所有书籍列表
     */
    public function getBooks(){
        $str = 'sid='.$this->sid.'&key='.$this->key;
        $sign = \md5($str);
        $url = 'http://www.gzdushu.com/apis/jieqi/articlelist.php?sid='.$this->sid.'&sign='.$sign;
        $res = httpPost($url);

        c_print($res);
    }

    /**
     * 获取 fullflag == 0 的书籍
     */
    public function bookStatus(){
        $str = 'sid='.$this->sid.'&key='.$this->key;
        $sign = \md5($str);
        $url = 'http://www.gzdushu.com/apis/jieqi/infolist.php?sid='.$this->sid.'&sign='.$sign;
        $res = httpPost($url);
        $data = object_to_array($res);
        foreach ($data as $key => $val){
            if($data[$key]['fullflag'] == 1){
                unset($data[$key]);
            }
        }
        c_print($data);
    }

    /**
     * 书籍列表、详情
     */
    public function getBooksInfo(){
        $n = input('get.n','','intval');
        $str = 'sid='.$this->sid.'&key='.$this->key;
        $sign = \md5($str);
        $url = 'http://www.gzdushu.com/apis/jieqi/infolist.php?sid='.$this->sid.'&sign='.$sign;
        $res = httpPost($url);
        $data = object_to_array($res);
        $arr = array_slice($data,10*$n,10);

        foreach ($arr as $key => $val){
            $book = [
                'other_bookid' => $val['articleid'],
                'u_id' => 2,
                'name' => $val['articlename'],
                'title' => $val['sort'],
                'author' => $val['author'],
                'info' => $val['intro'],
                'start_time' => $val['postdate'],
                'end_time' => $val['lastupdate'],
                'image' => $val['cover'],
                'is_end' => $val['fullflag'],
                'type' => 5,
                'chapters' => $val['chapters'],
                'words_num' =>$val['words']
            ];
            Db::name('book')->insert($book);
        }
        c_print($arr);
    }

    /**
     * 查询书籍的章节列表
     */
    public function showChapters($aid){
        $str = 'aid='.$aid.'&sid='.$this->sid.'&key='.$this->key;
        $sign = \md5($str);
        $url = 'http://www.gzdushu.com/apis/jieqi/articlechapter.php?sid='.$this->sid.'&aid='.$aid.'&sign='.$sign;
        $res = httpPost($url);
        $data = object_to_array($res);
        c_print($data);
    }

    /**
     * 获取章节列表
     * @param $aid 书籍id
     */
    public function getChapters($aid){
        $n = input('get.n','','intval');
        $b_id = input('get.b_id','','intval');
        if (!$b_id){
            $this->error('请输入书籍id');
        }
        $str = 'aid='.$aid.'&sid='.$this->sid.'&key='.$this->key;
        $sign = \md5($str);
        $url = 'http://www.gzdushu.com/apis/jieqi/articlechapter.php?sid='.$this->sid.'&aid='.$aid.'&sign='.$sign;
        $res = httpPost($url);
        $data = object_to_array($res);
        $arr = array_slice($data,$n,100);
        foreach ($arr as $key => $val){
            $chapter = [
                'other_id' => $val['chapterid'],
                'other_book_id' => $aid,
                'name' => $val['chaptername'],
                'time' => strtotime($val['postdate']),
                'b_id' => $b_id
            ];
            Db::name('chapter')->insert($chapter);
        }
        c_print($arr);
    }

    /**
     * 获取章节内容
     * @param $aid 书籍id
     * @param $cid 章节id
     */
    public function getChapterInfo($aid,$cid){
        $str = 'aid='.$aid.'&cid='.$cid.'&sid='.$this->sid.'&key='.$this->key;
        $sign = \md5($str);
        $url = 'http://www.gzdushu.com/apis/jieqi/chaptercontent.php?sid='.$this->sid.'&aid='.$aid.'&cid='.$cid.'&sign='.$sign;
        $res = httpPost($url);
        $data = object_to_array($res);
        $data['content'] = str_replace("\r\n","<br/>",$data['content']);
        $r = file_put_contents(WEB_PATH.'/uploads/file/1.txt',$res['content'],FILE_APPEND);
        c_print($r);
    }


    /**
     * 获取章节列表并获取内容
     * @param $aid 书籍id
     */
    public function saveContent($aid){
        $n = input('get.n','','intval');
        $b_id = input('get.b_id','','intval');
        if (!$b_id){
            $this->error('请输入书籍id');
        }
        $str = 'aid='.$aid.'&sid='.$this->sid.'&key='.$this->key;
        $sign = \md5($str);
        $url = 'http://www.gzdushu.com/apis/jieqi/articlechapter.php?sid='.$this->sid.'&aid='.$aid.'&sign='.$sign;
        $res = httpPost($url);
        $data = object_to_array($res);
        $arr = array_slice($data,$n,100);
//        c_print($data);die;
        foreach ($arr as $key => $val){
            $str1 = 'aid='.$aid.'&cid='.$val['chapterid'].'&sid='.$this->sid.'&key='.$this->key;
            $sign1 = \md5($str1);
            $uri = 'http://www.gzdushu.com/apis/jieqi/chaptercontent.php?sid='.$this->sid.'&aid='.$aid.'&cid='.$val['chapterid'].'&sign='.$sign1;
            $r = httpPost($uri);
            $r['content'] = str_replace("\r\n","<br/>",$r['content']);
            $content = [
                'content' => $r['content'],
                'content_status' => 1
            ];
            $where = [
                'other_id' => $val['chapterid'],
                'b_id' => $b_id
            ];
            Db::name('chapter')->where($where)->update($content);
        }
        c_print($arr);
    }

    public function checkBook(){
        $data = Db::name('book')
            ->field('id,name')
            ->where('type',5)
            ->where('is_del',0)
            ->order('id asc')
            ->select();
        $count = Db::name('book')->where('type',5)->where('is_del',0)->count();
        c_print($count);
        c_print($data);
    }

    


}