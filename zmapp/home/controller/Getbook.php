<?php

/**
 * @空控制器
 * @author 四川挚梦科技有限公司 
 * @date 2018-03-20
 * @copyright Copyright (C) 2016-2017, ChengDu ZhiMengCMS Co., Ltd.
 */

namespace app\home\controller;

use think\Db;
use think\Json;

class Getbook extends Common {

    public function __construct() {
        parent::__construct();
    }
    const GET_BOOKIDS_URL = 'http://store.zhewenit.com/api/Shuangxige/bookids?cpid=6'; // 获取所有授权作品 ID
    const GET_BOOKINFO_URL = 'http://store.zhewenit.com/api/Shuangxige/info?bookId='; // 获取书籍属性
    const GET_CHAPTERLIST_URL = 'http://store.zhewenit.com/api/Shuangxige/structure?bookId='; // 获取书籍章节列表
    // 获取章节内容 http://www.bqread.com/api/shuangxi/get_chapter_content.php?aid=3034&chapterid=207049

    public function index(){
        // 获取书籍id列表
        $url = $this::GET_BOOKIDS_URL;
        $res = httpPost($url);
        if ($res['code'] == 0){
            $bookIds = object_array($res['data']);
            Db::startTrans();
            try{
                foreach ($bookIds['books'] as $k=>$v){
                    $check = Db::name('bookids')->where('bookid',$v['bookId'])->find();

                    if (!$check){
                        // 没有该bookid,存入数据库
                        $dataId = [
                            'bookid' => $v['bookId'],
                            'type' => 1,
                            'create_time' => date('Y-m-d H:i:s')
                        ];
                        $saveIds = Db::name('bookids')->insert($dataId);
                    }
                }
                // 提交事务
                Db::commit();
                return 'success';
            } catch (\Exception $e) {
                // 回滚事务
                Db::rollback();
                return 'fail';
            }
        }
    }

    public function saveBook(){
        $ids = Db::name('bookids')->where('type',1)->field('bookid')->select();
        $arr = array_slice($ids,30,50);
        Db::startTrans();
        try{
            foreach ($arr as $k=>$v){
                $getInfoUrl = $this::GET_BOOKINFO_URL.$v['bookid'];
                $bookInfo = httpPost($getInfoUrl);
                $data = object_array($bookInfo['data']);
                $info = $data['books'];
                // 将书籍信息存入book表中
                if ($info['isEnd'] == ''){
                    $info['isEnd'] = 0;
                }
                $ary = [
                    'type' => 3,
                    'u_id' => 2, //超级用户
                    'words_num' => $info['words'],
                    'other_bookid' => $info['bookId'],
                    'image' => $info['cover'],
                    'name' => $info['name'],
                    'chapters' => $info['chapters'],
                    'info' => $info['intro'],
                    'author' => $info['authorName'],
                    'is_end' => $info['isEnd']
                ];
                switch ($info['typeid']){ // 重置书籍分类
                    case 1017:
                        $ary['cid'] = 5;
                        break;
                    case 1018:
                        $ary['cid'] = 18;
                        break;
                    case 1019:
                        $ary['cid'] = 13;
                        break;
                    case 1020:
                        $ary['cid'] = 11;
                        break;
                    case 1021:
                        $ary['cid'] = 12;
                        break;
                    case 1022:
                        $ary['cid'] = 6;
                        break;
                    case 1023:
                        $ary['cid'] = 19;
                        break;
                    case 1024:
                        $ary['cid'] = 20;
                        break;
                    default:
                        $ary['cid'] = 7;
                        break;
                }
                Db::name('book')->insert($ary);
            }
            // 提交事务
            Db::commit();
            return 'success';
        } catch (\Exception $e) {
            // 回滚事务
            Db::rollback();
            return 'fail';
        }
    }

    /**
     * 初始化：把所有bookid存入数据库
     * 获取所有授权作品 ID
     */
    public function getBookIds(){
        // 获取书籍id列表
        $url = $this::GET_BOOKIDS_URL;
        $res = httpPost($url);
        if ($res['code'] == 0){
            $bookIds = object_array($res['data']);
            $arr = array_slice($bookIds['books'],350,50);

            Db::startTrans();
            try{
                foreach ($arr as $k=>$v){
                    $check = Db::name('bookids')->where('bookid',$v['bookId'])->find();
                    if (!$check){
                        // 没有该bookid,存入数据库
                        $dataId = [
                            'bookid' => $v['bookId'],
                            'type' => 1,
                            'create_time' => date('Y-m-d H:i:s')
                        ];
                        $saveIds = Db::name('bookids')->insert($dataId);
                        // 根据id获取书籍属性
                        $getInfoUrl = $this::GET_BOOKINFO_URL.$v['bookId'];
                        $bookInfo = httpPost($getInfoUrl);
                        $data = object_array($bookInfo['data']);
                        $info = $data['books'];
                        if ($info['isEnd'] == ''){
                            $info['isEnd'] = 0;
                        }
                        // 将书籍信息存入book表中
                        $ary = [
                            'type' => 3,
                            'u_id' => 2, //超级用户
                            'words_num' => $info['words'],
                            'other_bookid' => $info['bookId'],
                            'image' => $info['cover'],
                            'name' => $info['name'],
                            'chapters' => $info['chapters'],
                            'info' => $info['intro'],
                            'author' => $info['authorName'],
                            'is_end' => $info['isEnd']
                        ];
                        switch ($info['typeid']){ // 重置书籍分类
                            case 1017:
                                $ary['cid'] = 5;
                                break;
                            case 1018:
                                $ary['cid'] = 18;
                                break;
                            case 1019:
                                $ary['cid'] = 13;
                                break;
                            case 1020:
                                $ary['cid'] = 11;
                                break;
                            case 1021:
                                $ary['cid'] = 12;
                                break;
                            case 1022:
                                $ary['cid'] = 6;
                                break;
                            case 1023:
                                $ary['cid'] = 19;
                                break;
                            case 1024:
                                $ary['cid'] = 20;
                                break;
                            default:
                                $ary['cid'] = 7;
                                break;
                        }
                        $saveBook = Db::name('book')->insert($ary);

                    }

                }
                // 提交事务
                Db::commit();
                return 'success';
            } catch (\Exception $e) {
                // 回滚事务
                Db::rollback();
                return 'fail';
            }
        }
    }

    public function getChapter(){
        $id = input('get.id');
        $other =  Db::name('book')->where('id',$id)->field('other_bookid')->find();
        if (!$other){
            return false;
        }
        $bookId = $other['other_bookid'];
        $url = $this::GET_CHAPTERLIST_URL.$bookId; // 获取章节列表
        $res = httpPost($url);
        if ($res['code'] != 0){
            return false;
        }
        $data = object_array($res['data']);
        $chapter = $data['books'];

        // 循环章节列表得到所有章节内容
        foreach ($chapter as $k => $v){
            $check = Db::name('chapter')->where('other_id',$v['chapterid'])->where('is_del',0)->field('id')->find();
            if (!$check){
                $data = [
                    'b_id' => $id,
                    'other_id' => $v['chapterid'],
                    'name' => $v['title'],
                    'time' => time()
                ];
                $get_content_url = 'http://store.zhewenit.com/api/Shuangxige/chapterinfo?bookId='.$bookId.'&chapterId='.$v['chapterid'];  // 通过章节列表获取章节内容再存入数据库
                $r = httpPost($get_content_url);
                $c_info = object_array($r['data']);
                $data['content'] = $c_info['books']['content'];
                $save = Db::name('chapter')->insert($data);
            }
        }
//        c_print($chapter);die;
    }

    public function getContent($bookId='1075',$chapterId='23368'){

        $get_content_url = 'http://store.zhewenit.com/api/Shuangxige/chapterinfo?bookId='.$bookId.'&chapterId='.$chapterId;
        $r = httpPost($get_content_url);
        $c_info = object_array($r['data']);
        $content = $c_info['books']['content'];

        c_print($r);
    }

    public function bookInfo($bookId='1122'){
        $getInfoUrl = $this::GET_BOOKINFO_URL.$bookId;
        $bookInfo = httpPost($getInfoUrl);
        $data = object_array($bookInfo['data']);
        $info = $data['books'];
        c_print($info);die;
    }

}



