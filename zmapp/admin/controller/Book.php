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

class Book extends Common
{

    public function __construct()
    {
        parent::__construct();
        $modules = $this->getModule(CONTROLLER); //获取模型配置

        $this->assign("modules", $modules);
        $this->modelFields($modules['table']);
    }


    /**
     * 把数字1-1亿换成汉字表述，如：123->一百二十三
     * @param [num] $num [数字]
     * @return [string] [string]
     */
    function numToWord($num)
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


    /**
     * 书籍信息
     */
    public function index()
    {
        $c_id = input('get.c_id');
        $type = input('get.type');
        $c_type = input('get.c_type');
        $status = input('get.status');
        $sysPath = config("admin.adminPath");
        switch ($type){
            case 1:
                $this->redirect(url($sysPath.'/book/lunbo'));
                break;
            case 2:
                $this->redirect(url($sysPath.'/book/recommend'));
                break;
            case 3:
                $this->redirect(url($sysPath.'/book/fine'));
                break;
            case 4:
                $this->redirect(url($sysPath.'/book/original'));
                break;
            case 5:
                $this->redirect(url($sysPath.'/book/okami'));
                break;
            default:
                break;
        }
        $ary_get['pageall'] = input("request.pageall", 15, 'intval');
        $keyword = input("get.keyword", '');
        $where = 'is_del = 0 AND ';
        if ($c_id != ""){
            $where .= "cid = '".$c_id."' AND ";
        }
        if ($status == 1){
            $where .= "is_end = 0 AND ";
        }
        if ($status == 2){
            $where .= "is_end = 1 AND ";
        }
        if ($c_type == 1){
            $where .= "type = 1 OR ";
            $where .= "type = 2 AND ";
        }
        if ($c_type == 3){
            $where .= "type = 3 AND ";
        }
        if (!empty($keyword)) {
            $where .= "name like '%" . urldecode($keyword) . "%' OR ";
            $where .= "author like '%" . urldecode($keyword) . "%' AND ";
        }
        $where .= "1 = 1";
        $count = Db::name(CONTROLLER)->where($where)->count();
        $this->assign("count", 20);
        $obj_page = $this->_Page($count, $ary_get['pageall']);
        $page = $obj_page->newshow();
        $ary_data = Db::name('book')
            ->where($where)
            ->order("id desc")
            ->limit($obj_page->firstRow, $obj_page->listRows)
            ->select();
        foreach ($ary_data as $key => $val){
            if ($val['type'] != 3){
                $b_id = $val['id'];
                $chapter = Db::name('chapter')->where('b_id',$b_id)->where('status',1)->count();
                $ary_data[$key]['c_count'] = $chapter;
            }

        }
        $this->assign("list", $ary_data);
        $this->assign("category", $c_id);
        $this->assign("page", $page);
        $Tplpath = $this->currentTplPath();

        return view($Tplpath);
    }

    public function editIndex()
    {
        try{
            $id=input("get.id",0,"intval");
            $value=input("get.value",0,"intval");
            if(!$id){JsonDie('0',"参数错误",'yes');	}
            if($value==0){
                $data=array('is_index'=>1);
            }else{
                $data=array('is_index'=>0);
            }

            $ary_result=Db::name('book')->where(array("id" => $id))->data($data)->update();
            if($ary_result){
                JsonDie('1',"操作成功",'yes');
            }else{
                JsonDie('0',"操作失败",'no');
            }
        }catch (\Exception $e) {
            JsonDie(0,'操作失败'.$e,'no');
        }

    }

    public function editRecommend()
    {
        try{
            $id=input("get.id",0,"intval");
            $value=input("get.value",0,"intval");
            if(!$id){JsonDie('0',"参数错误",'yes');	}
            if($value==0){
                $data=array('is_recommend'=>1);
            }else{
                $data=array('is_recommend'=>0);
            }

            $ary_result=Db::name('book')->where(array("id" => $id))->data($data)->update();
            if($ary_result){
                JsonDie('1',"操作成功",'yes');
            }else{
                JsonDie('0',"操作失败",'no');
            }
        }catch (\Exception $e) {
            JsonDie(0,'操作失败'.$e,'no');
        }
    }

    public function editFine()
    {
        try{
            $id=input("get.id",0,"intval");
            $value=input("get.value",0,"intval");
            if(!$id){JsonDie('0',"参数错误",'yes');	}
            if($value==0){
                $data=array('is_fine'=>1);
            }else{
                $data=array('is_fine'=>0);
            }

            $ary_result=Db::name('book')->where(array("id" => $id))->data($data)->update();
            if($ary_result){
                JsonDie('1',"操作成功",'yes');
            }else{
                JsonDie('0',"操作失败",'no');
            }
        }catch (\Exception $e) {
            JsonDie(0,'操作失败'.$e,'no');
        }
    }

    public function editOkami()
    {
        try{
            $id=input("get.id",0,"intval");
            $value=input("get.value",0,"intval");
            if(!$id){JsonDie('0',"参数错误",'yes');	}
            if($value==0){
                $data=array('is_okami'=>1);
            }else{
                $data=array('is_okami'=>0);
            }

            $ary_result=Db::name('book')->where(array("id" => $id))->data($data)->update();
            if($ary_result){
                JsonDie('1',"操作成功",'yes');
            }else{
                JsonDie('0',"操作失败",'no');
            }
        }catch (\Exception $e) {
            JsonDie(0,'操作失败'.$e,'no');
        }
    }

    public function editStatus()
    {
        try{
            $id=input("get.id",0,"intval");
            $value=input("get.value",0,"intval");
            if(!$id){JsonDie('0',"参数错误",'yes');	}
            if($value==0){
                $data=array('status'=>1);
            }else{
                $data=array('status'=>0);
            }

            $ary_result=Db::name('book')->where(array("id" => $id))->data($data)->update();
            if($ary_result){
                JsonDie('1',"操作成功",'yes');
            }else{
                JsonDie('0',"操作失败",'no');
            }
        }catch (\Exception $e) {
            JsonDie(0,'操作失败'.$e,'no');
        }
    }

    public function editOriginal()
    {
        try{
            $id=input("get.id",0,"intval");
            $value=input("get.value",0,"intval");
            if(!$id){JsonDie('0',"参数错误",'yes');	}
            if($value==0){
                $data=array('is_original'=>1);
            }else{
                $data=array('is_original'=>0);
            }

            $ary_result=Db::name('book')->where(array("id" => $id))->data($data)->update();
            if($ary_result){
                JsonDie('1',"操作成功",'yes');
            }else{
                JsonDie('0',"操作失败",'no');
            }
        }catch (\Exception $e) {
            JsonDie(0,'操作失败'.$e,'no');
        }
    }

    public function editEnd()
    {
        try{
            $id=input("get.id",0,"intval");
            $value=input("get.value",0,"intval");
            if(!$id){JsonDie('0',"参数错误",'yes');	}
            if($value==0){
                $data=array('is_end'=>1);
            }else{
                $data=array('is_end'=>0);
            }

            $ary_result=Db::name('book')->where(array("id" => $id))->data($data)->update();
            if($ary_result){
                JsonDie('1',"操作成功",'yes');
            }else{
                JsonDie('0',"操作失败",'no');
            }
        }catch (\Exception $e) {
            JsonDie(0,'操作失败'.$e,'no');
        }
    }

    public function editChapterStatus()
    {
        try{
            $id=input("get.id",0,"intval");
            $value=input("get.value",0,"intval");
            if(!$id){
                JsonDie('0',"参数错误",'yes');
            }

            if($value==0){
                $data=array('status'=>1);
                $title = '审核通过！';
            }else{
                $data=array('status'=>0);
                $title = '审核未通过！';
            }

            $ary_result = Db::name('chapter')->where(array("id" => $id))->data($data)->update();

            if ($ary_result){
                // 作者审核通知
                $chapter = Db::name('chapter')->where(array("id" => $id))->find();
                $words_num_last = Db::name('book')->where('id',$chapter['b_id'])->field('words_num')->find();
                if($data['status'] == 0){
                    $a = '审核未通过';
                    $title = '章节"'.$chapter['name'].'"审核未通过';

                    // 修改文章总字数
                    $words_num = $words_num_last['words_num'] - mb_strlen(DeleteHtml(strip_tags($chapter['content'])),'utf-8');
                }else{
                    $a = '审核通过';
                    $title = '章节"'.$chapter['name'].'"审核通过';
                    // 修改文章总字数
                    $words_num = $words_num_last['words_num'] + mb_strlen(DeleteHtml(strip_tags($chapter['content'])),'utf-8');

                }
                if ($words_num < 0){
                    $words_num = 0;
                }
                $ary = [
                    'words_num' => $words_num
                ];
                Db::name('book')->where('id',$chapter['b_id'])->update($ary);
                $book = Db::name('book')->where(array("id" => $chapter['b_id']))->find();
                $content = '亲爱的作者你好！你的书籍《'.$book['name'].'》发布的章节 “'.$chapter['name'].'” '.$a;
                $notice = [
                    'u_id' => $book['u_id'],
                    'title' => $title,
                    'content' => $content,
                    'type' => 1,
                    'create_time' => date('Y:m:d H:i:s')
                ];
                Db::name('notice')->insert($notice);

                JsonDie('1',"操作成功",'yes');
            }else{
                JsonDie('0',"操作失败",'no');
            }
        }catch (\Exception $e) {
            JsonDie(0,'操作失败'.$e,'no');
        }
    }

    public function categoryindex(){
        $category = Db::name('book_category')->where('is_del','0')->order('sort asc,id desc')->select();
        $this->assign('category',$category);
        return view();
    }

    public function categoryedit(){
        $id = input('get.id');
        $data = Db::name('book_category')->where('id',$id)->find();
        if($_POST){
            $this->categorySave();
        }
        $this->assign('data',$data);
        return view();
    }

    public function categoryDelete(){
        $id = input('get.id', 0, 'intval');
        $data = [
            'is_del' => 1
        ];
        $is_book = Db::name('book')->where('cid',$id)->select();
        if ($is_book){
            JsonDie(1, '该分类下还有书籍，不能删除', 'no');
        }
        $res = Db::name('book_category')->where('id',$id)->update($data);
        if (FALSE !== $res) {
            JsonDie(1, '操作成功', 'yes');
        } else {
            JsonDie(1, '操作失败', 'no');
        }
    }

    public function categoryadd(){
        if ($_POST){
            $post = input('post.','','trim');
            $check = Db::name('book_category')->where('name',$post['name'])->find();
            if ($check){
                JsonDie(0, '该分类已存在', 'no');
            }
            $data = [
                'name' => $post['name'],
                'time' => date('Y-m-d H:i:s'),
                'sort' => $post['sort']
            ];
            $res = Db::name('book_category')->insert($data);
            if (FALSE !== $res) {
                JsonDie(1, '操作成功', 'yes');
            } else {
                JsonDie(0, '操作失败', 'no');
            }
        }
        return view();
    }

    public function categorySave(){
        try {
            $ary_post = input("post.");
            $id = input('request.id', 0, 'intval');
            $data = [
                'name' => $ary_post['name'],
                'status' => $ary_post['status'],
                'sort' => $ary_post['sort']
            ];
            $ary_result = Db::name('book_category')->where('id',$id)->order('sort asc,id desc')->update($data);

            if (FALSE !== $ary_result) {
                JsonDie(1, '操作成功', 'yes');
            } else {
                JsonDie(1, '操作失败', 'no');
            }
        } catch (\Exception $e) {
            JsonDie(0, '操作失败' . $e, 'no');
        }
    }

    public function currentTplPath()
    {
        if (strtolower(ACTION) == 'add') {
            $path = config("template.view_path") . strtolower(CONTROLLER) . "/edit." . config("template.view_suffix");
            if (file_exists($path)) {
                return $path;
            } else {
                $path = config("template.view_path") . "public/edit." . config("template.view_suffix");
                return $path;
            }
        } else {
            $path = config("template.view_path") . strtolower(CONTROLLER) . "/" . strtolower(ACTION) . "." . config("template.view_suffix");
            if (file_exists($path)) {
                return $path;
            } else {
                $path = config("template.view_path") . "public/" . strtolower(ACTION) . "." . config("template.view_suffix");
                return $path;
            }
        }
    }

    /**
     * 添加分类
     */
    public function add()
    {

        $tag = CONTROLLER;
        if ($_POST) {
            $this->doSave();
            exit;
        }
        $category = $this->getSelect();
        $this->assign("category", $category);
        $Tplpath = $this->currentTplPath();
        return view($Tplpath);
    }

    /**
     * 添加书籍
     */
    public function addbook()
    {

        if ($_POST) {
            $this->doAdd();
            exit;
        }

        $Tplpath = $this->currentTplPath();
        return view($Tplpath);
    }

    /**
     * 章节
     */
    public function chapter(){
        $id = input('get.id','','intval');
        $ary_get['pageall'] = input("request.pageall", 20, 'intval');
        $p =  input('get.p');

        $book = Db::name('book')->where('id',$id)->field('name,type,other_bookid')->find();
        $this->assign("type", $book['type']);
        if ($book['type'] == 3){
            // 第三方平台的书籍
            $bookId = $book['other_bookid'];
            $url = 'http://store.zhewenit.com/api/Shuangxige/structure?bookId='.$bookId;
            $res = httpPost($url);
            if ($res['code'] != 0){
                return false;
            }
            $data = object_array($res['data']);
            $chapter = $data['books'];
            $count = count($chapter);

            $obj_page = $this->_Page($count, $ary_get['pageall']);
            $a = $this->page_array('20',$p,$chapter,2);
            $page = $obj_page->newshow();
            $this->assign("count", $count);
            $this->assign("page", $page);
            $this->assign('list',$a);
            $this->assign('book_other_id',$book['other_bookid']);
            $this->assign('b_id',$id);
            $this->assign('book',$book['name']);
            return view('chapter');
        }

        if ($book['type'] == 4){
            $bookId = $book['other_bookid'];
            $url = 'http://www.bqread.com/api/shuangxi/get_chapter_list.php?aid='.$bookId;
            $res = httpPost($url);
            if ($res['code'] != 0){
                return false;
            }
            $data = object_array($res['data']);
            $count = count($data);

            $obj_page = $this->_Page($count, $ary_get['pageall']);
            $a = $this->page_array('20',$p,$data,2);
            $page = $obj_page->newshow();
            $this->assign("count", $count);
            $this->assign("page", $page);
            $this->assign('list',$a);
            $this->assign('book_other_id',$book['other_bookid']);
            $this->assign('b_id',$id);
            $this->assign('book',$book['name']);
            return view('chapter');
        }

        $count = Db::name('chapter')->where('b_id',$id)->where('status',1)->count();
        $keyword = input("get.keyword", '');
        $where = '';
        $type = input('get.type','','intval');
        
        $color1 = '#0789D2'; // 蓝色
        $color2 = '#2fa770'; // 绿色
        if (!empty($keyword)) {
            $where .= "name like '%" . urldecode($keyword) . "%' AND ";
        }
        if ($type){
            if ($type == 3){
                $where .= ' status = 0 AND';
                $where .= ' pub = 1 ';
                $color1 = '#2fa770';
                $color2 = '#0789D2';
            }elseif ($type == 1){
                $where .= ' status = 1';
                $color2 = '#2fa770';
                $color1 = '#0789D2';
            }
        }else{
            $where .= ' status = 1';
        }
        $obj_page = $this->_Page($count, $ary_get['pageall']);
        $page = $obj_page->newshow();
        $chapter = Db::name('chapter')
            ->where('b_id',$id)
            ->where($where)
            ->where('pub',1)
            ->limit($obj_page->firstRow, $obj_page->listRows)
            ->order('id desc')
            ->select();

        $wei = Db::name('chapter')
            ->where('b_id',$id)
            ->where('status',0)
            ->where('pub',1)
            ->count();
        $this->assign("color1", $color1);
        $this->assign("color2", $color2);
        $this->assign("wei", $wei);
        $this->assign("count", $count);
        $this->assign("type", $book['type']);
        $this->assign('book',$book['name']);
        $this->assign('b_id',$id);
        $this->assign("page", $page);
        $this->assign('list',$chapter);

        return view();
    }

    /**
     * 数组分页函数  核心函数  array_slice
     * 用此函数之前要先将数据库里面的所有数据按一定的顺序查询出来存入数组中
     * $count   每页多少条数据
     * $page   当前第几页
     * $array   查询出来的所有数组
     * order 0 - 不变     1- 反序
     */
    function page_array($count='20',$page,$array,$order){
        global $countpage; #定全局变量
        $page=(empty($page))?'1':$page; #判断当前页面是否为空 如果为空就表示为第一页面
        $start=($page-1)*$count; #计算每次分页的开始位置
        if($order==1){
            $array=array_reverse($array);
        }
        $totals=count($array);
        $countpage=ceil($totals/$count); #计算总页面数
        $pagedata=array();
        $pagedata=array_slice($array,$start,$count);
        return $pagedata;  #返回查询数据
    }

    /**
     * 编辑章节
     */
    public function chapteredit(){
        $id = input('get.id','','intval');

        if ($_POST){
            $this->saveChapter();
            exit;
        }

        $data = Db::name('chapter')
            ->alias('a')
            ->join('book b','b.id = a.b_id')
            ->field('a.id,a.name,a.status,a.b_id,a.content,a.number,b.name as b_name,a.say')
            ->where('a.id',$id)
            ->find();
        $this->assign('data',$data);
        return view();
    }


    public function getChapter()
    {
        $id = input('post.id', '', 'intval');
        $data = Db::name('chapter')->where('id', $id)->find();
        if ($data) {
            JsonDie(1, '操作成功', 'yes', $data);
        } else {
            JsonDie(0, '', 'yes');
        }
    }

    public function otherEdit(){
        $id = input('get.id','','intval');
        $book_id = input('get.book_id','','intval');
        $title = input('get.title');
        $get_content_url = 'http://store.zhewenit.com/api/Shuangxige/chapterinfo?bookId='.$book_id.'&chapterId='.$id;
        $r = httpPost($get_content_url);
        $c_info = object_array($r['data']);
        $data = $c_info['books'];
        $data['name'] = $title;
        $this->assign('data',$data);
        return view('chapteredit');
    }

    public function getOtherChapter(){
        $type = input('post.type');
        $id = input('post.id','','intval');
        $book_id = input('post.book_id','','intval');
        $title = input('post.title');
        if ($type == 3){
            $get_content_url = 'http://store.zhewenit.com/api/Shuangxige/chapterinfo?bookId='.$book_id.'&chapterId='.$id;
            $r = httpPost($get_content_url);
            $c_info = object_array($r['data']);
            $data = $c_info['books']['content'];
            $a = str_replace("\n","<br/>",$data);
            if ($data){
                JsonDie(1, '操作成功', $title,$a);
            }else{
                JsonDie(0, '', 'yes');
            }
        }elseif ($type == 4){
            $get_content_url = 'http://www.bqread.com/api/shuangxi/get_chapter_content.php?aid='.$book_id.'&chapterid='.$id;
            $r = httpPost($get_content_url);
            $c_info = object_array($r['data']);
            $a = str_replace("\r\n","<br/>&nbsp&nbsp&nbsp&nbsp",$c_info['content']);
            $b = '&nbsp&nbsp&nbsp&nbsp'.str_replace("\n","<br/><br/>",$a);

            if ($c_info){
                JsonDie(1, '操作成功', $title,$b);
            }else{
                JsonDie(0, '', 'yes');
            }
        }

    }

    /**
     * 保存章节
     */
    public function saveChapter(){
        $post = input('post.');
        $id = input('get.id');
        $data= [
            'name' => $post['name'],
            'content' => $post['content'],
            'status' => $post['status'],
            'say' => $post['say'],
            'time' => time()
        ];

        $words_num_last = Db::name('book')->where('id',$post['b_id'])->field('words_num')->find(); // 原来总字数

        $old_content =  Db::name('chapter')->where('id',$id)->field('status,content')->find(); // 编辑之前的章节

        $old_num = mb_strlen(DeleteHtml(strip_tags($old_content['content'])),'utf-8'); // 编辑之前该章节字数

        if ($old_content['status'] != $data['status']){
            // 改变了状态 需改变字数
            if ($post['status'] == 1){
                $words_num = $words_num_last['words_num'] + mb_strlen(DeleteHtml(strip_tags($data['content'])),'utf-8');
            }else{
                $words_num = $words_num_last['words_num'] - $old_num;
            }
        }else{
            if ($data['status'] == 1){
                $words_num = $words_num_last['words_num'] + (mb_strlen(DeleteHtml(strip_tags($data['content'])),'utf-8') - $old_num);
            }else{
                // 状态未变，字数则不需修
                $words_num = $words_num_last['words_num'];
            }
        }

        if ($words_num < 0){
            $words_num = 0;
        }
        $ary = [
            'words_num' => $words_num
        ];
        try{
            Db::name('book')->where('id',$post['b_id'])->update($ary);
            $res = Db::name('chapter')->where('id',$id)->update($data);
            if ($res){
                // 作者审核通知
                if ($old_content['status'] != $data['status']){
                    $chapter = Db::name('chapter')->where(array("id" => $id))->find();
                    if($post['status'] == 0){
                        $a = '审核未通过';
                        $title = '章节"'.$chapter['name'].'"审核未通过';
                    }else{
                        $a = '审核通过';
                        $title = '章节"'.$chapter['name'].'"审核通过';
                    }

                    $book = Db::name('book')->where(array("id" => $chapter['b_id']))->find();
                    $content = '亲爱的作者你好！你的书籍《'.$book['name'].'》发布的章节 “'.$chapter['name'].'” '.$a;
                    $notice = [
                        'u_id' => $book['u_id'],
                        'title' => $title,
                        'content' => $content,
                        'type' => 1,
                        'create_time' => date('Y:m:d H:i:s')
                    ];
                    Db::name('notice')->insert($notice);
                }
            }
            if (FALSE !== $res) {
                JsonDie(1, '操作成功', 'yes');
            } else {
                JsonDie(1, '操作失败', 'no');
            }
        }catch(\Exception $e){
            JsonDie(0, '操作失败' . $e, 'no');
        }
    }

    /**
     * 删除章节
     */
    public function chapterdel(){
        $id = input('get.id');
        $b_id = input('get.b_id');
        $words_num_last = Db::name('book')->where('id',$b_id)->field('words_num')->find(); // 原来总字数
        $old_content =  Db::name('chapter')->where('id',$id)->field('content')->find(); // 即将删除的章节内容
        $old_num = mb_strlen(DeleteHtml(strip_tags($old_content['content'])),'utf-8'); // 删除章节的字数
        $words_num = $words_num_last['words_num'] - $old_num;
        $ary = [
            'words_num' => $words_num
        ];
        Db::name('book')->where('id',$b_id)->update($ary);
        if($id){
            try{
                $res = Db::name('chapter')->where('id',$id)->delete();
                if (FALSE !== $res) {
                    JsonDie(1, '操作成功', 'yes');
                } else {
                    JsonDie(1, '操作失败', 'no');
                }
            }catch (\Exception $e){
                JsonDie(0, '操作失败' . $e, 'no');
            }
        }
    }

    /**
     * 添加章节
     */
    public function addchapter(){
        if ($_POST){
            $post = input('post.');
            $b_id = $post['bid'];
            $count = Db::name('chapter')->where('b_id',$b_id)->count();

            $number = $count+1;

            $data = [
                'name' => $post['name'],
                'b_id' => $b_id,
                'content' => $post['content'],
                'number' => $number,
                'status' => 1,
                'time' => time()
            ];
            $words_num_last = Db::name('book')->where('id',$b_id)->field('words_num')->find();
            $words_num = $words_num_last['words_num'] + mb_strlen(DeleteHtml(strip_tags($data['content'])),'utf-8');
            $ary = [
                'words_num' => $words_num
            ];
            Db::name('book')->where('id',$b_id)->update($ary);

            $res = Db::name('chapter')->where('b_id',$b_id)->insert($data);
            if (FALSE !== $res) {
                JsonDie(1, '操作成功', 'yes');
            } else {
                JsonDie(1, '操作失败', 'no');
            }
        }
        return view();
    }

    public function doAdd(){
        $ary_post = input("post.");
        if ($ary_post['price'] < 0){
            JsonDie(0, '价格不能小于0', 'no');
        }
        if ($ary_post['node'] == ''){
            JsonDie(0, '收费节点必须填写', 'no');
        }
        if ($ary_post['node'] < 0){
            JsonDie(0, '收费节点不能小于0', 'no');
        }
        if ($ary_post['price'] == '' && $ary_post['node'] == ''){
            JsonDie(0, '收费节点和整本收费必须二选一', 'no');
        }
        if (!$ary_post['type']){
            JsonDie(0, '请选择作品类型', 'no');
        }
        $data = [
            'name' => $ary_post['name'],
            'cid' => $ary_post['category'],
            'author' => $ary_post['author'],
            'sort' => $ary_post['sort'],
            'image' => $ary_post['image'],
            'is_recommend' => $ary_post['is_recommend'],
            'is_index' => $ary_post['is_index'],
            'is_fine' => $ary_post['is_fine'],
            'is_original' => $ary_post['is_original'],
            'is_okami' => $ary_post['is_okami'],
            'is_end' => $ary_post['is_end'],
            'type' => $ary_post['type'],
            'node' => $ary_post['node'],
            'title' => $ary_post['title'],
            'info' => $ary_post['info'],
            'price' => $ary_post['price'],
            'start_time' => date('Y-m-d H:i:s')
        ];
        $ary_result = Db::name('book')->insert($data);

        if (FALSE !== $ary_result) {
            JsonDie(1, '操作成功', 'yes');
        } else {
            JsonDie(0, '操作失败', 'no');
        }

    }

    /**
     * @return \think\response\View
     * 书籍编辑
     */
    public function edit()
    {

        if ($_POST) {
            $this->doSave();
            exit;
        }
        $id = input("request.id", 0, 'intval');
        if (!$id) {
            JsonDie(0, '未找到数据', 'no');
        }
        $data = Db::name('book')->where(array('id' => $id))->find();

        $category = $this->getSelect($data['cid']);
        $this->assign("category", $category);
        $this->assign("data", $data);
        $Tplpath = $this->currentTplPath();
        return view($Tplpath);
    }

    /**
     * 保存信息
     */
    public function doSave()
    {
        try {
            $ary_post = input("post.");
            $id = input('request.id', 0, 'intval');
            if ($ary_post['price'] < 0){
                JsonDie(0, '价格不能小于0', 'no');
            }
            if ($ary_post['node'] == ''){
                JsonDie(0, '收费节点必须填写', 'no');
            }
            if ($ary_post['node'] < 0){
                JsonDie(0, '收费节点不能小于0', 'no');
            }
            if ($ary_post['price'] == '' && $ary_post['node'] == ''){
                JsonDie(0, '收费节点和整本收费必须二选一', 'no');
            }

            $book = Db::name('book')->where('id',$id)->find();
            $data = [
                'name' => $ary_post['name'],
                'cid' => $ary_post['category'],
                'author' => $ary_post['author'],
                'sort' => $ary_post['sort'],
                'image' => $ary_post['image'],
                'is_recommend' => $ary_post['is_recommend'],
                'is_index' => $ary_post['is_index'],
                'is_fine' => $ary_post['is_fine'],
                'title' => $ary_post['title'],
                'node' => $ary_post['node'],
                'info' => $ary_post['info'],
                'price' => $ary_post['price'],
                'is_original' => $ary_post['is_original'],
                'is_okami' => $ary_post['is_okami'],
                'is_end' => $ary_post['is_end']
            ];
            if($book['type'] > 2){
                if ($ary_post['type']){
                    JsonDie(0, '三方平台书籍不能选择作品类型', 'no');
                }
            }else{
                if (!$ary_post['type']){
                    JsonDie(0, '请选择作品类型', 'no');
                }
                $data['type'] = $ary_post['type'];
            }


            $ary_result = Db::name('book')->where('id',$id)->update($data);

            if (FALSE !== $ary_result) {
                JsonDie(1, '操作成功', 'yes');
            } else {
                JsonDie(1, '操作失败', 'no');
            }
        } catch (\Exception $e) {
            JsonDie(0, '操作失败' . $e, 'no');
        }
    }

    public function doDelete(){
        $id = input('get.id', 0, 'intval');
        $data = [
            'is_del' => 1
        ];

        $res = Db::name('book')->where('id',$id)->update($data);
        if (FALSE !== $res) {
            JsonDie(1, '操作成功', 'yes');
        } else {
            JsonDie(1, '操作失败', 'no');
        }
    }

    /**
     * 未审核的章节
     */
    public function examine(){
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
            $where .= "(a.name like '%" . urldecode($keyword) . "%' ";
            $where .= "OR b.name like '%" . urldecode($keyword) . "%' ) AND ";
        }
        if (!empty($keyword)) {
            $where .= "(a.name like '%" . urldecode($keyword) . "%' ";
            $where .= "OR b.name like '%" . urldecode($keyword) . "%' ) AND ";
        }

        $where .= ' a.status = 0 AND ';
        $where .= ' a.pub = 1';

        $count = Db::name('chapter')
            ->alias('a')
            ->join('book b','a.b_id = b.id')
            ->where('a.is_del','=',0)
            ->where('a.status','=',0)
            ->field('a.name,a.id,a.time,a.status,b.name as b_name,b.id as b_id')
            ->where($where)
            ->order('a.time desc')
            ->count();
        $this->assign('count',$count);
        $obj_page = $this->_Page($count,20);
        $page = $obj_page->newshow();

        $list = Db::name('chapter')
            ->alias('a')
            ->join('book b','a.b_id = b.id')
            ->where('a.is_del','=',0)
            ->where('a.status','=',0)
            ->field('a.name,a.id,a.time,a.status,b.name as b_name,b.id as b_id')
            ->limit($obj_page->firstRow, $obj_page->listRows)
            ->where($where)
            ->order('a.time desc')
            ->select();

        $this->assign('list',$list);
        $this->assign("page", $page);
        return view();
    }

    /**
     * 首页轮播展示 8个
     */
    public function lunbo(){
        $where = [
            'is_del' => 0,
            'status' => 1,
            'is_index' => 1
        ];
        $list = Db::name('book')->where($where)->field('id,name,author,cid,index_sort')->order('index_sort asc')->select();

        $this->assign('list',$list);
        return view();
    }

    // 轮播推荐排序
    public function index_sort(){
        $id = input('get.id');
        $data = Db::name('book')
            ->where('id',$id)
            ->field('id,name,index_sort')
            ->find();
        $this->assign('data',$data);
        return view();
    }

    // 精品推荐排序
    public function fine_sort(){
        $id = input('get.id');
        $data = Db::name('book')
            ->where('id',$id)
            ->field('id,name,fine_sort')
            ->find();
        $this->assign('data',$data);
        return view();
    }

    // 编辑力荐排序
    public function recommend_sort(){
        $id = input('get.id');
        $data = Db::name('book')
            ->where('id',$id)
            ->field('id,name,recommend_sort')
            ->find();
        $this->assign('data',$data);
        return view();
    }

    // 原创新品排序
    public function original_sort(){
        $id = input('get.id');
        $data = Db::name('book')
            ->where('id',$id)
            ->field('id,name,original_sort')
            ->find();
        $this->assign('data',$data);
        return view();
    }

    // 大神推荐排序
    public function okami_sort(){
        $id = input('get.id');
        $data = Db::name('book')
            ->where('id',$id)
            ->field('id,name,okami_sort')
            ->find();
        $this->assign('data',$data);
        return view();
    }

    public function editSort(){
        $post = input('post.');
        $data = [
            $post['type'] => $post['sort']
        ];
        $res = Db::name('book')->where('id',$post['b_id'])->update($data);
        if ($res){
            JsonDie(1, '操作成功', 'yes');
        }else{
            JsonDie(0, '操作失败', 'no');
        }
    }

    /**
     * 添加轮播展示
     */
    public function addIndex(){
        if ($_POST){
            $id = input('post.id','','intval');
            $res =  Db::name('book')->where('id',$id)->update(['is_index'=>1]);
            if (FALSE !== $res) {
                JsonDie(1, '操作成功', 'yes');
            } else {
                JsonDie(0, '操作失败', 'no');
            }
        }
        return view();
    }

    /**
     * 移出轮播展示
     */
    public function outIndex(){
        $id = input('get.id', 0, 'intval');
        $res =  Db::name('book')->where('id',$id)->update(['is_index'=>0]);
        if (FALSE !== $res) {
            JsonDie(1, '操作成功', 'yes');
        } else {
            JsonDie(1, '操作失败', 'no');
        }
    }

    /**
     * 编辑力荐
     */
    public function recommend(){
        $where = [
            'is_del' => 0,
            'status' => 1,
            'is_recommend' => 1
        ];
        $list = Db::name('book')->where($where)->field('id,name,author,cid,recommend_sort')->order('recommend_sort asc')->select();

        $this->assign('list',$list);
        return view();
    }

    /**
     * 添加轮播展示
     */
    public function addRecommend(){
        if ($_POST){
            $id = input('post.id','','intval');
            $res =  Db::name('book')->where('id',$id)->update(['is_recommend'=>1]);
            if (FALSE !== $res) {
                JsonDie(1, '操作成功', 'yes');
            } else {
                JsonDie(1, '操作失败', 'no');
            }
        }
        return view();
    }

    /**
     * 移出编辑力荐
     */
    public function outRecommend(){
        $id = input('get.id', 0, 'intval');
        $res =  Db::name('book')->where('id',$id)->update(['is_recommend'=>0]);
        if (FALSE !== $res) {
            JsonDie(1, '操作成功', 'yes');
        } else {
            JsonDie(1, '操作失败', 'no');
        }
    }

    /**
     * 精品推荐
     */
    public function fine(){
        $where = [
            'is_del' => 0,
            'status' => 1,
            'is_fine' => 1
        ];
        $list = Db::name('book')->where($where)->field('id,name,author,cid,fine_sort')->order('fine_sort asc')->select();

        $this->assign('list',$list);
        return view();
    }

    /**
     * 移出精品推荐
     */
    public function outFine(){
        $id = input('get.id', 0, 'intval');
        $res =  Db::name('book')->where('id',$id)->update(['is_fine'=>0]);
        if (FALSE !== $res) {
            JsonDie(1, '操作成功', 'yes');
        } else {
            JsonDie(1, '操作失败', 'no');
        }
    }

    /**
     * 添加精品推荐
     */
    public function addFine(){
        if ($_POST){
            $id = input('post.id','','intval');
            $res =  Db::name('book')->where('id',$id)->update(['is_fine'=>1]);
            if (FALSE !== $res) {
                JsonDie(1, '操作成功', 'yes');
            } else {
                JsonDie(1, '操作失败', 'no');
            }
        }
        return view();
    }

    /**
     * 原创新品
     */
    public function original(){
        $where = [
            'is_del' => 0,
            'status' => 1,
            'is_original' => 1
        ];
        $list = Db::name('book')->where($where)->field('id,name,author,cid,original_sort')->order('original_sort asc')->select();

        $this->assign('list',$list);
        return view();
    }

    /**
     * 移出原创新品
     */
    public function outOriginal(){
        $id = input('get.id', 0, 'intval');
        $res =  Db::name('book')->where('id',$id)->update(['is_original'=>0]);
        if (FALSE !== $res) {
            JsonDie(1, '操作成功', 'yes');
        } else {
            JsonDie(1, '操作失败', 'no');
        }
    }

    /**
     * 添加原创新品
     */
    public function addOriginal(){
        if ($_POST){
            $id = input('post.id','','intval');
            $res =  Db::name('book')->where('id',$id)->update(['is_original'=>1]);
            if (FALSE !== $res) {
                JsonDie(1, '操作成功', 'yes');
            } else {
                JsonDie(1, '操作失败', 'no');
            }
        }
        return view();
    }

    /**
     * 大神专区
     */
    public function okami(){
        $where = [
            'is_del' => 0,
            'status' => 1,
            'is_okami' => 1
        ];
        $list = Db::name('book')->where($where)->field('id,name,author,cid,okami_sort')->order('okami_sort asc')->select();

        $this->assign('list',$list);
        return view();
    }

    /**
     * 移出大神专区
     */
    public function outOkami(){
        $id = input('get.id', 0, 'intval');
        $res =  Db::name('book')->where('id',$id)->update(['is_okami'=>0]);
        if (FALSE !== $res) {
            JsonDie(1, '操作成功', 'yes');
        } else {
            JsonDie(1, '操作失败', 'no');
        }
    }

    /**
     * 添加大神专区
     */
    public function addOkami(){
        if ($_POST){
            $id = input('post.id','','intval');
            $res =  Db::name('book')->where('id',$id)->update(['is_okami'=>1]);
            if (FALSE !== $res) {
                JsonDie(1, '操作成功', 'yes');
            } else {
                JsonDie(1, '操作失败', 'no');
            }
        }
        return view();
    }
}
