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
    'view_path'    => WEB_PATH . "/theme/Admin/Default/",
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
	// 替换模板中的html标签
	'tpl_replace_string'=>[
		"href='css/"=>"href='/public/admin/default/css/",
		'href="css/'=>'href="/public/admin/default/css/',
		"src='js/" => "src='/public/admin/default/js/",
		'src="js/' => 'src="/public/admin/default/js/',
		'src="images/' => 'src="/public/admin/default/images/',
		"src='images/'" => "src='/public/admin/default/images/",		
		'src="picture/' => 'src="/public/admin/default/picture/',
		"src='picture/'" => "src='/public/admin/default/picture/",
		'src="upload/' => 'src="/public/admin/default/upload/',
		"src='upload/'" => "src='/public/admin/default/upload/",		
		"url(picture/" => "url(/public/admin/default/picture/",
		'url("picture/' => 'url("/public/admin/default/picture/',
		"href='Css/"=>"href='/public/admin/default/Css/",
		'href="Css/'=>'href="/public/admin/default/Css/',
		"src='Scripts/" => "src='/public/admin/default/Scripts/",
		'src="Scripts/' => 'src="/public/admin/default/Scripts/',
		'src="Images/' => 'src="/public/admin/default/Images/',
		"src='Images/'" => "src='/public/admin/default/Images/",		
		'src="Picture/' => 'src="/public/admin/default/Picture/',
		"src='Picture/'" => "src='/public/admin/default/Picture/",
		"url(Picture/" => "url(/public/admin/default/Picture/",
		'url("Picture/' => 'url("/public/admin/default/Picture/',		
		"url(images/" => "url(/public/admin/default/images/",
		"url('images/" => "url('/public/admin/default/images/",
		'url("images/' => 'url("/public/admin/default/images/',		
		"url(Images/" => "url(/public/admin/default/Images/",
		"url('Images/" => "url('/public/admin/default/Images/",
		'url("Images/' => 'url("/public/admin/default/Images/',		
	]
];
