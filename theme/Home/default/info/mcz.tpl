<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>充值记录</title>
    <link href="css/app_f7319b21.css" rel="stylesheet">
</head>
<body style="font-size: 12px;"><!--[if lt IE 10]>
<![endif]-->
<div id="root">
    <div class="user-manage-wrap">

        <section class="main-wrap">

            <div class="wallet-wrap"><h3 class="title">我的钱包</h3>
                <h3 class="m-title text-center">
                    <span onclick="javascript:history.back(-1);" class="fl" style="position: absolute; z-index: 1;">
                    </span>
                    <div class="active">充值记录</div>
                </h3>

                <div class="list-wrap">
                    <zhimeng table="recharge" where="[['u_id','=',$u_id],['is_pay','=',1]]" order="pay_time desc" limit="15" page="$p">
                    <div class="component-bill-recharge-item-wrap">
                        <div class="line-1">
                            <span>
                                <if condition="$r['type'] eq 5">
                                    开通会员
                                    <else/>
                                    充值成功
                                </if>
                            </span>
                            <span>
                                <if condition="$r['type'] eq 5">
                                    一年
                                    <else/>
                                    +{$r.amount}
                                </if>
                            </span>
                        </div>
                        <div class="line-2">
                            <if condition="$r['type'] eq 5">
                                <span>
                                    {$r.pay_time|date='Y-m-d H:i:s'}
                                </span>
                                <else/>
                                <span>
                                    {$r.pay_time|date='Y-m-d H:i:s'}
                                </span>
                                <span>{$r.amount*100}书币</span>
                            </if>

                        </div>
                    </div>
                    </zhimeng>
                </div>
            </div>
        </section>
        <footer class="text-center">Copyright © 2017-2018 {$site_name} All Rights Reserved</footer>
    </div>
</div>
<script src="https://hm.baidu.com/hm.js?0d372343734126a1ba9978a14c0f317f"></script>
<script>!function (a, b){function c(){var b=f.getBoundingClientRect().width;b/i>540&&(b=540*i);var c=b/10;f.style.fontSize=c+"px",k.rem=a.rem=c}var d,e=a.document,f=e.documentElement,g=e.querySelector('meta[name="viewport"]'),h=e.querySelector('meta[name="flexible"]'),i=0,j=0,k=b.flexible||(b.flexible={});if(g){console.warn("将根据已有的meta标签来设置缩放比例");var l=g.getAttribute("content").match(/initial\-scale=([\d\.]+)/);l&&(j=parseFloat(l[1]),i=parseInt(1/j))}else if(h){var m=h.getAttribute("content");if(m){var n=m.match(/initial\-dpr=([\d\.]+)/),o=m.match(/maximum\-dpr=([\d\.]+)/);n&&(i=parseFloat(n[1]),j=parseFloat((1/i).toFixed(2))),o&&(i=parseFloat(o[1]),j=parseFloat((1/i).toFixed(2)))}}if(!i&&!j){var p=(a.navigator.appVersion.match(/android/gi),a.navigator.appVersion.match(/iphone/gi)),q=a.devicePixelRatio;i=p?q>=3&&(!i||i>=3)?3:q>=2&&(!i||i>=2)?2:1:1,j=1/i}if(f.setAttribute("data-dpr",i),!g)if(g=e.createElement("meta"),g.setAttribute("name","viewport"),g.setAttribute("content","initial-scale="+j+", maximum-scale="+j+", minimum-scale="+j+", user-scalable=no"),f.firstElementChild)f.firstElementChild.appendChild(g);else{var r=e.createElement("div");r.appendChild(g),e.write(r.innerHTML)}a.addEventListener("resize",function(){clearTimeout(d),d=setTimeout(c,300)},!1),a.addEventListener("pageshow",function(a){a.persisted&&(clearTimeout(d),d=setTimeout(c,300))},!1),"complete"===e.readyState?e.body.style.fontSize=12*i+"px":e.addEventListener("DOMContentLoaded",function(){e.body.style.fontSize=12*i+"px"},!1),c(),k.dpr=a.dpr=i,k.refreshRem=c,k.rem2px=function(a){var b=parseFloat(a)*this.rem;return"string"==typeof a&&a.match(/rem$/)&&(b+="px"),b},k.px2rem=function(a){var b=parseFloat(a)/this.rem;return"string"==typeof a&&a.match(/px$/)&&(b+="rem"),b}}(window, window.lib || (window.lib ={}));</script>
<script>
    var _hmt = _hmt || [];
    (function () {
        var hm = document.createElement("script");
        hm.src = "https://hm.baidu.com/hm.js?0d372343734126a1ba9978a14c0f317f";
        var s = document.getElementsByTagName("script")[0];
        s.parentNode.insertBefore(hm, s);
    })();
</script>

</body>