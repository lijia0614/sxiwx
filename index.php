<?php
namespace think;
define('WEB_PATH', __DIR__); //系统根目录
// 定义应用目录
define('APP_PATH', __DIR__ . '/zmapp/');
// 加载框架基础引导文件
require __DIR__ . '/core/base.php';
// 添加额外的代码
if (version_compare(PHP_VERSION, '5.6.0', '<'))
    die('require PHP > 5.6.0 !');
// 执行应用并响应
Container::get('app', [APP_PATH])->run()->send();
?>