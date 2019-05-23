<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>创作平台</title>
    <link href="css/app_1f306cd5.css" rel="stylesheet">
    <style>
        .formList table{
            width: 100%;
            border:0;
        }
        .formList{
            margin-top: 20px;
            width: 100%;
        }
        .formList table tr td,.formList table tr th{
            height: 30px;
            line-height: 30px;
            text-align: center;
        }
        .formList table tr,.formList table tr th{
            border-bottom: 1px  solid #fff0f0;
        }
        .formList table tr:last-child{
            border-bottom: none;
        }
        .formList table tr td,.formList table tr th{
            border-right: 0px solid #ccc;
        }
        .formList table tr td:last-child,.formList table tr th:last-child{
            border-right: none;
        }
    </style>
</head>
<body><!--[if lt IE 10]>
<script src="js/leie9.js"></script><![endif]-->
<!--[if lte IE 11]>
<script src="https:js/es6-shim.min.js"></script>
<![endif]-->
<div id="root">
    <div class="app-wrap">
        <include file="common:users_header"/>
        <div class="main-wrap">
            <include file="common:users_nav"/>
            <section class="main-content">
                <div class="comment-wrap">
                    <h2 class="title">读者评论
                        <span style="font-size: 14px; color: rgb(160, 165, 174);">（共 {$count} 条）</span>
                    </h2>
                    <div class="formList">
                        <table>
                            <thead>
                                <tr>
                                    <th>用户</th>
                                    <th>书籍</th>
                                    <th>评论</th>
                                    <th>时间</th>
                                </tr>
                            </thead>
                            <tbody>
                            <volist name="data" id="vo">
                                <tr style="height: 40px;">
                                    <td style="cursor: pointer" data-id="{$vo.id}" class="gonggao">{$vo.u_name}</td>
                                    <td style="cursor: pointer" data-id="{$vo.id}" class="gonggao">{$vo.name}</td>
                                    <td style="cursor: pointer" data-id="{$vo.id}" class="gonggao">{$vo.content|trimhtml=0,20,true}</td>
                                    <td>{$vo.time|date='Y-m-d'}</td>
                                </tr>
                            </volist>
                            </tbody>
                        </table>


                    </div>
                    <div class="text-center" style="padding: 100px 0px;">
                        <p style="margin-top: 20px; color: rgb(160, 165, 175);">{$page}</p>
                    </div>
                    <if condition="empty($data)">
                        <div class="text-center" style="padding: 100px 0px;">
                            <img src="images/1oa0q.png" width="140">
                            <p style="margin-top: 20px; color: rgb(160, 165, 175);">暂无评论</p>
                        </div>
                    </if>
                    <div class="list-wrap"></div>
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

<script>
    $('.ant-btn-lg').click(function () {
        setTimeout(function(){ window.location.href = "{:url('users/editWriter')}"; }, 0);
    })
</script>

<script>
    $('.gonggao').click(function () {
        var id = $(this).attr('data-id');
        $.ajax({
            url:"{:url('users/info')}",
            data:{"id":id},
            type:"POST",
            success:function(req){
                console.log(req);
                if (req){
                    $('#rcDialogTitle0').html('');
                    $('#rcDialogTitle0').html('用户："'+req.u_name+'"评论了你的书籍《'+req.name+'》');
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
    });
    $('.ant-btn-primary').click(function () {
        $('.ant-modal-mask').addClass('ant-modal-mask-hidden');
        $('.ant-modal-wrap').css("display","none");
        window.location.reload()
    });
    $('.ant-modal-close-x').click(function () {
        $('.ant-modal-mask').addClass('ant-modal-mask-hidden');
        $('.ant-modal-wrap').css("display","none");
        window.location.reload()
    })


</script>
</body>