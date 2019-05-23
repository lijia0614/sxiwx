<header class="component-header-wrap">
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
    <div class="content clearfix">
        <a style="float: left;" href="{:url('index/index')}"><img src="{$logo}"></a>
        <div style="margin-left: 131px" class="fl tab">
            <a href="/">首页</a>
            <a href="{:url('welfare/welfare')}">福利</a>
            <a href="{:url('library/library')}">书库</a>
            <a href="{:url('recharge/recharge')}">充值</a>
            <a class="gongzs">客户端
                <div class="fonbs">
                    <img width="195px;" src="{$weixin}">
                    <p>扫一扫，惊喜不断</p>
                </div>
            </a>
            <a href="{:url('users/home')}">创作平台</a>
        </div>
        <div class="fr feature">
            <span style="height: 32px;" class="ant-input-search search ant-input-affix-wrapper">
                <input placeholder="输入书名/关键词" id="keywords" class="ant-input" type="text">
                <span style="cursor:pointer;" id="search" class="ant-input-suffix">
                    <i class="anticon anticon-search ant-input-search-icon"></i>
                </span>
            </span>

            <a href="{:url('info/bookShelf')}">
                <button type="button" class="ant-btn" style="color: rgb(255, 102, 126); border-color: rgb(255, 102, 126); border-radius: 15px; margin-right: 10px;">
                    <img src="//s.weituibao.com/static/jgc6q.png" width="13">
                    <span> 书架</span>
                </button>
            </a>
            <div class="dropdown ">
                <if condition="$user['image']">
                    <img class="avatar"src="{$user['image']}">
                    <else/>
                    <img class="avatar" src="images/touxiang.png">
                </if>
                <div class="overlayer">
                    <div class="user">
                        <a target="_blank" href="/usermanage/baseinfo">
                            <if condition="$user['image']">
                                <img alt="" src="{$user['image']}">
                                <else/>
                                <img alt="" src="images/touxiang.png">
                            </if>
                        </a>
                        <div>
                            <span class="name">{$user['pen_name']}</span><br>
                            <span class="id">ID：{$user['id']}</span>
                        </div>
                    </div>
                    <ul class="link text-center">
                        <li style="width: 72px;">
                            <a href="{:url('info/baseInfo')}">
                                <div>
                                    <img width="24" src="//s.weituibao.com/static/kkg3y.png">
                                </div>
                                个人信息
                            </a>
                        </li>
                        <li style="width: 72px;">
                            <a href="{:url('info/wallet')}">
                                <div>
                                    <img width="24" src="//s.weituibao.com/static/1533793256025/wallet.png">
                                </div>
                                我的钱包
                            </a>
                        </li>
                        <li style="width: 72px;">
                            <a href="{:url('info/reply')}">
                                <div class="">
                                    <img width="24" src="//s.weituibao.com/static/rkqxq.png">
                                </div>
                                我的消息
                            </a>
                        </li>
                        <li style="width: 72px;">
                            <a href="{:url('users/home')}">
                                <div class="">
                                    <img width="24" src="//s.weituibao.com/static/1533793256025/pen.png">
                                </div>
                                创作平台
                            </a>
                        </li>
                    </ul>
                    <div class="logout">
                        <a id="loginOut" href="javascript:">退出登录</a>
                    </div>
                </div>
            </div>
        </div>
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

</script>
<script src="js/jquery-1.9.1.js"></script>
<script src="/public/layer/layer.js"></script>
<script>
    $('#loginOut').click(function () {
        $.ajax({
            url:"{:url('login/loginOut')}",
            success:function(req){
                if (req.code == 0){
                    layer.alert(req.msg); return false;
                }
                if (req.code == 1){
                    setTimeout(function(){ window.location.href = "{:url('index/index')}"; }, 1000);
                }
            }
        });
    })

    $('#search').click(function () {
        var keywords = $('#keywords').val();
        if (keywords == ''){
            layer.msg('请输入书名', { offset: '50px' });return false;
        }
        window.location.href = "{:url('search/index')}"+'?keywords='+keywords;
    })
</script>