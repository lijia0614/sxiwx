<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <!-- <meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1,user-scalable=no"> -->
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=no">
    <meta http-equiv="keywords" content="{$site_keywords}">
    <meta http-equiv="description" content="{$site_description}">

    <!-- <title></title> -->
    <title>歌词 - {$site_name}</title>
    <link rel="stylesheet" href="css/font_626180_rzkibgk7ogl.css">
    <link rel="preload" href="css/0.dd2aeb5c.css" as="style">
    <link rel="stylesheet" href="css/indx.css">
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

    <link href="css/0.dd2aeb5c.css" rel="stylesheet">
    <link href="css/style.dd2aeb5c.css" rel="stylesheet">
    <title data-react-helmet="true"></title>


</head>
<body>
<div id="app">
    <div class="wrap" data-reactroot="">
        <include file="common:header"/>
        <div class="container-wrap library-wrap">
            <div class="library container">
                <div class="filter-group">
                    <div class="filter-categray">
                        <span class="type">分类：</span>
                        <span data-id="-1" class="active all">全部</span>
                        <zhimeng table="poetry_category" where="[['status','=',1]]">
                            <span data-id="{$r.id}">{$r.title}</span>
                        </zhimeng>
                    </div>
                </div>
                <div class="sort">
                    <span type="month_view_count" data-id="001" class="active">
                        点击量
                        <i class="iconfont icon-jiantou"></i>
                    </span>
                    <span data-id="002" class="">
                        更新时间
                        <i class="iconfont icon-jiantou"></i>
                    </span>
                </div>
            </div>
        </div>

        <div class="anime-page-wrap">
            <div class="Q-miancent"> <!--盒子 添加到线上删除-->
                <div class="Q-content">      <!-- 中间内容1200px-->
                    <div class="Q-content-left">
                        <ul class="list">
                            <zhimeng table="poetry" where="[['status','=',1]]" order="click desc" limit="8" page="$p">
                                <li class="info">
                                    <a href="{:url('anime/anime_show',['id'=>$r['id']])}">
                                        <p>{$r.title}</p>
                                        <div class="lick-zam">
                                            <img src="images/click.png" alt="">
                                            <span>{$r.click}</span>
                                        </div>
                                        <div class="poet">
                                            <img src="images/icon-peo.png" alt="">
                                            <span>{$r.author}</span>
                                        </div>
                                        <div class="poet-cont">
                                            {$r.content}
                                        </div>
                                    </a>
                                </li>
                            </zhimeng>

                        </ul>
                    </div>
                    <div class="Q-content-right">
                        <div class="Q-hot-tuijian">
                            <h3>热门推荐</h3>
                            <ul>
                                <zhimeng table="poetry" where="[['status','=',1],['is_recommend','=',1]]"
                                         order="click desc" limit="10">
                                    <li>
                                        <a href="{:url('anime/anime_show',['id'=>$r['id']])}">
                                            {$r.title}({$r.author})
                                        </a>
                                    </li>
                                </zhimeng>
                            </ul>
                        </div>
                        <div class="Q-img-shows">
                            <ad alias="sg_img" id="vo">
                                <a target="_blank" href="{$vo.link}">
                                    <img src="{$vo.image}" alt="">
                                </a>
                            </ad>
                        </div>
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
</body>
</html>
<script>
    $('.filter-group').find('span').click(function () {
        $(this).addClass('active').siblings().removeClass('active');
        var cid = $('.filter-categray .active').attr('data-id');
        $.ajax({
            url: "{:url('anime/anime')}",
            data:{"cid":cid},
            type: "POST",
            success: function (req) {
                var c = JSON.parse(req);
                if (c.status == 0) {
                    $('.list').html('');
                    $('.info').html('');
                    layer.msg(c.msg, {offset: '300px'});
                    return;
                }
                if (c.status == 1) {
                    $('.list').html('');
                    $('.info').html('');
                    var info = c.data;
                    console.log(info);
                    var html = '';
                    for (var x in info) {
                        html +=
                            '<li class="info">' +
                            '<a href="/home/anime/anime_show?id=' + info[x].id + '">' +
                            '<p>' + info[x].title + '</p>' +
                            '<div class="lick-zam">' +
                            '<img src="images/click.png" alt="">' +
                            '<span>' + info[x].click + '</span>' +
                            '</div>' +
                            '<div class="poet">' +
                            '<img src="images/icon-peo.png" alt="">' +
                            '<span>' + info[x].author + '</span>' +
                            '</div>' +
                            '<div class="poet-cont">' + info[x].content +
                            '</div>' +
                            '</a>' +
                            '</li>'
                    }
                    $('.list').append(html);
                }
            }
        })
    })
    $('.sort').find('span').click(function () {
        $(this).addClass('active').siblings().removeClass('active');
        var cid = $('.filter-categray .active').attr('data-id');
        var type = $('.sort .active').attr('data-id');
        $.ajax({
            url: "{:url('anime/seAnime')}",
            data:{"cid":cid,"type":type},
            type: "POST",
            success: function (req) {
                var c = JSON.parse(req);
                if (c.status == 0) {
                    $('.list').html('');
                    $('.info').html('');
                    layer.msg(c.msg, {offset: '300px'});
                    return;
                }
                if (c.status == 1) {
                    $('.list').html('');
                    $('.info').html('');
                    var info = c.data;
                    console.log(info);
                    var html = '';
                    for (var x in info) {
                        html +=
                            '<li class="info">' +
                            '<a href="/home/anime/anime_show?id=' + info[x].id + '">' +
                            '<p>' + info[x].title + '</p>' +
                            '<div class="lick-zam">' +
                            '<img src="images/click.png" alt="">' +
                            '<span>' + info[x].click + '</span>' +
                            '</div>' +
                            '<div class="poet">' +
                            '<img src="images/icon-peo.png" alt="">' +
                            '<span>' + info[x].author + '</span>' +
                            '</div>' +
                            '<div class="poet-cont">' + info[x].content +
                            '</div>' +
                            '</a>' +
                            '</li>'
                    }
                    $('.list').append(html);
                }
            }
        })
    })
</script>
