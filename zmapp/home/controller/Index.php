<?php
namespace app\home\controller;

use think\Controller;
use think\facade\Config;
use think\Db;
use think\facade\Env;
use think\facade\Validate;
use think\facade\Session;
use Upload\UploadFile;
use Payments\aliPay;
use Sms\aliyun;
use Excels\Excel;
use Oauths\qq;


class Index extends Common
{

    public function __construct()
    {
        parent::__construct();
    }


    /**
     * 首页
     * @author 四川挚梦科技有限公司
     * @date 2018-04-05
     */
    public function index()
    {
        $user_id = $this->user_id;
        if ($user_id) {
            $user = Db::name('member')->where('id', $user_id)->find();
            $this->assign('user', $user);
        }
        // 首页轮播推荐 3个
        $index = Db::name('book')
            ->where('is_del', 0)
            ->where('is_index', 1)
            ->where('status', 1)
            ->field('id,name,u_id,cid,words_num,image,info,author')
            ->order('index_sort asc')
            ->limit(8)
            ->select();
        foreach ($index as $k => $v){
            if($v['words_num'] > 9999){
                // 四舍五入保留小数点后两位
                $number = round($v['words_num']/10000,2);
                $index[$k]['words_num'] = $number.'万';
            }
        }

        $dashen = Db::name('book')
            ->where('is_del', 0)
            ->where('is_okami', 1)
            ->where('status', 1)
            ->order('okami_sort asc')
            ->field('id,name,u_id,cid,words_num,image,info,author')
            ->limit(3,3)
            ->select();

        foreach ($dashen as $k => $v){
            if($v['words_num'] > 9999){
                $number = round($v['words_num']/10000,2);
                $dashen[$k]['words_num'] = $number.'万';
            }
        }
        $this->assign('dashen',$dashen);
        // 精品推荐 is_fine：1; top 4
        $fine = Db::name('book')
            ->where('is_del', 0)
            ->where('is_fine', 1)
            ->order('fine_sort asc')
            ->field('id,name,u_id,cid,words_num,image,info,author')
            ->limit(4)
            ->select();
        foreach ($fine as $k => $v){
            if($v['words_num'] > 9999){
                $number = round($v['words_num']/10000,2);
                $fine[$k]['words_num'] = $number.'万';
            }
        }

        // 大神专区 is_okami：1 top 6
        $okami = Db::name('book')
            ->where('status', 1)
            ->where('is_del', 0)
            ->where('is_okami', 1)
            ->order('okami_sort asc')
            ->field('id,name,u_id,cid,words_num,image,info,author')
            ->limit(6)
            ->select();

        // 点击榜 top10
        $clicks = Db::name('book')
            ->where('status', 1)
            ->where('is_del', 0)
            ->order('clicks desc,id asc')
            ->field('id,name,u_id,image,info')
            ->limit(10)
            ->select();

        // 订阅帮 top10
        $take = Db::name('book')
            ->where('status', 1)
            ->where('is_del', 0)
            ->order('takes desc,id asc')
            ->field('id,name,u_id,image,info')
            ->limit(10)
            ->select();
        // 最近更新
        $new_table = Db::name('chapter')
            ->alias('a')
            ->join('book b','b.id = a.b_id')
            ->where('a.status' , 1)
            ->where('b.is_del' , 0)
            ->order('a.time desc')
            ->limit(50)
            ->field('a.id,a.name,a.time,a.b_id')
            ->buildSql();

        $news_chapter = Db::table($new_table . 'AS temp')
            ->group('b_id')
            ->order('time desc')
            ->limit(10)
            ->select();
//        c_print($news_chapter);
        foreach ($news_chapter as $k => $v) {
            $book = Db::name('book')
                ->where('id', $v['b_id'])
                ->field('id,name,words_num,author,cid,status')
                ->find();
            $news_chapter[$k]['book'] = $book;
            $news_chapter[$k]['words_num'] = $book['words_num'];
            $news_chapter[$k]['b_id'] = $book['id'];
        }

        foreach ($news_chapter as $k =>$v){
            if ($v['words_num'] > 9999){
                $news_chapter[$k]['words_num'] = round($v['words_num']/10000,2).'万';
            }
        }

        foreach ($news_chapter as $k=>$v){
            if ($v['book']['status'] == 0){
                array_splice($news_chapter, $k, 1);
            }
        }
        
        // 广告2
        $ad = Db::name('ad_postion')
            ->alias('a')
            ->join('ad b', 'a.id = b.postion_id')
            ->where('a.alias', '=', 'index_b')
            ->where('b.status', '=', '1')
            ->where('b.start_time', '<', time())
            ->where('b.end_time', '>', time())
            ->find();

        $this->assign('new', $news_chapter);
        $this->assign('ad', $ad);
        $this->assign('take', $take);
        $this->assign('index', $index);
        $this->assign('clicks', $clicks);
        $this->assign('okami', $okami);
        $this->assign('fine', $fine);
        return view();
    }

    public function agreement()
    {

        return view();
    }
}
