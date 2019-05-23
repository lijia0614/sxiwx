<?php
/**
 * 启梦
 * Created by PhpStorm.
 * User: 李贾
 * Date: 2019/5/9
 * Time: 16:36
 */

namespace app\api\controller;


use app\home\controller\Common;
use think\Db;

class Qm extends Common
{
    public function __construct() {
        parent::__construct();
        $cp_id = 7; // 追书
        $ips = [
            '127.0.0.1',
            '119.23.32.220',
            '119.123.71.110',
            '222.209.35.43' // 本地
        ];
        $ip = $_SERVER["REMOTE_ADDR"];
        $checkIp = in_array($ip,$ips);
        if (!$checkIp){
            z_json(8401,'your IP is not authorized', '');
        }
        $res = Db::name('output_api')->where('cp_id',$cp_id)->find();

        if ($res['status'] != 1){
            z_json(8403,'Interface has been closed', '');
        }
    }


    // 今阅平台书籍
    const GET_BOOKIDS_URL = 'http://www.bqread.com/api/shuangxi/get_book_list.php'; // 获取所有授权作品 ID
    const GET_BOOKINFO_URL = 'http://www.bqread.com/api/shuangxi/get_book_info.php?aid='; // 获取书籍属性
    const GET_CHAPTERLIST_URL = 'http://www.bqread.com/api/shuangxi/get_chapter_list.php?aid='; // 获取书籍章节列表

    // 8200 成功
    // 8400 请求参数错误
    // 8401 身份验证错误
    // 8403 拒绝请求
    // 8404 书籍授权/请求书籍不存在
    private $ids = [];

    /**
     * 获取书籍列表
     */
    public function getBookList(){
        $ids = Db::name('output_api')->where('cp_id',7)->field('ids')->find();
        $this->ids = $ids['ids'];
        $books = Db::name('book')
            ->where('id','in',$this->ids)
            ->field('id as bookid,name,author')
            ->select();
        if ($books){
            z_json(8200,'success',$books);
        }else{
            z_json(8404,'null', '');
        }
    }

    /**
     * 通过 bookid 获取书籍详情
     */
    public function getBookInfo(){
        $bookid = input('get.bookid','0','intval');

        // 验证书籍id是否受权
        $check = $this->checkID($bookid);
        if(!$check){
            z_json(8401,'bookid Unauthorized', '');
        }
        if (!$bookid){
            z_json(8400,'bookid error', '');
        }
        $book = Db::name('book')
            ->alias('a')
            ->join('book_category b','a.cid = b.id')
            ->where('a.id',$bookid)
            ->field('a.id,a.name,a.author,a.type,a.is_end,a.info,a.type,a.image,b.name as category,words_num,time as create_time')
            ->find();
        $url = $_SERVER['SERVER_NAME'];
        $str = 'www.bqread.com';

        if ($book['type'] == 4){
            if(strpos($book['image'],$str) == false){
                // 判断 $book['image'] 中是否有www.bqread.com,如果没有则说明改过image
                $book['image'] = $url.$book['image'];
            }
        }else{
            $book['image'] = 'http://'.$url.$book['image'];
        }

        if ($book){
            z_json(8200,'success',$book);
        }else{
            z_json(8404,'null', '');
        }
    }

    public function chapterList(){
        $bookid = input('get.bookid','0','intval');
        // 验证书籍id是否受权
        $check = $this->checkID($bookid);
        if(!$check){
            z_json(8401,'bookid Unauthorized', '');
        }
        if (!$bookid){
            z_json(8400,'bookid error', '');
        }
        $book = Db::name('book')->where('id',$bookid)->field('type,other_bookid')->find();

        if ($book['type'] == 4){
            $url = $this::GET_CHAPTERLIST_URL.$book['other_bookid']; // 获取章节列表
            $res = httpPost($url);
            $arr= object_array($res['data']);
            foreach ($arr as $k=>$v){
                $list[$k]['chapterid'] = $v['chapterid'];
                $list[$k]['name'] = $v['chaptername'];
                $list[$k]['words_number'] = $v['words'];
                $list[$k]['create_time'] = date('Y-m-d H:i:s',strtotime($v['postdate']));
            }
        }else{
            $list = Db::name('chapter')
                ->where('b_id',$bookid)
                ->where('status',1)
                ->field('id as chapterid,name,content,time')
                ->order('id asc')
                ->select();
            foreach ($list as $k=>$v){
                $list[$k]['words_number'] = mb_strlen(DeleteHtml(strip_tags($v['content'])),'utf-8');
                $list[$k]['create_time'] = date('Y-m-d H:i:s',$v['time']);
                unset($list[$k]['content']);
                unset($list[$k]['time']);
            }
        }

        if ($list){
            z_json(8200,'success',$list);
        }else{
            z_json(8404,'null', '');
        }
    }

    public function getContent(){
        $bookid = input('get.bookid','0','intval');
        $chapterid = input('get.chapterid','0','intval');
        // 验证书籍id是否受权
        $check = $this->checkID($bookid);
        if(!$check){
            z_json(8401,'bookid Unauthorized', '');
        }
        if (!$bookid){
            z_json(8400,'bookid error', '');
        }

        $book = Db::name('book')->where('id',$bookid)->field('type,other_bookid')->find();
        if ($book['type'] == 4){
            $get_content_url = 'http://www.bqread.com/api/shuangxi/get_chapter_content.php?aid='.$book['other_bookid'].'&chapterid='.$chapterid;
            $r = httpPost($get_content_url);
            $info = object_array($r['data']);
            $data = [
                'content' => $info['content'],
            ];
        }else{
            $data = Db::name('chapter')
                ->where('b_id',$bookid)
                ->where('id',$chapterid)
                ->field('content')
                ->find();
            $data['content'] = trimHtml($data['content'],0,100000);
        }

        if ($data){
            z_json(8200,'success',$data);
        }else{
            z_json(8404,'null', '');
        }
    }

    /**
     * 验证bookid权限
     * @param $id
     * @return bool
     */
    public function checkID($id){
        $ids = Db::name('output_api')->where('cp_id',7)->field('ids')->find();
        $idArr = explode(',',$ids['ids']);
        return in_array($id,$idArr);
    }
}