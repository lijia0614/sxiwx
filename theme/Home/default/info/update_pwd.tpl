<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>修改密码</title>
    <link href="css/app_f7319b21.css" rel="stylesheet">
</head>
<body style="font-size: 12px;">
<![endif]-->
<div id="root">
    <div class="user-manage-wrap">
        <include file="common:info_header"/>
        <section class="main-wrap">
            <include file="common:info_left"/>
            <div class="update-pwd-wrap">
                <div class="ant-tabs ant-tabs-top tabs ant-tabs-line">
                    <div role="tablist" class="ant-tabs-bar" tabindex="0">
                        <div class="ant-tabs-nav-container">
                            <span unselectable="unselectable" class="ant-tabs-tab-prev ant-tabs-tab-btn-disabled">
                                <span class="ant-tabs-tab-prev-icon"></span>
                            </span>
                            <span unselectable="unselectable" class="ant-tabs-tab-next ant-tabs-tab-btn-disabled">
                                <span class="ant-tabs-tab-next-icon"></span>
                            </span>
                            <div class="ant-tabs-nav-wrap">
                                <div class="ant-tabs-nav-scroll">
                                    <div class="ant-tabs-nav ant-tabs-nav-animated">
                                        <div class="ant-tabs-ink-bar ant-tabs-ink-bar-animated"
                                             style="display: block; transform: translate3d(240px, 0px, 0px); width: 88px;"></div>
                                        <div role="tab" aria-disabled="false" aria-selected="false"
                                             class=" ant-tabs-tab">
                                            <a href="{:url('info/baseInfo')}">基本信息</a>
                                        </div>
                                        <div role="tab" aria-disabled="false" aria-selected="false"
                                             class=" ant-tabs-tab">
                                            <a href="{:url('info/avatar')}">修改头像</a>
                                        </div>
                                        <div role="tab" aria-disabled="false" aria-selected="true"
                                             class="ant-tabs-tab-active ant-tabs-tab">修改密码
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
                    <div class="ant-tabs-content ant-tabs-content-animated" style="margin-left: -200%;">
                        <div role="tabpanel" aria-hidden="true"
                             class="ant-tabs-tabpane ant-tabs-tabpane-inactive"></div>
                        <div role="tabpanel" aria-hidden="true"
                             class="ant-tabs-tabpane ant-tabs-tabpane-inactive"></div>
                        <div role="tabpanel" aria-hidden="false" class="ant-tabs-tabpane ant-tabs-tabpane-active"></div>
                        <div role="tabpanel" aria-hidden="true"
                             class="ant-tabs-tabpane ant-tabs-tabpane-inactive"></div>
                    </div>
                </div>
                <div class="ant-row ant-form-item" style="margin-top: 50px;">
                    <div class="ant-col-9 ant-form-item-label"><label class="" title="原密码">原密码</label></div>
                    <div class="ant-col-8 ant-form-item-control-wrapper">
                        <div class="ant-form-item-control">
                            <span class="ant-form-item-children">
                                <input id="oldpwd" placeholder="输入原密码" type="password" class="ant-input" value="">
                            </span>
                        </div>
                    </div>
                </div>
                <div class="ant-row ant-form-item">
                    <div class="ant-col-9 ant-form-item-label">
                        <label class="" title="新密码">新密码</label>
                    </div>
                    <div class="ant-col-8 ant-form-item-control-wrapper">
                        <div class="ant-form-item-control">
                            <span class="ant-form-item-children">
                                <input id="pwd" placeholder="输入新密码" type="password" class="ant-input" value="">
                            </span>
                        </div>
                    </div>
                </div>
                <div class="ant-row ant-form-item">
                    <div class="ant-col-9 ant-form-item-label">
                        <label class="" title="确认新密码">确认新密码</label>
                    </div>
                    <div class="ant-col-8 ant-form-item-control-wrapper">
                        <div class="ant-form-item-control">
                            <span class="ant-form-item-children">
                                <input id="repwd" placeholder="再次输入新密码以确认" type="password" class="ant-input" value="">
                            </span>
                        </div>
                    </div>
                </div>
                <div class="ant-row ant-form-item">
                    <div class="ant-col-4 ant-col-offset-9 ant-form-item-control-wrapper">
                        <div class="ant-form-item-control">
                            <span class="ant-form-item-children">
                                <button type="button" class="ant-btn ant-btn-primary ant-btn-lg" style="width: 100%;">
                                    <span id="update_pwd">确认修改</span>
                                </button>
                            </span>
                        </div>
                    </div>
                </div>
                <div class="ant-row ant-form-item">
                    <div class="ant-col-offset-9 ant-form-item-control-wrapper">
                        <div class="ant-form-item-control">
                            <span class="ant-form-item-children">
                                <span class="tips">注：微信登录的用户需绑定手机号之后才能修改密码</span>
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
    $('.ant-btn-lg').click(function () {
        var old_pwd = $('#oldpwd').val();
        var pwd = $('#pwd').val();
        var repwd = $('#repwd').val();
        if (old_pwd == ''){
            layer.msg('请输出旧密码');return;
        }
        if (pwd.length < 6){
            layer.msg('密码长度不能小于6位');return;
        }
        if (pwd != repwd){
            layer.msg('两次密码输入不一样');return;
        }
        $.ajax({
            url:"{:url('info/updatePwd')}",
            data:{"old_pwd":old_pwd,"pwd":pwd},
            type:"POST",
            success:function(req){
                var c = JSON.parse(req);
                if (c.status == 0){
                    layer.msg(c.msg); return false;
                }
                if (c.status == 1){
                    layer.msg('修改成功');
                    setTimeout(function(){ window.location.reload(); }, 1000);
                }
            }
        });
    })
</script>

<div>
    <div class="ant-message"><span></span></div>
</div>
</body>