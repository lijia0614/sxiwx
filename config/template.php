<?php
// +----------------------------------------------------------------------
// | ThinkPHP [ WE CAN DO IT JUST THINK ]
// +----------------------------------------------------------------------
// | Copyright (c) 2006~2018 http://thinkphp.cn All rights reserved.
// +----------------------------------------------------------------------
// | Licensed ( http://www.apache.org/licenses/LICENSE-2.0 )
// +----------------------------------------------------------------------
// | Author: liu21st <liu21st@gmail.com>
// +----------------------------------------------------------------------

// +----------------------------------------------------------------------
// | 模板设置
// +----------------------------------------------------------------------

return [
    // 模板引擎类型 支持 php think 支持扩展
    'type'         => 'Think',
    // 模板路径
    'view_path'    => '',
    // 模板后缀
    'view_suffix'  => 'tpl',
    // 模板文件名分隔符
    'view_depr'    => DIRECTORY_SEPARATOR,
    // 模板引擎普通标签开始标记
    'tpl_begin'    => '{',
    // 模板引擎普通标签结束标记
    'tpl_end'      => '}',
    // 标签库标签开始标记
    'taglib_begin' => '<',
    // 标签库标签结束标记
    'taglib_end'   => '>',
	'taglib_pre_load'    =>    '\app\common\taglib\ZmCMS',//加载标签库
	'taglib_build_in'=>'Cx,\app\common\taglib\ZmCMS',
	'tpl_replace_string'=> [
		"href='css/"=>"href='/public/theme/css/",
		'href="css/'=>'href="/public/theme/css/',
		"src='js/" => "src='/public/theme/js/",
		'src="js/' => 'src="/public/theme/js/',
		'src="images/' => 'src="/public/theme/images/',
		"src='images/'" => "src='/public/theme/images/",		
		'src="picture/' => 'src="/public/theme/picture/',
		"src='picture/'" => "src='/public/theme/picture/",
		'src="upload/' => 'src="/public/theme/upload/',
		"src='upload/'" => "src='/public/theme/upload/",		
		"url(picture/" => "url(/public/theme/picture/",
		'url("picture/' => 'url("/public/theme/picture/',
		"href='Css/"=>"href='/public/theme/Css/",
		'href="Css/'=>'href="/public/theme/Css/',
		"src='Scripts/" => "src='/public/theme/Scripts/",
		'src="Scripts/' => 'src="/public/theme/Scripts/',
		'src="Images/' => 'src="/public/theme/Images/',
		"src='Images/'" => "src='/public/theme/Images/",		
		'src="Picture/' => 'src="/public/theme/Picture/',
		"src='Picture/'" => "src='/public/theme/Picture/",
		"url(Picture/" => "url(/public/theme/Picture/",
		'url("Picture/' => 'url("/public/theme/Picture/',		
		"url(images/" => "url(/public/theme/images/",
		"url('images/" => "url('/public/theme/images/",
		'url("images/' => 'url("/public/theme/images/',		
		"url(Images/" => "url(/public/theme/Images/",
		"url('Images/" => "url('/public/theme/Images/",
		'url("Images/' => 'url("/public/theme/Images/',					
		
	]
];
