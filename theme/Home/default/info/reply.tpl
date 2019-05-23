<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>{$site_name}</title>
    <link href="css/app_f7319b21.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="css/0_8b3eb11c.css">
</head>
<body style="font-size: 12px;"><!--[if lt IE 10]>
<script src="js/leie9.js"></script><![endif]-->
<!--[if lte IE 11]>
<script src="js/es6-shim.min.js"></script>
<![endif]-->
<div id="root">
    <div class="user-manage-wrap">
        <include file="common:info_header"/>
        <section class="main-wrap">
            <include file="common:info_left"/>
            <div class="reply-wrap">
                <h3 class="title">我的信息
                    <span>（共 {$count} 条）</span>
                </h3>
                <h3 class="m-title text-center">
                    <span class="fl" style="position: absolute; z-index: 1;"></span>
                    我的信息
                </h3>
                <div class="list">
                    <table style="width: 100%;" class="">
                        <colgroup>
                            <col style="width: 85%; min-width: 85%;">
                            <col style="width: 15%; min-width: 15%;">
                        </colgroup>
                        <thead class="ant-table-thead">
                        <tr>
                            <th class=""><span>标题</span></th>
                            <th class=""><span>时间</span></th>
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
                            </tr>
                        </volist>
                        </tbody>
                    </table>
                </div>


                <if condition="empty($data)">
                    <div class="no-data text-center">
                        <img src="images/aaiwg.png">
                        <div>
                            <p>暂时还没有收到任何消息哦~</p>
                            <p></p>
                        </div>
                    </div>
                </if>
            </div>
        </section>
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
    $('.gonggao').click(function () {
        var id = $(this).attr('data-id');
        $.ajax({
            url:"{:url('info/reply')}",
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


</script>

</body>