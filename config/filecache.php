<?php	
return array (
  'CACHE_ON' => '0',
  'CACHE_RULES' => 
  array (
    '*' => 
    array (
      0 => '{$_SERVER.REQUEST_URI|md5}',
    ),
  ),
  'CACHE_TIME' => '3600',
  'CACHE_NO' => 
  array (
    'module' => 
    array (
      0 => 'admin',
      1 => 'member',
    ),
    'controller' => 
    array (
      0 => '/home/login/',
      1 => '/home/weixin/',
      2 => '/home/product/',
      3 => '/home/ajax/',
      4 => '/home/oauth/',
      5 => '/home/api/',
    ),
    'action' => 
    array (
      0 => '/home/download/downloadfile',
      1 => '/home/download/index',
    ),
  ),
);
?>