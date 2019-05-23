<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>{$site_name}</title>
    <script src="js/jquery-1.9.1.js"></script>
    <script src="/public/layer/layer.js"></script>
    <link href="css/app_f7319b21.css" rel="stylesheet">
</head>
<body style="font-size: 12px;"><!--[if lt IE 10]>
<![endif]-->
<div id="root">
    <div class="user-manage-wrap">
        <section class="main-wrap">
            <nav class="component-nav-wrap">
                <div class="info text-center">
                    <if condition="$user['image']">
                        <img src="{$user['image']}" class="avatar">
                        <else/>
                        <img src="images/vh1za.png" class="avatar">
                    </if>
                    <div class="name">{$user['pen_name']}</div>
                    <div class="id">用户ID：{$user['id']}</div>
                </div>

            </nav>
            <div class="mobile-center">
                <h3 class="m-title text-center">
                    <span onclick="javascript:history.back(-1);" class="fl" style="position: absolute; z-index: 1;"></span>
                    <div>个人中心</div>
                </h3>
                <div class="user-info">
                    <if condition="$user['image']">
                        <img src="{$user['image']}">
                        <else/>
                        <img src="images/vh1za.png">
                    </if>

                    <div>
                        <div class="name">{$user['pen_name']}</div>
                        <div data-id="{$user['id']}" id="u_id" class="id">用户ID：{$user['id']}</div>
                    </div>
                </div>
                <div class="line-item">
                    <img src="images/7n760.png">
                    <span>
                        书币余额
                        <span style="color: rgb(167, 167, 167); margin-left: 10px;">{$user['money']}</span>
                    </span>
                    <a href="{:url('recharge/recharge')}" class="recharge-btn text-center">充值</a>
                </div>
                <!--
                <a class="line-item open_vip" id="tovip" href="javascript:volid(0);">
                    <img src="images/qiandao.png">
                    <span>开通会员<span style="color: red"></span></span>
                </a>
                -->

                <a class="line-item sign">
                    <img src="images/qiandao.png">
                    <span>签到</span>
                </a>

                <a class="line-item" href="{:url('sign/jilu')}">
                    <img src="images/jilu.png">
                    <span>签到明细</span><i></i>
                </a>
                <a class="open_vip" id="tovip" href="javascript:volid(0);">
                    <img style="width: 100%;" src="{$vip_image}">
                </a>
                <a class="line-item" href="{:url('info/mxiaofei')}">
                    <img src="images/6bje4.png">
                    <span>消费记录</span><i></i>
                </a>
                <a class="line-item" href="{:url('info/mcz')}">
                    <img src="images/wp62k.png"><span>充值记录</span><i></i></a>
                <a href="javascript:void(0);" id="loginOut" class="logout-btn text-center">退出登录</a>
            </div>
            <input id="str" type="hidden" value="{$str}">
            <input id="vip_price" type="hidden" value="{$ivp_price}">
        </section>
        <footer class="text-center">Copyright © 2017-2018 {$site_name} All Rights Reserved</footer>
    </div>
</div>
<script src="https://hm.baidu.com/hm.js?0d372343734126a1ba9978a14c0f317f"></script>
<script>
    !function (a, b){function c(){var b=f.getBoundingClientRect().width;b/i>540&&(b=540*i);var c=b/10;f.style.fontSize=c+"px",k.rem=a.rem=c}var d,e=a.document,f=e.documentElement,g=e.querySelector('meta[name="viewport"]'),h=e.querySelector('meta[name="flexible"]'),i=0,j=0,k=b.flexible||(b.flexible={});if(g){console.warn("将根据已有的meta标签来设置缩放比例");var l=g.getAttribute("content").match(/initial\-scale=([\d\.]+)/);l&&(j=parseFloat(l[1]),i=parseInt(1/j))}else if(h){var m=h.getAttribute("content");if(m){var n=m.match(/initial\-dpr=([\d\.]+)/),o=m.match(/maximum\-dpr=([\d\.]+)/);n&&(i=parseFloat(n[1]),j=parseFloat((1/i).toFixed(2))),o&&(i=parseFloat(o[1]),j=parseFloat((1/i).toFixed(2)))}}if(!i&&!j){var p=(a.navigator.appVersion.match(/android/gi),a.navigator.appVersion.match(/iphone/gi)),q=a.devicePixelRatio;i=p?q>=3&&(!i||i>=3)?3:q>=2&&(!i||i>=2)?2:1:1,j=1/i}if(f.setAttribute("data-dpr",i),!g)if(g=e.createElement("meta"),g.setAttribute("name","viewport"),g.setAttribute("content","initial-scale="+j+", maximum-scale="+j+", minimum-scale="+j+", user-scalable=no"),f.firstElementChild)f.firstElementChild.appendChild(g);else{var r=e.createElement("div");r.appendChild(g),e.write(r.innerHTML)}a.addEventListener("resize",function(){clearTimeout(d),d=setTimeout(c,300)},!1),a.addEventListener("pageshow",function(a){a.persisted&&(clearTimeout(d),d=setTimeout(c,300))},!1),"complete"===e.readyState?e.body.style.fontSize=12*i+"px":e.addEventListener("DOMContentLoaded",function(){e.body.style.fontSize=12*i+"px"},!1),c(),k.dpr=a.dpr=i,k.refreshRem=c,k.rem2px=function(a){var b=parseFloat(a)*this.rem;return"string"==typeof a&&a.match(/rem$/)&&(b+="px"),b},k.px2rem=function(a){var b=parseFloat(a)/this.rem;return"string"==typeof a&&a.match(/px$/)&&(b+="rem"),b}}(window, window.lib || (window.lib ={}));</script>
<script>
    var _hmt = _hmt || [];
    (function () {
        var hm = document.createElement("script");
        hm.src = "https://hm.baidu.com/hm.js?0d372343734126a1ba9978a14c0f317f";
        var s = document.getElementsByTagName("script")[0];
        s.parentNode.insertBefore(hm, s);
    })();
</script>

<script>
    $('#loginOut').click(function () {
        $.ajax({
            url: "{:url('login/loginOut')}",
            success: function (req) {
                if (req.code == 0) {
                    layer.msg(req.msg);
                    return false;
                }
                if (req.code == 1) {
                    setTimeout(function () {
                        window.location.href = "{:url('index/index')}";
                    }, 0000);
                }
            }
        });
    })

    $('#tovip').click(function () {
        var str = $('#str').val();
        var vip_price = $('#ivp_price').val();

        if(str != ''){
            layer.msg(str);
            return false;
        }
        window.location.href = "{:url('recharge/openVip')}";
    })

    $('.sign').click(function () {
        $.ajax({
            url: "{:url('sign/index')}",
            success: function (req) {
                if (req.code == 1){
                    layer.msg(req.msg);
                }else if(req.code == 0) {
                    layer.msg(req.msg);
                    return false;
                }
            }
        })
    })

</script>

</body>