<?php
/**
 * 得间 掌阅文档
 * Created by PhpStorm.
 * User: 李贾
 * Date: 2019/5/20
 * Time: 14:39
 */

namespace app\api\controller;


use app\home\controller\Common;
use think\Db;

class Zy extends Common
{

    private $cp_id = 9;

    public function __construct()
    {
        parent::__construct();
        $ips = [
            '127.0.0.1',
            '36.110.103.118',
            '59.151.100.21',
            '101.226.33.217',
            '182.48.105.10',
            '118.192.170.16',
            '222.209.33.139' // 本地
        ];
        $ip = $_SERVER["REMOTE_ADDR"];
        $checkIp = in_array($ip, $ips);
        if (!$checkIp) {
            z_json(1005, 'your IP is not authorized', '');
        }
        $res = Db::name('output_api')->where('cp_id', $this->cp_id)->find();
        if ($res['status'] != 1) {
            z_json(1005, 'Interface has been closed', '');
        }
    }


    /**
     * 获取授权书籍列表
     */
    public function getBookList()
    {
        $ids = Db::name('output_api')->where('cp_id', $this->cp_id)->field('ids')->find();
        $this->ids = $ids['ids'];
        $books = Db::name('book')
            ->where('id', 'in', $this->ids)
            ->field('id,name')
            ->select();
        if ($books) {
            m_json($books);
        } else {
            c_json(2003, 'no information', '');
        }
    }


    /**
     * 获取书籍详情
     */
    public function getBookInfo()
    {
        $bookId = input('get.id', '0', 'intval');
        // 验证书籍id是否受权
        $check = $this->checkID($bookId);
        if (!$check) {
            c_json(1004, 'id Unauthorized', '');
        }
        if (!$bookId) {
            c_json(2000, 'id error', '');
        }

        $book = Db::name('book')
            ->alias('a')
            ->join('book_category b', 'a.cid = b.id')
            ->where('a.id', $bookId)
            ->field('a.id,a.name,a.author,a.is_end,a.info as brief,a.image as cover,b.name as keywords,a.cid')
            ->find();
        $url = $_SERVER['SERVER_NAME'];
        $book['cover'] = 'http://' . $url . $book['cover'];
        if ($book['is_end'] == 1) {
            $book['complete_status'] = 'Y';
        } else {
            $book['complete_status'] = 'N';
        }
        unset($book['is_end']);
        switch ($book['cid']) {
            case 21:
                $book['category'] = "女频";
                $book['category_id'] = 2108;
                break;
            case 20:
                $book['category'] = "其他->同人作品";
                $book['category_id'] = 1314;
                break;
            case 19:
                $book['category'] = "男频->军事";
                $book['category_id'] = 1225;
                break;
            case 18:
                $book['category'] = "女频->现代言情->都市纯爱";
                $book['category_id'] = 1275;
                break;
            case 16:
                $book['category'] = "女频->青春校园->青春纯爱";
                $book['category_id'] = 1306;
                break;
            case 15:
                $book['category'] = "男频->都市";
                $book['category_id'] = 1209;
                break;
            case 14:
                $book['category'] = "女频->古代言情->种田经商";
                $book['category_id'] = 1256;
                break;
            case 13:
                $book['category'] = "女频->古代言情->古色古香";
                $book['category_id'] = 1285;
                break;
            case 12:
                $book['category'] = "女频->现代言情->都市纯爱";
                $book['category_id'] = 1275;
                break;
            case 11:
                $book['category'] = "其他->推理悬疑-未出版";
                $book['category_id'] = 1320;
                break;
            case 10:
                $book['category'] = "女频->现代言情->总裁豪门";
                $book['category_id'] = 1269;
                break;
            case 9:
                $book['category'] = "女频->现代言情->重生异能";
                $book['category_id'] = 1278;
                break;
            case 8:
                $book['category'] = "女频->古代言情->穿越时空";
                $book['category_id'] = 1280;
                break;
            case 7:
                $book['category'] = "女频->古代言情->穿越时空";
                $book['category_id'] = 1280;
                break;
            case 6:
                $book['category'] = "女频->青春校园->青春纯爱";
                $book['category_id'] = 1306;
                break;
            case 5:
                $book['category'] = "女频->现代言情->都市纯爱";
                $book['category_id'] = 1276;
                break;
        }
        unset($book['cid']);
        if ($book) {
            m_json($book);
        } else {
            c_json(2003, 'no information', '');
        }
    }


    /**
     * 获取书籍章节列表
     */
    public function chapterList()
    {
        $bookId = input('get.book_id', '0', 'intval');
        $check = $this->checkID($bookId);
        if (!$check) {
            z_json(1004, 'book_id Unauthorized', '');
        }
        if (!$bookId) {
            z_json(2000, 'book_id error', '');
        }
        $list = Db::name('chapter')
            ->where('b_id', $bookId)
            ->where('status', 1)
            ->field('id,name,time as create_time')
            ->order('id asc')
            ->select();
        foreach ($list as $k => $v) {
            $list[$k]['create_time'] = date('Y-m-d H:i:s', $v['create_time']);
        }

        if ($list) {
            m_json($list);
        } else {
            c_json(2003, 'no information', '');
        }
    }


    /**
     * 获取章节内容
     */
    public function getContent()
    {
        $bookId = input('get.book_id', '0', 'intval');
        $chapterId = input('get.chapter_id', '0', 'intval');
        $check = $this->checkID($bookId);
        if (!$check) {
            z_json(1004, 'book_id Unauthorized', '');
        }
        if (!$bookId) {
            z_json(2000, 'book_id error', '');
        }
        if (!$chapterId) {
            z_json(2000, 'chapter_id error', '');
        }
        $data = Db::name('chapter')
            ->where('b_id', $bookId)
            ->where('id', $chapterId)
            ->field('id,name,content,time as create_time')
            ->find();
        $data['content'] = trimHtml($data['content'], 0, 100000);
        $data['create_time'] = date('Y-m-d H:i:s', $data['create_time']);
        if ($data) {
            m_json($data);
        } else {
            c_json(2003, 'no information', '');
        }
    }


    /**
     * 验证bookId是否受权
     * @param $id //书籍id
     * @return bool
     */
    public function checkID($id)
    {
        $ids = Db::name('output_api')->where('cp_id', $this->cp_id)->field('ids')->find();
        $idArr = explode(',', $ids['ids']);
        return in_array($id, $idArr);
    }


}