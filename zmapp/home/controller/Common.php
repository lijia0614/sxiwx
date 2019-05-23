<?php

namespace app\home\controller;

use think\Controller;
use think\facade\Config;
use think\facade\Request;
use think\Db;
use app\common\controller\AppCommon;
use app\home\model\Config as SystemConfig;

class Common extends AppCommon {

    protected $user_id = '';

    public function __construct() {
        session_start();
        if (session('user_id')) {
            $this->user_id = session('user_id');
        }
        $SystemConfig = new SystemConfig();
        $webConfig = $SystemConfig->getCfgByModule("WEB_SITE");
        $WEBSITE = json_decode($webConfig['WEB_SITE'], true);

        if ($WEBSITE['site_status'] == 2){
            echo "正在升级中...";exit();
        }
        parent::__construct();
        $this->ReadWebsite(); //读取系统配置
		$this->getCustomize();// 自定义站点信息
        $this->paramFilter(); //将所有请求参数赋值到模板变量
        self::setThemes(); //动态配置模板目录
        self::systemStatus();//判断系统是否临时关闭
        $this->assign('module',request()->controller());
        $this->assign('action',request()->action());
        if ($this->user_id){
            $where = [
                'u_id' => $this->user_id,
                'type' => 2,
                'status' => 1
            ];
            $notice = Db::name('notice')
                ->where($where)
                ->count();
            $this->assign('m_c',$notice);
        }
    }

    /**
     * 读取系统配置
     * @author 四川挚梦科技有限公司
     * @date 2018-03-17
     */
    private function ReadWebsite() {
        $WEBSITE = cache('WEBSITE');
        if (!$WEBSITE) {
            $SystemConfig = new SystemConfig();
            $webConfig = $SystemConfig->getCfgByModule("WEB_SITE");
            $WEBSITE = json_decode($webConfig['WEB_SITE'], true);

            cache('WEBSITE', $WEBSITE);
        }
        $this->assign($WEBSITE);
    }
	
    /**
     * 获取自定义站点信息 
     * @author 四川挚梦科技有限公司 
     * @date 2018-05-01
     */
	public function getCustomize(){
		$CUSTOMIZE_SITE = cache('CUSTOMIZE_SITE');
		if(!$CUSTOMIZE_SITE){
			$SystemConfig = new SystemConfig();
			$c = $SystemConfig->getCfgByModule("CUSTOMIZE_SITE");		
			$CUSTOMIZE_SITE = json_decode($c['CUSTOMIZE_SITE'], true);
			cache('CUSTOMIZE_SITE', $CUSTOMIZE_SITE);
		}
        $this->assign($CUSTOMIZE_SITE);
	}	
	

    /**
     * 设置模板目录
     * @author 四川挚梦科技有限公司
     * @date 2018-04-07
     */
    private function setThemes() {
        $TEMPLATE_CONFIG = cache('TEMPLATE_CONFIG');
        if ($TEMPLATE_CONFIG) {
            config($TEMPLATE_CONFIG);
        } else {
            $SystemConfig = new SystemConfig();
            $config = $SystemConfig->getCfgByModule("TEMPLATE_CONFIG");
            $TEMPLATE_CONFIG = json_decode($config['TEMPLATE_CONFIG'], true);
            config($TEMPLATE_CONFIG);
            cache('TEMPLATE_CONFIG', $TEMPLATE_CONFIG); //缓存模板设置
        }
        config('template.view_path', WEB_PATH . "/theme/Home/" . $TEMPLATE_CONFIG['pc_template'] . "/");
		$templatePath = config('template.view_path');
		$this->view->config('view_path',$templatePath);
        $view_replace_arr = config('template.tpl_replace_string');

        if (is_array($view_replace_arr)) {
            foreach ($view_replace_arr as $key => $one) {
                $view_replace_arr[$key] = str_replace("theme", $TEMPLATE_CONFIG['pc_template'], $one);
            }
        }
        $bestKeywordArr=$this->setReplaceBestKeyword();//极限词替换
        $arrs=array_merge($view_replace_arr,$bestKeywordArr);
		$seoLinks=$this->setSeoLinks();
		if(count($seoLinks)>0){
			$arrs=array_merge($seoLinks,$arrs);//添加内链替换
		}
        config::set('template.tpl_replace_string', $arrs);
		$this->view->config('tpl_replace_string',$arrs);
    }

  /**
   * 替换极限词
   * @author 四川挚梦科技有限公司
   * @date 2018-04-07
   * */

  public function setReplaceBestKeyword(){
      $str="操你妈";
      $arr=explode("|",$str);
      $strArr=array();
      foreach($arr as $key=>$one){
          if($one=='最'){
              $strArr[$one]='更';
          }else{
             $strArr[$one]='*';
          }
      }
      return $strArr;
  }

    function getNext(&$array, $curr_key)
    {
        $next = 0;
        reset($array);
        do
        {
            $tmp_key = key($array);
            $res = next($array);
        } while ( ($tmp_key != $curr_key) && $res );

        if( $res )
        {
            $next = key($array);
        }

        return $next;
    }

    function getPrev(&$array, $curr_key)
    {
        end($array);
        $prev = key($array);
        do
        {
            $tmp_key = key($array);
            $res = prev($array);
        } while ( ($tmp_key != $curr_key) && $res );

        if( $res )
        {
            $prev = key($array);
        }
        return $prev;
    }

  /**
   * 设置站内链接
   * @author 四川挚梦科技有限公司
   * @date 2018-04-07
   * */

  public function setSeoLinks(){
	  
        $SEO_LINKS = cache('SEO_LINKS');
        if (!$SEO_LINKS) {
			$SEO_LINKS=Db::name("seo_links")->where("status",1)->select();
			if($SEO_LINKS){
				cache('SEO_LINKS', $SEO_LINKS);
			}
        }
	  $returnArray=array();
	  if(is_array($SEO_LINKS)){
		foreach($SEO_LINKS as $key=>$one){
			$target=($one['target']==1)?'target="_blank"':'target="_self"';//当前页打开还是新窗口打开
			$returnArray[$one['title']]='<a href="'.$one['link'].'" '.$target.'>'.$one['title'].'</a>';
		}  
	  }
      return $returnArray;
  }  
  


    /**
     * 将所有get参数赋值
     * @author 四川挚梦科技有限公司
     * @date 2017-03-29
     */
    private function paramFilter() {
        $arr = input('request.'); //get,post,cookies等请求参数
        $arr = paramFilter($arr);
        $param = Request::param(); //获取请求变量
        $param = paramFilter($param);
        $this->assign($arr); //赋值到模板
        $this->assign($param);
    }

    /**
     * 判断系统状态
     * @author 四川挚梦科技有限公司
     * @date 2017-04-18
     */
    static function systemStatus() {
        $config=config('WEBSITE');
        if ($config['site_status']==2) {
            header('Content-Type:text/html; charset=utf-8');
            exit("<!doctype html><html><head><meta charset=\"utf-8\"><meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\"><meta name=\"viewport\" content=\"width=device-width,initial-scale=1,maximum-scale=1,user-scalable=no\"><title>抱歉,系统临时关闭!!!</title><style>body{background-color:#444;font-size:14px}h3{font-size:60px;color:#eee;text-align:center;padding-top:30px;font-weight:400}</style></head><body><h3>系统临时关闭，请联系管理员</h3></body></html>");
        }
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
     * 判断是否登录
     */
    protected function isLogin()
    {
        $url='http://'.$_SERVER['SERVER_NAME'].$_SERVER["REQUEST_URI"];
        $module = request()->controller();
        $action = request()->action();

        $redirect = 'Home/'.$module.'/'.$action;
        if (empty($this->user_id)) {
            $this->redirect('login/login',['back'=>$url,'red'=>$redirect]);
        }
    }

}
