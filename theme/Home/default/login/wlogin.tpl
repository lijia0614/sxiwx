<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>{$site_name}</title>
    <link href="css/app_7fbeaa2d.css" rel="stylesheet">
</head>
<body style="font-size: 12px;"><!--[if lt IE 10]>
<![endif]-->
<div id="root">
    <div class="index-wrap">
        <div class="index-box">
            <div class="top-area clearfix">
                <a href="/" style="width: 163px; display: inline-block;"><img src="{$logo}"></a>
                <div class="fr"><a href="/">返回</a></div>
            </div>
            <div class="link-account-wrap">
                <div class="ant-row">
                    <div class="ant-col-14 ant-col-offset-5">
                        <div class="create ">
                            <div class="name">首次使用，创建新账号</div>
                            <div class="other">
                                <button type="button" id="ant-btn-primary" class="ant-btn ant-btn-primary">
                                    <span>确认创建</span>
                                </button>
                            </div>
                        </div>
                        <div class="link active">
                            <div class="name">绑定已有账号</div>
                            <div class="desc">如果您已注册过{$site_name}账号，选择此项可将已有账号绑定该账号，下次也可使用手机号登录</div>
                            <div class="other">
                                <div class="ant-row ant-form-item" style="margin-bottom: 4px;">
                                    <div class="ant-col-16 ant-form-item-control-wrapper">
                                        <div class="ant-form-item-control">
                                            <span class="ant-form-item-children">
                                                <span class="ant-input-affix-wrapper">
                                                    <span class="ant-input-prefix">
                                                        <img src="images/f7537.png" style="width: 13px;">
                                                    </span>
                                                    <input id="phone" placeholder="输入您的手机号" type="text" class="ant-input" value="">
                                                </span>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                                <div class="ant-row ant-form-item" style="margin-bottom: 8px;">
                                    <div class="ant-col-16 ant-form-item-control-wrapper">
                                        <div class="ant-form-item-control">
                                            <span class="ant-form-item-children">
                                                <span class="ant-input-affix-wrapper">
                                                    <span class="ant-input-prefix">
                                                        <img src="images/e9dmv.png" style="width: 13px;">
                                                    </span>
                                                    <input id="pwd" type="password" placeholder="输入您的密码" class="ant-input" value="">
                                                </span>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                                <button type="button" id="ant-btn-primary1" class="ant-btn ant-btn-primary"><span>确认绑定</span></button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <footer class="text-center">Copyright © 2017-2018 {$site_name} All Rights Reserved</footer>
    </div>
</div>
<script src="js/jquery-1.9.1.js"></script>
<script src="/public/layer/layer.js"></script>
<script>
    $('.create').click(function () {
        var active = $(this).hasClass('active');
        if (active == false){
            $(this).addClass('active');
            $('.link').removeClass('active')
        }
    })
    $('.link').click(function () {
        var active = $(this).hasClass('active')
        if (active == false){
            $(this).addClass('active');
            $('.create').removeClass('active')
        }
    })

    $('#ant-btn-primary').click(function () {
        window.location.href = "{:url('login/create')}";
    });

    $('#ant-btn-primary1').click(function () {
        var phone = $('#phone').val();
        var pwd = $('#pwd').val();
        var partten = /^1[3,5,7,8,9,1,2,4,6]\d{9}$/;
        if(!partten.test(phone)){
            layer.msg('请填写正确的手机号码'); return false;
        }
        if(pwd == ''){
            layer.msg('请填写密码'); return false;
        }
        $.ajax({
            url:"{:url('Login/bindPhone')}",
            data:{"phone":phone,"pwd":pwd},
            type:"POST",
            success:function(req){
                console.log(req);
                if (req.code == 0){
                    layer.msg(req.msg); return false;
                }
                if (req.code == 1){
                    layer.msg(req.msg);
                    setTimeout(function(){ window.location.href = "{:url('index/index')}"; }, 2000);
                }
            }
        });
    })
</script>
<script>
    var _hmt = _hmt || [];
    (function () {
        var hm = document.createElement("script");
        hm.src = "https://hm.baidu.com/hm.js?0d372343734126a1ba9978a14c0f317f";
        var s = document.getElementsByTagName("script")[0];
        s.parentNode.insertBefore(hm, s);
    })();
</script>

<div></div>
</body>