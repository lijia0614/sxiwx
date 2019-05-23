<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>绑定账号</title>
    <link href="css/app_f7319b21.css" rel="stylesheet">
</head>
<body style="font-size: 12px;"><!--[if lt IE 10]>
<![endif]-->
<div id="root">
    <div class="user-manage-wrap">
        <include file="common:info_header"/>
        <section class="main-wrap">
            <include file="common:info_left"/>
            <div class="bind-wrap">
                <div class="ant-tabs ant-tabs-top tabs ant-tabs-line">
                    <div role="tablist" class="ant-tabs-bar" tabindex="0">
                        <div class="ant-tabs-nav-container">
                            <span unselectable="unselectable" class="ant-tabs-tab-prev ant-tabs-tab-btn-disabled">
                                <span class="ant-tabs-tab-prev-icon"></span>
                            </span>
                            <span unselectable="unselectable" class="ant-tabs-tab-next ant-tabs-tab-btn-disabled">
                                <span class="ant-tabs-tab-next-icon"></span>
                            </span>
                            <div class="ant-tabs-nav-wrap">
                                <div class="ant-tabs-nav-scroll">
                                    <div class="ant-tabs-nav ant-tabs-nav-animated">
                                        <div class="ant-tabs-ink-bar ant-tabs-ink-bar-animated"
                                             style="display: block; transform: translate3d(360px, 0px, 0px); width: 122px;"></div>
                                        <div role="tab" aria-disabled="false" aria-selected="false"
                                             class=" ant-tabs-tab">
                                            <a href="{:url('info/baseInfo')}">基本信息</a>
                                        </div>
                                        <div role="tab" aria-disabled="false" aria-selected="false"
                                             class=" ant-tabs-tab">
                                            <a href="{:url('info/avatar')}">修改头像</a>
                                        </div>
                                        <div role="tab" aria-disabled="false" aria-selected="false"
                                             class=" ant-tabs-tab">
                                            <a href="{:url('info/updatePwd')}">修改密码</a>
                                        </div>
                                        <div role="tab" aria-disabled="false" aria-selected="true"
                                             class="ant-tabs-tab-active ant-tabs-tab">账号绑定
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="ant-tabs-content ant-tabs-content-animated" style="margin-left: -300%;">
                        <div role="tabpanel" aria-hidden="true"
                             class="ant-tabs-tabpane ant-tabs-tabpane-inactive"></div>
                        <div role="tabpanel" aria-hidden="true"
                             class="ant-tabs-tabpane ant-tabs-tabpane-inactive"></div>
                        <div role="tabpanel" aria-hidden="true"
                             class="ant-tabs-tabpane ant-tabs-tabpane-inactive"></div>
                        <div role="tabpanel" aria-hidden="false" class="ant-tabs-tabpane ant-tabs-tabpane-active"></div>
                    </div>
                </div>
                <if condition="$user['unionid'] and !$user['phone']">

                    <div class="accounts-wrap text-center">
                        <div class="account">
                            <div class="mobile active"></div>
                            <p>{$user['phone']}</p>
                            <a href="{:url('info/binMobile')}">
                                <button type="button" class="ant-btn">
                                    <span>绑定手机号</span>
                                </button>
                            </a>
                        </div>
                        <div class="account">
                            <div class="weixin weixin1"></div>
                            <p>{$user['pen_name']}</p>
                        </div>
                    </div>
                    <div class="tips">提示：绑定后可在登录页面使用手机号码登录当前账号</div>
                <else/>
                    <div class="accounts-wrap text-center">
                        <div class="account">
                            <div class="mobile active"></div>
                            <p>{$user['phone']}</p>
                            <a href="{:url('info/changeMobile')}">
                                <button type="button" class="ant-btn">
                                    <span>修改手机号</span>
                                </button>
                            </a>
                        </div>
                        <if condition="$user['unionid']">
                            <div class="account">
                                <div class="weixin weixin1"></div>
                                <p>{$user['pen_name']}</p>
                            </div>
                            <else/>
                            <div class="account">
                                <div class="weixin"></div>
                                <p>暂未绑定微信</p>
                                <a href="{:url('info/bin_wx')}">
                                    <span>我要绑定</span>
                                </a>
                            </div>
                        </if>
                    </div>
                    <div class="tips">提示：绑定后可在登录页面点击微信图标登录当前账号</div>
                </if>


            </div>
        </section>
        <footer class="text-center">Copyright © 2018-2019 {$site_name} All Rights Reserved</footer>
    </div>
</div>
<script>
    var _hmt = _hmt || [];
    (function () {
        var hm = document.createElement("script");
        hm.src = "https://hm.baidu.com/hm.js?0d372343734126a1ba9978a14c0f317f";
        var s = document.getElementsByTagName("script")[0];
        s.parentNode.insertBefore(hm, s);
    })();
</script>

</body>