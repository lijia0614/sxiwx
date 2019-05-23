<head>
    <meta charset="utf-8">
    <!-- <meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1,user-scalable=no"> -->
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=no">
    <meta http-equiv="keywords" content="{$site_keywords}">
    <meta http-equiv="description" content="{$site_description}">

    <!-- <title></title> -->
    <title>{$book['name']}</title>
    <link rel="stylesheet" href="css/font_626180_rzkibgk7ogl.css">

    <link rel="preload" href="css/0.5c112292.css" as="style">

    <link rel="preload" href="css/style.5c112292.css" as="style">

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

    <script>window.DEVICE = "pc"</script>
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
    <title data-react-helmet="true"></title>

</head>
<body>
<div id="app">
    <div class="wrap">
        <include file="common:header"/>
        <div class="read-page container-wrap">
            <div class="phone-menu-modal">
                <div class="modal-head">
                    <i onClick="javascript :history.back(-1);" class="iconfont icon-jiantouzuo"></i>
                    <span>{$book['name']}</span>
                </div>
                <div class="modal-body">
                    <div class="chapter clearfix">
                        <div class="chapter-title half-border-bottom">正文卷<span>共{$count}章</span></div>
                        <div class="chapter-item-list">
                            <if condition="$type eq 3">
                                <volist name="chapter" id="vo">
                                <if condition="$key+1 egt $book['node']">
                                    <div class="chapter-item">
                                        <a href="{:url('read/read',['bookId'=>$bookId,'id'=>$vo['chapterid']])}">{$vo.title}</a>
                                        <i class="iconfont icon-suo" style="color: #c37734;"></i>
                                    </div>
                                    <else/>
                                    <div class="chapter-item">
                                        <a href="{:url('read/read',['bookId'=>$bookId,'id'=>$vo['chapterid']])}">{$vo.title}</a>
                                    </div>
                                </if>
                                </volist>
                                <elseif condition="$type eq 4"/>
                                <volist name="chapter" id="vo">
                                    <if condition="$key+1 egt $book['node']">
                                        <div class="chapter-item">
                                            <a href="{:url('read/read',['bookId'=>$bookId,'id'=>$vo['chapterid']])}">{$vo.chaptername}</a>
                                            <i class="iconfont icon-suo" style="color: #c37734;"></i>
                                        </div>
                                        <else/>
                                        <div class="chapter-item">
                                            <a href="{:url('read/read',['bookId'=>$bookId,'id'=>$vo['chapterid']])}">{$vo.chaptername}</a>
                                        </div>
                                    </if>
                                </volist>
                                <else/>
                                <zhimeng table="chapter" where="[['b_id','=',$book['id']],['status','=',1],['is_del','=',0]]" order="id asc" limit="150" page="$p">
                                    <if condition="$key+1 egt $book['node']">
                                        <div class="chapter-item">
                                            <a href="{:url('read/read',['b_id'=>$book['id'],'id'=>$r['id']])}">{$r.name}</a>
                                            <i class="iconfont icon-suo" style="color: #c37734;"></i>
                                        </div>
                                        <else/>
                                        <div class="chapter-item">
                                            <a href="{:url('read/read',['b_id'=>$book['id'],'id'=>$r['id']])}">{$r.name}</a>
                                        </div>
                                    </if>
                                </zhimeng>
                            </if>

                        </div>
                        <div style="margin:0 auto;width: 150px;">{$page_show}</div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div>
    <div class="rc-notification" style="top: 65px; left: 50%;"><span></span></div>
</div>

</body>
