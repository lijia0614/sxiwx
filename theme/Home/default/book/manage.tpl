<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>作品管理</title>
    <link href="css/app_1f306cd5.css?" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="css/0_8b3eb11c.css">
    <script charset="utf-8" src="js/0_8b3eb11c.js"></script>
</head>

<body style=""><!--[if lt IE 10]>
<![endif]-->
<div id="root">
    <div class="app-wrap">
        <include file="common:users_header"/>
        <div class="main-wrap">
            <include file="common:users_nav"/>
            <section class="main-content">
                <div class="book-manage-wrap">
                    <h2 class="title">作品管理</h2>
                    <div style="margin-top: 25px; color: rgb(119, 128, 144);">当前作品总数
                        <span style="color: rgb(255, 100, 124);">{$count}</span> 本
                        <a href="{:url('users/createbook')}">
                            <button type="button" class="ant-btn fr ant-btn-primary" style="margin-top: -6px;">
                                <img width="16" src="//s.weituibao.com/static/e4amw.png" style="vertical-align: sub;">
                                <span> 创建作品</span>
                            </button>
                        </a></div>
                    <div class="table-wrap">
                        <div class="ant-table-wrapper">
                            <div class="ant-spin-nested-loading">
                                <div class="ant-spin-container">
                                    <div class="ant-table ant-table-large ant-table-scroll-position-left">
                                        <div class="ant-table-content">
                                            <div class="ant-table-body">
                                                <table class="">
                                                    <colgroup>
                                                        <col style="width: 35%; min-width: 35%;">
                                                        <col style="width: 20%; min-width: 20%;">
                                                        <col style="width: 19%; min-width: 19%;">
                                                        <col style="width: 26%; min-width: 26%;">
                                                    </colgroup>
                                                    <thead class="ant-table-thead">
                                                    <tr>
                                                        <th class=""><span>作品名称</span></th>
                                                        <th class=""><span>最新章节</span></th>
                                                        <th class=""><span>状态</span></th>
                                                        <th class=""><span>操作</span></th>
                                                    </tr>
                                                    </thead>
                                                    <tbody class="ant-table-tbody">
                                                    <volist name="book" id="vo">
                                                    <tr class="ant-table-row  ant-table-row-level-0">
                                                        <td class="">
                                                            <span class="ant-table-row-indent indent-level-0" style="padding-left: 0px;"></span>
                                                            <div class="book">
                                                                <img src="{$vo.image}"><span>{$vo.name}</span>
                                                            </div>
                                                        </td>
                                                        <td class="">
                                                            <zhimeng table="chapter" where="[['b_id','=',$vo['id']],['is_del','=',0]]" order="id desc" limit="1" >
                                                                <div>
                                                                    <div>{$r.name}</div>
                                                                    <div style="color: rgb(119, 128, 144); margin-top: 5px;">
                                                                        {$r.time|date='Y-m-d H:i'}
                                                                    </div>
                                                                </div>
                                                            </zhimeng>
                                                        </td>
                                                        <td class="">
                                                            <zhimeng table="chapter" where="[['b_id','=',$vo['id']],['is_del','=',0]]" order="id desc" limit="1" >
                                                            <div>
                                                                <if condition="$r.status eq 1">
                                                                    <div style="color: skyblue">已通过</div>
                                                                    <else/>
                                                                    <div style="color: rgb(246, 166, 35)">审核中</div>
                                                                </if>
                                                            </div>
                                                            </zhimeng>
                                                        </td>
                                                        <td class="">
                                                            <div class="action text-center clearfix">
                                                                <a class="fl" href="{:url('book/draft',['id'=>$vo.id])}">
                                                                    <img src="//s.weituibao.com/static/q6nce.png">
                                                                    <br>写新章节
                                                                </a>
                                                                <a href="{:url('book/published',['id'=>$vo.id])}">
                                                                    <img src="//s.weituibao.com/static/xulbm.png">
                                                                    <br>已发布章节
                                                                </a>
                                                                <a class="fr" href="{:url('book/setting',['id'=>$vo.id])}">
                                                                    <img src="//s.weituibao.com/static/t39yc.png">
                                                                    <br>作品设置
                                                                </a>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                    </volist>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
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
</body>