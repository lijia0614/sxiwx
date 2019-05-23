<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>绑定手机号码</title>
    <link href="css/app_f7319b21.css" rel="stylesheet">
</head>
<body style="font-size: 12px;"><!--[if lt IE 10]>
<![endif]-->
<div id="root">
    <div class="user-manage-wrap">
        <include file="common:info_header"/>
        <section class="main-wrap">
            <include file="common:info_left"/>
            <div class="change-mobile-wrap">
                <h3 class="title">绑定手机号码</h3>
                <div class="ant-row ant-form-item" style="margin-top: 30px; margin-bottom: 35px;">
                    <div style="color: #4bc1d2; width: 330px; margin: 0 auto">注意：已注册的手机号码不需要填写登录密码选项</div>
                </div>
                <div class="ant-row ant-form-item">
                    <div class="ant-col-9 ant-form-item-label">
                        <label class="" title="手机号">手机号</label>
                    </div>
                    <div class="ant-col-8 ant-form-item-control-wrapper">
                        <div class="ant-form-item-control">
                            <span class="ant-form-item-children">
                                <input id="phone" name="phone" type="text" class="ant-input ant-input-lg ant-input" value="">
                            </span>
                        </div>
                    </div>
                </div>
                <div class="ant-row ant-form-item">
                    <div class="ant-col-9 ant-form-item-label">
                        <label class="" title="短信验证码">短信验证码</label>
                    </div>
                    <div class="ant-col-8 ant-form-item-control-wrapper">
                        <div class="ant-form-item-control">
                            <span class="ant-form-item-children">
                                <span class="ant-input-group-wrapper ant-input-group-wrapper-lg">
                                    <span class="ant-input-wrapper ant-input-group">
                                        <input name="change-old-smscode" id="code" placeholder="输入短信验证码" type="text" class="ant-input ant-input-lg" value="">
                                        <span class="ant-input-group-addon">
                                            <button type="button" class="ant-btn ant-btn-background-ghost generate_code" style="color: rgb(73, 144, 226); border-color: transparent; width: 110px;">
                                                <span style="color: #4bc1d2">获取验证码</span>
                                            </button>
                                        </span>
                                    </span>
                                </span>
                            </span>
                        </div>
                    </div>
                </div>
                <div class="ant-row ant-form-item">
                    <div class="ant-col-9 ant-form-item-label">
                        <label class="" title="登录密码">登录密码</label>
                    </div>
                    <div class="ant-col-8">
                        <div class="ant-form-item-control">
                            <span class="ant-form-item-children">
                                <input placeholder="未注册手机号码填写此选项" name="change-old-mobile" id="pwd" type="password" class="ant-input " value="">
                            </span>
                        </div>
                    </div>
                </div>
                <div class="ant-row ant-form-item">
                    <div class="ant-col-9 ant-form-item-label">
                        <label class="" title="登录密码">确认密码</label>
                    </div>
                    <div class="ant-col-8">
                        <div class="ant-form-item-control">
                            <span class="ant-form-item-children">
                                <input placeholder="未注册手机号码填写此选项" name="change-old-mobile" id="pwd1" type="password" class="ant-input " value="">
                            </span>
                        </div>
                    </div>
                </div>
                <div class="ant-row ant-form-item">
                    <div class="ant-col-4 ant-col-offset-9 ant-form-item-control-wrapper">
                        <div class="ant-form-item-control">
                            <span class="ant-form-item-children">
                                <button type="button" class="ant-btn ant-btn-primary ant-btn-lg" style="width: 100%;">
                                    <span>提交</span>
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

    $('#phone').blur(function () {
        var phone = $('#phone').val();
        var partten = /^1[3,5,7,8,9,1,2,4,6]\d{9}$/;
        if(!partten.test(phone)){
            layer.msg('请填写正确的手机号码'); return false;
        }

    })

    $(".generate_code").click(function(){
        var disabled = $(".generate_code").attr("disabled");
        var phone = $('input[name="phone"]').val();
        var partten = /^1[3,5,7,8,9,1,2,4,6]\d{9}$/;
        if(!partten.test(phone)){
            layer.msg("请填写正确的手机号！");
            return false;
        }
        $.ajax({
            url:"{:url('info/bindMsg')}",
            data:{"phone":phone},
            type:"POST",
            success:function(req){
                console.log(req);
                if (req.code == 0){
                    layer.msg(req.msg);return false;
                }
                settime();
            }
        });
    });

    var countdown=60;
    var _generate_code = $(".generate_code");
    function settime() {
        if (countdown == 0) {
            _generate_code.attr("disabled",false);
            _generate_code.html("获取验证码");
            countdown = 60;
            return false;
        } else {
            $(".generate_code").attr("disabled", true);
            _generate_code.html("重新发送(" + countdown + ")");
            countdown--;
        }
        setTimeout(function() {
            settime();
        },1000);
    }

    $('.ant-btn-lg').click(function () {
        var phone = $('#phone').val();
        var code = $('#code').val();
        var pwd = $('#pwd').val();
        var pwd1 = $('#pwd1').val();
        var partten = /^1[3,5,7,8,9,1,2,4,6]\d{9}$/;
        if(!partten.test(phone)){
            layer.msg('请填写正确的手机号码'); return false;
        }
        if(code == ""){
            layer.msg('请填写验证码'); return false;
        }
        if (pwd != ''){
            if(pwd.length < 6){
                layer.msg('密码不能小于6位'); return false;
            }
            if(pwd != pwd1){
                layer.msg('两次密码输入不一样'); return false;
            }
        }

        $.ajax({
            url:"{:url('info/binMobile')}",
            data:{"phone":phone,"code":code,"pwd":pwd},
            type:"POST",
            success:function(req){
                console.log(req)
                if (req.code == 0){
                    layer.msg(req.msg); return false;
                }
                if (req.code == 1){
                    layer.msg(req.msg);
                    setTimeout(function(){ window.location.href = "{:url('info/bind')}"; }, 2000);
                }
            }
        });
    })
</script>

</body>