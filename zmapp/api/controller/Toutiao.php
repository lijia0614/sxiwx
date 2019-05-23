<?php
/**
 * 头条连载 (输出)
 * Created by PhpStorm.
 * User: 李贾
 * Date: 2019/4/15
 * Time: 15:23
 */

namespace app\api\controller;


use app\home\controller\Common;
use think\Db;

class Toutiao extends Common
{
    public function __construct() {
        parent::__construct();
        $cp_id = 5;
        $res = Db::name('output_api')->where('cp_id',$cp_id)->find();
        if ($res['status'] != 1){
            c_json(0,'Interface has been closed', '');
        }
    }

    // 今阅平台书籍
    const GET_BOOKIDS_URL = 'http://www.bqread.com/api/shuangxi/get_book_list.php'; // 获取所有授权作品 ID
    const GET_BOOKINFO_URL = 'http://www.bqread.com/api/shuangxi/get_book_info.php?aid='; // 获取书籍属性
    const GET_CHAPTERLIST_URL = 'http://www.bqread.com/api/shuangxi/get_chapter_list.php?aid='; // 获取书籍章节列表

    /**
     * 获取授权书籍列表
     * @return xml数据
     */
    public function getBookList(){
        $url = $_SERVER['SERVER_NAME'];
        $ids = Db::name('output_api')->where('cp_id',5)->field('ids')->find();
        $this->ids = $ids['ids'];
        $books = Db::name('book')
            ->alias('a')
            ->join('book_category b','a.cid = b.id')
            ->where('a.id','in',$this->ids)
            ->field('a.id,a.name,a.author,type,a.image,a.info,a.is_end,a.node,a.start_time,b.name as category,other_bookid')
            ->select();
        switch ($books['cid']){
            case 21:
                $book['channel'] = 'M';
                break;
            default:
                $book['channel'] = 'W';
                break;
        }
        $str = 'www.bqread.com';
        header("Content-type:text/xml;");
        $xml = "<?xml version=\"1.0\" encoding=\"utf-8\"?>";
        $xml .= "<rss version=\"2.0\">";
        $xml .= "<channel>";
        $xml .= "<title><![CDATA[双溪文学]]></title>";
        $xml .= "<description><![CDATA[双溪文学，为情而造文]]></description>";
        $xml .= "<link><![CDATA[http://www.sxiwx.com]]></link>";
        $xml .= "<next_page><![CDATA[]]></next_page>";
        
        foreach ($books as $key => $val){
            $saleChapterId = Db::name('chapter') // 开始收费章节
                ->where('b_id',$val['id'])
                ->limit($val['node'],1)
                ->order('id asc')
                ->field('id,name')
                ->select();
            if($val['is_end'] == 1){
                $status = 0;  // 完结
            }else{
                $status = 1;
            }
            $xml .= "<item>";
            $xml .= "<source><![CDATA[双溪文学]]></source>";
            $xml .= "<author><![CDATA[".$val['author']."]]></author>";
            $xml .= "<book_id><![CDATA[".$val['id']."]]></book_id>";
            $xml .= "<title><![CDATA[".$val['name']."]]></title>";
            $xml .= "<subtitle><![CDATA[]]></subtitle>";
            $xml .= "<link><![CDATA[http://www.sxiwx.com/api/Toutiao/getChapterList?bookId=".$val['id']."]]></link>";

            if(strpos($val['image'],$str) !== false){
                // 判断 $book['image'] 中是否有www.bqread.com,如果没有则说明改过image
                $xml .= "<thumb_url><![CDATA[".$val['image']."]]></thumb_url>";
            }else{
                $xml .= "<thumb_url><![CDATA[http://".$url.$val['image']."]]></thumb_url>";
            }

            $xml .= "<description><![CDATA[".$val['info']."]]></description>";
            $xml .= "<creation_status><![CDATA[".$status."]]></creation_status>";
            $xml .= "<genre><![CDATA[0]]></genre>";
            $xml .= "<sale_status><![CDATA[1]]></sale_status>";
            $xml .= "<price><![CDATA[]]></price>";
            $xml .= "<sale_chapter_id><![CDATA[".$saleChapterId['0']['id']."]]></sale_chapter_id>";

            if ($val['type'] == 4) {
                $xml .= "<pubDate><![CDATA[2018-04-22 17:05:22]]></pubDate>";
            }else{
                $xml .= "<pubDate><![CDATA[" . $val['start_time'] . "]]></pubDate>";
            }
            $xml .= "<category><![CDATA[".$val['category']."]]></category>";
            $xml .= "</item>";
        }
        $xml .="</channel>";
        $xml .="</rss>";
        return $xml;
    }

    /**
     * 通过书籍ID获取章节列表
     */
    public function getChapterList(){
        $id = input('get.bookId','','intval');
        $book = Db::name('book')
            ->where('id',$id)
            ->field('author,node,type,other_bookid')
            ->find();
        if ($book['type'] == 4){
            $url = $this::GET_CHAPTERLIST_URL.$book['other_bookid']; // 获取章节列表
            $res = httpPost($url);
            $arr = object_array($res['data']);
            $data = [];
            foreach ($arr as $k=>$v){
                $data[$k]['id'] = $v['chapterid'];
                $data[$k]['name'] = $v['chaptername'];
                $data[$k]['time'] = strtotime($v['postdate']);
            }
        }else{
            $data = Db::name('chapter')
                ->where('b_id',$id)
                ->where('status',1)
                ->field('id,name,time')
                ->order('id asc')
                ->select();
        }

        header("Content-type:text/xml;");
        $xml = "<?xml version=\"1.0\" encoding=\"utf-8\"?>";
        $xml .= "<rss version=\"2.0\">";
        $xml .= "<channel>";
        $xml .= "<title><![CDATA[双溪文学]]></title>";
        $xml .= "<description><![CDATA[双溪文学，为情而造文]]></description>";
        $xml .= "<link><![CDATA[http://www.sxiwx.com]]></link>";
        $xml .= "<next_page><![CDATA[]]></next_page>";
        foreach ($data as $k => $v){
            $sale_status = 0;
            if($k+2 > $book['node']){
                $sale_status = 1;
            }
            $index = $k+1;
            $xml .= "<item>";
            $xml .= "<source><![CDATA[双溪文学]]></source>";
            $xml .= "<author><![CDATA[".$book['author']."]]></author>";
            $xml .= "<book_id><![CDATA[".$id."]]></book_id>";
            $xml .= "<chapter_id><![CDATA[".$v['id']."]]></chapter_id>";
            $xml .= "<index><![CDATA[".$index."]]></index>";
            $xml .= "<title><![CDATA[".$v['name']."]]></title>";
            $xml .= "<link><![CDATA[http://www.sxiwx.com/api/Toutiao/getContent?bookId=".$id."&chapterId=".$v['id']."]]></link>";
            $xml .= "<pubDate><![CDATA[".date('Y-m-d H:i:s',$v['time'])."]]></pubDate>";
            $xml .= "<sale_status><![CDATA[".$sale_status."]]></sale_status>";
            $xml .= "<tome_name><![CDATA[正文]]></tome_name>";
            $xml .= "</item>";
        }
        $xml .="</channel>";
        $xml .="</rss>";
        return $xml;
    }

    /**
     * 根据章节ID获取章节内容
     */
    public function getContent(){
        $id = input('get.chapterId','','intval');
        $bookId = input('get.bookId','','intval');
        $book = Db::name('book')
            ->where('id',$bookId)
            ->field('author,node,type,other_bookid')
            ->find();
        if ($book['type'] == 4){
            $get_content_url = 'http://www.bqread.com/api/shuangxi/get_chapter_content.php?aid='.$book['other_bookid'].'&chapterid='.$id;
            $r = httpPost($get_content_url);
            $info = object_array($r['data']);
            $data = [
                'id' => $info['chapterid'],
                'name' => $info['chaptername'],
                'content' => $info['content'],
                'time' => strtotime($info['postdate'])
            ];
        }else{
            $data = Db::name('chapter')
                ->where('id',$id)
                ->where('status',1)
                ->field('id,name,content,time')
                ->find();
        }

        $content = trimHtml($data['content'],0,1000000);
        header("Content-type:text/xml;");
        $xml = "<?xml version=\"1.0\" encoding=\"utf-8\"?>";
        $xml .= "<rss version=\"2.0\">";
        $xml .= "<channel>";
        $xml .= "<title><![CDATA[双溪文学]]></title>";
        $xml .= "<description><![CDATA[双溪文学，为情而造文]]></description>";
        $xml .= "<link><![CDATA[http://www.sxiwx.com]]></link>";
        $xml .= "<item>";
        $xml .= "<title><![CDATA[".$data['name']."]]></title>";
        $xml .= "<description><![CDATA[".$content."]]></description>";
        $xml .= "<pubDate><![CDATA[".date('Y-m-d H:i:s',$data['time'])."]]></pubDate>";
        $xml .= "</item>";
        $xml .="</channel>";
        $xml .="</rss>";
        return $xml;
    }
}