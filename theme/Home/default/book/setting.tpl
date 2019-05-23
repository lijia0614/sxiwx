<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>作品设置</title>
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
                <include file="common:book_nav"/>
                <div class="book-setting-wrap">
                    <img class="book-cover" src="{$book['image']}">
                    <div class="detail">
                        <div class="ant-row ant-form-item"
                             style="margin-bottom: 10px; height: 40px; color: rgb(68, 78, 94);">
                            <div class="ant-col-3 ant-col-offset-1 ant-form-item-label"><label class="" title="作品名称">作品名称</label>
                            </div>
                            <div class="ant-col-19 ant-form-item-control-wrapper" style="margin-left: 10px;">
                                <div class="ant-form-item-control">
                                    <span class="ant-form-item-children">
                                        <div>{$book['name']}</div>
                                    </span>
                                </div>
                            </div>
                        </div>
                        <div class="ant-row ant-form-item"
                             style="margin-bottom: 10px; height: 40px; color: rgb(68, 78, 94);">
                            <div class="ant-col-3 ant-col-offset-1 ant-form-item-label">
                                <label class="" title="类型">类型</label>
                            </div>
                            <div class="ant-col-19 ant-form-item-control-wrapper" style="margin-left: 10px;">
                                <div class="ant-form-item-control">
                                    <span class="ant-form-item-children">
                                        <zhimeng table="book_category" where="['id','=',$book['cid']]" >
                                        <div>{$r.name}</div>
                                        </zhimeng>
                                    </span>
                                </div>
                            </div>
                        </div>
                        <div class="ant-row ant-form-item"
                             style="margin-bottom: 10px; height: 40px; color: rgb(68, 78, 94);">
                            <div class="ant-col-3 ant-col-offset-1 ant-form-item-label">
                                <label class="" title="授权类型">授权类型</label>
                            </div>
                            <div class="ant-col-19 ant-form-item-control-wrapper" style="margin-left: 10px;">
                                <div class="ant-form-item-control">
                                    <span class="ant-form-item-children">
                                        <div>
                                            <if condition="$book['type'] eq 1">
                                                独家首发
                                                <else/>
                                                驻站作品
                                            </if>
                                        </div>
                                    </span>
                                </div>
                            </div>
                        </div>
                        <div class="ant-row ant-form-item"
                             style="margin-bottom: 10px; height: 40px; color: rgb(68, 78, 94);">
                            <div class="ant-col-3 ant-col-offset-1 ant-form-item-label">
                                <label class="" title="字数">字数</label>
                            </div>
                            <div class="ant-col-19 ant-form-item-control-wrapper" style="margin-left: 10px;">
                                <div class="ant-form-item-control">
                                    <span class="ant-form-item-children">
                                        <div>{$num}</div>
                                    </span>
                                </div>
                            </div>
                        </div>
                        <div class="ant-row ant-form-item"
                             style="margin-bottom: 10px; height: 40px; color: rgb(68, 78, 94);">
                            <div class="ant-col-3 ant-col-offset-1 ant-form-item-label">
                                <label class="" title="介绍">介绍</label>
                            </div>
                            <div class="ant-col-19 ant-form-item-control-wrapper" style="margin-left: 10px;">
                                <div class="ant-form-item-control">
                                    <span class="ant-form-item-children">
                                        <div class="desc">{$book['info']}</div>
                                    </span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <a href="{:url('book/editBook',['id'=>$id])}">
                        <button type="button" class="ant-btn edit-btn ant-btn-lg">
                            <span>修 改</span>
                        </button>
                    </a>
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