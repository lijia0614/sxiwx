<?php
namespace app\home\controller;

use think\Controller;
use think\facade\Config;
use think\Db;
use think\facade\Env;
use think\facade\Validate;
use think\facade\Session;
use QL\QueryList;


class Collection extends Common {

    public function __construct() {
        parent::__construct();
    }
  
    /**
     * 获取采集表中的采集规则，获得内容URL并入库
     * @date 2017-04-12
     */
    public function getCollection() {
        $collect_id = input("request.collect_id", 0, 'intval');
        if (!$collect_id) {
            $this->error("没有采集规则id");
        }
        $collects = Db::name("collection")->where(array("id" => $collect_id))->find();
        $urls = $this->get_content_collect_urls($collects); //获取规则下所有内容页URL
        $contents_url = $this->format_url($collects, $urls); //格式化URL
        $this->add_collects_url($collects, $contents_url); //添加到数据库
        $this->success("URL列表已采集完成", "home/Collection/getData", '', 2);
    }
	
    /**
     * 开始采集
     * @date 2017-04-12
     */
	public function getData(){
		return view(WEB_PATH . '/public/collects/downdata.tpl');
	}
	
	

    /**
     * 根据获取等采集内容URL，获取内容详情,并添加到相对应的板块中
     * @date 2017-04-12
     */
    public function datadown() {

        $fields = 'b.*,a.url,a.small_img,a.id as content_id';
        $join = array(array(config('database.prefix') . 'collection b', "b.id=a.collects_id", "LEFT"));
        $ary_data = Db("collection_url")->alias('a')->field($fields)->where("a.status",0)->join($join)->order("a.id",'desc')->find();
        if (count($ary_data) < 1) {
			JsonDie(9999, '<li><span class="correct_span">&radic;</span>已经采集完啦</li>');
        }
        $get_feilds = json_decode($ary_data['collect_data'], true);
        $content_url = $ary_data['url']; //采集的内容URL
        $small_image = $ary_data['small_img']; //采集的内容缩略图
        $collect_content_box = $ary_data['collect_content_box']; //内容所属容器
        $rulesArr = $this->format_rules($ary_data, $get_feilds); //格式化采集规则
        if (!$rulesArr) {
            JsonDie(0, '<li><span class="correct_span error_span">&radic;</span>采集规则非法</li>');
        }
        if (!$content_url) {
			JsonDie(0, '<li><span class="correct_span error_span">&radic;</span>URL参数有误</li>');
        }
        $ql = QueryList::run('Request', array(
                    'target' => $content_url,
                    'referrer' => $content_url,
                    'method' => 'GET',
                    'params' => array('var1' => 'testvalue', 'var2' => 'somevalue'),
                    'user_agent' => 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.8; rv:21.0) Gecko/20100101 Firefox/21.0',
                    'timeout' => '30'
        ));

        $get_data = $ql->setQuery($rulesArr, $collect_content_box, 'UTF-8', $ary_data['collect_content_type'], true)->getData();
        if (isset($get_data[0])) {
            $inset_data = $get_data[0];
            $inset_data['cid'] = $ary_data['category_id'];
            if ($small_image) {
                $inset_data['image'] = $this->downloadImg($small_image, $ary_data);
            } else if ($inset_data['image']) {
                $sm_url = $this->url_path_check($ary_data, $inset_data['image']);
                ;
                $inset_data['image'] = $this->downloadImg($sm_url, $ary_data);
            }
        } else {
			Db::name('collection_url')->where('id', $ary_data['content_id'])->update(array('status' => 1));
            JsonDie(0, '<li><span class="correct_span error_span">&radic;</span>未获取到内容:'.json_encode($rulesArr).'</li>');
        }
        //判断是否要采集内容分页
        if ($ary_data['get_content_page']) {
            $filed_arr = explode("###", $ary_data['get_content_page']);
            $get_content_rule['child_url'] = array($filed_arr[0], $filed_arr[1]); //下标0为选择器,下标1为获取值的类型	
            $ql->setQuery($get_content_rule);
            $childurl_data = $ql->data;
            $child_url = '';
            if (is_array($childurl_data) && count($childurl_data) >= 1) {
                foreach ($childurl_data as $one) {
                    $child_url[] = $one['child_url'];
                }
                $child_url = array_unique($child_url);
            }
        }

        //采集内容分页结束
        $child_content = "";
        if (isset($child_url) && $child_url) {
            foreach ($child_url as $one) {
                $u = $this->url_path_check($ary_data, $one);
                $child_data = QueryList::run('Request', array(
                            'target' => $u,
                            'referrer' => $u,
                            'method' => 'GET',
                            'params' => array('var1' => 'testvalue', 'var2' => 'somevalue'),
                            'user_agent' => 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.8; rv:21.0) Gecko/20100101 Firefox/21.0',
                            'timeout' => '30'
                        ))->setQuery($rulesArr, '', 'UTF-8', $ary_data['collect_content_type'], true)->getData();
                if (isset($child_data[0]['content'])) {
                    $child_content .= "###page###" . $child_data[0]['content'];
                }
            }
        }
        $inset_data['content'] .= $child_content;
        $inset_data = $this->remove_keyword($ary_data, $inset_data); //删除要过滤的关键词
        $inset_data = $this->replace_keyword($ary_data, $inset_data); //替换原站关键词		
        $inset_data['create_time'] = time();
        $inset_data['update_time'] = time();
        $inset_data['status'] = 0;
		if(strtolower($table)=='download'){//如果是下载模型则有下载附件的字段
			$inset_data['is_down']=0;
		}
        $table = $ary_data['model'];
        $result = Db::name($table)->insert($inset_data);
        if ($result) {
            Db::name('collection_url')->where('id', $ary_data['content_id'])->update(array('status' => 1));
			JsonDie(1, '<li><span class="correct_span">&radic;</span>'.$inset_data['title'] . '<span style="float:right;">采集完成</span></li>');
        }
    }

    /**
     * 根据采集模块ID测试采集数据是否正常
     * @collect_id 采集表中规则id;
     * @date 2017-04-12
     */
    public function TestCollects() {
        $collect_id = input("request.collect_id", 0, 'intval');
        if (!$collect_id) {
            $this->error("没有采集规则id");
        }
        $collects = Db::name("collection")->where(array("id" => $collect_id))->find();
        if (!$collects) {
            $this->error("没有找到该条采集规则");
        }
        $urls = $this->get_content_collect_urls($collects); //获取规则下所有内容页URL
        $urls = $this->format_url($collects, $urls); //格式化URL
        if (isset($urls[0]['url'])) {
            $content_url = $urls[0]['url'];
        } else {
            $this->error("采集URL列表，没有采集到数据", "/", '', 3);
        }

        $this->assign('urls', $urls);
        $get_feilds = json_decode($collects['collect_data'], true);
        $rulesArr = $this->format_rules($collects, $get_feilds, true); //格式化采集规则
        //$get_data=QueryList::Query($content_url,$rulesArr,'','UTF-8',$collects['collect_content_type'],true)->data;
        $ql = QueryList::run('Request', array(
                    'target' => $content_url,
                    'referrer' => $content_url,
                    'method' => 'GET',
                    'params' => array('var1' => 'testvalue', 'var2' => 'somevalue'),
                    'user_agent' => 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.8; rv:21.0) Gecko/20100101 Firefox/21.0',
                    'timeout' => '30'
        ));
        $get_data = $ql->setQuery($rulesArr, '', 'UTF-8', $collects['collect_content_type'], true)->getData();
        if (isset($get_data[0])) {
            $detail_data = $get_data[0];
        }

        //判断是否要采集内容分页
        if ($collects['get_content_page']) {
            $filed_arr = explode("###", $collects['get_content_page']);
            $get_content_rule['child_url'] = array($filed_arr[0], $filed_arr[1]); //下标0为选择器,下标1为获取值的类型	
            $ql->setQuery($get_content_rule);
            $childurl_data = $ql->data;
            $child_url = '';
            if (is_array($childurl_data) && count($childurl_data) >= 1) {
                foreach ($childurl_data as $one) {
                    $child_url[] = $one['child_url'];
                }
                $child_url = array_unique($child_url);
            }
        }

        //采集内容分页结束
        $child_content = "";
        if (isset($child_url) && $child_url) {

            foreach ($child_url as $one) {
                $u = $this->url_path_check($collects, $one);
                $child_data = QueryList::run('Request', array(
                            'target' => $u,
                            'referrer' => $u,
                            'method' => 'GET',
                            'params' => array('var1' => 'testvalue', 'var2' => 'somevalue'),
                            'user_agent' => 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.8; rv:21.0) Gecko/20100101 Firefox/21.0',
                            'timeout' => '30'
                        ))->setQuery($rulesArr, '', 'UTF-8', $collects['collect_content_type'], true)->getData();
                if (isset($child_data[0]['content'])) {
                    $child_content .= "###page###" . $child_data[0]['content'];
                }
            }
        }
        $detail_data['content'] .= $child_content;

        $detail_data = $this->remove_keyword($collects, $detail_data); //删除要过滤的关键词
        $detail_data = $this->replace_keyword($collects, $detail_data); //替换原站关键词
        $this->assign('data', $detail_data);
        return view(WEB_PATH . '/public/collects/collects.tpl');
    }

    /**
     * 获取内容URL列表
     * @collects 数组,采集表中的配置参数
     * @date 2017-04-12
     */
    private function get_content_collect_urls($collects) {
        $collect_url = $collects['collect_url'];
        $start_page = intval($collects['collect_page_min']); //起始页
        $end_page = intval($collects['collect_page_max']); //结束页
        $rule = $collects['get_content_collect_urls']; //采集内容页url规则
        $small_img_url = $collects['small_img_url']; //采集内容页url规则
        $get_content_urls_box = $collects['get_content_urls_box']; //列表url所属容器
	   // $get_content_urls_box = ".tplist li"; //列表url所属容器
        $urls = array();
        //设置采集规则开始
        $regArr['url'] = array($rule, 'href');
        if ($small_img_url) {
            $regArr['small_img_url'] = array($small_img_url, 'src');
        }
        //设置采集规则结束	
        if ($collects['collect_page_status'] == 0 || !strstr($collect_url, "分页") || $end_page < 1) {
            //$urls[] = QueryList::Query($collect_url,$regArr,'','UTF-8', $collects['collect_content_type'],$removeHead = false)->data;

            $urls[] = QueryList::run('Request', array(
                        'target' => $collect_url,
                        'referrer' => $collect_url,
                        'method' => 'GET',
                        'params' => array('var1' => 'testvalue', 'var2' => 'somevalue'),
                        'user_agent' => 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.8; rv:21.0) Gecko/20100101 Firefox/21.0',
                        'timeout' => '30'
                    ))->setQuery($regArr, $get_content_urls_box, 'UTF-8', $collects['collect_content_type'], true)->getData();
				
        } else {
            for ($i = $start_page; $i <= $end_page; $i++) {
                $url = str_replace("分页", $i, $collect_url);
                //$urls[] = QueryList::Query($url,$regArr,'','UTF-8', $collects['collect_content_type'],$removeHead = false)->data;
                $urls[] = QueryList::run('Request', array(
                            'target' => $url,
                            'referrer' => $url,
                            'method' => 'GET',
                            'params' => array('var1' => 'testvalue', 'var2' => 'somevalue'),
                            'user_agent' => 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.8; rv:21.0) Gecko/20100101 Firefox/21.0',
                            'timeout' => '30'
                        ))->setQuery($regArr, $get_content_urls_box, 'UTF-8', $collects['collect_content_type'], true)->getData();
            }
        }
        $urls = array_filter($urls);
        return $urls;
    }

    /*
      判断是否要采集内容中第一张图片为缩略图
     */

    private function get_content_small_image($fields, $collects) {
        if ($collects['is_get_content_small_image'] == 1) {
            $filed_arr = explode("###", $fields['content']);
            $fields['image'] = $filed_arr[0] . " img:first###src";
        }
        return $fields;
    }

    /**
     * 格式化采集规则
     * @collects 采集的基本配置数据
     * @fields 根据数据库字段,获取的采集字段配置
     * @TestCollects bool值，true为测试采集使用，将不下载图片
     * @date 2017-04-12
     */
    private function format_rules($collects, $fields, $TestCollects = false) {
        if (!is_array($fields) || count($fields) < 1) {
            return false;
        }
        $fields = $this->get_content_small_image($fields, $collects);
        $rulesArr = array(); //采集规则数组
        foreach ($fields as $key => $one) {
            $filed_arr = explode("###", $one);
            if (is_array($filed_arr) && count($filed_arr) == 2) {
                $rulesArr[$key] = array($filed_arr[0], $filed_arr[1]); //下标0为选择器,下标1为获取值的类型									
                $rulesArr[$key][] = $this->remove_tags($collects); //规则的第三个参数,过滤后台不需要的标签

                if (!$TestCollects) {
                    $rulesArr[$key][] = function($content) use($collects) {//规则的第四个参数,获取到的内容回调函数
                        $doc = \phpQuery::newDocumentHTML($content);
                        $imgs = pq($doc)->find('img');
                        foreach ($imgs as $img) {
                            $src = $this->url_path_check($collects, pq($img)->attr('src')); //判断图片是相对路径还是绝对路径，补全URL地址
                            if ($src) {
                                $img_path_dir = '/uploads/' . $collects['model'] . '/image/' . date('Y') . '/' . date('m') . '/' . date('d') . '/';
                                $img_file_name = md5($src) . '.jpg';
                                if (!is_dir(WEB_PATH . $img_path_dir)) {
                                    @mkdir(WEB_PATH . $img_path_dir, 0777, true);
                                }

                                $stream = $this->curl_img($src);
                                @file_put_contents(WEB_PATH . $img_path_dir . $img_file_name, $stream);
                                pq($img)->attr('src', $img_path_dir . $img_file_name);
                                //$this->is_resize_fill($img_path_dir.$img_file_name);//判断是否裁剪图片
                                //$this->is_watermark($img_path_dir . $img_file_name); //判断是否添加水印
                            }
                        }
                        return $doc->htmlOuter();
                    };
                }
            }
        }
        return $rulesArr;
    }


    /**
     * 替换原站的关键词
     * @collects 采集的基本配置数据
     * @data 可以传数组，也可以传字符串
     * @date 2017-04-12
     */
    private function replace_keyword($collects, $data) {
        if (!$collects['replace_keyword']) {
            return $data;
        }
        $replace_keyword_arr = explode("\r\n", $collects['replace_keyword']);
        if (count($replace_keyword_arr) < 1) {
            return $data;
        }
        foreach ($replace_keyword_arr as $keyword_str) {
            if ($keyword_str) {
                $keywords_arr = explode("|", $keyword_str);
                if (count($keywords_arr) == 2) {
                    $data = str_replace($keywords_arr[0], $keywords_arr[1], $data);
					//$data = preg_replace("/".$keywords_arr[0]."/is",$keywords_arr[1],$data);//使用正规替换原关键词
                }
            }
        }
        return $data;
    }

    /**
     * 清除后台配置要过滤的关键词
     * @collects 采集的基本配置数据
     * @data 可以传数组，也可以传字符串
     * @date 2017-04-12
     */
    private function remove_keyword($collects, $data) {
        if (!$collects['remove_keyword'] || !$data) {
            return $data;
        }
        $remove_keyword_arr = explode("\r\n", $collects['remove_keyword']);
        if (count($remove_keyword_arr) < 1) {
            return $data;
        }
        foreach ($remove_keyword_arr as $one) {
            foreach ($data as $key => $done) {
                $data[$key] = str_replace($one, '', $done);
				//$data[$key] = preg_replace("/".$one."/is",'',$done);//使用正规替换原关键词
            }
        }
        return $data;
    }

    /**
     * 清除后台配置要过滤的标签
     * @collects 采集的基本配置数据
     * @date 2017-04-12
     */
    private function remove_tags($collects) {
        $remove_str = '';
        if ($collects['is_remove_script'] == 1) {
            $remove_str .= "-script noscript ";
        }
        if ($collects['is_remove_a'] == 1) {
            $remove_str .= "a ";
        }
        if ($collects['is_remove_div'] == 1) {
            $remove_str .= "div ";
        }
        if ($collects['is_remove_p'] == 1) {
            $remove_str .= "p ";
        }
        if ($collects['is_remove_input'] == 1) {
            $remove_str .= "-input ";
        }
        if ($collects['is_remove_textarea'] == 1) {
            $remove_str .= "-textarea ";
        }
        if ($collects['is_remove_from'] == 1) {
            $remove_str .= "-form ";
        }
        if ($collects['is_remove_iframe'] == 1) {
            $remove_str .= "-iframe ";
        }
        if ($collects['is_remove_span'] == 1) {
            $remove_str .= "span ";
        }
        if ($collects['is_remove_li'] == 1) {
            $remove_str .= "li ";
        }
        if (isset($collects['is_remove_mark'])&&!empty($collects['is_remove_mark'])) {
			$is_remove_mark_arr=explode("\r\n",$collects['is_remove_mark']);
			if(count($is_remove_mark_arr)>0){
				foreach($is_remove_mark_arr as $one){
            		$remove_str .= $one." ";
				}
			}
        }	
        return $remove_str;
    }

    /**
     * 添加内容页URL到待采集数据表
     * @collects 采集的基本配置数据
     * @urls 远程图片地址
     * @date 2017-04-12
     */
    private function add_collects_url($collects, $urls) {
        if (is_array($urls)) {
            foreach ($urls as $key => $one) {
                $check = Db::name("collection_url")->where(array('code' => md5($one['url'])))->find();
                if (!$check) {
                    try {
                        $data = array('collects_id' => $collects['id'], 'url' => $one['url'], 'status' => 0, 'create_time' => time(), 'code' => md5($one['url']));
                        if (isset($one['small_img'])) {
                            $data['small_img'] = $one['small_img'];
                        }
                        Db::name('collection_url')->insert($data);
                    } catch (\Exception $e) {
                        JsonDie(0, $e, 'no', $data = '');
                    }
                }
            }
        }
    }

    /**
     * 格式化待采集URL,去掉需要过滤的URL
     * @collects 采集的基本配置数据
     * @urls url地址数组	 
     * @date 2017-04-12
     */
    private function format_url($collects, $urls) {
        if (!is_array($urls)) {
            return false;
        }
        $contents_url = array();
        if ($urls) {
            foreach ($urls as $key => $one) {
                if (is_array($one)) {
                    foreach ($one as $ckey => $cone) {
                        $collect_urls_remove = $collects['get_content_collect_urls_remove'];
                        if ($this->remove_collect_urls($collect_urls_remove, $cone['url'])) {
                            $data['url'] = $this->url_path_check($collects, $cone['url']);
                            if (isset($cone['small_img_url']) && !empty($cone['small_img_url'])) {
                                $data['small_img'] = $this->url_path_check($collects, $cone['small_img_url']);
                            }
                            $contents_url[] = $data;
                        }
                    }
                }
            }
        }
        return $contents_url;
    }

    /**
     * 过滤不需要的url
     * @collect_urls_remove 要删除的url规则
     * @url 需要检查的url
     * @date 2017-04-12
     */
    private function remove_collect_urls($collect_urls_remove, $url) {
        if (!$collect_urls_remove) {
            return true;
        }
        $url_remove_arr = explode("|", $collect_urls_remove);
        if (count($url_remove_arr) < 1) {
            return true;
        }
        foreach ($url_remove_arr as $remove_url) {
            if (strstr($url, $remove_url)) {
                return false;
            }
        }
        return true;
    }

    /**
     * 格式化URL,补全URL信息
     * @collects 采集的基本配置数据
     * @url 链接地址或者图片地址	 
     * @date 2017-04-12
     */
    private function url_path_check($collects, $url) {
        if (empty($url)) {
            return false;
        }
        $domain_array = parse_url($collects['collect_url']);
        $domain = $domain_array['host'];
        $new_url = '';
        if (substr($url, 0, 1) == '/') {
            $new_url = $domain_array['scheme'] . "://" . $domain . $url;
        } else if (substr($url, 0, 4) == 'http') {
            $new_url = $url;
        } else {
            $url_path = pathinfo($collects['collect_url']);
            $new_url = $url_path['dirname'] . "/" . $url;
        }
        return $new_url;
    }

    /**
     * 远程下载图片
     * @imgurl 远程图片地址
     * @collects 采集的基本配置数据
     * @date 2017-04-12
     */
    private function downloadImg($imgurl, $collects) {
        $img_path_dir = '/uploads/' . $collects['model'] . '/image/' . date('Y') . '/' . date('m') . '/' . date('d') . '/';
        $img_file_name = md5($imgurl) . '.jpg';
        if (!is_dir(WEB_PATH . $img_path_dir)) {
            @mkdir(WEB_PATH . $img_path_dir, 0777, true);
        }
        $localSrc = $img_path_dir . $img_file_name;
        $stream = $this->curl_img($imgurl);
        @file_put_contents(WEB_PATH . $localSrc, $stream);
        return $localSrc;
    }
	
    /**
     * curl模拟浏览器访问图片
     * @url 图片URL
     * @date 2017-04-12
     */
    public function curl_img($url) {
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
        curl_setopt($ch, CURLOPT_AUTOREFERER, true);
        curl_setopt($ch, CURLOPT_REFERER, $url);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_USERAGENT, "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.8; rv:21.0) Gecko/20100101 Firefox/21.0");
        $result = curl_exec($ch);
        curl_close($ch);
        return $result;
    }	
	


}