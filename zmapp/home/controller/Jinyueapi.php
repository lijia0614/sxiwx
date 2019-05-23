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

class Jinyueapi extends Common {

    public function __construct() {
        parent::__construct();
    }
    const GET_BOOKIDS_URL = 'http://www.bqread.com/api/shuangxi/get_book_list.php'; // 获取所有授权作品 ID
    const GET_BOOKINFO_URL = 'http://www.bqread.com/api/shuangxi/get_book_info.php?aid='; // 获取书籍属性
    const GET_CHAPTERLIST_URL = 'http://www.bqread.com/api/shuangxi/get_chapter_list.php?aid='; // 获取书籍章节列表

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
//            c_print($bookIds);die;
            Db::startTrans();
            try{
                foreach ($bookIds as $k=>$v){
                    $check = Db::name('bookids')
                        ->where('bookid',$v['articleid'])
                        ->where('type',2)
                        ->find();

                    if (!$check){
                        // 没有该bookid,存入数据库
                        $dataId = [
                            'bookid' => $v['articleid'],
                            'type' => 2,
                            'create_time' => date('Y-m-d H:i:s')
                        ];

                        $b = Db::name('bookids')->insert($dataId);

                        // 根据id获取书籍属性
                        $getInfoUrl = $this::GET_BOOKINFO_URL.$v['articleid'];
                        $bookInfo = httpPost($getInfoUrl);

                        $data = object_array($bookInfo['data']);

                        // 将书籍信息存入book表中
                        $ary = [
                            'type' => 4, // 今阅书籍
                            'u_id' => 2, //超级用户
                            'words_num' => $data['words'],
                            'other_bookid' => $data['articleid'],
                            'image' => $data['cover'],
                            'name' => $data['articlename'],
                            'chapters' => $data['chapters'],
                            'info' => $data['intro'],
                            'author' => $data['author'],
                            'is_end' => $data['fullflag']
                        ];
                        switch ($data['sort']){ // 重置书籍分类
                            case '都市异能':
                                $ary['cid'] = 9;
                                break;
                            case '悬疑灵异':
                                $ary['cid'] = 11;
                                break;
                            case '玄幻奇幻':
                                $ary['cid'] = 8;
                                break;
                            case '仙侠修真':
                            case '仙侠情缘':
                                $ary['cid'] = 7;
                                break;
                            case '军事历史':
                                $ary['cid'] = 19;
                                break;
                            case '网游竞技':
                                $ary['cid'] = 16;
                                break;
                            case '科幻未来':
                                $ary['cid'] = 15;
                                break;
                            case '古代言情':
                                $ary['cid'] = 13;
                                break;
                            case '灵异惊悚':
                                $ary['cid'] = 11;
                                break;
                            case '浪漫青春':
                                $ary['cid'] = 6;
                                break;
                            case '幻想言情':
                                $ary['cid'] = 5;
                                break;
                            default:
                                $ary['cid'] = 18;
                                break;
                        }
                        $save = Db::name('book')->insert($ary);
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

    public function getBookInfo(){
        $bookId = input('get.bookId');
        $url = $this::GET_BOOKINFO_URL.$bookId;
        $res = httpPost($url);
        c_print($res);die;
    }

    public function getc(){
        $url = $this::GET_CHAPTERLIST_URL.'373';
        $res = httpPost($url);
        c_print($res);die;
    }

    public function getChapter(){

        $bookId = 3384;
        $url = $this::GET_CHAPTERLIST_URL.$bookId; // 获取章节列表
        $res = httpPost($url);
        if ($res['code'] != 0){
            return false;
        }
        $data = object_array($res['data']);
        c_print($data);die;
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

    public function getContent($bookId='3384',$chapterId='364448'){

        $get_content_url = 'http://www.bqread.com/api/shuangxi/get_chapter_content.php?aid=3384&chapterid=364448';
        $r = httpPost($get_content_url);
        $c_info = object_array($r['data']);
        $content = $c_info['books']['content'];

        c_print($c_info);
    }

    /**
     * 检查重复的书籍
     */
    public function checkBook()
    {
        $arr = Db::name('book')
            ->where('id', '>', '106')
            ->where('is_del', 0)
            ->field('id,name,author')
            ->order('id desc')
            ->select();
        $res = array();
        $key = array();
        foreach ($arr as $v) {
            $t = array_filter($arr, function ($t) use ($v) {
                return $t['name'] == $v['name'];
            });
            if (count($t) > 1) {
                $key = array_merge($key, array_keys($t));
                $res = array_merge($res, $t);
                $arr = array_diff_key($arr, $t);
            }
        }
        $res = array_combine($key, $res);
        c_print($res);

        c_print(count($res));
    }



}



