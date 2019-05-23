<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>找回密码</title>
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
            <div style="background-image: url({$logo}); background-repeat:no-repeat; background-size:160px; "
                 class="top-area clearfix">
                <a href="/" style="width: 163px; height: 100%; display: inline-block;"></a>
                <div class="fr"><a href="{:url('login/login')}">立即登录</a></div>
            </div>
            <div class="find-password-wrap">
                <div class="ant-row ant-form-item" style="margin-bottom: 16px;">
                    <div class="ant-col-12 ant-col-offset-6 ant-form-item-control-wrapper">
                        <div class="ant-form-item-control"><span class="ant-form-item-children"><h2
                                        class="title">找回密码</h2></span></div>
                    </div>
                </div>

                <div class="step-0">
                    <div class="ant-row ant-form-item" style="margin-bottom: 16px;">
                        <div class="ant-col-10 ant-col-offset-7 ant-form-item-control-wrapper">
                            <div class="ant-form-item-control">
                                <span class="ant-form-item-children">
                                    <span class="ant-input-affix-wrapper ant-input-affix-wrapper-lg">
                                        <span class="ant-input-prefix">
                                            <img src="images/f7537.png" style="width: 13px;"></span>
                                        <input name="phone" type="number" id="phone" placeholder="输入您的手机号" type="text"class="ant-input ant-input-lg" value="">
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
                                                    <img src="images/4vnta.png" style="width: 13px;"></span>
                                                <input name="findpassword-smscode" id="code" placeholder="输入短信验证码" type="text" class="ant-input ant-input-lg" value="">
                                            </span>
                                            <span class="ant-input-group-addon">
                                                <button type="button" class="generate_code ant-btn ant-btn-background-ghost" style="color: rgb(73, 144, 226); border-color: transparent; width: 110px;">
                                                    <span>获取验证码</span>
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
                                    <input name="password" id="password" type="password" placeholder="设置至少6位的密码" class="ant-input ant-input-lg" value="">
                                </span>
                            </span>
                            </div>
                        </div>
                    </div>
                    <div class="ant-row ant-form-item" style="margin-bottom: 16px;">
                        <div class="ant-col-10 ant-col-offset-7 ant-form-item-control-wrapper">
                            <div class="ant-form-item-control">
                                <span class="ant-form-item-children">
                                    <button type="button" class="ant-btn ant-btn-primary ant-btn-lg" style="width: 100%;">
                                        <span>确定</span>
                                    </button>
                                </span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <footer class="text-center">{$site_name} {$site_icp}</footer>
    </div>
</div>
<script>
    $(".generate_code").click(function(){
        var disabled = $(".generate_code").attr("disabled");
        var phone = $('input[name="phone"]').val();
        var partten = /^1[3,5,7,8,9,1,2,4,6]\d{9}$/;
        if(!partten.test(phone)){
            layer.msg('请填写正确的新手机号码'); return false;
        }
        $.ajax({
            url:"{:url('login/sendMsg')}",
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

    $('.ant-btn-primary').click(function () {
        var phone = $('#phone').val();
        var code = $('#code').val();
        var pwd = $('#password').val();
        if(code == ""){
            layer.msg('请填写验证码'); return false;
        }
        if (pwd.length < 6) {
            layer.msg('密码长度不能小于6位数'); return false;
        }
        $.ajax({
            url:"{:url('login/changePwd')}",
            data:{"phone":phone,"code":code,"pwd":pwd},
            type:"POST",
            success:function(req){
                console.log(req)
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