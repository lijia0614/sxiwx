<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <!-- <meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1,user-scalable=no"> -->
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=no">
    <meta http-equiv="keywords" content="{$site_keywords}">
    <meta http-equiv="description" content="{$site_description}">

    <!-- <title></title> -->
    <title>{$data['title']} - {$site_name}</title>
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

        <div class="anime-page-wrap">
            <div class="Q-miancent"> <!--盒子 添加到线上删除-->
                <div class="Q-content">      <!-- 中间内容1200px-->
                    <div class="Q-content-left Q-content-left-poety">
                        <div class="poety-txt">
                            <h2>{$data['title']}</h2>
                            <div class="poet-txt">
                                <img src="images/icon-peo.png" alt="">
                                <span>{$data['author']}</span>
                            </div>
                            <div class="poet-cont-models">
                                {$data['content']}
                            </div>
                        </div>

                        <div class="to-click-zan">
                            <img src="images/click.png" alt="">
                            <span>{$data['click']}</span>
                        </div>

                    </div>
                    <div class="Q-content-right">
                        <div class="Q-hot-tuijian">
                            <h3>热门推荐</h3>
                            <ul>
                                <zhimeng table="poetry" where="[['status','=',1],['is_recommend','=',1]]" order="click desc" limit="10" >
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
            </div>
            <include file="common:footer"/>
        </div>
    </div>
</div>
</body>
</html>

