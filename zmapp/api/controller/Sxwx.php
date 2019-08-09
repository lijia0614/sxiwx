<?php
/**
 * 双溪文学输出标准API模板
 * Created by PhpStorm.
 * User: 李贾
 * Date: 2019/5/9
 * Time: 16:36
 */

namespace app\api\controller;


use app\home\controller\Common;
use think\Db;

class Sxwx extends Common
{
    private $cp_id = 1; // 对方CP_ID,必填
    private $ids = []; // 所有授权书籍ID

    /**
     * 返回状态码说明
     * 8200 成功
     * 8400 请求参数错误
     * 8401 身份验证错误
     * 8403 拒绝请求
     * 8404 书籍未授权/请求书籍不存在
     */

    public function __construct() {
        parent::__construct();
        $ips = [
            '101.95.101.90',  // 对方IP
            '222.211.206.176' // 本地
        ];
        $ip = $_SERVER["REMOTE_ADDR"];
        $checkIp = in_array($ip,$ips);
        if (!$checkIp){
            z_json(8401,'your IP is not authorized', '');
        }
        $res = Db::name('output_api')->where('cp_id',$this->cp_id)->find();

        if ($res['status'] != 1){
            z_json(8403,'Interface has been closed', '');
        }
    }



    /**
     * 获取书籍列表
     */
    public function getBookList(){
        $ids = Db::name('output_api')->where('cp_id',$this->cp_id)->field('ids')->find();
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
            z_json(8401,'bookid Unauthorized','');
        }
        if (!$bookid){
            z_json(8400,'bookid error','');
        }
        $book = Db::name('book')
            ->alias('a')
            ->join('book_category b','a.cid = b.id')
            ->where('a.id',$bookid)
            ->field('a.id,a.name,a.author,a.is_end,a.info,a.image,b.name as category,words_num,time as create_time')
            ->find();
        $url = $_SERVER['SERVER_NAME'];
        $book['image'] = 'http://'.$url.$book['image'];
        if ($book){
            z_json(8200,'success',$book);
        }else{
            z_json(8404,'null', '');
        }
    }

    /**
     * 获取书籍章节列表
     */
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

        if ($list){
            z_json(8200,'success',$list);
        }else{
            z_json(8404,'null', '');
        }
    }

    /**
     * 获取章节内容
     */
    public function getContent(){
        $bookid = input('get.bookid','0','intval');
        $chapterid = input('get.chapterid','0','intval');
        if (!$chapterid){
            z_json(8400,'chapterid error', '');
        }
        // 验证书籍id是否受权
        $check = $this->checkID($bookid);
        if(!$check){
            z_json(8401,'bookid Unauthorized', '');
        }
        if (!$bookid){
            z_json(8400,'bookid error', '');
        }
        $data = Db::name('chapter')
            ->where('b_id',$bookid)
            ->where('id',$chapterid)
            ->field('content')
            ->find();
        $data['content'] = trimHtml($data['content'],0,100000);
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
        $ids = Db::name('output_api')->where('cp_id',$this->cp_id)->field('ids')->find();
        $idArr = explode(',',$ids['ids']);
        return in_array($id,$idArr);
    }
}