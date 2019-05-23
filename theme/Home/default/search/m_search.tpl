<head>
    <meta charset="utf-8">
    <!-- <meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1,user-scalable=no"> -->
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=no">
    <!-- <title></title> -->
    <title>搜索 - {$site_name}</title>
    <link rel="stylesheet" href="css/font_626180_rzkibgk7ogl.css">

    <link rel="preload" href="css/0.5c112292.css" as="style">

    <link rel="preload" href="css/style.5c112292.css" as="style">

    <script src="https://hm.baidu.com/hm.js?0d372343734126a1ba9978a14c0f317f"></script>
    <script>
        // 设置rem字号
        ;(function (doc, win) {
            'use strict';
            var docEl = doc.documentElement;
            var resizeEvt = 'resize';

            function recalc() {
                var clientWidth = docEl.clientWidth;
                if (!clientWidth) return;
                docEl.style.fontSize = (100 * clientWidth / 750) + 'px';
            }

            recalc();
            win.addEventListener(resizeEvt, recalc, false);
        })(document, window);

    </script>

    <script>window.DEVICE = "phone"</script>
    <script>
        var _hmt = _hmt || [];
        (function () {
            var hm = document.createElement("script");
            hm.src = "https://hm.baidu.com/hm.js?0d372343734126a1ba9978a14c0f317f";
            var s = document.getElementsByTagName("script")[0];
            s.parentNode.insertBefore(hm, s);
        })();
    </script>
    <base href="/">
    <link href="css/0.5c112292.css" rel="stylesheet">
    <link href="css/style.5c112292.css" rel="stylesheet">
    <script src="js/jquery-1.9.1.js"></script>
    <script src="/public/layer/layer.js"></script>
    <title data-react-helmet="true"></title>


</head>
<body>
<div id="app">
    <div class="wrap">
        <div class="m-nav ">
            <i onclick="javascript:history.back(-1);" class="iconfont icon-xiangzuo"></i>
            <i class="iconfont icon-search"></i>

            <input id="keywords" type="search" placeholder="输入书名/关键词" value="">

        </div>
        <div class="container-wrap search-wrap">
            <div class="half-border-top"></div>
            <div class="search container">
                <div class="content clearfix">
                    <div class="m-content">
                        <div class="m-hot-recommend">
                            <h4>热门推荐</h4>
                            <div class="list">
                                <zhimeng table="book" where="[['status','=',1],['is_del','=',0],['is_recommend','=',1]]" order="sort desc" limit="10" >
                                <a class="half-border" href="{:url('read/index',['id'=>$r['id']])}">{$r.name}</a>
                                </zhimeng>
                            </div>
                        </div>

                    </div>
                    <div class="content-right">
                        <div class="hot-recommend"><h4>热门推荐</h4>
                            <div class="r-list clearfix"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div>
    <div class="rc-notification" style="top: 65px; left: 50%;"><span></span></div>
</div>
<script>
    $('.icon-search').click(function () {
        var keywords = $('#keywords').val();
        if (keywords == ''){
            layer.msg('请输入书名', { offset: '50px' });return false;
        }
        window.location.href = "{:url('search/mIndex')}"+'?keywords='+keywords;
    })
</script>
</body>