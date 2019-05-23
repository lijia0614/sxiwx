<?php
/**
 * 追书
 * Created by PhpStorm.
 * User: 李贾
 * Date: 2019/5/9
 * Time: 16:36
 */

namespace app\api\controller;


use app\home\controller\Common;
use think\Db;

class Zs extends Common
{
    public function __construct()
    {
        parent::__construct();
        $cp_id = 6; // 追书
        $ips = [
            '127.0.0.1',
            '180.166.117.14',
            '180.169.70.118',
            '106.75.107.71',
            '106.75.119.22',
            '106.75.107.25',
            '106.75.107.27',
            '106.75.50.53',
            '106.75.22.195',
            '106.75.19.209',
            '106.75.7.175',
            '123.59.61.104',
            '123.59.60.148',

            '222.209.35.167' // 本地
        ];
        $ip = $_SERVER["REMOTE_ADDR"];
        $checkIp = in_array($ip, $ips);
        if (!$checkIp) {
            z_json(8401, 'your IP is not authorized', '');
        }
        $res = Db::name('output_api')->where('cp_id', $cp_id)->find();
        if ($res['status'] != 1) {
            z_json(8403, 'Interface has been closed', '');
        }
    }

    // 8200 成功
    // 8400 请求参数错误
    // 8401 身份验证错误
    // 8403 拒绝请求
    // 8404 书籍授权/请求书籍不存在
    private $ids = [];

    /**
     * 获取书籍列表
     */
    public function getBookList()
    {
        $ids = Db::name('output_api')->where('cp_id', 6)->field('ids')->find();
        $this->ids = $ids['ids'];
        $books = Db::name('book')
            ->where('id', 'in', $this->ids)
            ->field('id,name,author')
            ->select();
        if ($books) {
            z_json(8200, 'success', $books);
        } else {
            z_json(8404, 'null', '');
        }
    }

    /**
     * 通过 bookid 获取书籍详情
     */
    public function getBookInfo()
    {
        $bookid = input('get.bookid', '0', 'intval');

        // 验证书籍id是否受权
        $check = $this->checkID($bookid);
        if (!$check) {
            z_json(8401, 'bookid Unauthorized', '');
        }
        if (!$bookid) {
            z_json(8400, 'bookid error', '');
        }
        $book = Db::name('book')
            ->alias('a')
            ->join('book_category b', 'a.cid = b.id')
            ->where('a.id', $bookid)
            ->field('a.id,a.name as bookname,a.author as authorname,a.is_end as fullflag,a.info as intro,a.image as bookpic,b.name as category')
            ->find();
        $url = $_SERVER['SERVER_NAME'];
        $book['bookpic'] = 'http://' . $url . $book['bookpic'];
        if ($book) {
            z_json(8200, 'success', $book);
        } else {
            z_json(8404, 'null', '');
        }
    }

    /**
     * 章节列表
     */
    public function chapterList()
    {
        $bookid = input('get.bookid', '0', 'intval');
        // 验证书籍id是否受权
        $check = $this->checkID($bookid);
        if (!$check) {
            z_json(8401, 'bookid Unauthorized', '');
        }
        if (!$bookid) {
            z_json(8400, 'bookid error', '');
        }
        $list = Db::name('chapter')
            ->where('b_id', $bookid)
            ->where('status', 1)
            ->field('id as chapterid,name as chaptername')
            ->order('id asc')
            ->select();
        foreach ($list as $key => $val) {
            $list[$key]['volumename'] = '正文';
            $list[$key]['chapterorder'] = $key + 1;
            $list[$key]['contenturl'] = 'http://www.sxiwx.com/api/zs/getContent?bookid=' . $bookid . '&chapterid=' . $val['chapterid'];
        }
        if ($list) {
            z_json(8200, 'success', $list);
        } else {
            z_json(8404, 'null', '');
        }
    }

    /**
     * 章节内容
     */
    public function getContent()
    {
        $bookid = input('get.bookid', '0', 'intval');
        $chapterid = input('get.chapterid', '0', 'intval');
        // 验证书籍id是否受权
        $check = $this->checkID($bookid);
        if (!$check) {
            z_json(8401, 'bookid Unauthorized', '');
        }
        if (!$bookid) {
            z_json(8400, 'bookid error', '');
        }
        $data = Db::name('chapter')
            ->where('b_id', $bookid)
            ->where('id', $chapterid)
            ->field('content')
            ->find();
        $data['content'] = trimHtml($data['content'], 0, 100000);
        if ($data) {
            z_json(8200, 'success', $data);
        } else {
            z_json(8404, 'null', '');
        }
    }


    /**
     * 验证bookid权限
     * @param $id
     * @return bool
     */
    public function checkID($id)
    {
        $ids = Db::name('output_api')->where('cp_id', 6)->field('ids')->find();
        $idArr = explode(',', $ids['ids']);
        return in_array($id, $idArr);
    }

}
