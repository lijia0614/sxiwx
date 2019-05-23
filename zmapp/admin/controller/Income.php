<?php

namespace app\admin\controller;
use think\Controller;
use think\Exception;
use think\facade\Config;
use think\facade\Request;
use think\facade\Session;
use think\Db;
use app\common\controller\AppCommon;
use app\admin\model\RoleNav;
use app\admin\model\OperationLog;
use Auths\Auth;
use Pages\Page;
use Tree\Tree;

class Income extends Common
{

    public function __construct()
    {
        parent::__construct();
        $modules = $this->getModule(CONTROLLER); //获取模型配置

        $this->assign("modules", $modules);
        $this->modelFields($modules['table']);
    }

    /**
     * 书籍稿费
     */
    public function bookFee(){
        $cof = Db::name('config')->where('c_key','CUSTOMIZE_SITE')->field('c_value')->find();
        $config = json_decode($cof['c_value']);
        $arr  = object_to_array($config);


        $c_id = input('get.c_id');
        $ary_get['pageall'] = input("request.pageall", 15, 'intval');
        $keyword = input("get.keyword", '');
        $where = 'is_del = 0 AND ';
        if ($c_id != ""){
            $where .= "cid = '".$c_id."' AND ";
        }
        if (!empty($keyword)) {
            $where .= "name like '%" . urldecode($keyword) . "%' OR ";
            $where .= "author like '%" . urldecode($keyword) . "%' AND ";
        }

        $where .= "1 = 1";
        $count = Db::name('book')->where($where)->count();
        $this->assign("count", 20);
        $obj_page = $this->_Page($count, $ary_get['pageall']);
        $page = $obj_page->newshow();

        $date = date('Y-m-d',time());
        $monthStart =  date('Y-m-01', strtotime($date));
        $monthEnd = date('Y-m-d', strtotime(date('Y-m-01', strtotime($date)) . ' +1 month -1 day'));

        $ary_data = Db::name('book')
            ->where($where)
            ->field('id,name,cid,author,is_end')
            ->order("id asc")
            ->limit($obj_page->firstRow, $obj_page->listRows)
            ->select();
        foreach ($ary_data as $k=>$v){
            $chapter_list = Db::name('chapter')
                ->where('b_id',$v['id'])
                ->where('is_del',0)
                ->where('status',1)
                ->field('content')
                ->select();
            $count = Db::name('chapter')
                ->where('b_id',$v['id'])
                ->where('is_del',0)
                ->where('status',1)
                ->count();
            $chapter_m = Db::name('chapter')
                ->where('b_id',$v['id'])
                ->where('is_del',0)
                ->where('status',1)
                ->where('time','>',strtotime($monthStart))
                ->where('time','<',strtotime($monthEnd))
                ->field('content')
                ->select();
            $count_m = Db::name('chapter')
                ->where('b_id',$v['id'])
                ->where('is_del',0)
                ->where('status',1)
                ->where('time','>',strtotime($monthStart))
                ->where('time','<',strtotime($monthEnd))
                ->count();
            $ary_data[$k]['count'] = $count;
            $w = 0; // 字数
            foreach ($chapter_list as $key=>$val){
                $w += mb_strlen(strip_tags(DeleteHtml($val['content'])),'utf-8');
            }
            $ary_data[$k]['words_num'] = $w;
            $ary_data[$k]['fee'] = round($w/1000*$arr['fee'],2);

            $w1 = 0;
            if ($chapter_m){
                foreach ($chapter_m as $key=>$val){
                    $w1 += mb_strlen(strip_tags(DeleteHtml($val['content'])),'utf-8');
                }
                $ary_data[$k]['count_m'] = $count_m;
                $ary_data[$k]['words_m'] = $w1;
                $ary_data[$k]['fee_m'] = round($w1/1000*$arr['fee'],2);
            }else{
                $ary_data[$k]['count_m'] = 0;
                $ary_data[$k]['words_m'] = 0;
                $ary_data[$k]['fee_m'] = 0;
            }
        }
//        array_multisort(array_column($ary_data,'fee_m'),SORT_DESC,$ary_data);

        $this->assign('fee',$arr['fee']);
        $this->assign("list", $ary_data);
        $this->assign("category", $c_id);
        $this->assign("page", $page);
        return view();
    }

    /**
     * 书籍稿费详细
     */
    public function feeInfo(){
        $start_date = input("get.start_date", '');
        $end_date = input("get.end_date", '');
        $id = input('get.id');

        $date = date('Y-m-d',time());
        $monthStart =  date('Y-m-01', strtotime($date));
        $monthEnd = date('Y-m-d', strtotime(date('Y-m-01', strtotime($date)) . ' +1 month -1 day'));
        $where = '';
        if (!empty($start_date) && empty($end_date)){
            $where .= "time > '".strtotime($start_date)."' AND ";
        }elseif(!empty($end_date) && empty($start_date)){
            $where .= "time < '".strtotime($end_date)."' AND ";
        }elseif (!empty($start_date) && !empty($end_date)){
            $where .= "time > '".strtotime($start_date)."' AND ";
            $where .= "time < '".strtotime($end_date)."' AND ";
        }else{
            $where .= "time > '".strtotime($monthStart)."' AND ";
            $where .= "time < '".strtotime($monthEnd)."' AND ";
            $this->assign('start_date',$monthStart);
            $this->assign('end_date',$monthEnd);
        }
        $where .= '1 = 1';

        $cof = Db::name('config')->where('c_key','CUSTOMIZE_SITE')->field('c_value')->find();
        $config = json_decode($cof['c_value']);
        $arr  = object_to_array($config);
        $ary_get['pageall'] = input("request.pageall", 20, 'intval');

        $book = Db::name('book')->where('id',$id)->field('id,name')->find();

        $count = Db::name('chapter')
            ->where('b_id',$id)
            ->where('is_del',0)
            ->where('status',1)
            ->where($where)
            ->count();
        $this->assign("count", 20);
        $obj_page = $this->_Page($count, $ary_get['pageall']);
        $page = $obj_page->newshow();

        $list = Db::name('chapter')
            ->where('b_id',$id)
            ->where('is_del',0)
            ->where('status',1)
            ->where($where)
            ->field('id,name,content,time')
            ->limit($obj_page->firstRow, $obj_page->listRows)
            ->order('id asc')
            ->select();
        $data = Db::name('chapter')
            ->where('b_id',$id)
            ->where('is_del',0)
            ->where('status',1)
            ->where($where)
            ->field('content')
            ->order('id asc')
            ->select();
        $worlds = 0;
        foreach ($list as $k=>$v){
            $list[$k]['words_num'] = mb_strlen(strip_tags(DeleteHtml($v['content'])),'utf-8');
            $list[$k]['fee'] = round($list[$k]['words_num']/1000*$arr['fee'],2);
            unset($list[$k]['content']);
        }
        foreach ($data as $k=>$v){
            $data[$k]['words_num'] = mb_strlen(strip_tags(DeleteHtml($v['content'])),'utf-8');
            $worlds += $data[$k]['words_num'];
        }
        $price = round($worlds/1000*$arr['fee'],2);
//        c_print($list);
        $this->assign('price',$price);
        $this->assign('worlds',$worlds);
        $this->assign('fee',$arr['fee']);
        $this->assign('book',$book);
        $this->assign('page',$page);
        $this->assign('count',$count);
        $this->assign('list',$list);
        return view();
    }


    /**
     * 充值统计
     */
    public function recharge(){
        $start_date = input("get.start_date", '');
        $end_date = input("get.end_date", '');
        $keyword = input("get.keyword", '');

        $where = '';
        if (!empty($start_date) && empty($end_date)){
            $where .= "a.create_time > '".$start_date."' AND ";
        }elseif(!empty($end_date) && empty($start_date)){
            $where .= "a.create_time < '".$end_date."' AND ";
        }elseif (!empty($start_date) && !empty($end_date)){
            $where .= "a.create_time > '".$start_date."' AND ";
            $where .= "a.create_time < '".$end_date."' AND ";
        }
        if (!empty($keyword)) {
            $where .= "(a.order_num like '%" . urldecode($keyword) . "%' ";
            $where .= "OR c.phone like '%" . urldecode($keyword) . "%' ) AND ";
        }
        $where .= ' b.is_pay = 1';
        $count = Db::name('recharge_log')
            ->alias('a')
            ->join('recharge b','a.order_num = b.order_num')
            ->join('member c','a.u_id = c.id')
            ->field('a.total_fee,a.u_id,a.order_num,a.seller_id,a.create_time,b.type,c.phone')
            ->where($where)
            ->count();
        $this->assign('count',$count);
        $obj_page = $this->_Page($count,20);
        $page = $obj_page->newshow();
        $list = Db::name('recharge_log')
            ->alias('a')
            ->join('recharge b','a.order_num = b.order_num')
            ->join('member c','a.u_id = c.id')
            ->field('a.total_fee,a.u_id,a.order_num,a.seller_id,a.create_time,b.type,c.phone,c.name,c.pen_name,c.unionid,c.money')
            ->where($where)
            ->group('a.id')
            ->limit($obj_page->firstRow, $obj_page->listRows)
            ->order('a.create_time desc')
            ->select();

        $t_list = Db::name('recharge_log')
            ->alias('a')
            ->join('recharge b','a.order_num = b.order_num')
            ->field('a.total_fee')
            ->where('b.is_pay',1)
            ->select();

        $now_total = 0;
        foreach ($list as $k=>$v){
            $now_total += $v['total_fee'];
        }

        $total = 0; // 总量
        foreach ($t_list as $k=>$v){
            $total += $v['total_fee'];
        }
        $this->assign('list',$list);
        $this->assign("page", $page);
        $this->assign('total',$total);
        $this->assign('now_total',$now_total);
        return view();
    }

    /**
     * 订阅统计
     */
    public function take(){
        $start_date = input("get.start_date", '');
        $end_date = input("get.end_date", '');
        $keyword = input("get.keyword", '');
        $where = '';
        if (!empty($start_date) && empty($end_date)){
            $where .= "a.time > '".strtotime($start_date)."' AND ";
        }elseif(!empty($end_date) && empty($start_date)){
            $where .= "a.time < '".strtotime($end_date)."' AND ";
        }elseif (!empty($start_date) && !empty($end_date)){
            $where .= "a.time > '".strtotime($start_date)."' AND ";
            $where .= "a.time < '".strtotime($end_date)."' AND ";
        }
        if (!empty($keyword)) {
            $where .= "b.author like '%" . urldecode($keyword) . "%' OR ";
            $where .= "d.phone like '%" . urldecode($keyword) . "%' OR ";
            $where .= "b.name like '%" . urldecode($keyword) . "%' AND ";
        }
        $where .= ' 1=1';
        $count = Db::name('reward')
            ->alias('a')
            ->join('book b','a.b_id = b.id')
            ->join('member d','a.u_id = d.id')
            ->field('a.id,a.price,a.status,a.time,a.b_id,a.z_id,b.name,b.author,d.phone')
            ->where($where)
            ->count();
        $this->assign('count',$count);
        $obj_page = $this->_Page($count,20);
        $page = $obj_page->newshow();
        $list = Db::name('reward')
            ->alias('a')
            ->join('book b','a.b_id = b.id')
            ->join('member d','a.u_id = d.id')
            ->field('a.id,a.price,a.status,a.time,a.b_id,a.z_id,b.name,b.author,d.phone,d.name,d.pen_name,d.unionid,d.money')
            ->where($where)
            ->limit($obj_page->firstRow, $obj_page->listRows)
            ->order('a.id desc')
            ->select();
        $total_list = Db::name('reward')->field('price')->select();
        $total = 0; // 总量
        foreach ($total_list as $k=>$v){
            $total += $v['price'];
        }
        $now_total = 0; // 当前页总量
        foreach ($list as $k=>$v){
            $now_total += $v['price'];
            if (!empty($v['z_id'])){
                $chapter = Db::name('chapter')->where('id',$v['z_id'])->field('name')->find();
                $list[$k]['chapter'] = $chapter['name'];
            }
        }
        $this->assign('list',$list);
        $this->assign("page", $page);
        $this->assign('total',$total);
        $this->assign('now_total',$now_total);
        return view();
    }

    /**
     * 编辑订阅详情
     */
    public function takeEdit(){
        $id = input('get.id');
        $data = Db::name('reward')
            ->alias('a')
            ->join('book b','a.b_id = b.id')
            ->join('member d','a.u_id = d.id')
            ->field('a.id,a.price,a.time,a.b_id,a.z_id,b.name,b.author,d.phone')
            ->where('a.id = '.$id)
            ->order('a.id desc')
            ->find();
        if (!empty($data['z_id'])){
            $chapter = Db::name('chapter')->where('id',$data['z_id'])->field('name')->find();
            $data['chapter'] = $chapter['name'];
        }
        if ($_POST){
            $this->doTakeEdit();
        }
        $this->assign('data',$data);
        return view();
    }

    /**
     * 编辑订阅
     */
    public function doTakeEdit(){
        $post = input('post.');
        $res = Db::name('reward')
            ->where('id',$post['id'])
            ->update(['price'=>$post['price']]);
        if ($res){
            JsonDie(1, '操作成功', 'yes');
        }else{
            JsonDie(0, '操作失败', 'no');
        }
    }

    /**
     * 删除订阅
     */
    public function takeDel(){
        $id = input('get.id');
        $res = Db::name('reward')
            ->where('id',$id)
            ->delete();
        if ($res){
            JsonDie(1, '操作成功', 'yes');
        }else{
            JsonDie(0, '操作失败', 'no');
        }
    }

    /**
     * 打赏列表
     */
    public function reward(){
        $start_date = input("get.start_date", '');
        $end_date = input("get.end_date", '');
        $keyword = input("get.keyword", '');
        $where = '';
        if (!empty($start_date) && empty($end_date)){
            $where .= "a.time > '".strtotime($start_date)."' AND ";
        }elseif(!empty($end_date) && empty($start_date)){
            $where .= "a.time < '".strtotime($end_date)."' AND ";
        }elseif (!empty($start_date) && !empty($end_date)){
            $where .= "a.time > '".strtotime($start_date)."' AND ";
            $where .= "a.time < '".strtotime($end_date)."' AND ";
        }
        if (!empty($keyword)) {
            $where .= "a.gift_name like '%" . urldecode($keyword) . "%' OR ";
            $where .= "c.author like '%" . urldecode($keyword) . "%' OR ";
            $where .= "b.phone like '%" . urldecode($keyword) . "%' OR ";
            $where .= "c.name like '%" . urldecode($keyword) . "%' AND ";
        }
        $where .= ' 1=1';
        $count = Db::name('gift')
            ->alias('a')
            ->join('member b','b.id = a.u_id')
            ->join('book c','c.id = a.b_id')
            ->field('a.id,a.b_id,a.gift_name,a.number,a.total,a.msg,a.time,b.phone,c.author,c.name')
            ->where($where)
            ->count();
        $this->assign('count',$count);
        $obj_page = $this->_Page($count,20);
        $page = $obj_page->newshow();
        $list = Db::name('gift')
            ->alias('a')
            ->join('member b','b.id = a.u_id')
            ->join('book c','c.id = a.b_id')
            ->field('a.id,a.b_id,a.gift_name,a.number,a.total,a.msg,a.time,b.phone,c.author,c.name,b.name as u_name,b.pen_name,b.money,b.unionid')
            ->where($where)
            ->limit($obj_page->firstRow, $obj_page->listRows)
            ->order('a.id desc')
            ->select();
        $total_list = Db::name('gift')
                ->alias('a')
                ->join('member b','b.id = a.u_id')
                ->join('book c','c.id = a.b_id')
                ->field('sum(a.total) as total')
                ->find();

        $now_total = 0; // 当前页总量
        foreach ($list as $k=>$v){
            $now_total += $v['total'];
        }

        $this->assign("page", $page);
        $this->assign('total',$total_list['total']);
        $this->assign('now_total',$now_total);
        $this->assign('list',$list);
        return view();
    }

    /**
     * 编辑打赏详情
     */
    public function rewardEdit(){
        $id = input('get.id');
        $data = Db::name('gift')
            ->alias('a')
            ->join('member b','b.id = a.u_id')
            ->join('book c','c.id = a.b_id')
            ->field('a.id,a.gift_name,a.number,a.total,a.msg,c.author,c.name')
            ->where('a.id',$id)
            ->find();
        if ($_POST){
            $this->doRewardEdit();
        }
        $this->assign('data',$data);
        return view();
    }

    /**
     * 编辑打赏
     */
    public function doRewardEdit(){
        $post = input('post.');
        if ($post['number'] < 1){
            JsonDie(0, '数量不能小于1', 'no');
        }
        if ($post['total'] < 0){
            JsonDie(0, '总额不能小于0', 'no');
        }
        $res = Db::name('gift')
            ->where('id',$post['id'])
            ->update(['number'=>$post['number'],'total'=>$post['total']]);
        if ($res){
            JsonDie(1, '操作成功', 'yes');
        }else{
            JsonDie(0, '操作失败', 'no');
        }
    }

    /**
     * 删除打赏
     */
    public function rewardDel(){
        $id = input('get.id');
        $res = Db::name('gift')
            ->where('id',$id)
            ->delete();
        if ($res){
            JsonDie(1, '操作成功', 'yes');
        }else{
            JsonDie(0, '操作失败', 'no');
        }
    }

    /**
     * 签到
     */
    public function sign(){
        $start_date = input("get.start_date", '');
        $end_date = input("get.end_date", '');
        $keyword = input("get.keyword", '');
        $where = '';
        if (!empty($start_date) && empty($end_date)){
            $where .= "a.create_time > '".strtotime($start_date)."' AND ";
        }elseif(!empty($end_date) && empty($start_date)){
            $where .= "a.create_time < '".strtotime($end_date)."' AND ";
        }elseif (!empty($start_date) && !empty($end_date)){
            $where .= "a.create_time > '".strtotime($start_date)."' AND ";
            $where .= "a.create_time < '".strtotime($end_date)."' AND ";
        }
        if (!empty($keyword)) {
            $where .= "b.phone like '%" . urldecode($keyword) . "%' OR ";
            $where .= "b.name like '%" . urldecode($keyword) . "%' OR ";
            $where .= "b.pen_name like '%" . urldecode($keyword) . "%' AND ";
        }
        $where .= ' 1=1';
        $count = Db::name('sign')
            ->alias('a')
            ->join('member b','b.id = a.u_id')
            ->field('a.*,b.phone,b.pen_name')
            ->where($where)
            ->count();

        $this->assign('count',$count);
        $obj_page = $this->_Page($count,20);
        $page = $obj_page->newshow();
        $list = Db::name('sign')
            ->alias('a')
            ->join('member b','b.id = a.u_id')
            ->where($where)
            ->field('a.*,b.phone,b.pen_name,b.name')
            ->limit($obj_page->firstRow, $obj_page->listRows)
            ->order('a.id desc')
            ->select();
        $this->assign('page',$page);
        $this->assign('list',$list);
        return view();
    }

    public function delSign(){
        $id = input('get.id');
        $res = Db::name('sign')->where('id',$id)->delete();
        if ($res){
            JsonDie(1, '操作成功', 'yes');
        }else{
            JsonDie(0, '操作失败', 'no');
        }
    }

    /**
     * 把数字1-1亿换成汉字表述，如：123->一百二十三
     * @param [num] $num [数字]
     * @return [string] [string]
     */
    public function numToWord($num)
    {
        $chiNum = array('零', '一', '二', '三', '四', '五', '六', '七', '八', '九');
        $chiUni = array('','十', '百', '千', '万', '亿', '十', '百', '千');
        $chiStr = '';
        $num_str = (string)$num;
        $count = strlen($num_str);
        $last_flag = true; //上一个 是否为0
        $zero_flag = true; //是否第一个
        $temp_num = null; //临时数字
        $chiStr = '';//拼接结果
        if ($count == 2) {//两位数
            $temp_num = $num_str[0];
            $chiStr = $temp_num == 1 ? $chiUni[1] : $chiNum[$temp_num].$chiUni[1];
            $temp_num = $num_str[1];
            $chiStr .= $temp_num == 0 ? '' : $chiNum[$temp_num];
        }else if($count > 2){
            $index = 0;
            for ($i=$count-1; $i >= 0 ; $i--) {
                $temp_num = $num_str[$i];
                if ($temp_num == 0) {
                    if (!$zero_flag && !$last_flag ) {
                        $chiStr = $chiNum[$temp_num]. $chiStr;
                        $last_flag = true;
                    }
                }else{
                    $chiStr = $chiNum[$temp_num].$chiUni[$index%9] .$chiStr;
                    $zero_flag = false;
                    $last_flag = false;
                }
                $index ++;
            }
        }else{
            $chiStr = $chiNum[$num_str[0]];
        }
        return $chiStr;
    }

}
