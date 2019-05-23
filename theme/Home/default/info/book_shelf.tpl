<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>我的书架</title>
    <link href="css/app_f7319b21.css" rel="stylesheet">
</head>
<body style="font-size: 12px;"><!--[if lt IE 10]>
<![endif]-->
<div id="root">
    <div class="user-manage-wrap">
        <include file="common:info_header"/>
        <section class="main-wrap">
            <include file="common:info_left"/>
            <div class="bookshelf-wrap">
                <h3 class="title">我的书架<span>（共 {$count} 本）</span></h3>
                <h3 class="m-title text-center">
                    <span  class="fl" style="position: absolute; z-index: 1;"></span>
                    我的书架
                </h3>
                <div class="list-head">
                    <span>作品</span>
                    <span>操作</span>
                </div>
                <div class="list">
                    <volist name="data" id="vo">
                    <div class="component-bookshelf-item-wrap">
                        <a target="_blank" href="{:url('read/index',['id'=>$vo['id']])}">
                            <img class="cover" src="{$vo.image}">
                        </a>
                        <div class="info">
                            <div class="name">
                                <a target="_blank" href="{:url('read/index',['id'=>$vo['id']])}">{$vo.name}</a>
                            </div>
                            <div class="status">{$vo.author}
                                <span>| </span>
                                <if condition="$vo.is_end eq 1">
                                    已完结
                                    <else/>
                                    连载中
                                </if>
                            </div>
                            <div>
                                <if condition="$vo.type eq 3 || $vo.type eq 4">

                                    <span class="last-update">
                                        <span>
                                            {$vo.read_time}
                                        </span>
                                        <a target="_blank" href="{:url('read/read',['bookId'=>$bookId,'id'=>$vo.end.chapterid])}">{$vo.end.title}</a>
                                    </span>
                                    <else/>

                                    <span class="last-update">
                                        <span>
                                            <if condition="$vo.record">
                                                {$vo.read_time}
                                                <else/>
                                                还没有阅读
                                            </if>
                                        </span>
                                        <if condition="$vo.chapter['name']">
                                            <a target="_blank" href="{:url('read/read',['b_id'=>$vo.id,'id'=>$vo.chapter['id']])}">{$vo.chapter['name']}</a>
                                            <else/>
                                            暂未更新
                                        </if>
                                    </span>
                                </if>

                                <if condition="$vo.type eq 3 || $vo.type eq 4">

                                    <if condition="vo.$res">
                                        <a target="_blank" href="{:url('read/read',['bookId'=>$vo.bookId,'id'=>$vo.res.chapterid])}" class="last-read">
                                            上次阅读：{$vo.res.title|trimhtml=0,12,true}
                                        </a>
                                        <else/>
                                        <a class="last-read">暂未阅读</a>

                                    </if>
                                    <else/>
                                    <if condition="$vo.record.name">
                                        <a target="_blank" href="{:url('read/read',['b_id'=>$vo.id,'id'=>$vo.record['chapterid']])}" class="last-read">
                                            上次阅读：{$vo.record.name}
                                        </a>
                                        <else/>
                                        <a class="last-read">暂未阅读</a>

                                    </if>
                                </if>

                            </div>
                            <div class="m-action">
                                <if condition="$vo.type eq 3 || $vo.type eq 4">
                                    <if condition="$vo.res">
                                        <a style="width: 1.4rem;" target="_blank" href="{:url('read/read',['bookId'=>$vo.bookId,'id'=>$vo.res.chapterid])}" class="ant-btn ant-btn-primary ant-btn-sm">
                                            <span>继续阅读</span>
                                        </a>
                                        <else/>
                                        <a style="width: 1.4rem;" target="_blank" href="{:url('read/read',['bookId'=>$vo.bookId,'id'=>$vo.firt['chapterid']])}" class="ant-btn ant-btn-primary ant-btn-sm">
                                            <span>开始阅读</span>
                                        </a>
                                    </if>
                                    <else/>
                                    <if condition="$vo.record.name">
                                        <a style="width: 1.4rem;" target="_blank" href="{:url('read/read',['b_id'=>$vo.id,'id'=>$vo.record['id']])}" class="ant-btn ant-btn-primary ant-btn-sm">
                                            <span>继续阅读</span>
                                        </a>
                                        <else/>
                                        <if condition="$vo.first">
                                            <a style="width: 1.4rem;" target="_blank" href="{:url('read/read',['b_id'=>$vo.id,'id'=>$vo.first['id']])}" class="ant-btn ant-btn-primary ant-btn-sm">
                                                <span>开始阅读</span>
                                            </a>
                                            <else/>
                                            <a style="width: 1.4rem;" href="javascript:void(0)" class="ant-btn ant-btn-primary ant-btn-sm">
                                                <span>还未更新</span>
                                            </a>
                                        </if>
                                    </if>
                                </if>

                                <button style="width: 1.4rem;" type="button" onclick="move_out({$vo.id})"  class="ant-btn ant-btn-sm move_out">
                                    <span>移出书架</span>
                                </button>
                            </div>
                        </div>
                        <div class="action">

                            <if condition="$vo.type eq 3 || $vo.type eq 4">

                                <if condition="$vo.res">
                                    <a target="_blank" href="{:url('read/read',['bookId'=>$vo.bookId,'id'=>$vo.res.chapterid])}" class="ant-btn ant-btn-primary">
                                        <span>继续阅读</span>
                                    </a>
                                    <else/>
                                    <a target="_blank" href="{:url('read/read',['bookId'=>$vo.bookId,'id'=>$vo.firt['chapterid']])}" class="ant-btn ant-btn-primary">
                                        <span>开始阅读</span>
                                    </a>
                                </if>

                                <else/>
                                <if condition="$vo.record.name">
                                    <a target="_blank" href="{:url('read/read',['b_id'=>$vo.id,'id'=>$vo.record['id']])}" class="ant-btn ant-btn-primary">
                                        <span>继续阅读</span>
                                    </a>
                                    <else/>
                                    <if condition="$vo.first">
                                        <a target="_blank" href="{:url('read/read',['b_id'=>$vo.id,'id'=>$vo.first['id']])}" class="ant-btn ant-btn-primary">
                                            <span>开始阅读</span>
                                        </a>
                                        <else/>
                                        <a href="javascript:void(0)" class="ant-btn ant-btn-primary">
                                            <span>还未更新</span>
                                        </a>
                                    </if>

                                </if>
                            </if>

                            <button onclick="move_out({$vo.id})" type="button" class="ant-btn move_out">
                                <span>移出书架</span>
                            </button>
                        </div>
                    </div>
                    </volist>

                </div>
                <if condition="empty($data)">
                    <div class="no-data text-center">
                        <img src="images/olkwl.png">
                        <div>
                            <p >啊哦，你的书架居然是空的</p>
                            <p>将正在阅读的书籍加入书架方便追更哦~</p>
                        </div>
                    </div>
                </if>
            </div>
        </section>
        <footer class="text-center">Copyright © 2017-2018 {$site_name} All Rights Reserved</footer>
    </div>
</div>
<script>
    $('.fl').click(function () {
        setTimeout(function(){ window.location.href = "{:url('index/index')}"; }, 0000);
    });
    
    function move_out(b_id) {
        $.ajax({
            url:"{:url('info/moveOut')}",
            data:{"b_id":b_id},
            type:"POST",
            success:function(req){
                var c = JSON.parse(req);
                if (c.status == 0){
                    layer.alert(c.msg); return false;
                }
                if (c.status == 1){
                    layer.msg(c.msg);
                    setTimeout(function(){ window.location.reload(); }, 1000);
                }
            }
        });
    }

</script>

</body>