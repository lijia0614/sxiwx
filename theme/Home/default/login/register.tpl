<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>{$site_name}</title>
    <link href="css/app_f7319b21.css" rel="stylesheet">
    <script src="js/jquery-1.9.1.js"></script>
    <script src="/public/layer/layer.js"></script>
    <style>
        .ant-input-affix-wrapper .ant-input {
             min-height: auto;
        }
    </style>
</head>
<body style="font-size: 12px;"><!--[if lt IE 10]>

<![endif]-->
<div id="root">
    <div class="index-wrap">
        <div class="index-box">
            <div style="background-image: url({$logo}); background-repeat:no-repeat; background-size:160px; " class="top-area clearfix">
                <a href="/" style="width: 163px; height: 100%; display: inline-block;"></a>
                <div class="fr"><a href="{:url('login/login')}">立即登录</a></div>
            </div>
            <div class="register-wrap">
                <div class="ant-row ant-form-item" style="margin-bottom: 16px;">
                    <div class="ant-col-10 ant-col-offset-7 ant-form-item-control-wrapper">
                        <div class="ant-form-item-control">
                            <span class="ant-form-item-children">
                                <h2 class="title">注册</h2>
                            </span>
                        </div>
                    </div>
                </div>
                <div class="ant-row ant-form-item" style="margin-bottom: 16px;">
                    <div class="ant-col-10 ant-col-offset-7 ant-form-item-control-wrapper">
                        <div class="ant-form-item-control">
                            <span class="ant-form-item-children">
                                <span class="ant-input-affix-wrapper ant-input-affix-wrapper-lg">
                                    <span class="ant-input-prefix">
                                        <img src="images/f7537.png" style="width: 13px;"></span>
                                    <input name="phone" placeholder="输入手机号" type="text" class="ant-input ant-input-lg" value="">
                                </span>
                            </span>
                        </div>
                    </div>
                </div>


                <div class="ant-row ant-form-item" style="margin-bottom: 16px;">
                    <div class="ant-col-10 ant-col-offset-7 ant-form-item-control-wrapper">
                        <div class="ant-form-item-control">
                            <span class="ant-form-item-children">
                                <span class="ant-input-group-wrapper ant-input-group-wrapper-lg">
                                    <span class="ant-input-wrapper ant-input-group">
                                        <span class="ant-input-affix-wrapper ant-input-affix-wrapper-lg">
                                            <span class="ant-input-prefix">
                                                <img src="images/4vnta.png" style="width: 13px;">
                                            </span>
                                            <input name="code" placeholder="输入短信验证码" type="text" class="ant-input ant-input-lg " value="">
                                        </span>
                                        <span class="ant-input-group-addon">
                                            <button type="button" class="ant-btn ant-btn-background-ghost generate_code" style="color: rgb(73, 144, 226); border-color: transparent; width: 110px;">
                                                <span class="">获取验证码</span>
                                            </button>
                                        </span>
                                    </span>
                                </span>
                            </span>
                        </div>
                    </div>
                </div>

                <div class="ant-row ant-form-item" style="margin-bottom: 16px;">
                    <div class="ant-col-10 ant-col-offset-7 ant-form-item-control-wrapper">
                        <div class="ant-form-item-control">
                            <span class="ant-form-item-children">
                                <span class="ant-input-affix-wrapper ant-input-affix-wrapper-lg">
                                    <span class="ant-input-prefix">
                                        <img src="images/e9dmv.png" style="width: 13px;">
                                    </span>
                                    <input name="password" type="password" placeholder="设置至少6位的密码" class="ant-input ant-input-lg" value="">
                                </span>
                            </span>
                        </div>
                    </div>
                </div>
                <div class="ant-row ant-form-item" style="margin-bottom: 16px;">
                    <div class="ant-col-10 ant-col-offset-7 ant-form-item-control-wrapper">
                        <div class="ant-form-item-control">
                            <span class="ant-form-item-children">
                                <span class="ant-input-affix-wrapper ant-input-affix-wrapper-lg">
                                    <span class="ant-input-prefix">
                                        <img src="images/e9dmv.png" style="width: 13px;">
                                    </span>
                                    <input name="password2" type="password" placeholder="再次输入密码确认" class="ant-input ant-input-lg" value="">
                                </span>
                            </span>
                        </div>
                    </div>
                </div>
                <div class="ant-row ant-form-item" style="margin-bottom: 16px;">
                    <div class="ant-col-10 ant-col-offset-7 ant-form-item-control-wrapper">
                        <div class="ant-form-item-control"><span class="ant-form-item-children">
                                <button type="button" class="ant-btn ant-btn-primary ant-btn-lg" style="width: 100%;">
                                    <span id="reg">提交注册</span>
                                </button>
                            </span>
                        </div>
                    </div>
                </div>
                <div class="ant-row">
                    <div class="ant-col-10 ant-col-offset-7">
                        <label class="ant-checkbox-wrapper" style="color: rgb(153, 153, 153);">
                            <span class="ant-checkbox ant-checkbox-checked">
                                <input id="checkbox" type="checkbox" checked class="ant-checkbox-input" value="">
                                <span class="ant-checkbox-inner"></span>
                            </span>
                            <span>我已阅读并接受
                                <a rel="noopener noreferrer" target="_blank" href="{:url('index/agreement')}" style="color: rgb(73, 144, 226);">
                                    《双溪文学用户协议》
                                </a>
                            </span>
                        </label>
                    </div>
                </div>
            </div>
        </div>
        <footer class="text-center">Copyright © 2017-2018 {$site_name} All Rights Reserved</footer>
    </div>
</div>

<script>

    $(".generate_code").click(function(){
        var disabled = $(".generate_code").attr("disabled");
        var phone = $('input[name="phone"]').val();
        var partten = /^1[3,5,7,8,9,1,2,4,6]\d{9}$/;
        if(disabled){
            return false;
        }
        if(!partten.test(phone)){
            layer.alert("请填写正确的手机号！");
            return false;
        }
        $.ajax({
            url:"{:url('login/reg_sms')}",
            data:{"phone":phone},
            type:"POST",
            success:function(req){
                console.log(req);
                if (req.code == 0){
                    layer.alert(req.msg);return false;
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
        var phone = $('input[name="phone"]').val();
        var password = $('input[name="password"]').val();
        var c_password = $('input[name="password2"]').val();
        var code = $('input[name="code"]').val();
        var partten = /^1[3,5,7,8,9,1,2,4,6]\d{9}$/;
        if ($('#checkbox').is(':checked') == false) {
            layer.alert('需同意《双溪文学用户协议》才可注册');return false;
        }
        if(!partten.test(phone)){
            layer.alert('请填写正确的手机号码'); return false;
        }
        if (code == ''){
            layer.alert('请填写验证码'); return false;
        }
        if (password == ''){
            layer.alert('请填写注册密码'); return false;
        }
        if (password.length < 6) {
            layer.alert('密码长度不能小于6位数'); return false;
        }
        if (c_password == ''){
            layer.alert('请确认注册密码'); return false;
        }
        if (password != c_password){
            layer.alert('两次输入密码不一样'); return false;
        }
        $.ajax({
            url:"{:url('Login/register')}",
            data:{"phone":phone,"code":code,"password":password},
            type:"POST",
            success:function(req){
                if (req.code == 0){
                    layer.msg(req.msg); return false;
                }
                if (req.code == 1){
                    layer.msg(req.msg);
                    setTimeout(function(){ window.location.href = "{:url('login/login')}"; }, 2000);
                }
            }
        });
    })
</script>


</body>