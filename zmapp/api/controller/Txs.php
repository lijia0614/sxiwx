<?php
/**
 * 淘小说
 * Created by PhpStorm.
 * User: 李贾
 * Date: 2019/7/17
 * Time: 14:39
 */

namespace app\api\controller;


use app\home\controller\Common;
use think\Db;

class Txs extends Common
{

    private $cp_id = 12;

    public function __construct()
    {
        parent::__construct();
        $ips = [
            '127.0.0.1',
            '120.25.201.164',
            '120.25.125.34',
            '112.74.96.182',
            '120.25.216.65',
            '112.74.79.21',
            '120.77.236.242',
            '119.23.144.217',
            '47.107.29.80 ',
            '112.74.173.20',
            '120.78.10.136',
            '111.202.205.18',
            
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
    public function Books()
    {
        $ids = Db::name('output_api')->where('cp_id', $this->cp_id)->field('ids')->find();
        $this->ids = $ids['ids'];
        $books = Db::name('book')
            ->where('id', 'in', $this->ids)
            ->field('id as bookId,name as title')
            ->select();
        $data = [
            'errcode' => 0,
            'errmsg' => 'success',
            'data' => $books
        ];
        if ($books) {
            m_json($data);
        } else {
            c_json(2003, 'no information', '');
        }
    }


    /**
     * 获取书籍详情
     */
    public function book()
    {
        $bookId = input('get.bookId', '0', 'intval');
        // 验证书籍id是否受权
        $check = $this->checkID($bookId);
        if (!$check) {
            c_json(1004, 'bookId Unauthorized', '');
        }
        if (!$bookId) {
            c_json(2000, 'bookId error', '');
        }

        $book = Db::name('book')
            ->alias('a')
            ->join('book_category b', 'a.cid = b.id')
            ->where('a.id', $bookId)
            ->field('a.id as bookId,a.name as title,a.author,a.is_end,a.info as intro,a.image as cover,a.cid,a.start_time as createTime,a.words_num as words')
            ->find();

        $url = $_SERVER['SERVER_NAME'];
        $book['cover'] = 'http://' . $url . $book['cover'];
        if ($book['is_end'] == 1) {
            $book['status'] = 50;
        } else {
            $book['status'] = 30;
        }
        unset($book['is_end']);
        switch ($book['cid']) {
            case 21:
                $book['categoryId'] = 204000;
                break;
            case 20:
                $book['categoryId'] = 112000;
                break;
            case 19:
                $book['categoryId'] = 107000;
                break;
            case 18:
                $book['categoryId'] = 204000;
                break;
            case 16:
                $book['categoryId'] = 205000;
                break;
            case 15:
                $book['categoryId'] = 105000;
                break;
            case 14:
                $book['categoryId'] = 201000;
                break;
            case 13:
                $book['categoryId'] = 203000;
                break;
            case 12:
                $book['categoryId'] = 204000;
                break;
            case 11:
                $book['categoryId'] = 201000;
                break;
            case 10:
                $book['categoryId'] = 204000;
                break;
            case 9:
                $book['categoryId'] = 105000;
                break;
            case 8:
                $book['categoryId'] = 207000;
                break;
            case 7:
                $book['categoryId'] = 202000;
                break;
            case 6:
                $book['categoryId'] = 204000;
                break;
            case 5:
                $book['categoryId'] = 204000;
                break;

        }
        unset($book['cid']);
        $data = [
            'errcode' => 0,
            'errmsg' => 'success',
            'data' => $book
        ];
        if ($book) {
            m_json($data);
        } else {
            c_json(2003, 'no information', '');
        }
    }


    /**
     * 获取书籍章节列表
     */
    public function chapters()
    {
        $bookId = input('get.bookId', '0', 'intval');
        $check = $this->checkID($bookId);
        if (!$check) {
            z_json(1004, 'bookId Unauthorized', '');
        }
        if (!$bookId) {
            z_json(2000, 'bookId error', '');
        }
        $list = Db::name('chapter')
            ->where('b_id', $bookId)
            ->where('status', 1)
            ->field('id as chapterId,name as title,time as updateTime')
            ->order('id asc')
            ->select();
        foreach ($list as $k => $v) {
            $list[$k]['updateTime'] = date('Y-m-d H:i:s', $v['updateTime']);
        }

        $data = [
            'errcode' => 0,
            'errmsg' => 'success',
            'data' => $list
        ];
        if ($list) {
            m_json($data);
        } else {
            c_json(2003, 'no information', '');
        }
    }


    /**
     * 获取章节内容
     */
    public function content()
    {
        $bookId = input('get.bookId', '0', 'intval');
        $chapterId = input('get.chapterId', '0', 'intval');
        $check = $this->checkID($bookId);
        if (!$check) {
            z_json(1004, 'bookId Unauthorized', '');
        }
        if (!$bookId) {
            z_json(2000, 'bookId error', '');
        }
        if (!$chapterId) {
            z_json(2000, 'chapterId error', '');
        }
        $data = Db::name('chapter')
            ->where('b_id', $bookId)
            ->where('id', $chapterId)
            ->field('name as title,content')
            ->find();
        $data['content'] = trimHtml($data['content'], 0, 100000);
        $info = [
            'errcode' => 0,
            'errmsg' => 'success',
            'data' => $data
        ];
        if ($data) {
            m_json($info);
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