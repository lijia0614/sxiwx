<?php

namespace app\home\controller;

use Monolog\Handler\IFTTTHandler;
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


class Read extends Common {

    public function __construct() {

        parent::__construct();
    }

    /**
     * 首页
     */
    public function index() {
        $user_id = $this->user_id;
        $user = Db::name('member')->where('id',$user_id)->find();
        $this->assign('user',$user);
        $get = input('get.');
        $book = Db::name('book')
            ->where('id',$get['id'])
            ->where('is_del',0)
            ->where('status',1)
            ->find();
//        c_print($book['info']);
        $this->assign('info',$book['info']);
        if (!$book){
            $this->error('没有相关的书籍信息！','index/index');
        }

        $chapter_list = Db::name('chapter')
            ->where('b_id',$get['id'])
            ->where('is_del',0)
            ->where('status',1)
            ->field('content')
            ->select();

        $w = $book['words_num']; // 字数
        $beginToday = mktime(0,0,0,date('m'),date('d'),date('Y'));
        $endToday = mktime(0,0,0,date('m'),date('d')+1,date('Y'))-1;

        $beginThismonth=mktime(0,0,0,date('m'),1,date('Y'));
        $endThismonth=mktime(23,59,59,date('m'),date('t'),date('Y'));

        // 今日金主
        $todayMember = Db::name('gift')
            ->alias('a')
            ->join('member b','a.u_id = b.id')
            ->field('sum(a.total) as all_total,a.u_id,b.name,b.image')
            ->where('a.time','>=', $beginToday)
            ->where('a.time','<=', $endToday)
            ->where('a.b_id','=',$get['id'])
            ->group('u_id')
            ->limit(1)
            ->order('all_total desc')
            ->find();

        // 本月土豪
        $monthMember = Db::name('gift')
            ->alias('a')
            ->join('member b','a.u_id = b.id')
            ->field('sum(a.total) as all_total,a.u_id,b.name,b.image')
            ->where('a.time','>=', $beginThismonth)
            ->where('a.time','<=', $endThismonth)
            ->where('a.b_id','=',$get['id'])
            ->group('u_id')
            ->limit(1)
            ->order('all_total desc')
            ->find();

        // 捧场王
        $king = Db::name('gift')
            ->alias('a')
            ->join('member b','a.u_id = b.id')
            ->field('sum(a.total) as all_total,a.u_id,b.name,b.image')
            ->where('a.b_id','=',$get['id'])
            ->group('u_id')
            ->limit(1)
            ->order('all_total desc')
            ->find();

        // 最新动态
        $news = Db::name('gift')
            ->alias('a')
            ->join('member b','a.u_id = b.id')
            ->field('a.number,b.name,a.gift_name')
            ->where('a.b_id','=',$get['id'])
            ->limit(5)
            ->order('a.time desc')
            ->select();

        // 粉丝榜
        $fans = Db::name('gift')
            ->alias('a')
            ->join('member b','a.u_id = b.id')
            ->field('sum(a.total) as all_total,a.u_id,b.name,b.image')
            ->where('a.b_id','=',$get['id'])
            ->group('u_id')
            ->limit(10)
            ->order('all_total desc')
            ->select();

        // 查一共有多少目录
        $chapter_count = Db::name('chapter')
            ->where('b_id',$get['id'])
            ->where('is_del',0)
            ->where('status',1)
            ->count();

        //查询第一章
        $first = Db::name('chapter')->where('b_id',$get['id'])->order('id asc')->limit(1)->find();

        // 查询最后一章
        $last = Db::name('chapter')
            ->where('b_id',$get['id'])
            ->where('status',1)
            ->order('id desc')
            ->limit(1)
            ->find();
//        c_print($last);
        $last['content'] = mb_substr(strip_tags($last['content']), 0, 120, 'utf-8');

        // 打赏查询的人数
        $r_count = Db::name('reward')->where('b_id',$get['id'])->group('u_id')->count();

        // 查询留言
        $msg = Db::name('message')->where('b_id',$get['id'])->select();
        $m_count = Db::name('message')->where('b_id',$get['id'])->count();

        // 点击量+1
        $clicks = Db::name('book')->where('id',$get['id'])->field('clicks,info')->find();

        // 打赏
        $g_count  = Db::name('gift')->where('b_id',$get['id'])->sum('total');

        $now = [
            'clicks' => $clicks['clicks']+1
        ];
        Db::name('book')->where('id',$get['id'])->update($now);

        // 查询是否加入书架
        $data = [
            'u_id' => $this->user_id,
            'b_id' => $get['id']
        ];
        $is_take = Db::name('take')->where($data)->find();

        $this->assign('chapter_count',$chapter_count);
        $this->assign('king',$king);
        $this->assign('type',$book['type']);
        $this->assign('w',$w);
        $this->assign('fans',$fans);
        $this->assign('g_count',$g_count);
        $this->assign('news',$news);
        $this->assign('month',$monthMember);
        $this->assign('today',$todayMember);
        $this->assign('r_count',$r_count);
        $this->assign('is_take',$is_take);
        $this->assign('first',$first);
        $this->assign('last',$last);
        $this->assign('msg',$msg);
        $this->assign('m_count',$m_count);
        return view();
    }

    /**
     * 阅读第三方的书籍(第一章)
     */
    public function readOther(){
        $bookId = input('get.book_id');
        $chapterId = input('get.id');
        $get_content_url = 'http://store.zhewenit.com/api/Shuangxige/chapterinfo?bookId='.$bookId.'&chapterId='.$chapterId;
        $r = httpPost($get_content_url);
        $c_info = object_array($r['data']);
        $data = $c_info['books']['content'];

        $book = Db::name('book')->where('other_bookid',$bookId)->find();
        c_print($book);

    }

    public function readList(){
        $b_id = input('get.b_id');
        $book = Db::name('book')
            ->where('id',$b_id)
            ->where('is_del',0)
            ->where('status',1)
            ->find();
        $bookId = $book['other_bookid'];
        if ($book['type'] == 3){
            $url = 'http://store.zhewenit.com/api/Shuangxige/structure?bookId='.$bookId;
            $res = httpPost($url);
            if ($res['code'] != 0){
                return false;
            }
            $data = object_array($res['data']);
            $chapter = $data['books'];
            $count = count($chapter);
        }elseif ($book['type'] == 4){
            $url = 'http://www.bqread.com/api/shuangxi/get_chapter_list.php?aid='.$bookId;
            $res = httpPost($url);
            if ($res['code'] != 0){
                return false;
            }
            $chapter = object_array($res['data']);
            $count = count($chapter);

        }else{
            $chapter = Db::name('chapter')
                ->where('b_id',$b_id)
                ->where('status',1)
                ->where('is_del',0)
                ->order('id asc')
                ->select();
            $count = Db::name('chapter')
                ->where('b_id',$b_id)
                ->where('status',1)
                ->where('is_del',0)
                ->count();
        }
        $this->assign('type',$book['type']);
        $this->assign('count',$count);
        $this->assign('chapter',$chapter);
        $this->assign('book',$book);
        $this->assign('bookId',$bookId);
        return view();
    }

    /**
     * 赠送礼物
     */
    public function toGift(){
        if(empty($this->user_id)){
            JsonDie("0", '请先登录', '','');
            exit();
        }
        if ($_POST){
            $post = input('post.');
            $total = $post['u_price'] * $post['number'];

            $user = Db::name('member')->where('id',$this->user_id)->field('id,money')->find();

            $week = strtotime('-1week'); // 一周前的时间戳
            $signMoney = Db::name('sign') // 未使用签到的金币
            ->where('u_id',$this->user_id)
                ->where('status',1)
                ->where('create_time','>',$week)
                ->sum('money');

            if ($total > $user['money'] && $total > $signMoney){
                JsonDie("0", '余额不足', '','');
            }

            if ($post['name'] == 1){
                $post['name'] = '玫瑰花';
            }
            if ($post['name'] == 2){
                $post['name'] = '巧克力';
            }
            if ($post['name'] == 3){
                $post['name'] = '金元宝';
            }
            if ($post['name'] == 4){
                $post['name'] = '钻石';
            }
            if ($post['name'] == 5){
                $post['name'] = '南瓜马车';
            }
            if ($post['name'] == 6){
                $post['name'] = '文思泉涌牌';
            }
            $data = [
                'gift_name' => $post['name'],
                'u_id' => $this->user_id,
                'b_id' =>$post['b_id'],
                'number' => $post['number'],
                'total' => $total,
                'msg' => $post['msg'],
                'time' => time()
            ];

            if ($total <= $signMoney){
                $Sign = new Sign();
                $res = $Sign->signBuy($total);
                if ($res){
                    Db::name('gift')->insert($data);
                    JsonDie("1", '赠送成功', '','');
                }
            }

            $now_money = $user['money'] - $total;
            // 启动事务
            Db::startTrans();
            try{
                Db::name('gift')->insert($data);
                Db::name('member')->where('id',$this->user_id)->update(['money' => $now_money]);
                // 提交事务
                Db::commit();
                JsonDie("1", '赠送成功', '','');
            } catch (\Exception $e) {
                // 回滚事务
                Db::rollback();
                JsonDie("0", '赠送失败', '','');
            }
        }else{
            JsonDie("0", '提交渠道错误', '','');
        }
    }

    /**
     * 章节列表
     */
    public function chapter_list(){
        $user_id = $this->user_id;
        if ($user_id){
            $user = Db::name('member')->where('id',$user_id)->find();
            $this->assign('user',$user);
        }

        $get = input('get.');
        $book = Db::name('book')->where('id',$get['id'])->find();
        $this->assign('type',$book['type']);
        if ($book['type'] == 3){
            // 三方平台的书籍
            $bookId = $book['other_bookid'];
            $url = 'http://store.zhewenit.com/api/Shuangxige/structure?bookId='.$bookId;
            $res = httpPost($url);
            if ($res['code'] != 0){
                return false;
            }
            $otherData = object_array($res['data']);
            $otherChapter = $otherData['books'];
//            c_print($otherChapter);
            $otherCount = count($otherChapter);
            $this->assign('o_list',$otherChapter);
            $this->assign('otherCount',$otherCount);
            $this->assign('book_id',$bookId);
        }
        if ($book['type'] == 4){
            // 三方平台的书籍
            $bookId = $book['other_bookid'];
            $url = 'http://www.bqread.com/api/shuangxi/get_chapter_list.php?aid='.$bookId;
            $res = httpPost($url);
            if ($res['code'] != 0){
                return false;
            }
            $otherChapter = object_array($res['data']);

            $otherCount = count($otherChapter);
            $this->assign('t_list',$otherChapter);
            $this->assign('otherCount',$otherCount);
            $this->assign('book_id',$bookId);
        }
        $chapter_list = Db::name('chapter')
            ->where('b_id',$get['id'])
            ->where('is_del',0)
            ->where('status',1)
            ->field('content')
            ->select();
        $w = 0; // 字数
        foreach ($chapter_list as $k=>$v){
            $w += mb_strlen(strip_tags(DeleteHtml($v['content'])),'utf-8');
        }

        // 查询第一章
        $first = Db::name('chapter')->where('b_id',$get['id'])->order('id asc')->limit(1)->find();

        // 查一共有多少章节
        $chapter_count = Db::name('chapter')
            ->where('b_id',$get['id'])
            ->where('is_del',0)
            ->where('status',1)
            ->count();
        $where = [
            'b_id' => $get['id'],
            'is_del' => 0,
            'status' => 1
        ];
        $list =  Db::name('chapter')
            ->where($where)
            ->field('id,name,price')
            ->order('id asc')
            ->select();
        // 查询收费节点
        $node = Db::name('book')->where('id',$get['id'])->field('node')->find();

        // 查询是否加入书架
        $data = [
            'u_id' => $this->user_id,
            'b_id' => $get['id']
        ];
        $is_take = Db::name('take')->where($data)->find();
        $this->assign('first',$first);
        $this->assign('w',$w);
        $this->assign('chapter_count',$chapter_count);
        $this->assign('list',$list);
        $this->assign('node',$node['node']);
        $this->assign('is_take',$is_take);
        return view();
    }

    /**
     * 加入书架
     */
    public function take(){
        $this->isLogin();
        $b_id = input('post.b_id','','intval');

        $data = [
            'u_id' => $this->user_id,
            'b_id' => $b_id
        ];
        $is_take = Db::name('take')->where($data)->find();
        if ($is_take){
            $this->error('该书您已加入书架，请不要重复操作');
        }

        $res = Db::name('take')->insert($data);
        if ($res){
            $this->success('加入成功');
        }else{
            $this->error('加入失败');
        }
    }


    public function getOtherChapters(){
        $bookId = input('post.bookId');
        $url = 'http://store.zhewenit.com/api/Shuangxige/structure?bookId='.$bookId;
        $res = httpPost($url);
        if ($res['code'] != 0){
            return false;
        }
        $data = object_array($res['data']);
        $chapters = $data['books'];
        return JsonDie(1,'success','yes',$chapters);
    }

    public function getjinYueChapters(){
        $bookId = input('post.bookId');
        $url = 'http://www.bqread.com/api/shuangxi/get_chapter_list.php?aid='.$bookId;
        $res = httpPost($url);
        if ($res['code'] != 0){
            return false;
        }
        $chapters = object_array($res['data']);

        return JsonDie(1,'success','yes',$chapters);
    }

    /**
     * 阅读章节
     *
     */
	public function read(){
        $user_id = $this->user_id;
        if ($user_id){
            $user = Db::name('member')->where('id',$user_id)->find();
            $this->assign('user',$user);
        }
        $get = input('get.');
        $bookId = input('get.bookId');
        if ($bookId){
            // 第三方平台的书籍
            $book = Db::name('book')
                ->where('other_bookid',$bookId)
                ->where('is_del',0)
                ->where('status',1)
                ->find();
        }else{
            $book = Db::name('book')
                ->where('id',$get['b_id'])
                ->where('is_del',0)
                ->where('status',1)
                ->find();
        }
        $this->assign('type',$book['type']);
        if (!$book){
            $this->error('没有相关的书籍信息！','index/index');
        }
        // 增加阅读记录
        if ($user_id){
            $is_read = [
                'u_id' => $this->user_id,
                'b_id' => $book['id']
            ];
            $is_read = Db::name('read_record')->where($is_read)->find(); // 判断用户是否已经阅读过这本书
            if ($is_read){
                $data = [
                    'chapter_id' => $get['id'],
                    'time' => time()
                ];
                Db::name('read_record')->where($is_read)->update($data);
            }else{
                $data = [
                    'u_id' => $this->user_id,
                    'chapter_id' => $get['id'],
                    'b_id' => $book['id'],
                    'time' => time()
                ];
                Db::name('read_record')->insert($data);
            }
        }

        else{
            // 上一页
            $prevs = Db::name("chapter")->where("b_id",$get['b_id'])->where('id','<',$get['id'])->order("id desc")->find();
            // 下一页
            $nexts = Db::name("chapter")
                ->where("b_id",$get['b_id'])
                ->where('id','>',$get['id'])
                ->where('status',1)
                ->order("id asc")
                ->find();
        }

        // 查询分类名b_
        $category = Db::name('book_category')->where('id',$book['cid'])->find();
        
        // 查询收费类型
        if ($book['node'] != ''){
            // 查询该章节是否收费
            if($this->user_id == $book['u_id'] && $this->user_id){


                $data =  Db::name('chapter')->where('b_id',$get['b_id'])->where('id',$get['id'])->find();
                $count = mb_strlen(strip_tags(DeleteHtml($data['content'])),'UTF-8'); // 字数
                $this->assign('count',$count);
                $this->assign('data',$data);
                $this->assign('book',$book);
                $this->assign('prevs',$prevs);
                $this->assign('nexts',$nexts);
                $this->assign('category',$category);
                return view();
            }
            $node = $book['node'];
            $num = Db::name('chapter')  // 统计当前是第多少章
            ->where('b_id',$get['b_id'])
                ->where('id','<=',$get['id'])
                ->where('status',1)
                ->count('id');

            if($num > ($node-1)){
//                 echo "收费";
                // 检查用户是否是会员
                $check_vip = checkVip($this->user_id);
                if ($check_vip){
                    // 是会员
                    $data =  Db::name('chapter')->where('b_id',$get['b_id'])->where('id',$get['id'])->find();
                    $count = mb_strlen(strip_tags(DeleteHtml($data['content'])),'UTF-8'); // 字数
                    $this->assign('data',$data);
                    $this->assign('count',$count);
                    $this->assign('prevs',$prevs);
                    $this->assign('nexts',$nexts);
                    $this->assign('book',$book);
                    $this->assign('category',$category);
                    return view();
                }
                $one_where = [
                    'u_id' => $this->user_id,
                    'z_id' => $get['id'],
                    'status' => 1
                ];
                $is_one = Db::name('reward')->where($one_where)->find(); // 已经购买本章节

                if ($is_one){
                    // 已经购买过本章节

                    // 已购买本章节
                    $data =  Db::name('chapter')->where('b_id',$get['b_id'])->where('id',$get['id'])->find();
                    $count = mb_strlen(strip_tags(DeleteHtml($data['content'])),'UTF-8'); // 字数
                    $this->assign('data',$data);
                    $this->assign('count',$count);
                    $this->assign('prevs',$prevs);
                    $this->assign('nexts',$nexts);
                    $this->assign('book',$book);
                    $this->assign('category',$category);
                    return view();
                }else{
                    // 未购买

                    if ($book['price'] != ''){
                        // 查询是否已经购买章节  整本出售的书籍
                        $all_where = [
                            'b_id' => $get['b_id'],
                            'u_id' => $this->user_id,
                            'status' => 2
                        ];
                        $is_all = Db::name('reward')->where($all_where)->find(); // 已经购买整本
                        if ($is_all){
                            // 已经购买整本书

                            $data =  Db::name('chapter')->where('b_id',$get['b_id'])->where('id',$get['id'])->find();
                            $count = mb_strlen(strip_tags(DeleteHtml($data['content'])),'UTF-8'); // 字数
                            $this->assign('data',$data);
                            $this->assign('count',$count);
                            $this->assign('prevs',$prevs);
                            $this->assign('nexts',$nexts);
                            $this->assign('book',$book);
                            $this->assign('category',$category);
                            return view();
                        }else{
                            // 未购买本章节
                            $data =  Db::name('chapter')->where('b_id',$get['b_id'])->where('id',$get['id'])->find();
                            $count = mb_strlen(strip_tags(DeleteHtml($data['content'])),'UTF-8'); // 字数
                            $data['content'] = mb_substr(strip_tags($data['content']), 0, 180, 'utf-8');
                            $all = 1;
                            $url='http://'.$_SERVER['SERVER_NAME'].$_SERVER["REQUEST_URI"];
                            $this->assign('back',$url);
                            $this->assign('price',$book['price']);
                            $this->assign('all',$all);
                            $this->assign('count',$count);
                            $this->assign('data',$data);
                            $this->assign('book',$book);
                            $this->assign('prevs',$prevs);
                            $this->assign('nexts',$nexts);
                            $this->assign('category',$category);
                            return view('read_s');
                        }
                    }else{
                        $data =  Db::name('chapter')->where('b_id',$get['b_id'])->where('id',$get['id'])->find();
                        $count = mb_strlen(strip_tags(DeleteHtml($data['content'])),'UTF-8'); // 字数
                        $data['content'] = mb_substr(strip_tags($data['content']), 0, 180, 'utf-8');
                        // 该章节费用 5书币每1000字 只以1000为单位，采用向下取整
                        $n = floor($count/1000);
                        if ($n < 1){
                            $n = 1;
                        }
                        $price = $n * 5 ;
                        $url='http://'.$_SERVER['SERVER_NAME'].$_SERVER["REQUEST_URI"];
                        $this->assign('back',$url);
                        $this->assign('price',$price);
                        $this->assign('count',$count);
                        $this->assign('data',$data);
                        $this->assign('book',$book);
                        $this->assign('prevs',$prevs);
                        $this->assign('nexts',$nexts);
                        $this->assign('category',$category);
                        return view('read_s');
                    }
                }
            }else{
                // 不收费
                $data =  Db::name('chapter')->where('b_id',$get['b_id'])->where('id',$get['id'])->find();
                $count = mb_strlen(strip_tags(DeleteHtml($data['content'])),'UTF-8'); // 字数
                $this->assign('count',$count);
                $this->assign('data',$data);
                $this->assign('book',$book);
                $this->assign('prevs',$prevs);
                $this->assign('nexts',$nexts);
                $this->assign('category',$category);
                return view();
            }
        }
        return view();
    }

    /**
     * 购买章节
     */
    public function buy(){
        $this->isLogin();

        $money_ary = Db::name('member')->where('id',$this->user_id)->field('money')->find();
        $money = $money_ary['money']; // 余额
	    $id = input('post.id','','intval'); // 章节ID
        $b_id = input('post.b_id','','intval'); // 书籍ID
        $bookId = input('post.bookId','','intval');
        $book = Db::name('book')->where('other_bookid',$bookId)->field('id,type')->find();

        $chapterId = input('post.chapterId','','intval');

        if ($chapterId){
            if ($book['type'] == 3){
                $get_content_url = 'http://store.zhewenit.com/api/Shuangxige/chapterinfo?bookId='.$bookId.'&chapterId='.$chapterId;
                $r = httpPost($get_content_url);
                $c_info = object_array($r['data']);
                $data = $c_info['books'];
                $n = floor($data['words']/1000);
            }
            if ($book['type'] == 4){
                $get_content_url = 'http://www.bqread.com/api/shuangxi/get_chapter_content.php?aid='.$bookId.'&chapterid='.$chapterId;
                $r = httpPost($get_content_url);
                $data = object_array($r['data']);
                $n = floor($data['words']/1000);
            }
        }else{
            $info = Db::name('chapter')->where('id',$id)->find();
            $count = mb_strlen(strip_tags($info['content']),'UTF-8'); // 字数
            // 该章节费用 5书币每1000字 只以1000为单位，采用向下取整
            $n = floor($count/1000);
        }
        if ($n < 1){
            $n = 1;
        }
        $price = $n * 5 ; //购买价格

        $week = strtotime('-1week'); // 一周前的时间戳
        $signMoney = Db::name('sign') // 未使用签到的金币
            ->where('u_id',$this->user_id)
            ->where('status',1)
            ->where('create_time','>',$week)
            ->sum('money');

        if ($price > $money && $price > $signMoney){
            JsonDie("0", '余额不足', '','');
        }

        if ($chapterId){
            if ($book['type'] == 3){
                $r_data = [
                    'b_id' => $book['id'],
                    'z_id' => $chapterId,
                    'u_id' => $this->user_id,
                    'price' => $price,
                    'time' => time(),
                    'status' => 1 // 只购买章节
                ];
            }
            if ($book['type'] == 4){
                $r_data = [
                    'b_id' => $book['id'],
                    'z_id' => $chapterId,
                    'u_id' => $this->user_id,
                    'price' => $price,
                    'time' => time(),
                    'status' => 1 // 只购买章节
                ];
            }
        }else{
            $r_data = [
                'b_id' => $b_id,
                'z_id' => $id,
                'u_id' => $this->user_id,
                'price' => $price,
                'time' => time(),
                'status' => 1 // 只购买章节
            ];
        }

        if ($price <= $signMoney){
            $Sign = new Sign();
            $res = $Sign->signBuy($price);
            if ($res){
                Db::name('reward')->insert($r_data);
                JsonDie("1", '购买成功', '','');
            }
        }

        $now_money = $money - $price;

        $book = Db::name('book')->where('id',$b_id)->field('takes')->find();
        $where = [
            'takes' => $book['takes'] + $price
        ];

        // 启动事务
        Db::startTrans();
        try{
            Db::name('member')->where('id',$this->user_id)->update(['money' => $now_money]);
            Db::name('book')->where('id',$b_id)->update($where);
            Db::name('reward')->insert($r_data);
            // 提交事务
            Db::commit();
            JsonDie("1", '购买成功', '','');
        } catch (\Exception $e) {
            // 回滚事务
            Db::rollback();
            JsonDie("0", '购买失败', '','');
        }

    }

    /**
     * 购买整本书
     */
    public function buy_all(){
        $this->isLogin();
        $money_ary = Db::name('member')->where('id',$this->user_id)->field('money')->find();
        $money = $money_ary['money']; // 余额
        $b_id = input('post.b_id','','intval'); // 书籍ID
        $book = Db::name('book')->where('id',$b_id)->find();

        $price = $book['price'];

        $week = strtotime('-1week'); // 一周前的时间戳
        $signMoney = Db::name('sign') // 未使用签到的金币
        ->where('u_id',$this->user_id)
            ->where('status',1)
            ->where('create_time','>',$week)
            ->sum('money');

        if ($price > $money && $price > $signMoney){
            JsonDie("0", '余额不足', '','');
        }
        $r_data = [
            'b_id' => $b_id,
            'u_id' => $this->user_id,
            'price' => $price,
            'time' => time(),
            'status' => 2 // 购买整书
        ];
        if ($price <= $signMoney){
            $Sign = new Sign();
            $res = $Sign->signBuy($price);
            if ($res){
                Db::name('reward')->insert($r_data);
                JsonDie("1", '购买成功', '','');
            }
        }

        $now_money = $money - $price;

        $where = [
            'takes' => $book['takes'] + $price
        ];
        // 启动事务
        Db::startTrans();
        try{
            Db::name('member')->where('id',$this->user_id)->update(['money' => $now_money]);
            Db::name('reward')->insert($r_data);
            Db::name('book')->where('id',$b_id)->update($where);
            // 提交事务
            Db::commit();
            JsonDie("1", '购买成功', '','');
        } catch (\Exception $e) {
            // 回滚事务
            Db::rollback();
            JsonDie("0", '购买失败', '','');
        }

    }

    /**
     * 留言
     */
    public function to_msg(){
        if (empty($this->user_id)) {
            $this->error('登录之后才能留言哦！');
            exit();
        }
        $post = input('post.');
        $info = Db::name('book')->where('id',$post['b_id'])->field('u_id')->find();
        $user = Db::name('member')->where('id',$this->user_id)->field('pen_name,image')->find();
        $data = [
            'u_id' => $this->user_id,
            'b_id' => $post['b_id'],
            'author_id' => $info['u_id'], // 作者id
            'content' => $post['content'],
            'u_name' => $user['pen_name'],
            'image' => $user['image'],
            'time' => time()
        ];
        $res = Db::name('message')->insert($data);
        if ($res){
            $this->success('留言成功');
        }else{
            $this->error('留言失败');
        }
    }

}










