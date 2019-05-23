<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>创作平台</title>
    <link href="css/app_1f306cd5.css?" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="css/0_8b3eb11c.css">
    <script charset="utf-8" src="js/0_8b3eb11c.js"></script>
    <script src="/public/vend/laydate/laydate.js"></script>
    <script src="/public/layui/layui.js"></script>
    <style>
        #LAY_layedit_1{
            width: 100%;
        }
    </style>
</head>

<body style=""><!--[if lt IE 10]>
<![endif]-->
<div id="root">
    <div class="app-wrap">
        <include file="common:users_header"/>
        <div class="main-wrap">
            <include file="common:users_nav"/>
            <section class="main-content">
                <include file="common:book_nav"/>
                <div class="book-published-wrap">
                    <div class="chapter-aside">
                        <div class="top">共 <span>{$count}</span>章</div>

                        <ul class="ant-menu ant-menu-light ant-menu-root ant-menu-inline" role="menu"
                            aria-activedescendant="" tabindex="0" style="width: 220px;">

                            <li class="ant-menu-submenu ant-menu-submenu-inline ant-menu-submenu-open">

                                <ul class="ant-menu ant-menu-sub ant-menu-inline" role="menu" aria-activedescendant=""
                                    id="1033$Menu" style="">
                                    <volist name="list" id="vo">
                                        <li class="ant-menu-item" role="menuitem" aria-selected="false"
                                            style="padding-left: 48px;padding-right: 0px;">
                                            <a href="{:url('book/published',['id'=>$vo['b_id'],'d_id'=>$vo['id']])}" style="text-decoration: none;">
                                                <div class="component-chapter-item-wrap">
                                                    <div class="chapter-name clearfix">
                                                        <span style="width: 90px;" class="name-long fl">{$vo.name}</span>

                                                    </div>

                                                    <div class="chapter-words">共 {$vo.leng} 字
                                                        <span class="fr">{$vo.time|date='m-d H:i'}</span>
                                                    </div>
                                                </div>
                                            </a>
                                        </li>
                                    </volist>
                                </ul>
                            </li>

                        </ul>
                    </div>
                    <div class="component-editor-wrap">
                        <input class="ant-input ant-input-lg article-title" placeholder="此处输入章节号与章节名，示例“第十章 天降正义”" readonly="" type="text" value="{$data['name']}">
                        <textarea id="demo" style="display: none;">{$data['content']}</textarea>

                    </div>
                </div>
            </section>
        </div>
        <footer class="text-center">Copyright © 2017-2018 {$site_name} All Rights Reserved</footer>
    </div>
</div>


<div>
    <div class="ant-message"><span></span></div>
</div>
<script>
    layui.use('layedit', function(){
        var layedit = layui.layedit;
        layedit.build('demo',{
            tool: [],
            width:500,
            height:700
        }); //建立编辑器
    });
</script>
</body>