<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>个人信息</title>
    <link href="css/app_f7319b21.css" rel="stylesheet">
</head>
<body style="font-size: 12px;"><!--[if lt IE 10]>
<script src="js/1482724534125/leie9.js"></script><![endif]-->
<!--[if lte IE 11]>
<script src="js/es6-shim.min.js"></script>
<![endif]-->
<div id="root">
    <div class="user-manage-wrap">
        <include file="common:info_header"/>
        <section class="main-wrap">
            <include file="common:info_left"/>
            <div class="base-info-wrap">
                <div class="ant-tabs ant-tabs-top tabs ant-tabs-line">
                    <div role="tablist" class="ant-tabs-bar" tabindex="0">
                        <div class="ant-tabs-nav-container">
                            <span unselectable="unselectable"  class="ant-tabs-tab-prev ant-tabs-tab-btn-disabled">
                                <span class="ant-tabs-tab-prev-icon"></span>
                            </span>
                            <span unselectable="unselectable" class="ant-tabs-tab-next ant-tabs-tab-btn-disabled">
                                <span class="ant-tabs-tab-next-icon"></span>
                            </span>
                            <div class="ant-tabs-nav-wrap">
                                <div class="ant-tabs-nav-scroll">
                                    <div class="ant-tabs-nav ant-tabs-nav-animated">
                                        <div class="ant-tabs-ink-bar ant-tabs-ink-bar-animated"
                                             style="display: block; transform: translate3d(0px, 0px, 0px); width: 88px;"></div>
                                        <div role="tab" aria-disabled="false" aria-selected="true"
                                             class="ant-tabs-tab-active ant-tabs-tab">
                                            <a href="{:url('info/baseInfo')}">基本信息</a>
                                        </div>
                                        <div role="tab" aria-disabled="false" aria-selected="false"
                                             class=" ant-tabs-tab">
                                            <a href="{:url('info/avatar')}">修改头像</a>
                                        </div>
                                        <div role="tab" aria-disabled="false" aria-selected="false"
                                             class=" ant-tabs-tab">
                                            <a href="{:url('info/updatePwd')}">修改密码</a>
                                        </div>
                                        <div role="tab" aria-disabled="false" aria-selected="false"
                                             class=" ant-tabs-tab">
                                            <a href="{:url('info/bind')}">账号绑定</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="ant-tabs-content ant-tabs-content-animated" style="margin-left: 0%;">
                        <div role="tabpanel" aria-hidden="false" class="ant-tabs-tabpane ant-tabs-tabpane-active"></div>
                        <div role="tabpanel" aria-hidden="true"
                             class="ant-tabs-tabpane ant-tabs-tabpane-inactive"></div>
                        <div role="tabpanel" aria-hidden="true"
                             class="ant-tabs-tabpane ant-tabs-tabpane-inactive"></div>
                        <div role="tabpanel" aria-hidden="true"
                             class="ant-tabs-tabpane ant-tabs-tabpane-inactive"></div>
                    </div>
                </div>
                <div class="ant-row ant-form-item" style="margin-top: 50px;">
                    <div class="ant-col-9 ant-form-item-label">
                        <label class="" title="用户ID">用户ID</label>
                    </div>
                    <div class="ant-col-8 ant-form-item-control-wrapper">
                        <div class="ant-form-item-control">
                            <span class="ant-form-item-children">
                                <input name="user-id" disabled="" type="text" class="ant-input ant-input-disabled" value="{$user['id']}">
                            </span>
                        </div>
                    </div>
                </div>
                <div class="ant-row ant-form-item">
                    <div class="ant-col-9 ant-form-item-label">
                        <label class="" title="昵称">昵称</label>
                    </div>
                    <div class="ant-col-8 ant-form-item-control-wrapper">
                        <div class="ant-form-item-control">
                            <span class="ant-form-item-children">
                                <input name="user-nickname" disabled="" id="name" placeholder="输入昵称" type="text" class="ant-input ant-input-disabled" value="{$user['pen_name']}">
                            </span>
                        </div>
                    </div>
                </div>
                <div class="ant-row ant-form-item">
                    <div class="ant-col-9 ant-form-item-label">
                        <label class="" title="注册时间">注册时间</label>
                    </div>
                    <div class="ant-col-8 ant-form-item-control-wrapper">
                        <div class="ant-form-item-control">
                            <span class="ant-form-item-children">
                                <input name="user-time" disabled="" type="text" class="ant-input ant-input-disabled" value="{$user['time']|date='Y-m-d H:i'}">
                            </span>
                        </div>
                    </div>
                </div>
                <div class="ant-row ant-form-item">
                    <div class="ant-col-9 ant-form-item-label">
                        <label class="" title="性别">性别</label>
                    </div>
                    <div class="ant-col-8 ant-form-item-control-wrapper">
                        <div class="ant-form-item-control">
                            <span class="ant-form-item-children">
                                <div class="ant-radio-group">

                                    <label name="sex" class="ant-radio-wrapper ant-radio-wrapper-checked ant-radio-wrapper-disabled">

                                        <span class='ant-radio-disabled ant-radio <if condition="$user['sex'] eq 1">ant-radio-checked</if> '>
                                        <input type="radio" <if condition="$user['sex'] eq 1">checked="checked"</if> class="ant-radio-input " value="1">
                                            <span class="ant-radio-inner"></span>
                                        </span>
                                        <span>男</span>
                                    </label>
                                    <label name="sex" class="ant-radio-wrapper">
                                        <span class="ant-radio-disabled ant-radio <if condition="$user['sex'] eq 2">ant-radio-checked</if>">
                                            <input type="radio"  <if condition="$user['sex'] eq 2">checked="checked"</if> class="ant-radio-input sex" value="2">
                                            <span class="ant-radio-inner"></span>
                                        </span>
                                        <span>女</span>
                                    </label

                                </div>
                            </span>
                        </div>
                    </div>
                </div>
                <div class="ant-row ant-form-item">
                    <div class="ant-col-4 ant-col-offset-9 ant-form-item-control-wrapper">
                        <div class="ant-form-item-control">
                            <span class="ant-form-item-children">
                                <button type="button" class="ant-btn ant-btn-lg" style="width: 100%;">
                                    <span id="info">修改信息</span>
                                </button>
                            </span>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <footer class="text-center">Copyright © 2017-2018 {$site_name} All Rights Reserved</footer>
    </div>
</div>
<script>
    var _hmt = _hmt || [];
    (function () {
        var hm = document.createElement("script");
        hm.src = "https://hm.baidu.com/hm.js?0d372343734126a1ba9978a14c0f317f";
        var s = document.getElementsByTagName("script")[0];
        s.parentNode.insertBefore(hm, s);
    })();


    $('.ant-radio-group label').on('click',function () {
        $(this).addClass('ant-radio-wrapper-checked').siblings().removeClass('ant-radio-wrapper-checked');
        $(this).find('span.ant-radio').addClass('ant-radio-checked').parents('label').siblings('label').find('span.ant-radio').removeClass('ant-radio-checked');
        $(this).find("input.ant-radio-input").attr("checked",true).parents('label').siblings('label').find("input.ant-radio-input").attr("checked",false)
    });
</script>
<script>
    $('.ant-btn-lg').click(function () {
        if($(this).hasClass('ant-btn-primary')){
            $('.ant-btn-lg').removeClass('ant-btn-primary');
            $('#name').addClass('ant-input-disabled');
            $('#name').attr("disabled",true);
            $('#info').html('修改信息');
            $('.ant-radio-wrapper').addClass('ant-radio-wrapper-disabled');
            $('.ant-radio').addClass('ant-radio-disabled');
            var sex = $("input[type='radio']:checked").val();
            var pen_name = $("#name").val();
            $.ajax({
                url:"{:url('info/baseInfo')}",
                data:{"sex":sex,"pen_name":pen_name},
                type:"POST",
                success:function(req){
                    var c = JSON.parse(req);
                    if (c.status == 0){
                        layer.msg(c.msg); return false;
                    }
                    if (c.status == 1){
                        layer.msg(c.msg);
                        // setTimeout(function(){ window.location.href = "{:url('users/succ')}"+'&id='+c.data; }, 1000);
                    }
                }
            });
        }else{
            $('.ant-btn-lg').addClass('ant-btn-primary');
            $('#name').removeClass('ant-input-disabled');
            $('#name').attr("disabled",false);
            $('#info').html('保存信息');
            $('.ant-radio-wrapper').removeClass('ant-radio-wrapper-disabled');
            $('.ant-radio').removeClass('ant-radio-disabled');
        }
    })



</script>
</body>