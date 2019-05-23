<head>
    <meta charset="utf-8">
    <!-- <meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1,user-scalable=no"> -->
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=no">
    <meta http-equiv="keywords" content="{$site_keywords}">
    <meta http-equiv="description" content="{$site_description}">

    <read table='book' id="$id"></read>
    <!-- <title></title> -->
    <title>{$name} - {$site_name}</title>
    <link rel="stylesheet" href="css/font_626180_rzkibgk7ogl.css">

    <link rel="preload" href="css/0.dd2aeb5c.css" as="style">

    <link rel="preload" href="css/style.dd2aeb5c.css" as="style">

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
    <link href="css/0.dd2aeb5c.css" rel="stylesheet">
    <link href="css/style.dd2aeb5c.css" rel="stylesheet">
    <title data-react-helmet="true"></title>

    <style>
        @media (max-width: 768px){
            .book .content .book-tab{
                width: 100%;
            }
            .book .content .book-directory{
                box-sizing: border-box;
                overflow: hidden;
            }
            .book .content .book-directory .chapter-item{
                width: 100%;
            }
            .book .content .book-directory .chapter-item a{
                display: block;
                padding-right: 0px;
            }
            .rc-tabs-top .rc-tabs-nav-wrap{
                box-sizing: border-box;
                padding: 0 8px;
            }
        }
    </style>
</head>
<body>
<div id="app">
    <div class="wrap">
        <include file="common:header"/>
        <div class="m-nav ">
            <i onclick="javascript:history.back();" class="iconfont icon-xiangzuo"></i>
            <span>小说主页</span>
            <i class="iconfont icon-home" style="position: absolute; right: 0.3rem;"></i>
        </div>
        <div class="half-border-top"></div>
        <div class="container-wrap book-wrap">
            <div class="book container ">
                <div class="content">
                    <div class="book-info-wrap">
                        <div class="book-info clearfix">
                            <img class="book-cover" src="{$image}" alt="">
                            <div class="center"><h3>{$name}</h3>
                                <div class="novel-author">作者：{$author}</div>
                                <div class="cate">分类：
                                    <zhimeng table="book_category" where="['id','=',$cid]" >
                                        {$r.name}
                                    </zhimeng>
                                </div>
                                <div class="number">字数：
                                    <if condition="$type eq 3">
                                        {$words_num}
                                        <else/>
                                        {$w}
                                    </if>
                                </div>
                                <div class="status">状态：
                                    <if condition="$is_end eq 1">
                                        完结
                                        <else/>
                                        未完结
                                    </if>
                                </div>
                            </div>
                            <div class="buttons">
                                <if condition="$type eq 3">
                                    <if condition="$otherCount neq 0">
                                        <a href="{:url('read/read',['bookId'=>$book_id,'id'=>$first_id])}">
                                            <button class="read-btn">开始阅读</button>
                                        </a>
                                        <else/>
                                        <a href="javascript:void(0);">
                                            <button class="read-btn">没有章节</button>
                                        </a>
                                    </if>
                                    <else/>
                                    <if condition="$first['id']">
                                        <a href="{:url('read/read',['b_id'=>$id,'id'=>$first['id']])}">
                                            <button class="read-btn">开始阅读</button>
                                        </a>
                                        <else/>
                                        <a href="javascript:void(0);">
                                            <button class="read-btn">没有章节</button>
                                        </a>
                                    </if>
                                </if>

                            </div>
                        </div>
                    </div>
                    <div class="book-tab">
                        <div class="rc-tabs rc-tabs-top">
                            <div role="tablist" class="rc-tabs-bar" tabindex="0">
                                <div class="rc-tabs-nav-container">
                                    <span unselectable="unselectable" class="rc-tabs-tab-prev rc-tabs-tab-btn-disabled">
                                        <span class="rc-tabs-tab-prev-icon"></span>
                                    </span>
                                    <span unselectable="unselectable" class="rc-tabs-tab-next rc-tabs-tab-btn-disabled">
                                        <span class="rc-tabs-tab-next-icon"></span>
                                    </span>
                                    <div style=" height: 42px;" class="rc-tabs-nav-wrap">
                                        <div class="rc-tabs-nav-scroll">
                                            <div class="rc-tabs-nav rc-tabs-nav-animated">
                                                <div class="rc-tabs-ink-bar rc-tabs-ink-bar-animated"
                                                     style="display: block; transform: translate3d(96px, 0px, 0px); width: 104px;"></div>
                                                <div role="tab" aria-disabled="false" aria-selected="false"
                                                     class=" rc-tabs-tab">
                                                    <a style="color: #77c2b5" href="{:url('read/index',['id'=>$id])}">作品信息</a>
                                                </div>
                                                <div role="tab" aria-disabled="false" aria-selected="true"
                                                     class="rc-tabs-tab-active rc-tabs-tab">
                                                    <if condition="$type eq 3 || $type eq 4">
                                                        作品目录({$otherCount}章)
                                                        <else/>
                                                        作品目录({$chapter_count}章)
                                                    </if>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="rc-tabs-content rc-tabs-content-animated" style="transform: translateX(-100%) translateZ(0px);">
                                <div role="tabpanel" aria-hidden="true" class="rc-tabs-tabpane rc-tabs-tabpane-inactive">

                                </div>
                                <div role="tabpanel" aria-hidden="false" class="rc-tabs-tabpane rc-tabs-tabpane-active">
                                    <div class="book-directory">
                                        <div class="chapter-list">
                                            <div class="chapter clearfix">
                                                <div class="chapter-title half-border-bottom">正文卷</div>
                                                <div class="chapter-item-list">
                                                    <if condition="$type eq 3">
                                                        <volist name="o_list" id="vo">
                                                            <if condition="$vo['sort'] egt $node">
                                                            <a href="{:url('read/read',['bookId'=>$book_id,'id'=>$vo['chapterid']])}">
                                                                <div style="color: #777;" class="chapter-item half-border-bottom">
                                                                    {$vo.title}&nbsp;&nbsp;&nbsp;
                                                                    <i style="font-size: 8px;color: #c37734;">vip</i>
                                                                </div>
                                                            </a>
                                                                <else/>
                                                                <a href="{:url('read/read',['bookId'=>$book_id,'id'=>$vo['chapterid']])}">
                                                                    <div style="color: #777;" class="chapter-item half-border-bottom">
                                                                        {$vo.title}&nbsp;&nbsp;&nbsp;

                                                                    </div>
                                                                </a>
                                                            </if>
                                                        </volist>

                                                        <elseif condition="$type eq 4"/>

                                                        <volist name="t_list" id="vo">
                                                            <if condition="$key+1 egt $node">
                                                                <a href="{:url('read/read',['bookId'=>$book_id,'id'=>$vo['chapterid']])}">
                                                                    <div style="color: #777;" class="chapter-item half-border-bottom">
                                                                        {$vo.chaptername}&nbsp;&nbsp;&nbsp;
                                                                        <i style="font-size: 8px;color: #c37734;">vip</i>
                                                                    </div>
                                                                </a>
                                                                <else/>
                                                                <a href="{:url('read/read',['bookId'=>$book_id,'id'=>$vo['chapterid']])}">
                                                                    <div style="color: #777;" class="chapter-item half-border-bottom">
                                                                        {$vo.chaptername}&nbsp;&nbsp;&nbsp;

                                                                    </div>
                                                                </a>
                                                            </if>
                                                        </volist>

                                                        <else/>
                                                        <volist name="list" id="vo">
                                                            <if condition="$key+1 egt $node">
                                                                <a href="{:url('read/read',['b_id'=>$id,'id'=>$vo['id']])}">
                                                                    <div style="color: #777;" class="chapter-item half-border-bottom">
                                                                        {$vo.name}&nbsp;&nbsp;&nbsp;
                                                                        <i style="font-size: 8px;color: #c37734;">vip</i>
                                                                    </div>
                                                                </a>
                                                                <else/>
                                                                <a href="{:url('read/read',['b_id'=>$id,'id'=>$vo['id']])}">
                                                                    <div style="color: #777;" class="chapter-item half-border-bottom">
                                                                        {$vo.name}
                                                                    </div>
                                                                </a>
                                                            </if>
                                                        </volist>
                                                    </if>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <include file="common:footer"/>
            </div>
        </div>
    </div>
</div>

<div>
    <div class="rc-notification" style="top: 65px; left: 50%;"><span></span></div>
</div>
<input type="hidden" id="b_id" value="{$id}"/>
<script>
    $('.take').click(function () {
        var b_id = $('#b_id').val();
        $.ajax({
            url:"{:url('read/take')}",
            data:{"b_id":b_id},
            type:"POST",
            success:function(req){
                if (req.code == 0){
                    alert(req.msg); return false;
                }
                if (req.code == 1){
                    alert(req.msg);
                    $('.bookrack-btn').addClass('disabled')
                    $('.bookrack-btn').removeClass('take')
                    $('.bookrack-btn').html('已加入书架')
                }
            }
        });
    })
</script>
</body>