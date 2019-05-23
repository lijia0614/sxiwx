<?php

/**
 * 微鲤
 * 看书网
 * 书籍输出接口
 */

namespace app\api\controller;

use app\home\controller\Common;
use app\home\model\Config as SystemConfig;
use think\Db;
use think\Json;

class Wl extends Common {

    public function __construct() {
        parent::__construct();
    }

    // 临时取消403,408
    // 886,970,180,925,544 看书网新加


    private $ids = [44,47,40,49,94,93,103,78,100,48,50,51,79,82,53,83,104,102,97,68,42,99,445,52,108,446,880,881,448,882,879,213,219,254,885,218,215,257,253,250,247,217,246,252,212,216,258,244,220,214,255,256,280,287,288,886,285,289,292,293,290,291,309,307,308,321,312,334,313,330,314,315,360,361,319,320,359,332,357,277,283,294,278,266,297,275,282,267,281,271,298,299,270,269,263,279,274,265,264,273,268,300,272,296,295,302,284,301,306,310,349,328,327,190,209,188,167,238,240,189,211,156,241,242,157,130,442,205,206,203,197,239,232,191,192,233,165,199,210,207,248,234,235,210,204,195,236,163,166,184,198,185,125,200,202,261,221,222,436,262,441,245,223,260,193,224,249,225,259,440,226,227,228,230,311,243,237,160,194,168,179,183,174,180,182,187,186,430,431,161,432,433,434,435,437,438,439,208,162,158,170,429,159,164,169,171,172,173,175,176,177,178,231,229,428,427,426,425,424,423,358,364,369,366,378,371,370,372,373,377,379,381,386,387,365,392,390,368,393,394,397,367,395,396,399,398,400,389,401,385,384,383,376,109,375,374,151,359,316,362,402,363,418,318,326,305,317,304,337,344,339,325,340,331,303,335,276,338,322,348,345,324,346,355,323,356,347,341,343,353,340,336,352,351,354,350,333,382,155,410,409,406,309,391,380,329,414,415,388,413,407,405,404,420,419,417,411,421,412,422,926,973,886,970,180,925,544,891,910,890,889,908,931,920,928,930,929,913,922,938,916,897,917,905,936,1186,923,911,939,902,964,921,912];

    public function getNoImg(){
        $ids = [161,165,186,370,371, 378, 381, 384 ,385 ,389, 392, 395, 396, 397, 399, 400 ,425, 427, 435, 438];
        $books = Db::name('book')
            ->where('id','in',$ids)
            ->field('id,name')
            ->select();
        c_print($books);
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
            ->where('id','in',$this->ids)
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
        switch ($book['categoryId']){
            case 29:
            case 31:
            case 33:
            case 35:
            case 37:
            case 39:
            case 41:
            case 43:
            case 45:
                $book['channel'] = 'W';
                break;
            case 51:
            case 53:
            case 55:
                $book['channel'] = 'P';
                break;
            default:
                $book['channel'] = 'M';
                break;
        }
        if ($book['type'] == 4){
            $str = 'www.bqread.com';
            if(strpos($book['image'],$str) !== false){
                // 判断 $book['image'] 中是否有www.bqread.com,如果没有则说明改过image
                $book['cover'] = $book['image'];
            }else{
                $book['cover'] = $url.$book['image'];
            }
        }elseif ($book['type'] == 3){
            $str = 'www.yuexiadu.com';
            if(strpos($book['image'],$str) !== false){
                // 判断 $book['image'] 中是否有www.yuexiadu.com,如果没有则说明改过image
                $book['cover'] = $book['image'];
            }else{
                $book['cover'] = $url.$book['image'];
            }
        }elseif ($book['bookId'] == 925 || $book['bookId'] == 970){
            $book['cover'] = $book['image'];
        }
        else{
            $book['cover'] = $url.$book['image'];
        }

        $book['price'] = 5;
        $book['displayName'] = $book['name'];
        if ($book['publishTime'] == '0000-00-00 00:00:00'){
            $book['publishTime'] = '';
        }
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
                if ($v['updateTime'] == ''){
                    $v['updateTime'] = time();
                }
                $chapters[$k]['chaptername'] = $v['title'];
                $chapters[$k]['chapterOrder'] = $v['sort'];
                $chapters[$k]['lastupdate'] = $v['updateTime'];
                unset($chapters[$k]['chaptersize']);
                unset($chapters[$k]['sort']);
                unset($chapters[$k]['title']);
                unset($chapters[$k]['updateTime']);
            }
        }elseif($book['type'] == 4){
            $url = 'http://www.bqread.com/api/shuangxi/get_chapter_list.php?aid='.$book['other_bookid'];
            $res = httpPost($url);
            if ($res['code'] != 0){
                return false;
            }
            $chapters = object_array($res['data']);

            foreach ($chapters as $k => $v){
                unset($chapters[$k]['chaptertype']);
                unset($chapters[$k]['isvip']);
                unset($chapters[$k]['saleprice']);
                unset($chapters[$k]['postdate']);
                unset($chapters[$k]['words']);
                $chapters[$k]['lastupdate'] = strtotime($v['lastupdate']);
            }
            foreach ($chapters as $k => $v){
                $chapters[$k]['chapterOrder'] = $k + 1;
            }
        }else{
            $chapters = Db::name('chapter')
                ->where('b_id',$id)
                ->where('status',1)
                ->field('id as chapterid,name as chaptername,time as lastupdate')
                ->order('id asc')
                ->select();
            foreach ($chapters as $k => $v){
                $chapters[$k]['chapterOrder'] = $k + 1;
            }
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
        }elseif ($book['type'] == 3){
            $get_content_url = 'http://store.zhewenit.com/api/Shuangxige/chapterinfo?bookId='.$book['other_bookid'].'&chapterId='.$chapterId;
            $r = httpPost($get_content_url);

            $c_info = object_array($r['data']);
            $chapter = $c_info['books'];

            $chapter['bookId'] = $book['other_bookid'];
            $chapter['chaptername'] = $chapter['title'];
            $chapter['lastupdate'] = $chapter['updateTime'];
            if ($chapter['lastupdate'] == ''){
                $chapter['lastupdate'] = time();
            }
            unset($chapter['title']);
            unset($chapter['updateTime']);
            unset($chapter['words']);
        }else{
            $chapter = Db::name('chapter')
                ->where('b_id',$bookId)
                ->where('id',$chapterId)
                ->field('id as chapterid,b_id as bookId,name as chaptername,time as lastupdate,content')
                ->find();
        }
        $chapter['content'] = trimHtml($chapter['content'],0,10000000);
        if ($chapter){
            c_json(200, 'success', $chapter);
        }else{
            c_json(0, 'error', '');
        }
    }


}



