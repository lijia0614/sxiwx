<?php
// 应用行为扩展定义文件
return array(
    // 应用初始化
    'app_init'     => array(),
    // 应用开始
    'app_begin'    => array(),
    // 模块初始化
    'module_init'  => array('app\\home\\behavior\\CheckPc','app\\home\\behavior\\ReadHtmlCacheBehavior'),
    // 操作开始执行
    'action_begin' => array(),
    // 视图内容过滤
    'view_filter'  => array(),
    // 日志写入
    'log_write'    => array(),
	
	'response_end' => array('app\\home\\behavior\\WriteHtmlCacheBehavior'),
    // 应用结束
    'app_end'      => array(),
);

?>