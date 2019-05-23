<?php
return [
    'USER_AUTH_ON' => true, //开启权限认证
    'USER_AUTH_TYPE' => 2, // 默认认证类型 1 登录认证 2 实时认证
    'USER_AUTH_KEY'         => 'adminAuth',
	'AUTH_TYPE' => array('NODE', 'MODULE', 'ACTION'), //授权类型的常量
	'ADMIN_AUTH_KEY' => 'SystemManage',//超级管理员标识
    'RBAC_ROLE_TABLE' => 'role',//角色表
    'RBAC_USER_TABLE' => 'admin',//用户表
    'RBAC_ACCESS_TABLE' => 'role_access',//授权明细表
    'RBAC_NODE_TABLE' => 'role_node',	//节点表
    'AUTH_TYPE' => array('NODE', 'MODULE', 'ACTION'), //授权类型的常量	
 	'NOT_AUTH_MODULE' => 'Index,User,Error', // 默认无需认证模块
    'NOT_AUTH_ACTION' => 'doEditstatus', // 默认无需认证方法
	'USER_AUTH_GATEWAY' => '/Admin/User/Login', // 默认认证网关		
];
