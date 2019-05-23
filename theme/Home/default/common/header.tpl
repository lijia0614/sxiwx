<script src="js/jquery-1.9.1.js"></script>
<script src="/public/layer/layer.js"></script>
<style>
    .gongzs{
        position: relative;
        cursor: pointer;
    }
    .gongzs .fonbs{
        position: absolute;
        top: 58px;
        left: -70px;
        width: 200px;
        display: none;
        background: #fff;
        z-index: 20;
        border: 1px solid #4bc1d2;
    }
    .header .fonbs img{
        width: 100%;
        height: 190px;
        margin: 5px auto 5px;
        box-sizing: border-box;
        overflow: hidden;
    }
    .fonbs p{
        width: 100%;
        overflow: hidden;
        padding:  0 5px;
        box-sizing: border-box;
        text-align: center;
        float: left;
        line-height: 30px;
    }
    .gongzs:hover .fonbs{
        display: block;

    }
    .header a{
        display: inline-block;
    }
</style>
<header class="header">
    <div class="header-div">
        <a class="pc-logo" href="/">
            <img src="{$logo}" alt="{$site_name}"></a>
        <a class="m-logo" href="/">
            <img src="{$logo}" alt="{$site_name}"></a>
        <a <if condition="$module eq 'Index'"> class="active" </if> href="/">首页</a>
        <a <if condition="$module eq 'Library'"> class="active" </if> href="{:url('library/library')}">书库</a>
        <a <if condition="$module eq 'Recharge'"> class="active" </if> href="{:url('recharge/recharge')}" target="_blank">充值</a>
        <a class="gongzs">客户端
            <div class="fonbs">
                <img src="{$weixin}">
                <p>扫一扫，惊喜不断</p>
            </div>
        </a>

        <a <if condition="$module eq 'Welfare'"> class="active" </if> href="{:url('welfare/welfare')}">福利</a>
        <a <if condition="$module eq 'Users'"> class="active" </if> href="{:url('users/home')}" target="_blank">创作平台</a>
        <!--
        <a <if condition="$module eq 'Anime'"> class="active" </if> href="{:url('anime/anime')}">古风歌词</a>
        -->
        <a <if condition="$module eq 'Anime'"> class="active" </if> href="{:url('music/index')}">歌单</a>
        <if condition="$user">
            <span class="hide"></span>
            <div style=" float: right;position: relative">
                <if condition="$user['image']">
                    <img id="head_por" alt="" src="{$user['image']}" style="float: right; width: 30px; height: 30px; border-radius: 50%; margin-top: 20px; margin-right: 0px; ">
                    <if condition="$m_c gt 0">
                        <div style="position: absolute;
right: -2px;top: 22px;width:8px;height:8px; border-radius:6px;background-color: #f54236">
                        </div>
                    </if>
                    <else/>
                    <img id="head_por" style="float: right; width: 30px; height: 30px; border-radius: 50%; margin-top: 20px; margin-right: 0px;" src="images/touxiang.png">
                </if>
            </div>

            <a target="_blank" href="{:url('info/bookShelf')}" class="bookrack">
                <i class="iconfont icon-shujia"></i>书架
            </a>
            <else/>
            <span class="pc-login">
                <a class="register" href="{:url('login/register')}">注册</a>
                <a class="login" href="{:url('login/login')}">登录
                    <i class="iconfont icon-fs-line"></i>
                </a>
        </span>

        </if>

        <span class="phone-login">
            <i class="iconfont icon-touxiang"></i>
        </span>
        <if condition="!$music">
            <span class="header-search">
            <input style="margin-top: 20px;" id="keywords" placeholder="输入书名/关键词" type="text" value=""><i id="search" class="iconfont icon-search"></i>
        </span>
        </if>

    </div>
</header>
<header class="m-header">
    <div class="top">
        <a href="" class="top-left">
            <img src="{$logo}" alt="{$site_name}">
        </a>
        <span class="top-right">
            <i id="m-search" class="iconfont icon-search"></i>
            <a href="{:url('info/bookShelf')}" class="bookrack">
                <i class="iconfont icon-shujia"></i>
            </a>
            <span class="user-info"></span>
            <a href="" class="margin-left: 0px;">
                <if condition="$user['image']">
                    <a href="{:url('info/mcenter')}">
                        <img id="head_por" alt="" src="{$user['image']}"  style="width: 0.5rem; height: 0.5rem; border-radius: 100%; vertical-align: middle;">
                    </a>

                <else/>
                    <a href="{:url('info/mcenter')}">
                        <img id="head_por" alt="" src="images/touxiang.png"  style="width: 0.5rem; height: 0.5rem; border-radius: 100%; vertical-align: middle;">
                    </a>
                </if>
            </a>
        </span>
    </div>
    <div class="top-nav">

        <a <if condition="$module eq 'Index'"> class="active" </if> href="/">首页</a>
        <a <if condition="$module eq 'Library'"> class="active" </if> href="{:url('library/library')}">书库</a>
        <a <if condition="$module eq 'Recharge'"> class="active" </if> href="{:url('recharge/recharge')}" target="_blank">充值</a>
        <a <if condition="$module eq 'Welfare'"> class="active" </if> href="{:url('welfare/welfare')}">福利</a>
        <a <if condition="$module eq 'Users'"> class="active" </if> href="{:url('info/mcenter')}" target="_blank">个人中心</a>

        <a <if condition="$module eq 'Anime'"> class="active" </if> href="{:url('users/home')}">创作平台</a>

    </div>
</header>
<script>
    // 设置rem字号
    ;(function(doc,win){
        'use strict';
        var docEl = doc.documentElement;
        var resizeEvt =  'resize';
        function recalc() {
            var clientWidth = docEl.clientWidth;
            if (!clientWidth) return;
            docEl.style.fontSize = (100 * clientWidth / 750) + 'px';
        }

        recalc();
        win.addEventListener(resizeEvt, recalc, false);
    })(document,window);
    var mdwith=window.screen.width;
    if(mdwith<= 768){
        $('header.header').css('display','none');
        $('.pc-logo').css('display','none')
    }else{
        $('header.header').css('display','block');
        $('.pc-logo').css('display','block')
    }
</script>

<div class="rc-tooltip account-overlayer rc-tooltip-placement-bottomRight rc-tooltip-hidden"
     style="left: 1239.5px; top: 50px;">
    <div class="rc-tooltip-content">
        <div class="rc-tooltip-arrow"></div>
        <div class="rc-tooltip-inner">
            <div class="overlayer">
                <div class="user">
                    <a target="_blank" href="{:url('info/baseInfo')}" style="margin-right: 0px;">
                        <if condition="$user['image']">
                            <img alt="" src="{$user['image']}">
                            <else/>
                            <img alt="" src="images/touxiang.png">
                        </if>
                    </a>
                    <div>
                        <span class="name">{$user['pen_name']}</span><br>
                        <span class="id">ID：{$user['id']}--{$m_c}</span>
                    </div>
                </div>
                <ul class="link text-center">
                    <li style="width: 74px;">
                        <a target="_blank" href="{:url('info/baseInfo')}">
                            <span>
                                <img width="48" alt="" src="images/info.png">
                            </span>
                            <br>个人信息</a>
                    </li>
                    <li style="width: 74px;">
                        <a target="_blank" href="{:url('info/wallet')}">
                            <span>
                                <img width="48" alt="" src="images/wallet.png">
                            </span>
                            <br>我的钱包</a>
                    </li>
                    <li>
                        <a target="_blank" href="{:url('info/reply')}">
                            <span>
                                <img width="48" alt="" src="images/reply.png">
                            </span>
                            <if condition="$m_c gt 0">
                                <br><p style="color: #f54236">新消息！</p>
                                <else/>
                                <br>我的消息
                            </if>
                            </a>
                        <span class="hide"> </span>
                    </li>
                    <li>
                        <a target="_blank" href="{:url('users/home')}">
                            <span>
                                <img width="48" alt="" src="images/pen.png">
                            </span><br>
                            创作平台
                        </a>
                        <span class="hide"></span>
                    </li>
                </ul>
                <div class="logout">
                    <a id="loginOut" href="javascript:">退出登录</a>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    $('#loginOut').click(function () {
        $.ajax({
            url:"{:url('login/loginOut')}",
            success:function(req){
                if (req.code == 0){
                    layer.alert(req.msg); return false;
                }
                if (req.code == 1){
                    setTimeout(function(){ window.location.href = "{:url('index/index')}"; }, 0000);
                }
            }
        });
    })

    $("#head_por").mouseover(function (){
        $(".rc-tooltip-placement-bottomRight").removeClass('rc-tooltip-hidden');
    }).mouseout(function (){
        $(".rc-tooltip-placement-bottomRight").addClass('rc-tooltip-hidden');
    });
    $('.rc-tooltip-placement-bottomRight').mouseover(function () {
        $(this).removeClass('rc-tooltip-hidden')
    }).mouseout(function (){
        $(this).addClass('rc-tooltip-hidden');
    });

    $('#search').click(function () {
        var keywords = $('#keywords').val();
        if (keywords == ''){
            layer.msg('请输入书名', { offset: '50px' });return false;
        }
        window.location.href = "{:url('search/index')}"+'?keywords='+keywords;
    })

    $('#m-search').click(function () {
        window.location.href = "{:url('search/mSearch')}"
    })


</script>