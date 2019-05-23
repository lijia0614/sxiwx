<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <!-- <meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1,user-scalable=no"> -->
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=no">
    <meta http-equiv="keywords" content="{$site_keywords}">
    <meta http-equiv="description" content="{$site_description}">

    <!-- <title></title> -->
    <title>福利 - {$site_name}</title>
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
    <link href="css/0.dd2aeb5c.css" rel="stylesheet">
    <link href="css/style.dd2aeb5c.css" rel="stylesheet">
    <title data-react-helmet="true"></title>


</head>
<body>
<div id="app">
    <div class="wrap" data-reactroot="">
        <include file="common:header"/>
        <div class="welfare-page">
            <div class="react-parallax ">

                <div class="react-parallax-content" style="position:relative">
                    <div class="welfare-banner">
                        <img style="width: 1320px;height: 400px" class="img" src="images/banner3.jpg" alt=""/>
                    </div>
                </div>
            </div>
            <div class="welfare-content">
                <div class="section1">
                    <zhimeng table="fuli" where="['type','=',1]">
                    <h4>{$r.title}</h4>
                    </zhimeng>
                    <div class="tab-panle">
                        <div class="tab clearfix">
                            <zhimeng table="mosi_c" order="id asc">
                                <div class="sss active" id="1">
                                    <h5>{$r.title}</h5>
                                    <p>{$r.content}</p>
                                    <span>{$r.type}</span>
                                    <img class="top-left-icon" src="images/Rectangle.png" alt=""/>
                                    <img class="xunzhang" src="{$r.image}" alt=""/>
                                </div>
                            </zhimeng>
                        </div>
                        <div class="panle">
                            <zhimeng table="fuli" where="['type','=',1]">
                                <div class="sss-content active">
                                    {$r.content}
                                </div>
                            </zhimeng>
                        </div>
                    </div>
                </div>
                <div class="section2">
                    <zhimeng table="fuli" where="['type','=',2]">
                    <h4>{$r.title}</h4>
                    </zhimeng>

                    <div>
                        <zhimeng table="fuli" where="['type','=',2]">
                        {$r.content}
                        </zhimeng>
                        <img src="{$r.image}" alt=""/>
                    </div>
                </div>
                <div class="section3">
                    <zhimeng table="fuli" where="['type','=',3]">
                    <h4>{$r.title}</h4>
                    </zhimeng>
                    <div>

                        <div class="action-content">
                            <zhimeng table="fuli" where="['type','=',3]">
                            {$r.content}
                            <img src="{$r.image}" alt=""/>
                            </zhimeng>
                        </div>
                        <div class="pindao clearfix">
                            <div style="width: 100%" class="women">
                                <h6>女频：</h6>
                                <div class="card">
                                    <dl class="title">
                                        <dt style="width: 50%;">前一部签约作品完本字数</dt>
                                        <dd>奖励金额</dd>
                                    </dl>
                                    <zhimeng table="keep_c" where="['status','=',1]" order="id asc">
                                    <dl>
                                        <dt style="width: 50%;">{$r.title}</dt>
                                        <dd>{$r.info}</dd>
                                    </dl>
                                    </zhimeng>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
                <div class="section4">
                    <zhimeng table="fuli" where="['type','=',4]">
                        <h4>{$r.title}</h4>
                    </zhimeng>
                    <div>
                        <zhimeng table="fuli" where="['type','=',4]">
                            {$r.content}
                            <img src="{$r.image}" alt=""/>
                        </zhimeng>
                    </div>
                </div>
                <div class="section5">
                    <zhimeng table="fuli" where="['type','=',5]">
                        <h4>{$r.title}</h4>
                    </zhimeng>
                    <div>
                        <zhimeng table="fuli" where="['type','=',5]">
                            {$r.content}
                            <img src="{$r.image}" alt=""/>
                        </zhimeng>
                    </div>
                </div>
                <div class="section6">
                    <div class="section6-content">
                        <h4>投稿通道</h4>
                        <p>如果您想在本站发表作品，请投稿至以下任一编辑邮箱，请勿一稿多投<br/>想要了解网站福利、申请签约等，可加编辑QQ咨询</p>
                        <div class="qqs clearfix" style="margin-left:130px">
                            <zhimeng table="tougao" where="['status','=',1]" order="sort desc">
                                <div class="qq">
                                    <a target="_blank"
                                       href="http://wpa.qq.com/msgrd?v=3&amp;uin={$r.content}&amp;site=qq&amp;menu=yes"><img
                                                class="qq-tx" src="images/qq.png" alt=""/>
                                        <div><span>{$r.title}</span>
                                            <p>{$r.content}</p>
                                        </div>
                                        <img class="add" src="images/add.png" alt=""/>
                                    </a>
                                </div>
                            </zhimeng>
                        </div>
                        <p>以上所有福利计划有效期为2018年3月1日至2019年12月31日，在法律允许的范围内，本站对本福利计划拥有最终解释权<br/>如遇不可抗力因素，本站有权终止本福利计划</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>window.__INITIAL_STATE__ = {
        "app": {
            "isLogin": false,
            "userInfo": {},
            "qrcode": {},
            "info": {},
            "writerNotice": {},
            "commentNotice": {}
        },
        "home": {
            "sliderList": [],
            "editorRecommendList": [],
            "newRecommendList": [],
            "readRecommendList": [],
            "selectedRecommendList": [],
            "maleRankList": [],
            "femaleRankList": [],
            "textRecommendList": [],
            "bannerList": [],
            "goodRecommendList": [],
            "manitoList": [],
            "clickRankList": [],
            "subRankList": []
        },
        "book": {"novelInfo": {}, "chapterList": []},
        "read": {"chapterContent": {}, "goToChapterContent": {}},
        "library": {"libraryList": [], "category": []},
        "router": {"location": {"pathname": "\u002Fwelfare", "search": "", "hash": "", "key": "xu7eu8"}}
    }</script>
</body>
</html>
