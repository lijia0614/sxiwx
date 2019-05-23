<head>
    <meta charset="utf-8">
    <!-- <meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1,user-scalable=no"> -->
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=no">
    <meta http-equiv="keywords" content="{$site_keywords}">
    <meta http-equiv="description" content="{$site_description}">

    <!-- <title></title> -->
    <title>搜索 - {$keywords}</title>
    <link rel="stylesheet" href="css/font_626180_rzkibgk7ogl.css">

    <link rel="preload" href="css/0.2933c71f.css" as="style">

    <link rel="preload" href="css/style.2933c71f.css" as="style">


    <link rel="preload" href="js/vendors.2933c71f.js" as="script">

    <link rel="preload" href="js/client.2933c71f.js" as="script">
    <base href="/">
    <link href="css/0.2933c71f.css" rel="stylesheet">
    <link href="css/style.2933c71f.css" rel="stylesheet">
    <title data-react-helmet="true"></title>

</head>
<body>
<div id="app">
    <div class="wrap">
        <include file="common:header"/>
        <div class="m-nav ">
            <i onclick="javascript:history.back(-1);" class="iconfont icon-xiangzuo"></i>
            <i class="iconfont icon-search"></i>
                <input type="search" class="keywords" placeholder="输入书名/关键词" value="{$keywords}"><i class="iconfont icon-cuo search"></i>
        </div>
        <div class="container-wrap search-wrap">
            <div class="half-border-top"></div>
            <div class="search container">
                <div class="content-top">
                    <div class="search-input">
                        <input class="keywords1" placeholder="输入书名/关键词" value="{$keywords}">
                        <span class="search1">搜索</span>
                    </div>
                </div>
                <div class="content clearfix">
                    <div class="content-left">
                        <div class="search-result">
                            <div class="result-num">
                                共<span>{$count}</span>条叫<span>{$keywords}</span>的结果
                            </div>
                            <div class="novel-list">
                                <volist name="book" id="vo">
                                <div data-id="366" class="novel-item clearfix">
                                    <a class="img-link" target="_blank" href="{:url('read/index',['id'=>$vo['id']])}">
                                        <img src="{$vo.image}" alt="">
                                    </a>
                                    <a target="_blank" href="{:url('read/index',['id'=>$vo['id']])}">
                                        <h5>{$vo.name}</h5>
                                    </a>
                                    <div class="author">
                                        <span class="name">
                                            <i class="iconfont icon-zuozhe"></i>{$vo.author}
                                        </span>
                                        <span class="category">{$vo.c_name}</span>
                                        <span class="status">
                                            <if condition="$vo['is_end'] eq 0">
                                                连载中
                                                <else/>
                                                完结
                                            </if>
                                        </span>
                                        <span>{$vo.words_num}字</span>
                                    </div>
                                    <a target="_blank" href="/book/366">
                                        <p class="desc">
                                            {$vo.info}
                                        </p>
                                    </a>
                                </div>
                                </volist>
                            </div>
                        </div>
                    </div>
                    <div class="content-right">
                        <div class="hot-recommend"><h4>热门推荐</h4>
                            <div class="r-list clearfix">
                                <zhimeng table="book" where="[['is_del','=',0],['is_recommend','=',1]]" order="sort desc" limit="10" >
                                <div class="r-item hot-recommend-item clearfix" data-id="378">
                                    <a class="img-link" target="_blank" href="{:url('read/index',['id'=>$r['id']])}">
                                        <img src="{$r.image}" alt=""></a>
                                    <a target="_blank" href="{:url('read/index',['id'=>$r['id']])}">
                                        <h5>{$r.name}</h5>
                                    </a>
                                    <div class="author">作者：
                                        <span class="name">{$r.author}</span>
                                    </div>
                                    <div class="author">分类：
                                        <zhimeng table="book_category" where="[['id','=',$r['cid']]]" id="vo">
                                        <span>{$vo.name}</span>
                                        </zhimeng>
                                    </div>
                                </div>
                                </zhimeng>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <include file="common:footer"/>
        </div>
    </div>
</div>
<div>
    <div class="rc-notification" style="top: 65px; left: 50%;"><span></span></div>
</div>
<script>
    $('.search1').click(function () {
        var keywords = $('.keywords1').val();
        if (keywords == ''){
            layer.msg('请输入书名', { offset: '50px' });return false;
        }
        window.location.href = "{:url('search/index')}"+'?keywords='+keywords;
    })
    $('.search').click(function () {
        var keywords = $('.keywords').val();
        if (keywords == ''){
            layer.msg('请输入书名', { offset: '50px' });return false;
        }
        window.location.href = "{:url('search/index')}"+'?keywords='+keywords;
    })
</script>
</body>