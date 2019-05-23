<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>创作平台</title>
    <link href="css/app_1f306cd5.css?" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="css/0_8b3eb11c.css">
    <script charset="utf-8" src="/js/0_8b3eb11c.js"></script>
    <style>

        #root .ant-table-thead > tr > th {
            text-align: center;
        }
        #root .ant-table-tbody > tr > td{
            text-align: center;
        }
        #root .ant-table-tbody > tr > td:first-child{
            text-align: left;
        }
        .detils span{
            width: 40px;
            display: block;
            cursor: pointer;
        }
    </style>
</head>
<body><!--[if lt IE 10]>
<script src="js/leie9.js"></script><![endif]-->
<!--[if lte IE 11]>
<script src="js/es6-shim.min.js"></script>
<![endif]-->
<div id="root">
    <div class="app-wrap">
        <include file="common:users_header"/>
        <div class="main-wrap">
            <include file="common:users_nav"/>
            <section class="main-content">
                <div class="home-wrap">
                    <div class="user-overview clearfix">
                        <img class="avatar fl" src="images/vh1za.png" alt="头像">
                        <div class="user">
                            <div class="name">{$user['name']}</div>
                            <div class="data">今天是{$time|date='Y-m-d'}，{$time1}。</div>
                        </div>
                    </div>
                    <div class="notice"><h2 class="title">通知</h2>
                        <div class="table-wrap">
                            <div class="ant-table-wrapper">
                                <div class="ant-spin-nested-loading">
                                    <div class="ant-spin-container">
                                        <div class="ant-table ant-table-large ant-table-scroll-position-left">
                                            <div class="ant-table-content">
                                                <div class="ant-table-body">
                                                    <table class="">
                                                        <colgroup>
                                                            <col style="width: 85%; min-width: 85%;">
                                                            <col style="width: 15%; min-width: 15%;">
                                                        </colgroup>
                                                        <thead class="ant-table-thead">
                                                        <tr>
                                                            <th class=""><span>标题</span></th>
                                                            <th class=""><span>时间</span></th>
                                                            <th class=""><span>操作</span></th>
                                                        </tr>
                                                        </thead>
                                                        <tbody class="ant-table-tbody">
                                                        <volist name="data" id="vo">
                                                            <tr class="ant-table-row  ant-table-row-level-0">
                                                                <td class="">
                                                                    <span class="ant-table-row-indent indent-level-0" style="padding-left: 0px;"></span>
                                                                    <div>

                                                                        <if condition="$vo.type eq 3">
                                                                            <div id="gonggao" class="gonggao" data-id="{$vo.id}" style="display: inline-block; width: 96%; margin-left: 10px; cursor: pointer;">
                                                                                <span style="color:#4bc1d2">[公告]</span>
                                                                                {$vo.title}
                                                                            </div>
                                                                            <else/>
                                                                            <i class="read-tag" style="
                                                                                <if condition='$vo.status eq 1'>
                                                                                 background-color: rgb(195, 203, 219);
                                                                                 <else/>
                                                                                 background-color: white;
                                                                                </if>
                                                                                display: inline-block;
                                                                                vertical-align: top;
                                                                                margin-top: 8px;
                                                                                width: 8px;
                                                                                height: 8px;
                                                                                border-radius: 50%;">
                                                                            </i>
                                                                            <div id="gonggao" class="gonggao" data-id="{$vo.id}" style="display: inline-block; width: 96%; margin-left: 10px; cursor: pointer;">
                                                                                {$vo.title}
                                                                            </div>
                                                                        </if>

                                                                    </div>
                                                                </td>
                                                                <td class="">{$vo.time|date='Y-m-d'}</td>
                                                                <td class="detils">
                                                                    <span class="del" data-id="{$vo.id}">删除</span>
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
                    <div style="width: 300px; margin: 0 auto">{$page}</div>
                </div>

            </section>
        </div>
        <div>
            <div>
                <div class="ant-modal-mask ant-modal-mask-hidden"></div>
                <div tabindex="-1" class="ant-modal-wrap " role="dialog" aria-labelledby="rcDialogTitle0" style="display: none;">
                    <div role="document" class="ant-modal" style="width: 520px; transform-origin: -47px 250px 0px;">
                        <div class="ant-modal-content">
                            <button aria-label="Close" class="ant-modal-close"><span class="ant-modal-close-x"></span>
                            </button>
                            <div class="ant-modal-header">
                                <div class="ant-modal-title" id="rcDialogTitle0">{$r.title}</div>
                            </div>
                            <div class="ant-modal-body">
                                <div id="content">{$r.content}</div>
                            </div>
                            <div class="ant-modal-footer">
                                <button type="button" class="ant-btn ant-btn-primary"><span>确 定</span></button>
                            </div>
                        </div>
                        <div tabindex="0" style="width: 0px; height: 0px; overflow: hidden;">sentinel</div>
                    </div>
                </div>
            </div>
        </div>
        <footer class="text-center">Copyright © 2017-2018 {$site_name} All Rights Reserved</footer>
    </div>
</div>

<div>
    <div class="ant-message"><span></span></div>
</div>
<script>
    $('.gonggao').click(function () {
        var id = $(this).attr('data-id');
        $.ajax({
            url:"{:url('users/home')}",
            data:{"id":id},
            type:"POST",
            success:function(req){
                console.log(req);
                if (req){
                    $('#rcDialogTitle0').html('');
                    $('#rcDialogTitle0').html(req.title);
                    $('#content').html('');
                    $('#content').html(req.content);
                }
                if (req.code == 1){
                    layer.msg('数据错误')
                }
            }
        });
        $('.ant-modal-mask').removeClass('ant-modal-mask-hidden');
        $('.ant-modal-wrap').css("display","block");
    })
    $('#gonggao').click(function () {
        $('.ant-modal-mask').removeClass('ant-modal-mask-hidden');
        $('.ant-modal-wrap').css("display","block");
    })
    $('.ant-btn-primary').click(function () {
        $('.ant-modal-mask').addClass('ant-modal-mask-hidden');
        $('.ant-modal-wrap').css("display","none");
        window.location.reload()
    })
    $('.ant-modal-close-x').click(function () {
        $('.ant-modal-mask').addClass('ant-modal-mask-hidden');
        $('.ant-modal-wrap').css("display","none");
        window.location.reload()
    })

    $('.del').click(function () {
        var id = $(this).attr('data-id');

        layer.confirm('确定删除吗？', {
            btn: ['确定','取消'] //按钮
        }, function(){
            $.ajax({
                url:"{:url('users/delNotice')}",
                data:{"id":id},
                type:"POST",
                success:function(req){
                    if (req.code == 0){
                        layer.msg(req.msg, {icon: 2});
                    }
                    if (req.code == 1){
                        layer.msg(req.msg, {icon: 1});
                        window.location.reload()
                    }
                }
            });

        }, function(){
            return;
        });
    })
</script>
</body>