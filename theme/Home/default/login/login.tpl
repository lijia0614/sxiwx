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
                <a href="/" tyle="width: 163px; height: 100%; display: inline-block;"></a>
                <div class="fr"><a href="{:url('login/register')}">免费注册</a></div>
            </div>
            <div class="login-wrap">
                <div class="ant-row ant-form-item" style="margin-bottom: 16px;">
                    <div class="ant-col-10 ant-col-offset-7 ant-form-item-control-wrapper">
                        <div class="ant-form-item-control">
                            <span class="ant-form-item-children">
                                <h2 class="title">登录</h2>
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
                                        <img src="//s.weituibao.com/static/f7537.png" style="width: 13px;"></span>
                                    <input name="phone" placeholder="输入您的手机号" type="text" class="ant-input ant-input-lg" value="">
                                </span>
                            </span>
                        </div>
                    </div>
                </div>
                <div class="ant-row ant-form-item" style="margin-bottom: 16px;">
                    <div class="ant-col-10 ant-col-offset-7 ant-form-item-control-wrapper">
                        <div class="ant-form-item-control">
                            <span class="ant-form-item-children">
                                <span class="ant-input-affix-wrapper <s-affix-wrapper-lg">
                                    <span class="ant-input-prefix">
                                        <img src="//s.weituibao.com/static/e9dmv.png" style="width: 13px;">
                                    </span>
                                    <input name="password" autocomplete="new-password" type="password" placeholder="输入您的密码" class="ant-input ant-input-lg" value="">
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
                                    <span>立即登录</span>
                                </button>
                            </span>
                        </div>
                    </div>
                </div>
                <div class="ant-row">
                    <div class="ant-col-10 ant-col-offset-7">
                        <label class="ant-checkbox-wrapper" style="color: rgb(119, 128, 144);">
                            <!--
                            <span class="ant-checkbox ant-checkbox-checked">
                                <input type="checkbox" class="ant-checkbox-input" value="">
                                <span class="ant-checkbox-inner"></span>
                            </span>
                            <span>下次自动登录</span>
                            -->
                        </label>
                        <a class="fr" href="{:url('login/findpwd')}" style="color: rgb(73, 144, 226);">忘记密码？</a>
                    </div>
                    <div class="ant-col-10 ant-col-offset-7">
                        <div class="ant-divider ant-divider-horizontal ant-divider-with-text" style="color: rgb(119, 128, 144); font-size: 14px;">
                            <span class="ant-divider-inner-text">第三方登录</span>
                        </div>
                    </div>
                    <input type="hidden" name="back" id="back" value="{$back}">
                    <div class="ant-col-10 ant-col-offset-7 text-center">
                        <a href="{:url('login/wechatLogin',['red'=>$red,'id'=>$id,'b_id'=>$b_id])}">
                            <img src="images/welogin.png" width="40">
                        </a>
                    </div>
                </div>
            </div>
        </div>
        <footer class="text-center">Copyright © 2017-2018 {$site_name} All Rights Reserved</footer>
    </div>
</div>
<script>
    $('.ant-btn-lg').click(function () {
        var phone = $('input[name="phone"]').val();
        var password = $('input[name="password"]').val();
        var back = $('input[name="back"]').val();
        var partten = /^1[1,2,3,4,5,6,7,8,9]\d{9}$/;
        if(!partten.test(phone)){
            layer.alert("请填写正确的手机号！");
            return false;
        }
        if (password == ''){
            layer.alert('请输入密码'); return false;
        }
        $.ajax({
            url:"{:url('Login/login')}",
            data:{"phone":phone,"password":password},
            type:"POST",
            success:function(req){
                console.log(req);
                if (req.code == 0){
                    layer.alert(req.msg); return false;
                }
//                console.log(req);return;
                if (req.code == 1){
                   if (back == ''){
                       setTimeout(function(){ window.location.href = "{:url('index/index')}"; }, 0);
                   }else {
                       setTimeout(function () {
                           window.location.href = back;
                       }, 0);
                   }
                }
            }
        })
    })
</script>

</body>