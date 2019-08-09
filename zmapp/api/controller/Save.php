<?php
/**
 * Created by PhpStorm.
 * User: 李贾
 * Date: 2019/8/9
 * Time: 17:26
 */

namespace app\api\controller;


use app\home\controller\Common;

class Save extends Common
{
    public function __construct() {
        parent::__construct();
    }


    public function index(){
        ini_set("max_execution_time", "0");
        $path = WEB_PATH.'/uploads/file/';
        $file_path = $path."fhbb.txt";
        if(file_exists($file_path)){
            $fp = fopen($file_path,"r");
            $str = fread($fp,filesize($file_path));//指定读取大小，这里把整个文件内容读取出来
            $str = str_replace("\r\n","<br />",$str);
            $arr = explode("###",$str);
            unset($arr[0]);
            $new_arr = array();
            //c_print($arr);die;
            foreach ($arr as $key => $val){
                $length = strpos($val,"<br />");
                $content = mb_substr($val,$length);
                $title = mb_substr($val,0,$length);
                $new_arr[]['name'] = 1;
                $new_arr[]['content'] = 2;
//                c_print($content);die;
            }
            fclose($new_arr);
        }
    }
}