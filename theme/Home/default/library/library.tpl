<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=no">
    <meta http-equiv="keywords" content="{$site_keywords}">
    <meta http-equiv="description" content="{$site_description}">

    <title>书库 - {$site_name}</title>
    <link rel="stylesheet" href="css/font_626180_rzkibgk7ogl.css">
    <link rel="preload" href="css/0.dd2aeb5c.css" as="style">
    <link rel="preload" href="css/style.dd2aeb5c.css" as="style">
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

</head>
<body>
<div id="app">
    <div class="wrap">
        <include file="common:header"/>
        <div class="m-nav "><i class="iconfont icon-xiangzuo"></i><span>书库</span></div>
        <div class="half-border-top"></div>
        <div class="container-wrap library-wrap">
            <div class="library container">
                <div class="filter-group">
                    <div class="filter-categray">
                        <span class="type">分类：</span>
                        <span data-id="-1" class="active all">全部</span>
                        <zhimeng table="book_category" where="[['status','=',1],['is_del','=',0]]">
                        <span data-id="{$r.id}">{$r.name}</span>
                        </zhimeng>
                    </div>
                    <div class="filter-words half-border-top">
                        <span class="type tt1">字数：</span>
                        <span data-id="-1" class="active all">全部</span>
                        <span class="" data-id="3w">30万字以下</span>
                        <span class="" data-id="5w">30-50万字</span>
                        <span class="" data-id="10w">50-100万字</span>
                        <span class="" data-id="20w">100-200万字</span>
                        <span class="" data-id="20s">200万字以上</span>
                    </div>
                    <div class="filter-status half-border-top">
                        <span class="type">状态：</span>
                        <span data-id="-1" class="active all">全部</span>
                        <span class="" data-id="0">连载</span>
                        <span class="" data-id="1">完结</span>
                    </div>
                </div>
                <div class="sort">
                    <span type="month_view_count" data-id="001" class="active">
                        点击量
                        <i class="iconfont icon-jiantou"></i>
                    </span>
                    <span data-id="002" class="">
                        总字数
                        <i class="iconfont icon-jiantou"></i>
                    </span>
                    <span data-id="003" class="">
                        更新时间
                        <i class="iconfont icon-jiantou"></i>
                    </span>
                </div>
                <div class="library-list-wrp">
                    <div class="library-list">
                        <zhimeng table="book" where="[['status','=',1],['is_del','=',0]]" order="clicks desc" limit="20" page="$p">
                        <div class="item" data-id="665">
                            <a class="img-link" target="_blank" href="{:url('read/index',['id'=>$r['id']])}">
                                <img src="{$r.image}" alt="">
                            </a>
                            <a target="_blank" href="{:url('read/index',['id'=>$r['id']])}">
                                <h5>{$r.name}</h5>
                            </a>
                            <div class="author">
                                <span class="name">
                                    <i class="iconfont icon-zuozhe"></i>
                                    {$r.author}
                                </span>
                                <span class="category">
                                    <zhimeng table="book_category" where="['id','=',$r['cid']]" id="v">
                                    {$v.name}
                                    </zhimeng>
                                </span>
                                <span class="status">
                                    <if condition="$r.is_end eq 1">
                                        完结
                                        <else/>
                                        连载
                                    </if>

                                </span>
                            </div>
                            <p class="desc">
                                {$r.info|trimHtml=0,150}
                            </p>
                            <span class="num">
                                <php>
                                    if($r['words_num'] > 9999){
                                        $a = round($r['words_num']/10000,2);;
                                    }
                                </php>
                                <if condition="$r.words_num">
                                    <if condition="$r.words_num gt 9999">
                                            {$a} 万字
                                        <else/>
                                            {$r.words_num}字
                                    </if>
                                    <else/>
                                    0字
                                </if>
                            </span>
                        </div>
                        </zhimeng>
                    </div>
                </div>
                <ul class="rc-pagination " unselectable="unselectable">
                    <li>{$page_show}</li>
                </ul>
            </div>
            <include file="common:footer"/>
        </div>
    </div>
</div>
<div>
    <div class="rc-notification" style="top: 65px; left: 50%;"><span></span></div>
</div>
<script>
    $('.filter-group').find('span').click(function () {
        $(this).addClass('active').siblings().removeClass('active');
        var category = $('.filter-categray .active').attr('data-id');
        var words_num = $('.filter-words .active').attr('data-id');
        var status = $('.filter-status .active').attr('data-id');
        $.ajax({
            url:"{:url('Library/library')}",
            data:{"category":category,"words_num":words_num,"status":status},
            type:"POST",
            success:function(req){
                var c = JSON.parse(req);
                if (c.status == 0){
                    $('.library-list').html('');
                    $('.rc-pagination').html('');
                    layer.msg(c.msg, { offset: '300px' });return;
                }
                if (c.status == 1){
                    $('.library-list').html('');
                    $('.rc-pagination').html('');
                    var book = c.data;
                    var html = '';
                    for (var x in book) {
                        html +=
                            '<div class="item" data-id="665">'+
                                '<a class="img-link" target="_blank" href="/home/read/index?id=' + book[x].id + '">'+
                                    '<img src="' + book[x].image + '">'+
                                '</a>'+
                                '<a target="_blank" href="/home/read/index?id=' + book[x].id + '">'+
                                    '<h5>'+ book[x].name+'</h5>'+
                                '</a>'+
                                '<div class="author">'+
                                    '<span class="name">'+
                                        '<i class="iconfont icon-zuozhe"></i>'+book[x].author+
                                    '</span>'+
                                    '<span class="category">'+book[x].c_name+'</span>'+
                                    '<span class="status">'+ book[x].status+'</span>'+
                                '</div>'+
                                '<p class="desc">'+book[x].info+'</p>'+
                                '<span class="num"> '+
                                    book[x].words_num+'字'+
                                '</span>'+
                            '</div>'
                    }
                    $('.library-list').append(html);
                }
            }
        })
    })
    
    $('.sort').find('span').click(function () {
        $(this).addClass('active').siblings().removeClass('active');
        var category = $('.filter-categray .active').attr('data-id');
        var words_num = $('.filter-words .active').attr('data-id');
        var status = $('.filter-status .active').attr('data-id');
        var type =  $('.sort .active').attr('data-id');
        $.ajax({
            url:"{:url('Library/queryBook')}",
            data:{"category":category,"words_num":words_num,"status":status,"type":type},
            type:"POST",
            success:function(req){
                var c = JSON.parse(req);
                if (c.status == 0){
                    $('.library-list').html('');
                    $('.rc-pagination').html('');
                    layer.msg(c.msg, { offset: '300px' });return;
                }
                if (c.status == 1){
                    $('.library-list').html('');
                    $('.rc-pagination').html('');
                    var book = c.data;
                    var html = '';
                    for (var x in book) {
                        html +=
                            '<div class="item" data-id="665">'+
                            '<a class="img-link" target="_blank" href="/home/read/index?id=' + book[x].id + '">'+
                            '<img src="' + book[x].image + '">'+
                            '</a>'+
                            '<a target="_blank" href="/home/read/index?id=' + book[x].id + '">'+
                            '<h5>'+ book[x].name+'</h5>'+
                            '</a>'+
                            '<div class="author">'+
                            '<span class="name">'+
                            '<i class="iconfont icon-zuozhe"></i>'+book[x].author+
                            '</span>'+
                            '<span class="category">'+book[x].c_name+'</span>'+
                            '<span class="status">'+ book[x].status+'</span>'+
                            '</div>'+
                            '<p class="desc">'+book[x].info+'</p>'+
                            '<span class="num"> '+
                            book[x].words_num+'字'+
                            '</span>'+
                            '</div>'
                    }
                    $('.library-list').append(html);
                }
            }
        })
    })
</script>
</body>