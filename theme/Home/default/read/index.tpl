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

    <style>

    </style>
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
        .reward-modal{
            position: fixed;
            top: 52%;
            z-index: 20;
            left: 50%;
            margin-left: -300px;
            margin-top: -161px;
            display:none
        }
        @media (max-width: 768px){
            .info-right{
                display: none;
            }
            .book .content .support-book .gift-list .gift-item{

                width: 25%;
            }
            .book .content .support-book .gift-list{
                padding: 5px;
                 justify-content: initial;
                flex-wrap: wrap;
            }
            .book .content .support-book .top-fans .new-support{
               display: none;
            }
            .book .content .support-book .top-fans > div{
                width: 31%;
            }
            .reward-modal{
                width: 100%;
                top: 16%;
                z-index: 20;
                 left: auto;
                 margin-left: auto;
                 margin-top: auto;

            }
            .book .content .book-desc .desc-content.des-less{
                color: #777;
            }

            .iconfont icon-jiantouxia{
                display: none;
            }
            .iconfont icon-xiangzuo-copy{
                display: none;
            }
            .book .content .comments-list{
                padding:20px;
            }
            .reward-modal .rc-dialog-body .label{
                overflow: hidden;
                margin-bottom: 0;
            }
            .reward-modal .rc-dialog-body button{
                margin-top: 8px;
            }
            .reward-modal .rc-dialog-body .text{
                padding-left: 0;
            }
            .reward-modal .rc-dialog-body .ipt-wrap .input{
                flex:1;
            }
            .reward-modal .rc-dialog-body .ipt-wrap{
                display: flex;
            }
            .reward-modal .rc-dialog-content{
                width: 90%;
                margin:0 auto;
            }
            .reward-modal .rc-dialog-body textarea{
                width: 100%;
            }
            .rc-tabs-top .rc-tabs-nav-wrap,.book-comments{
                padding: 0 5px;
                box-sizing: border-box;
            }
            .book .content .book-comments textarea.wishContent{
                margin-top: 15px;
                box-sizing: border-box;
                width: 93%;
            }
            .book .content .book-comments .comment-bottom{
                padding-right:20px;
            }
            .comment-box>span{
                display: block;
                float: left;
            }


            .book .content .book-comments textarea,.book .content .book-tab, .book .content .support-book .gift-list .gift-item img,.book .content .info-left{
                width: 100%;
            }

        }
    </style>
</head>

<body >
<div id="app">
    <div class="wrap">
        <include file="common:header"/>
        <div class="m-nav ">
            <i onclick="javascript:history.back();"  class="iconfont icon-xiangzuo"></i>
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
                                <div class="cate">分类：<zhimeng table="book_category" where="['id','=',$cid]" >{$r.name}</zhimeng>
                                </div>
                                <if condition="$type eq 1">
                                    <div class="number">类型：原创首发</div>
                                </if>

                                <div class="number">字数：
                                    <if condition="$type eq 3 || $type eq 4">
                                        {$words_num}
                                        <else/>
                                        {$w}
                                    </if>
                                </div>
                                <div class="status">状态：
                                    <if condition="$is_end eq 1">
                                        完结
                                       <else/>
                                        连载中
                                    </if>
                                </div>
                            </div>
                            <div class="buttons">
                                <if condition="$type eq 3 || $type eq 4">
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

                                <if condition="$is_take['id']">
                                    <button class="bookrack-btn disabled">已在书架</button>
                                    <else/>
                                    <button class="bookrack-btn take ">加入书架</button>
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
                                                <div class="rc-tabs-ink-bar rc-tabs-ink-bar-animated"style="display: block; transform: translate3d(0px, 0px, 0px); width: 56px;">

                                                </div>
                                                <div role="tab" aria-disabled="false" aria-selected="true"
                                                     class="rc-tabs-tab-active rc-tabs-tab">作品信息
                                                </div>
                                                <div role="tab" aria-disabled="false" aria-selected="false"
                                                     class=" rc-tabs-tab">
                                                    <a style="color: #77c2b5" href="{:url('read/chapter_list',['id'=>$id])}">
                                                        <if condition="$type eq 3 || $type eq 4">
                                                            作品目录({$otherCount}章)
                                                            <else/>
                                                            作品目录({$chapter_count}章)
                                                        </if>

                                                    </a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="rc-tabs-content rc-tabs-content-animated"
                                 style="transform: translateX(0%) translateZ(0px);">
                                <div role="tabpanel" aria-hidden="false" class="rc-tabs-tabpane rc-tabs-tabpane-active">
                                    <div class="info-left">
                                        <div class="book-desc">
                                            <div title="" class="desc-content des-less">
                                                <php>
                                                    echo $info;
                                                </php>
                                                <span class="show-book-desc">
                                                    <i class="iconfont icon-jiantouxia"></i>
                                                </span>
                                            </div>
                                        </div>
                                        <div class="latest-chapter">
                                            <h4>最新章节
                                                <if condition="$type eq 3 || $type eq 4">
                                                    <a target="_blank" href="{:url('read/read',['bookId'=>$book_id,'id'=>$otherNew['chapterid']])}">
                                                        <else/>
                                                        <a target="_blank" href="{:url('read/read',['b_id'=>$last['b_id'],'id'=>$last['id']])}">
                                                </if>
                                                    <if condition="$type eq 3">
                                                        <span>{$otherNew['title']}</span>
                                                        <span class="push-time">更新时间：{$otherNew.updateTime|date='Y-m-d H:i'}</span>
                                                        <elseif condition="$type eq 4"/>
                                                        <span>{$otherNew['chaptername']}</span>
                                                        <span class="push-time">更新时间：{$otherNew.lastupdate}</span>
                                                        <else/>
                                                        <span>{$last['name']}</span>
                                                        <span class="push-time">更新时间：{$last.time|date='Y-m-d H:i'}</span>
                                                    </if>
                                                </a>
                                            </h4>
                                            <div class="book-content">
                                                <if condition="$type eq 3 || $type eq 4">
                                                    {$otherNew['content']}...
                                                    <else/>
                                                    {$last['content']}...
                                                </if>
                                                <if condition="$type eq 3 || $type eq 4">
                                                    <a target="_blank" href="{:url('read/read',['bookId'=>$book_id,'id'=>$otherNew['chapterid']])}">
                                                    <else/>
                                                    <a target="_blank" href="{:url('read/read',['b_id'=>$last['b_id'],'id'=>$last['id']])}">
                                                </if>

                                                    <span class="continue-read">点击阅读&gt;&gt;</span>
                                                </a>
                                            </div>
                                        </div>
                                        <div class="support-book">
                                            <h4>
                                                支持作品
                                                <span>本月共收到
                                                    <span>
                                                        {$r_count}
                                                    </span>人的打赏，共计
                                                    <span>
                                                        {$g_count}
                                                    </span>书币
                                                </span>
                                            </h4>
                                            <div class="gift-list">
                                                <div class="gift-item" data-id="1">
                                                    <img src="images/img1.PNG" alt="">
                                                    <span class="name">玫瑰花</span>
                                                    <span class="count">
                                                        <span>50</span>书币
                                                    </span>
                                                </div>
                                                <div class="gift-item" data-id="2">
                                                    <img src="images/img2.PNG" alt="">
                                                    <span class="name">巧克力</span>
                                                    <span class="count">
                                                        <span>99</span>书币
                                                    </span>
                                                </div>
                                                <div class="gift-item" data-id="3">
                                                    <img src="images/img3.PNG" alt="">
                                                    <span class="name">金元宝</span>
                                                    <span class="count">
                                                        <span>520</span>书币
                                                    </span>
                                                </div>
                                                <div class="gift-item" data-id="4">
                                                    <img src="images/img4.PNG" alt="">
                                                    <span class="name">钻石</span>
                                                    <span class="count">
                                                        <span>999</span>书币
                                                    </span>
                                                </div>
                                                <div class="gift-item" data-id="5">
                                                    <img src="images/img5.PNG" alt="">
                                                    <span class="name">南瓜马车</span>
                                                    <span class="count">
                                                        <span>1888</span>书币
                                                    </span>
                                                </div>
                                                <div class="gift-item" data-id="6">
                                                    <img src="images/img6.PNG" alt="">
                                                    <span class="name">文思泉涌牌</span>
                                                    <span class="count">
                                                        <span>8888</span>书币
                                                    </span>
                                                </div>
                                            </div>
                                            <div class="top-fans">
                                                <div class="top1">
                                                    <if condition="$king">
                                                        <div class="mod">
                                                            <img class="tx" src="{$king['image']}" alt="">
                                                            <img class="badge" src="images/pcw.png" alt="">
                                                            <span class="name">{$king['name']}</span>
                                                            <p class="support-count">
                                                                共打赏
                                                                <span>{$king['all_total']}</span> 书币
                                                            </p>
                                                        </div>
                                                        <else/>
                                                        <div class="mod gift-item">
                                                            <span class="tx" style="line-height: 80px; font-size: 16px; background: rgb(205, 206, 211); color: rgb(119, 119, 119);">空缺</span>
                                                            <img class="badge" src="images/pcw.png" alt="">
                                                            <span class="name">虚位以待</span>
                                                            <p class="shangwei" data-id="1">立即上位&gt;&gt;</p>
                                                        </div>
                                                    </if>

                                                </div>
                                                <div class="top2">
                                                    <if  condition="$month">
                                                        <div class="mod">
                                                            <img class="tx" src="{$month['image']}" alt="">
                                                            <img class="badge" src="images/tuhao.png" alt="">
                                                            <span class="name">{$month['name']}</span>
                                                            <p class="support-count">
                                                                共打赏
                                                                <span>{$month['all_total']}</span> 书币
                                                            </p>
                                                        </div>
                                                        <else/>
                                                        <div class="mod gift-item">
                                                            <span class="tx" style="line-height: 80px; font-size: 16px; background: rgb(205, 206, 211); color: rgb(119, 119, 119);">空缺</span>
                                                            <img class="badge" src="images/tuhao.png" alt="">
                                                            <span class="name">虚位以待</span>
                                                            <p class="shangwei" data-id="1">立即上位&gt;&gt;</p>
                                                        </div>
                                                    </if>
                                                </div>
                                                <div class="top3">
                                                    <if condition="$today">
                                                        <div class="mod">
                                                            <img class="tx" src="{$today['image']}" alt="">
                                                            <img class="badge" src="images/jinzhu.png" alt="">
                                                            <span class="name">{$today['name']}</span>
                                                            <p class="support-count">
                                                                共打赏
                                                                <span>{$today['all_total']}</span> 书币
                                                            </p>
                                                        </div>
                                                        <else/>
                                                        <div class="mod gift-item">
                                                            <span class="tx" style="line-height: 80px; font-size: 16px; background: rgb(205, 206, 211); color: rgb(119, 119, 119);">空缺</span>
                                                            <img class="badge" src="images/jinzhu.png" alt="">
                                                            <span class="name">虚位以待</span>
                                                            <p class="shangwei" data-id="1">立即上位&gt;&gt;</p>
                                                        </div>
                                                    </if>
                                                </div>

                                                <div class="new-support">
                                                    <div class="mod">
                                                        <h5>最新动态</h5>
                                                        <div class="cycle-wrap">
                                                            <ul>
                                                                <volist name="news" id="vo">
                                                                <li>
                                                                    {$vo['name']}打赏了 x{$vo['number']} {$vo['gift_name']}
                                                                </li>
                                                                </volist>
                                                            </ul>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="book-comments" id="comments">
                                            <h4>评论<span>共 {$m_count} 条</span></h4>
                                            <div class="comment-box">
                                                <span>
                                                    <i class="iconfont icon-touxiang2"></i>
                                                </span>
                                                <i class="iconfont icon-xiangzuo-copy"></i>
                                                <textarea class="wishContent" name="" id="textarea" cols="30" rows="10" placeholder="我也来说两句..."></textarea>
                                                <div class="comment-bottom">
                                                    <i data-type="textarea" class="iconfont icon-smile"></i>
                                                    <span class="wordsNum">你还能输入500字</span>
                                                    <button id="go_msg">发表</button>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="comments-list">
                                            <volist name="msg" id="vo">
                                            <div class="comment-item">
                                                <div class="item-left">
                                                    <img class="user-tx" src="{$vo['image']}" alt="">
                                                </div>
                                                <div class="item-right">
                                                    <span class="user-name">{$vo['u_name']}</span>
                                                    <div class="user-comment">
                                                        {$vo['content']}
                                                    </div>
                                                    <div class="comment-info">
                                                        <span class="co-time">{$vo['time']|date='Y-m-d H:i'}</span>
                                                    </div>
                                                </div>
                                            </div>
                                            </volist>
                                        </div>
                                    </div>
                                    <div class="info-right">
                                        <div class="fans-rank"><h4>粉丝贡献榜</h4>

                                            <if condition="$fans">
                                                <volist name="fans" id="vo">
                                                    <div class="fans-list">
                                                        <div class="fans-item">
                                                            <span class="top{$key}"></span>
                                                            <div class="name">{$vo.name}</div>
                                                            <div class="wandou">
                                                                <span>{$vo.all_total}</span>书币
                                                            </div>
                                                            <img src="{$vo.image}" alt="">
                                                        </div>
                                                    </div>
                                                </volist>

                                                <else/>
                                                <div class="fans-list">
                                                    <div class="null-reward gift-item">
                                                        <img src="images/dashang_null.png"alt="">
                                                        <p>粉丝榜还有位置，快来送礼物吧 作者大大很期待！</p>
                                                        <button data-id="1">给作者大大送礼物</button>
                                                    </div>
                                                </div>
                                            </if>

                                        </div>
                                        <div class="same-recommend"><h4>同类推荐</h4>
                                            <div class="same-list">
                                                <zhimeng table="book" where="[['status','=',1],['cid','=',$cid],['is_del','=',0]]" limit="10">
                                                    <div class="r-item hot-recommend-item clearfix" data-id="151">
                                                        <a class="img-link" target="_blank" href="{:url('read/index',['id'=>$r['id']])}">
                                                            <img src="{$r.image}" alt="">
                                                        </a>
                                                        <a target="_blank" href="{:url('read/index',['id'=>$r['id']])}">
                                                            <h5> {$r.name}</h5>
                                                        </a>
                                                        <div class="author">作者：
                                                            <span class="name">{$r.author}</span>
                                                        </div>
                                                        <div class="author">分类：
                                                            <span>
                                                                <zhimeng table="book_category" where="['id','=',$cid]" id="vo">
                                                                    {$vo.name}
                                                                </zhimeng>
                                                            </span>
                                                        </div>
                                                    </div>
                                                </zhimeng>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div role="tabpanel" aria-hidden="true"
                                     class="rc-tabs-tabpane rc-tabs-tabpane-inactive"></div>
                            </div>
                        </div>
                    </div>
                </div>

                <!--礼物弹出层-->
                <div class="rc-dialog-mask rc-dialog-mask-hidden"></div>
                <div class="rc-dialog reward-modal" role="document">
                    <div class="rc-dialog-content" >
                    <button aria-label="Close" class="rc-dialog-close">
                        <span class="rc-dialog-close-x"></span>
                    </button>
                    <div class="rc-dialog-header">
                        <div class="rc-dialog-title" id="rcDialogTitle0">打赏</div>
                    </div>
                    <div class="rc-dialog-body">
                        <div class="label">
                            <span class="tag">数量：</span>
                            <div class="ipt-wrap">
                                <span class="reduces"><i style="margin-left: 11px;" class="iconfont icon-minus"></i></span>
                                <span class="input">
                                    <img id="img" src="images/img1.PNG" alt="">X  <i>1</i>
                                </span>
                                <span class="adds"><i style="margin-left: 11px;"  class="iconfont icon-plus"></i></span>
                            </div>
                            <div class="text">
                                <span id="total" style="float: left">本次共花费 <i>50</i> 书币</span>
                                <i class="g_price" style="display: none">50</i>
                                <i class="g_name" style="display: none">1</i>
                                <a target="_blank" href="{:url('recharge/recharge')}">
                                    去充值&gt;&gt;
                                </a>
                                <span>账户余额 {$user['money']} 书币</span>
                            </div>
                        </div>
                        <div class="label">
                            <span class="tag">赠言：</span>
                            <textarea id="msg" name="textarea" placeholder="">感激涕零，潸然泪下，于是想给一朵玫瑰！</textarea>
                        </div>
                        <button id="gift" style="margin-left: 41px;">确认赏TA</button>
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
<input type="hidden" id="u_id" value="{$user['id']}"/>
<input type="hidden" id="b_id" value="{$id}"/>
<script>
    // 送礼弹出层
    $('.gift-item').click(function () {
        $('.rc-dialog-mask').removeClass('rc-dialog-mask-hidden');
        $('body').css('overflow', 'hidden');
        $('.reward-modal').css('display', 'block');
        $('span.input').find('i').html('1');
        var name = $(this).attr('data-id');
        var img = $(this).find('img').attr('src');
        if(img == '/public/default/images/dashang_null.png'){
            img = '/public/default/images/img1.PNG'
        }
        if(img == '/public/default/images/pcw.png'){
            img = '/public/default/images/img1.PNG'
        }
        if(img == '/public/default/images/tuhao.png'){
            img = '/public/default/images/img1.PNG'
        }
        if(img == '/public/default/images/jinzhu.png'){
            img = '/public/default/images/img1.PNG'
        }
        var price = $(this).find('span.count').find('span').html();
        console.log(price);
        if (price == undefined){
            price = 50;
        }
        console.log(price);
        $('#total').html('本次共花费'+'<i>'+price+'</i>'+'书币');
        $('.g_price').html(price);
        $('.g_name').html(name);
        $('#img').attr('src',img);
        if (name == 1){
            $('#msg').val('感激涕零，潸然泪下，于是想给您一朵玫瑰！');
        }
        if (name == 2){
            $('#msg').val('爱你，就给你松露巧克力，追文甜甜又蜜蜜！');
        }
        if (name == 3){
            $('#msg').val('爱你，就要送你金元宝！');
        }
        if (name == 4){
            $('#msg').val('爱情恒久远，钻石永流传！');
        }
        if (name == 5){
            $('#msg').val('尊贵的我，和尊贵的你之间，就差一辆南瓜马车！');
        }
        if (name == 6){
            $('#msg').val('哔哔哔！一符在手，哪里不通贴哪里，保你文思泉涌，日码百万！');
        }
    })
    $('.rc-dialog-close').click(function () {
        $('.rc-dialog-mask').addClass('rc-dialog-mask-hidden');
        $('.reward-modal').css('display', 'none');
        $('body').css('overflow', 'auto')
    })
    $('.rc-dialog-mask').click(function () {
        $('.rc-dialog-mask').addClass('rc-dialog-mask-hidden');
        $('.reward-modal').css('display', 'none');
        $('body').css('overflow', 'auto')
    })

    $('#gift').click(function () {
        var name = $('.g_name').html();
        var number = $('span.input').find('i').html();
        var u_price = $('.g_price').html();
        var msg = $('#msg').val();
        var b_id = $('#b_id').val();
        $.ajax({
            url:"{:url('read/toGift')}",
            data:{"b_id":b_id,"name":name,"number":number,"u_price":u_price,"msg":msg},
            type:"POST",
            success:function(req){
                var c = JSON.parse(req);
                if (c.status == 0){
                    layer.msg(c.msg, { offset: '300px' }); return;
                }
                if (c.status == 1){
                    layer.msg(c.msg, { offset: '300px' });
                    window.location.reload();
                }
            }
        });
    })

    // 礼物+1
    $('.reduces').click(function () {
        var t = $('span.input').find('i');
        t.html(parseInt(Number(t.text()) - 1));

        var abs = $('#total').find('i');
        var sized = $('i.g_price');
        abs.html(parseInt(Number(sized.text()*Number(t.text()))))
        if (Number(t.text()) <=1) {
            t.html(1);
            abs.html(Number(sized.text()))
        }

    });

    // 礼物-1
    $('.adds').click(function () { //数量加
        var t = $('span.input').find('i');
        t.html(parseInt(Number(t.text()) + 1));
        var sized = $('i.g_price');
        var abs = $('#total').find('i');
        abs.html(parseInt(Number(sized.text()*Number(t.text()))))
    })

    // 加入书架
    $('.take').click(function () {
        var b_id = $('#b_id').val();
        var u_id = $('#u_id').val();
        if (u_id == ''){
            setTimeout(function(){ window.location.href = "{:url('login/login')}"; }, 0);
            return false;
        }
        $.ajax({
            url:"{:url('read/take')}",
            data:{"b_id":b_id},
            type:"POST",
            success:function(req){
                if (req.code == 0){
                    layer.msg(req.msg, { offset: '300px' }); return false;
                }
                if (req.code == 1){
                    layer.msg(req.msg, { offset: '300px' });
                    $('.bookrack-btn').addClass('disabled')
                    $('.bookrack-btn').removeClass('take')
                    $('.bookrack-btn').html('已在书架')
                }
            }
        });
    })

    var checkStrLengths = function (str, maxLength) {
        var maxLength = maxLength;
        var result = 0;
        if (str && str.length > maxLength) {
            result = maxLength;
        } else {
            result = str.length;
        }
        return result;
    }

    $(".wishContent").on('input propertychange', function () {
        //获取输入内容
        var userDesc = $(this).val();
        //判断字数
        var len;
        if (userDesc) {
            len = checkStrLengths(userDesc, 500);
        } else {
            len = 0
        }
        //显示字数
        $(".wordsNum").html('你还能输入'+(500-len) + '字');
    });
    // 留言
    $('#go_msg').click(function () {
        var content = $('#textarea').val();
        var b_id = $('#b_id').val();
        if(content == ''){
            layer.msg('请出入留言内容', { offset: '300px' });return false;
        }
        $.ajax({
            url:"{:url('read/to_msg')}",
            data:{"b_id":b_id,"content":content},
            type:"POST",
            success:function(req){
                console.log(req);
                if (req.code == 0){
                    layer.msg(req.msg, { offset: '300px' }); return false;
                }
                if (req.code == 1){
                    window.location.reload();
                }
            }
        });
    })


</script>

</body>







