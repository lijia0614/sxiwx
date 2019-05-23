<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>歌单-双溪文学</title>
    <link rel="stylesheet" href="css/font_626180_rzkibgk7ogl.css">
    <link rel="preload" href="css/0.dd2aeb5c.css" as="style">
    <link rel="preload" href="css/style.dd2aeb5c.css" as="style">
    <link href="css/0.dd2aeb5c.css" rel="stylesheet">
    <link href="css/style.dd2aeb5c.css" rel="stylesheet">
    <script src="js/jquery-1.9.1.js"></script>
    <link href="/public/admin/default/css/common.css" rel="stylesheet" type="text/css" />
</head>
<body>

<include file="common:header"/>
<div style="min-height: 700px" class="library">
    <div class="filter-group">
        <div class="s_lang half-border-top">
            <span class="type tt1">语种：</span>
            <span data-id="0" class="active all">全部</span>
            <zhimeng table="lang" where="['status','=',1]" order="sort asc">
            <span class="" data-id="{$r.id}">{$r.title}</span>
            </zhimeng>
        </div>

        <div class="s_type half-border-top">
            <span class="type tt1">风格：</span>
            <span data-id="0" class="active all">全部</span>
            <zhimeng table="type" where="['status','=',1]" order="sort asc">
                <span class="" data-id="{$r.id}">{$r.title}</span>
            </zhimeng>
        </div>

        <div class="s_feel half-border-top">
            <span class="type tt1">情感：</span>
            <span data-id="0" class="active all">全部</span>
            <zhimeng table="feel" where="['status','=',1]" order="sort asc">
                <span class="" data-id="{$r.id}">{$r.title}</span>
            </zhimeng>
        </div>
    </div>
    <div class="sort">
        <span type="month_view_count" data-id="1" class="active">
            最新添加
            <i class="iconfont icon-jiantou"></i>
        </span>
        <span data-id="2" class="">
            热门歌曲
            <i class="iconfont icon-jiantou"></i>
        </span>
    </div>
    <div class="sungaitable">
        <table>
            <thead>
            <tr>
                <td style="width: 15%" >封面</td>
                <td style="width: 15%" >歌曲</td>
                <td></td>
                <td>歌手</td>
                <td>专辑</td>
                <td style="display: none">时长</td>
            </tr>
            </thead>
            <tbody class="library-list">
                <volist name="list" id="vo">
                    <tr>
                        <td style="width: 15%;height: 100px;" class="suntit">
                            <img style="max-height: 75px;" src="{$vo.image}"/>
                            <span></span>
                        </td>
                        <td style="width: 25%" class="suntit">
                            <span></span>
                            {$vo.title}
                        </td>
                        <td>
                            <span data-src="{$vo.content}" data="{$vo.id}" class="sxplay"></span>
                        </td>
                        <td>{$vo.songer}</td>
                        <td>{$vo.zj}</td>
                        <td>
                            <audio style="display: none" id="a{$vo.id}" controls="controls">
                                <source src="{$vo.content}" type="audio/ogg">
                                <source src="{$vo.content}" type="audio/mpeg">
                                Your browser does not support the audio element.
                            </audio>
                        </td>

                    </tr>
                </volist>
            </tbody>
        </table>
    </div>
    <div class="pageBoxx">
        <div class="pageBox">
            <div class="pageList">&nbsp;&nbsp;{$page|raw}</div>
        </div>
    </div>
</div>
<!--audio-->
<div class="rc-pagination">
    <volist name="list" id="vo">
        <div data="{$vo.id}" class="audiobox audiobox{$vo.id} none">
            <div  class="jy12">
                <audio class="aa" id="audio{$vo.id}" controls="controls">
                    <source src="{$vo.content}" type="audio/ogg">
                    <source src="{$vo.content}" type="audio/mpeg">
                    Your browser does not support the audio element.
                </audio>
            </div>
        </div>
    </volist>
</div>

<include file="common:footer"/>
</body>
<script>
    $('.filter-group').find('span').click(function () {
        $(this).addClass('active').siblings().removeClass('active');
        var lang = $('.s_lang .active').attr('data-id');
        var type = $('.s_type .active').attr('data-id');
        var feel = $('.s_feel .active').attr('data-id');
        $.ajax({
            url:"{:url('music/getMusic')}",
            data:{"lang":lang,"type":type,"feel":feel},
            type:"POST",
            success:function(req){
                var c = JSON.parse(req);
                console.log(c);
                if (c.status == 0){
                    $('.library-list').html('');
                    $('.rc-pagination').html('');
                    layer.msg(c.msg, { offset: '300px' });return;
                }
                if (c.status == 1){
                    $('.library-list').html('');
                    $('.rc-pagination').html('');
                    var music = c.data;
                    var html = '';
                    var tpl = '';
                    for (var x in music) {
                        html +=
                        '<tr>'+
                            '<td class="suntit"><span></span>'+music[x].title+'</td>'+
                            '<td>'+
                            '<span data='+music[x].id+' class="sxplay"></span>'+
                            '</td>'+
                            '<td>'+music[x].songer+'</td>'+
                            '<td>'+music[x].zj+'</td>'+
                            //'<td>04:16</td>'+
                        '</tr>'
                    }
                    for (var x in music) {
                        tpl +=
                            '<div data='+music[x].id+' class="audiobox audiobox'+music[x].id+' none">'+
                                '<div  class="jy12">'+
                                    '<audio controls="controls">'+
                                        '<source src="'+music[x].content+'" type="audio/ogg">'+
                                        '<source src="'+music[x].content+'" type="audio/mpeg">'+
                                        'Your browser does not support the audio element.'+
                                    '</audio>'+
                                '</div>'+
                            '</div>'
                    }
                    $('.library-list').append(html);
                    $('.rc-pagination').append(tpl);

                    $(".sxplay").click(function () {
                        var id = $(this).attr('data');
                        $(".sxplay").removeClass("sxplayon");
                        $(this).addClass("sxplayon");
                        $(".audiobox"+id).fadeIn("none");
                        $(".audiobox").each(function (index, e) {
                            if ($(e).attr('data') != id){
                                $(e).css('display', 'none')
                            }
                        });
                        $.ajax({
                            url:"{:url('music/updateClick')}",
                            data:{"id":id},
                            type:"POST",
                            success:function(req){
                                console.log(req);return;
                            }
                        })
                    })
                }
            }

        })
    })

    $('.sort').find('span').click(function () {
        $(this).addClass('active').siblings().removeClass('active');
        var sort =  $('.sort .active').attr('data-id');
        var lang = $('.s_lang .active').attr('data-id');
        var type = $('.s_type .active').attr('data-id');
        var feel = $('.s_feel .active').attr('data-id');
        $.ajax({
            url:"{:url('music/getMusic')}",
            data:{"lang":lang,"type":type,"feel":feel,"sort":sort},
            type:"POST",
            success:function(req){
                var c = JSON.parse(req);
                console.log(c);
                if (c.status == 0){
                    $('.library-list').html('');
                    $('.rc-pagination').html('');
                    layer.msg(c.msg, { offset: '300px' });return;
                }
                if (c.status == 1){
                    $('.library-list').html('');
                    $('.rc-pagination').html('');
                    var music = c.data;
                    var html = '';
                    var tpl = '';
                    for (var x in music) {
                        html +=
                            '<tr>'+
                            '<td class="suntit"><span></span>'+music[x].title+'</td>'+
                            '<td>'+
                            '<span data='+music[x].id+' class="sxplay"></span>'+
                            '</td>'+
                            '<td>'+music[x].songer+'</td>'+
                            '<td>'+music[x].zj+'</td>'+
                            //'<td>04:16</td>'+
                            '</tr>'
                    }
                    for (var x in music) {
                        tpl +=
                            '<div data='+music[x].id+' class="audiobox audiobox'+music[x].id+' none">'+
                            '<div  class="jy12">'+
                            '<audio controls="controls">'+
                            '<source src="'+music[x].content+'" type="audio/ogg">'+
                            '<source src="'+music[x].content+'" type="audio/mpeg">'+
                            'Your browser does not support the audio element.'+
                            '</audio>'+
                            '</div>'+
                            '</div>'
                    }
                    $('.library-list').append(html);
                    $('.rc-pagination').append(tpl);

                    $(".sxplay").click(function () {
                        var id = $(this).attr('data');
                        $(".sxplay").removeClass("sxplayon");
                        $(this).addClass("sxplayon");
                        $(".audiobox"+id).fadeIn("none");
                        $(".audiobox").each(function (index, e) {
                            if ($(e).attr('data') != id){
                                $(e).css('display', 'none')
                            }
                        });
                        $.ajax({
                            url:"{:url('music/updateClick')}",
                            data:{"id":id},
                            type:"POST",
                            success:function(req){
                                console.log(req);return;
                            }
                        })
                    })
                }
            }

        })
    })

    $(".sxplay").click(function () {
        var id = $(this).attr('data');
        $(".sxplay").removeClass("sxplayon");
        $(this).addClass("sxplayon");

        $(".audiobox"+id).fadeIn("none");
        $(".aa").load();
//        $("#audio"+id).attr('autoplay','autoplay');

        $(".audiobox").each(function (index, e) {
            if ($(e).attr('data') != id){
                $(e).css('display', 'none')
            }
        });
        $.ajax({
            url:"{:url('music/updateClick')}",
            data:{"id":id},
            type:"POST",
            success:function(req){
                console.log(req);return;
            }
        })
    })
</script>
</html>