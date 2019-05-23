<?php

namespace app\common\taglib;

use think\template\TagLib;

class ZmCMS extends TagLib {

    /**
     * 定义标签列表
     */
    protected $tags = array(
        // 标签定义： attr 属性列表 close 是否闭合（0 或者1 默认1） alias 标签别名 level 嵌套层次
        'zhimeng' => array('attr' => 'table,cid,where,order,limit,id,page,sql,field,expired,cache','alias'=>'zhimeng'), //闭合标签，默认为不闭合
        'read' => array('attr' => 'table,field,id','alias'=>'read','close'=>1,'alias'=>'read'), //闭合标签，默认为不闭合
		'datatags' => array('attr' => 'table,cid,where,order,limit,id,page,sql,field,expired', 'close' => 1), //闭合标签，默认为不闭合
		'zminner' => array('attr' => 'table,join_a,join_b,jointype,where,order,limit,id,page,field,cache', 'close' => 1), //闭合标签，默认为不闭合
		'zmcount' => array('attr' => 'table,where', 'close' => 0), //闭合标签，默认为不闭合
		'ad' => array('attr' => 'alias,id', 'close' => 1), //闭合标签，默认为不闭合
    );

    /**
     * 循环读取列表
     */
    public function tagzhimeng($tag, $content) {
        $table = isset($tag['table']) ? $tag['table'] : die('Table is empty');
        $where = !empty($tag['where']) ? $tag['where'] : '["status","=",1]';
        $cid = !empty($tag['cid']) ? $tag['cid'] : '';
        $order = !empty($tag['order']) ? $tag['order'] : '';
        $limit = !empty($tag['limit']) ? intval($tag['limit']) : '';
        $id = !empty($tag['id']) ? $tag['id'] : 'r';
        $key = !empty($tag['key']) ? $tag['key'] : 'i';
        $mod = !empty($tag['mod']) ? $tag['mod'] : '2';
        $field = !empty($tag['field']) ? $tag['field'] : '';
        $cache = !empty($tag['cache']) ? $tag['cache'] : '';
        $page = !empty($tag['page']) ? $tag['page'] : '';
        $parseStr = '<?php '."\r\n";
        $parseStr .= '$where=array();$where[]= ' . $where . ';'."\r\n";
        $m = "m" . mt_rand(100000, 999999);
        $ret = 'ret' . mt_rand(100000, 999999);
        if ($cid) {
            $parseStr .= 'if(isset($cid)&&$cid!=0) { '."\r\n";
            $parseStr .= '$arrid=model("Config")->getCategoryid(' . $cid . ');'."\r\n";
            $parseStr .= '$instr=implode(",",$arrid);'."\r\n";
            $parseStr .= '$where[]=["cid","in",$instr];'."\r\n";
            $parseStr .= ' } '."\r\n";
        }
        $parseStr .= '$'.$ret.' =Db::name("' . $tag['table'] . '")->where($where)';
        if ($field) {
            $parseStr .= '->field("' . $field . '")';
        }
        if ($limit&&!$page) {
            $parseStr .= '->limit(0,'.$limit.')';
        }
		if($cache){
			$parseStr .=  '->cache(true,'.$cache.')';
		}
        if ($order) {
            $parseStr .= '->order("' . $order . '")';
        }
        if($page){
            $limit = isset($limit) ? $limit : 10; //如果有page，没有输入limit则默认为10
            $parseStr .= '->page('.$page.','.$limit.')->select();';//没有分页使用select
            $parseStr .= '$count=Db::name("' . $tag['table'] . '")->where($where)->count();';
            $parseStr .= '$pageClassName = new \Pages\Page( $count, ' . $limit . ' );';  //分页类引用
            $parseStr .= '$page_show=$pageClassName->show();';
        }else{
            $parseStr .= '->select();'."\r\n";//没有分页使用select
        }
        $parseStr .= 'if ($' . $ret . '){ $' . $key . '=0;'."\r\n";
        $parseStr .= 'foreach($' . $ret . ' as $key=>$' . $id . ')';
        $parseStr .= '{ ++$' . $key . ';$mod = ($' . $key . ' % ' . $mod . ' );?>';
        $parseStr .= $content;
        $parseStr .= '<?php }}?>';
        return $parseStr;
    }

    /**
     * 读取单条信息
     */

    public function tagread($tag, $content) {
        $name = isset($tag['table']) ? $tag['table'] : die('Table is empty');
        $field = isset($tag['field']) ? $tag['field'] :'*';
        $id = isset($tag['id']) ? $tag['id'] :0;
        if(!$id){
            die("bad request");
        }
        $str = '<?php ' . "\r\n";
		$str.='$fid='.$id. ";\r\n";
        $str.='$id=intval($fid)'. ";\r\n";
        $str .= '$data=Db::name(\'' . $name . '\')->field(\''.$field.'\')->where("id",$id)->find();' . "\r\n"; //查询语句
        $str .= '$prevs=Db::name("' . $name . '")->field("'.$field.'")->where("id","<",$id)->order("sort asc,id desc")->find();'. "\r\n"; //上一条
        $str .= '$nexts=Db::name("' . $name . '")->field("'.$field.'")->where("id",">",$id)->order("sort asc,id asc")->find();'. "\r\n"; //下一条
		$click_str = "<script language='javascript' src='/home/api/clicks.html?id=".$id."&model=".$name."'></script>";		
        $str .= '$click_show="' . $click_str . '";'. "\r\n"; //统计点击次数
        $str .= 'if($data){extract($data);}'. "\r\n";
        $str .= $content;
        $str .= '  ?>';
        return $str;
    }

    /**
     * 多表查询
     */

	public function tagzminner($tag, $content) {
        $name = isset($tag['table']) ? $tag['table'] : die('Table is empty');
		$tb=explode(",",$name);
		$TableCount=count($tb);
		if($TableCount<2){
			die('Table is error');
		}else if($TableCount==2){
			$a=$tb[0];
			$b=$tb[1];	
		}else if($TableCount==3){
			$a=$tb[0];
			$b=$tb[1];
			$c=$tb[2];
		}else{
			die('Table is error');
		}	
		$jointype = !empty($tag['jointype']) ? $tag['jointype'] : 'INNER';
        $where = !empty($tag['where']) ? $tag['where'] : ' 1 ';
		$join_a = !empty($tag['join_a']) ? $tag['join_a'] : die('join_a where is empty!');
        $order = !empty($tag['order']) ? $tag['order'] : '';
        $limit = !empty($tag['limit']) ? intval($tag['limit']) : false;
        $id = !empty($tag['id']) ? $tag['id'] : 'r';
        $key = !empty($tag['key']) ? $tag['key'] : 'i';
        $mod = !empty($tag['mod']) ? $tag['mod'] : '2';
        $page = !empty($tag['page']) ? $tag['page'] : false;
        $field = !empty($tag['field']) ? $tag['field'] : '';
        $debug = !empty($tag['debug']) ? $tag['debug'] : false;
        $expired = !empty($tag['expired']) ? $tag['expired'] : false;
		$cache = !empty($tag['cache']) ? $tag['cache'] : false;

        $parseStr = '<?php ';
        $parseStr .= '$where= "' . $where . '";';
		$parseStr .= '$cache= "' . $cache . '";';
        $m = "m" . mt_rand(100000, 999999);
        $ret = 'ret' . mt_rand(100000, 999999);
		if($TableCount==2){
			if ($page) {
				$limit = $limit ? $limit : 10; //如果有page，没有输入limit则默认为10
				$parseStr .=  '$count=Db::name("' . $a . '")->alias("a")->join("'.$b.' b","'.$join_a.'","'.$jointype.'")->where($where)->count();';
				$parseStr .= '$pageClassName = new \Pages\Page( $count, ' . $limit . ' );';  //分页类引用
				$parseStr .= '$page_show=$pageClassName->show();';
			}
			$parseStr .=  '$'.$ret . '=Db::name("' . $a . '")->alias("a")->join("'.$b.' b","'.$join_a.'","'.$jointype.'")';
		}else if($TableCount==3){
			if ($page) {
				$limit = $limit ? $limit : 10; //如果有page，没有输入limit则默认为10
				$parseStr .=  '$count=Db::name("' . $a . '")->alias("a")->join("'.$b.' b","'.$join_a.'","'.$jointype.'")->join("'.$c.' c","'.$join_b.'","'.$jointype.'")->where($where)->count();';
				$parseStr .= '$pageClassName = new \Pages\Page( $count, ' . $limit . ' );';  //分页类引用
				$parseStr .= '$page_show=$pageClassName->show();';
			}			
			
			$join_b = !empty($tag['join_b']) ? $tag['join_b'] : die('join_b where is empty!');
			$parseStr .=  '$'.$ret . '=Db::name("' . $a . '")->alias("a")->join("'.$b.' b","'.$join_a.'","'.$jointype.'")->join("'.$c.' c","'.$join_b.'","'.$jointype.'")';
		}

		if($where){
			$parseStr .=  '->where($where)';
		}		
		if($cache){
			$parseStr .=  '->cache(true,$cache)';
		}
        if ($field) {
            $parseStr .= '->field("' . $field . '")';
        }
        if ($limit&&!$page) {
            $parseStr .= '->limit(0,"' . $limit . '")';
        }
        if ($page) {
			$limit = $limit ? $limit : 10; //如果有page，没有输入limit则默认为1
            $parseStr .= '->page("'.$page.'","' .$limit. '")';
        }
        if ($order) {
            $order = str_replace("order", "sort", $order);
            $parseStr .= '->order("' . $order . '")';
        }
        $parseStr .= '->select();';
        $parseStr .= 'if ($' . $ret . '){ $' . $key . '=0;';
        $parseStr .= 'foreach($' . $ret . ' as $key=>$' . $id . ')';
        $parseStr .= '{ ++$' . $key . ';$mod = ($' . $key . ' % ' . $mod . ' );?>';
        $parseStr .= $content;
        $parseStr .= '<?php }}?>';
        return $parseStr;
    }
	
    /**
     * 广告标签，读取广告
     */

    public function tagad($tag, $content) {
        $alias = isset($tag['alias']) ? $tag['alias'] : die('alias is empty');
        $id = isset($tag['id']) ? $tag['id'] :'r';
        if(!$id){
            die("bad request");
        }
        $str = '<?php ' . "\r\n";
		$str.='$fields="a.*,b.alias";'."\r\n";
		$str.='$where_ad[]=["b.alias","=","'.$alias.'"];'."\r\n";
		$str.='$where_ad[]=["a.start_time","<=",time()];'."\r\n";
		$str.='$where_ad[]=["a.end_time",">=",time()];'."\r\n";
		$str.='$adLists=Db::name("ad")->alias("a")->field($fields)->where($where_ad)->join("ad_postion b","b.id=a.postion_id","LEFT")->order(["sort"=>"asc","id"=>"desc"])->select();';
		
        $str .= 'if ($adLists){ $indexKey=0;'."\r\n";
        $str .= 'foreach($adLists as $key=>$' . $id . ')';
        $str .= '{ ++$indexKey;?>';
        $str .= $content;
        $str .= '<?php }}?>';
        return $str;
    }	
	
	


}
