<head>
    <meta charset="utf-8">
    <!-- <meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1,user-scalable=no"> -->
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=no">
    <meta http-equiv="keywords" content="{$site_keywords}">
    <meta http-equiv="description" content="{$site_description}">

    <!-- <title></title> -->
    <title>
        <if condition="$type eq 3">
            {$data['title']}
            <elseif condition="$type eq 4"/>
            {$data['chaptername']}
            <else/>
            {$data['name']}
        </if>

    </title>
    <link rel="stylesheet" href="css/font_626180_rzkibgk7ogl.css">

    <link rel="preload" href="css/0.dd2aeb5c.css" as="style">

    <link rel="preload" href="css/style.dd2aeb5c.css" as="style">

    <base href="/">
    <link href="css/0.dd2aeb5c.css" rel="stylesheet">
    <link href="css/style.dd2aeb5c.css" rel="stylesheet">
    <title data-react-helmet="true"></title>
    <style>
        .rc-dialog-mask-hidden{
            z-index: 20;
        }
        .reward-modal-read{
            position: fixed;
            left: 50%;
            top:50%;
            margin-top: -233px;
            z-index: 50;
            margin-left: -300px;
            display: none;
        }
        .reward-modal .rc-dialog-body button{
            margin-left: 100px;
        }
        .reward-modal .rc-dialog-body .ipt-wrap span{
            text-align: center;
        }
    </style>

</head>
<body>
<div id="app">
    <div class="wrap">
        <include file="common:header"/>
        <div class="read-page container-wrap">
            <div class="novel-container  yellow">
                <div class="breadcrumbs">
                    <div class="pc-breadcrumbs">
                        <span>
                            <a target="_blank" href="/">首页</a>
                        </span>
                        <span>
                            <a target="_blank" href="">
                                <i class="iconfont icon-jiantouyou"></i>
                                {$category['name']}
                            </a>
                        </span>
                        <span>
                            <a target="_blank" href="{:url('read/index',['id'=>$book['id']])}" class="iconfont icon-jiantouyou">
                                {$book['name']}
                            </a>
                        </span>
                        <span>
                            <i  class="iconfont icon-jiantouyou"></i>
                        </span>
                        <span>
                            <if condition="$type eq 3">
                                {$data['title']}
                                <elseif condition="$type eq 4"/>
                                {$data['chaptername']}
                                <else/>
                                {$data['name']}
                            </if>
                        </span>
                    </div>
                    <div class="phone-breadcrumbs">
                        <i class="iconfont icon-xiangzuo"></i>
                        <span>
                            <if condition="$type eq 3">
                                {$data['title']}
                                <elseif condition="$type eq 4"/>
                                {$data['chaptername']}
                                <else/>
                                {$data['name']}
                            </if>
                        </span>
                        <i class="iconfont icon-home"></i>
                        <a href="/" style="margin-left: 0px;">
                            <i class="iconfont icon-touxiang"></i>
                        </a>
                        <a href="{:url('users/home')}" class="bookrack">
                            <i class="iconfont icon-shujia"></i>
                        </a>
                    </div>
                </div>

                <!--手机设置start-->
                <div class="phone-setting">
                    <span class="m-yellow m-color active"></span>
                    <span class="m-green m-color "></span>
                    <span class="m-pink m-color "></span>
                    <span class="m-black m-color ">
                        <img src="images/night.png" alt="">
                    </span>
                    <div class="fonschange-phone" style="float: right">
                        <span class="changefont">A+</span>
                        <span class="changefont">A-</span>
                    </div>
                </div>
                <!--手机设置end-->

                <div class="novel-content">
                    <div id="title" class="novel-title"><h2>
                            <if condition="$type eq 3">
                                {$data['title']}
                                <elseif condition="$type eq 4"/>
                                {$data['chaptername']}
                                <else/>
                                {$data['name']}
                            </if>
                        </h2>
                        <div class="info">
                            <span>作者：{$book['author']}</span>
                            <span>发表时间：
                                <if condition="$type eq 3">
                                    {$data['updateTime']|date='Y-m-d H:i'}
                                    <elseif condition="$type eq 4"/>
                                    {$data['postdate']}
                                    <else/>
                                    {$data['time']|date='Y-m-d H:i'}
                                </if>
                            </span>
                            <span>字数：
                                <if condition="$type eq 3">
                                    {$data['words']}
                                    <elseif condition="$type eq 4"/>
                                    {$data['words']}
                                    <else/>
                                    {$count}
                                </if>
                            </span>
                        </div>
                    </div>
                    <div class="novel-text" style="font-size: 16px;">
                        {$data['content']}
                        <if condition="$data['say']">
                            我有话说：{$data['say']}
                        </if>

                    </div>
                    <div class="pc-menu">
                        <if condition="$prevs">
                            <span class="prev-btn">
                            <i class="icon-jiantouzuo iconfont"></i>
                            <if condition="$type eq 3  || $type eq 4">
                                <a style="color: #7e818a" href="{:url('read/read',['bookId'=>$book['other_bookid'],'id'=>$prevs['chapterid']])}">上一章</a>
                                <else/>
                                <a style="color: #7e818a" href="{:url('read/read',['b_id'=>$book['id'],'id'=>$prevs['id']])}">上一章</a>
                            </if>

                        </span>
                        </if>
                        <if condition="$nexts">
                            <span class="next-btn">
                            <if condition="$type eq 3 || $type eq 4">
                                <a style="color: #7e818a" href="{:url('read/read',['bookId'=>$book['other_bookid'],'id'=>$nexts['chapterid']])}">下一章</a>
                                <else/>
                                <a style="color: #7e818a" href="{:url('read/read',['b_id'=>$book['id'],'id'=>$nexts['id']])}">下一章</a>
                            </if>

                            <i class="icon-jiantouyou iconfont"></i>
                        </span>
                        </if>
                    </div>
                </div>
                <div class="phone-menu">
                    <if condition="$prevs">
                    <span class="prev-btn">
                        <i class="icon-jiantouzuo iconfont"></i>
                        <if condition="$type eq 3  || $type eq 4">
                            <a style="color: #7e818a" href="{:url('read/read',['bookId'=>$book['other_bookid'],'id'=>$prevs['chapterid']])}">
                        上一章
                        </a>
                            <else/>
                            <a style="color: #7e818a" href="{:url('read/read',['b_id'=>$book['id'],'id'=>$prevs['id']])}">
                        上一章
                        </a>
                        </if>

                    </span>
                    </if>
                    <span class="menu-btn">
                        <a style="color: #7e818a;" href="{:url('read/readList',['b_id'=>$book['id']])}">
                           目录
                        </a>
                    </span>
                    <if condition="$nexts">
                    <span class="next-btn">
                        <if condition="$type eq 3 || $type eq 4">
                            <a style="color: #7e818a" href="{:url('read/read',['bookId'=>$book['other_bookid'],'id'=>$nexts['chapterid']])}">
                        下一章
                        </a>
                            <else/>
                            <a style="color: #7e818a" href="{:url('read/read',['b_id'=>$book['id'],'id'=>$nexts['id']])}">
                        下一章
                        </a>
                        </if>

                        <i class="icon-jiantouyou iconfont"></i>
                    </span>
                    </if>
                </div>

                <div class="pc-aside" style="left: 1512px;">
                    <span id="hoverMe" class="icon ">
                        <i class="iconfont icon-caidan"></i>
                    </span>
                    <span id="hoverMe2" class="icon ">
                        <i class="iconfont icon-shezhi"></i>
                    </span>
                    <span id="hoverMe3" class="icon ">
                        <i class="iconfont icon-jin"></i>
                    </span>
                    <span id="hoverMe4" class="icon ">
                        <i class="iconfont icon-pinglun2"></i>
                    </span>
                    <span id="hoverMe5" class="icon">
                        <a href="javascript:scroll(0,0)"><i class="iconfont icon-top"></i></a>
                    </span>

                    <!--设置页面-->
                    <div class="setting-modal" style="display: none">
                        <div class="modal-head">
                            <h4>设置</h4>
                            <span class="close csz">
                                <i class="iconfont icon-guanbi"></i>
                            </span>
                        </div>
                        <div class="read-theme">
                            <span>阅读主题：</span>
                            <i class="yellow-icon active"></i>
                            <i class="green-icon "></i>
                            <i class="pink-icon "></i>
                            <i class="purp-icon"></i>
                        </div>
                        <div class="read-font"><span>字体大小：</span>
                            <div style="width: 151px;" class="fonschange">
                                <span class="disable">A-</span>
                                <span>16</span>
                                <span class="">A+</span>
                            </div>
                        </div>
                    </div>
                    <!--设置页面-->

                    <div class="chapter-modal" style="display: none">
                        <div class="modal-head">
                            <h4>目录</h4>
                            <span class="close cm">
                                <i class="iconfont icon-guanbi"></i>
                            </span>
                        </div>
                        <div class="chapter-list">
                            <div class="chapter clearfix">
                                <div class="chapter-title">正文卷
                                    <span>
                                        <i class="iconfont icon-jiantouup"></i>
                                    </span>
                                </div>
                                <div class="chapter-item-list active ">
                                    <if condition="$type eq 3 || $type eq 4">
                                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;加载中...
                                        <else/>
                                        <zhimeng table="chapter" where="[['b_id','=',$b_id],['is_del','=',0],['status','=',1]]" order="id asc">
                                            <div class="chapter-item <if condition="$id eq $r['id']"> reading </if> ">
                                                <a href="{:url('read/read',['b_id'=>$r['b_id'],'id'=>$r['id']])}">{$r.name}</a>
                                            </div>
                                        </zhimeng>
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

<div class="rc-dialog-mask rc-dialog-mask-hidden"></div>

<div role="document" class="rc-dialog reward-modal reward-modal-read" style="width: 600px;">
        <div class="rc-dialog-content">
            <button aria-label="Close" class="rc-dialog-close"><span class="rc-dialog-close-x"></span></button>
            <div class="rc-dialog-header">
                <div class="rc-dialog-title" id="rcDialogTitle0">打赏</div>
            </div>
            <div class="rc-dialog-body">
                <div class="gift-list">
                    <div class="gift-item active" data-id="1">
                        <img src="images/img1.PNG" alt="">
                        <span class="name">玫瑰花</span>
                        <span class="count">
                            <span>50</span>书币
                        </span>
                    </div>
                    <div class="gift-item " data-id="2">
                        <img src="images/img2.PNG" alt="">
                        <span class="name">巧克力</span>
                        <span class="count">
                            <span>99</span>书币
                        </span>
                    </div>
                    <div class="gift-item " data-id="3">
                        <img src="images/img3.PNG" alt="">
                        <span class="name">金元宝</span>
                        <span class="count">
                            <span>520</span>书币
                        </span>
                    </div>
                    <div class="gift-item " data-id="4">
                        <img src="images/img4.PNG" alt="">
                        <span class="name">钻石</span>
                        <span class="count">
                            <span>999</span>书币
                        </span>
                    </div>
                    <div class="gift-item " data-id="5">
                        <img src="images/img5.PNG" alt="">
                        <span class="name">南瓜马车</span>
                        <span class="count">
                            <span>1888</span>书币</span>
                    </div>
                    <div class="gift-item " data-id="6">
                        <img src="images/img6.PNG" alt="">
                        <span class="name">文思泉涌牌</span>
                        <span class="count">
                            <span>8888</span>书币</span>
                    </div>
                </div>
                <div class="label">
                    <i class="g_price" style="display: none">50</i>
                    <i class="g_name" style="display: none">1</i>
                    <span class="tag">数量：</span>
                    <div class="ipt-wrap">
                        <span class=" reduces">
                            <i class="iconfont icon-minus"></i>
                        </span>
                        <span class="input">
                            <img id="img" src="images/img1.PNG" alt="">X  <i>1</i>
                        </span>
                        <span  class="adds">
                            <i class="iconfont icon-plus"></i>
                        </span>
                    </div>
                    <div class="text">
                        本次共花费 <i id="tot"><i id="total">50</i></i> 书币
                        <a target="_blank" href="{:url('recharge/recharge')}">
                            去充值&gt;&gt;
                        </a>
                        <span>账户余额 {$user['money']} 书币</span>
                    </div>
                </div>
                <div class="label">
                    <span class="tag">赠言：</span>
                    <textarea id="g_content" name="textarea" placeholder="">感激涕零，潸然泪下，于是想给大大喂面！</textarea>
                </div>
                <input id="b_id" value="{$b_id}" type="hidden">
                <input id="user" value="{$user['id']}" type="hidden">
                <button id="gift">确认赏TA</button>
            </div>
        </div>
        <div tabindex="0" style="width: 0px; height: 0px; overflow: hidden;">sentinel</div>
    </div>
    <input type="hidden" id="type" value="{$type}">
    <input type="hidden" id="bookId" value="{$book['other_bookid']}">
<div>
    <div class="rc-notification" style="top: 65px; left: 50%;"><span></span></div>
</div>
<script>
    // 查看目录
    $('.icon-caidan').click(function () {
        var type = $('#type').val();

        if (type == 3){
            var bookId = $('#bookId').val();
            $.ajax({
                url:"{:url('read/getOtherChapters')}",
                data:{"bookId":bookId},
                type:"POST",
                success:function(req){
                    var c = JSON.parse(req);
                    console.log(c);
                    if (c.status == 0){
                        $('.chapter-item-list').html('');return;
                    }
                    if (c.status == 1){
                        $('.chapter-item-list').html('');
                        var book = c.data;
                        var html = '';
                        for (var x in book) {
                            html +=
                                '<div class="chapter-item reading ">'+
                                '<a href="/home/read/read?id=' + book[x].chapterid + '&bookId='+bookId+'">'+ book[x].title+'</a>'+
                                '</div>'
                        }
                        $('.chapter-item-list').append(html);
                    }
                }
            })
            $('.chapter-modal').toggle();
        }else if(type == 4){
            var bookId = $('#bookId').val();
            $.ajax({
                url:"{:url('read/getjinYueChapters')}",
                data:{"bookId":bookId},
                type:"POST",
                success:function(req){
                    var c = JSON.parse(req);
                    console.log(c);
                    if (c.status == 0){
                        $('.chapter-item-list').html('');return;
                    }
                    if (c.status == 1){
                        $('.chapter-item-list').html('');
                        var book = c.data;
                        var html = '';
                        for (var x in book) {
                            html +=
                                '<div class="chapter-item reading ">'+
                                '<a href="/home/read/read?id=' + book[x].chapterid + '&bookId='+bookId+'">'+ book[x].chaptername+'</a>'+
                                '</div>'
                        }
                        $('.chapter-item-list').append(html);
                    }
                }
            })
            $('.chapter-modal').toggle();
        }else{
            $('.chapter-modal').toggle();
        }

    });
    $('.cm').click(function () {
        $('.chapter-modal').toggle();
    });

    // 设置页面
    $('.icon-shezhi').click(function () {
        $('.setting-modal').toggle();
    });

    $('.csz').click(function () {
        $('.setting-modal').toggle();
    });

    // 评论
    $('.icon-pinglun2').click(function () {
        var type = $('#type').val();
        if (type == 3){
            window.open("{:url('read/index',['id'=>$book['id']])}"+'#comments');
        }else{
            window.open("{:url('read/index',['id'=>$b_id])}"+'#comments');
        }

    });

    // 打赏页面显示
    $('.icon-jin').click(function () {
        var id = $('#user').val();
        if (id == ''){
            setTimeout(function(){ window.location.href = "{:url('login/login')}"; }, 0000);return;
        }
        if($('.reward-modal-read').css("display") == "none"){
            $('.reward-modal-read').css("display","block")
        }

        $('.rc-dialog-mask-hidden').css("display","block")
    });
    $('.rc-dialog-close').click(function () {
        $('.reward-modal-read').css("display","none");
        $('.rc-dialog-mask-hidden').css("display","none");
    });
    $('.rc-dialog-mask-hidden').click(function () {
        $('.reward-modal-read').css("display","none");
        $('.rc-dialog-mask-hidden').css("display","none");
    });

    $('.gift-item').click(function () {
        $(this).addClass('active').siblings().removeClass('active');
        var data_id = $('.gift-list .active').attr('data-id');
        var img = $('.gift-list .active img').attr('src');
        var num = $('span.input').find('i').text();

        $('#img').attr('src',img);
        if (data_id == 1){
            $('#g_content').val('感激涕零，潸然泪下，于是想给您一朵玫瑰！');
            $('#total').html(50*num);
        }
        if (data_id == 2){
            $('#g_content').val('爱你，就给你松露巧克力，追文甜甜又蜜蜜！');
            $('#total').html(99*num);
        }
        if (data_id == 3){
            $('#g_content').val('爱你，就要送你金元宝！');
            $('#total').html(520*num);
        }
        if (data_id == 4){
            $('#g_content').val('爱情恒久远，钻石永流传！');
            $('#total').html(999*num);
        }
        if (data_id == 5){
            $('#g_content').val('尊贵的我，和尊贵的你之间，就差一辆南瓜马车！');
            $('#total').html(1888*num);
        }
        if (data_id == 6){
            $('#g_content').val('哔哔哔！一符在手，哪里不通贴哪里，保你文思泉涌，日码百万！');
            $('#total').html(8888*num);
        }
    })


    // 礼物-1
    $('.reduces').click(function () {
        var t = $('span.input').find('i');
        var num = $('span.input').find('i').text();
        var data_id = $('.gift-list .active').attr('data-id');
        if (data_id == 1){
            var price = 50;
        }
        if (data_id == 2){
             var price = 99;
        }
        if (data_id == 3){
            var price = 520;
        }
        if (data_id == 4){
            var price = 999;
        }
        if (data_id == 5){
            var price = 1888;
        }
        if (data_id == 6){
            var price = 8888;
        }
        t.html(parseInt(Number(num) - 1));
        var abs = $('#tot').find('i');
        var sized = $('i.g_price');
        abs.html(parseInt(Number(price*Number(t.text()))))
        if (Number(t.text()) <=1) {
            t.html(1);
            abs.html(Number(sized.text()))
        }

    });

    // 礼物+1
    $('.adds').click(function () { //数量加
        var t = $('span.input').find('i');
        var num = $('span.input').find('i').text();
        var data_id = $('.gift-list .active').attr('data-id');
        if (data_id == 1){
            var price = 50;
        }
        if (data_id == 2){
            var price = 99;
        }
        if (data_id == 3){
            var price = 520;
        }
        if (data_id == 4){
            var price = 999;
        }
        if (data_id == 5){
            var price = 1888;
        }
        if (data_id == 6){
            var price = 8888;
        }

        t.html(parseInt(Number(num) + 1));

        var sized = $('i.g_price');
        var abs = $('#tot').find('i');

        abs.html(parseInt(Number(price*Number(t.text()))))

    })


    $('#gift').click(function () {
        var name = $('.gift-list .active').attr('data-id');
        var number = $('span.input').find('i').text();
        var data_id = $('.gift-list .active').attr('data-id');
        if (data_id == 1){
            var price = 50;
        }
        if (data_id == 2){
            var price = 99;
        }
        if (data_id == 3){
            var price = 520;
        }
        if (data_id == 4){
            var price = 999;
        }
        if (data_id == 5){
            var price = 1888;
        }
        if (data_id == 6){
            var price = 8888;
        }
        var u_price = price;
        var msg = $('#g_content').val();
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
                    setTimeout("location.reload()",2000);

                }
            }
        });
    })

    $('.fonschange span').click(function () {
        var c =$(this).html();
        fontschose(c)
    })


    function  fontschose(e) {
        if(e =='A+'){
            if($(this).hasClass('disable')){
                return false
            }else{
                var del =$('.fonschange span').eq(1).html();

                var db='';
                if(del == 16){
                    $('.fonschange span').eq(0).removeClass('disable');
                    db=18
                }else if(del == 18){
                    db=24
                }else if(del == 24){
                    db=30
                }else{
                    $('.fonschange span').eq(2).addClass('disable');
                    return
                }
                $('.novel-text').css('fontSize',db);
                $('.fonschange span').eq(1).html(db)
            }

        }
        else if(e =='A-'){
            if($(this).hasClass('disable')){
                return false
            }else{
                var del =$('.fonschange span').eq(1).html();

                var db='';
                if(del == 30){
                    db=24;
                    $('.fonschange span').eq(2).removeClass('disable');
                }else if(del == 24){
                    db=18
                }else if(del == 18){
                    db=16;
                    $('.fonschange span').eq(0).addClass('disable');
                }else{
                    $('.fonschange span').eq(0).addClass('disable');
                }
                $('.novel-text').css('fontSize',db);
                $('.fonschange span').eq(1).html(db)
            }
        }
    }
    $('.read-theme i').click(function () {
       var color =$(this).attr('class').split('-');

       var actCol='';
        $('.read-theme').find('i').each(function (item,index) {
            if($(index).hasClass('active')){
                actCol =$(index).attr('class').split('-')
            }
        })

       $(this).addClass('active').siblings('i').removeClass('active');
       $('.novel-container').addClass(color[0]).removeClass(actCol[0])
    })


    // 手机设置

    $('.phone-setting>span').click(function () {
        var color =$(this).attr('class').split(' ')[0].split('-')[1];
        var actCol='';
        $('.phone-setting').find('span.m-color').each(function (item,index) {

            if($(index).hasClass('active')){
                actCol =$(index).attr('class').split(' ')[0].split('-')[1];
            }
        });

        $(this).addClass('active').siblings('span').removeClass('active');
        $('.novel-container').addClass(color).removeClass(actCol)

    })
    $('.phone-setting').find('span.changefont').click(function () {
        var c =$(this).html();
        console.log(c)
        var fonsm=$('.novel-text').css('font-size').split('px')[0];

        if(c =='A+'){
            if($(this).hasClass('disable')){
                return false
            }else{
                var del=$('.novel-text').css('font-size').split('px')[0];

                var db='';
                if(del == 16){
                    $('.fonschange span').eq(0).removeClass('disable');
                    db=18
                }else if(del == 18){
                    db=24
                }else if(del == 24){
                    db=30
                }else{
                    $('.fonschange span').eq(2).addClass('disable');
                    return
                }
                $('.novel-text').css('fontSize',db);
            }

        }
        else if(c =='A-'){
            if($(this).hasClass('disable')){
                return false
            }else{
                var del=$('.novel-text').css('font-size').split('px')[0];

                var db='';
                if(del == 30){
                    db=24;
                    $('.fonschange span').eq(2).removeClass('disable');
                }else if(del == 24){
                    db=18
                }else if(del == 18){
                    db=16;
                    $('.fonschange span').eq(0).addClass('disable');
                }else{
                    $('.fonschange span').eq(0).addClass('disable');
                }
                $('.novel-text').css('fontSize',db);

            }
        }

    })
</script>
</body>