<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>修改手机号码</title>
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
                <h3 class="title">修改手机号</h3>
                <div class="ant-row ant-form-item" style="margin-top: 80px; margin-bottom: 100px;">

                </div>
                <div class="ant-row ant-form-item">
                    <div class="ant-col-9 ant-form-item-label">
                        <label class="" title="手机号">手机号</label>
                    </div>
                    <div class="ant-col-8 ant-form-item-control-wrapper">
                        <div class="ant-form-item-control">
                            <span class="ant-form-item-children">
                                <input name="phone" disabled="" type="text" class="ant-input ant-input-lg ant-input-disabled" value="{$user['phone']}">
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
                                                <span>获取验证码</span>
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
                        <label class="" title="新手机号">新手机号</label>
                    </div>
                    <div class="ant-col-8">
                        <div class="ant-form-item-control">
                            <span class="ant-form-item-children">
                                <input name="change-old-mobile" id="new_phone" type="number" class="ant-input " value="">
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

    $(".generate_code").click(function(){
        var disabled = $(".generate_code").attr("disabled");
        var phone = $('input[name="phone"]').val();

        $.ajax({
            url:"{:url('info/sendMsg')}",
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
        var new_phone = $('#new_phone').val();
        var code = $('#code').val();
        var partten = /^1[3,5,7,8,9,1,2,4,6]\d{9}$/;
        if(!partten.test(new_phone)){
            layer.alert('请填写正确的新手机号码'); return false;
        }
        if(code == ""){
            layer.alert('请填写验证码'); return false;
        }
        $.ajax({
            url:"{:url('info/changeMobile')}",
            data:{"new_phone":new_phone,"code":code},
            type:"POST",
            success:function(req){
                console.log(req)
                if (req.code == 0){
                    layer.alert(req.msg); return false;
                }
                if (req.code == 1){
                    layer.alert(req.msg);
                    setTimeout(function(){ window.location.href = "{:url('info/bind')}"; }, 2000);
                }
            }
        });
    })
</script>

</body>