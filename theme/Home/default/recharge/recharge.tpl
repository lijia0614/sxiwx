<head><title>充值</title>
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=no">
    <link rel="stylesheet" href="css/font_626180_rzkibgk7ogl.css">
    <link rel="stylesheet" href="css/app.57f84.css">
    <script src="js/jquery-1.9.1.js"></script>
    <script src="/public/layer/layer.js"></script>
    <script type="text/javascript">(function (doc, win) {
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
        })(document, window);</script>
    <style>
        @media (max-width: 768px){
            .account-info{
                padding-left: 15px;
            }
        }
    </style>
</head>
<body>
<div id="root">
    <div data-reactroot="" class="layout-wrap container-wrap ">
        <div class="m-nav ">
            <i class="iconfont icon-xiangzuo"></i>
            <span>充值</span>
        </div>
        <div class="recharge-wrap">
            <div class="container-wrap recharge-wrap">
                <div class="recharge container">
                    <h4>在线充值</h4>
                    <div class="account-info">
                        <div>
                            <!-- react-text: 11 -->
                            账号ID：
                            <!-- /react-text -->
                            <span>{$user['id']}</span>
                        </div>
                    </div>
                    <div class="pay-way">
                        <span class="title">支付方式</span>
                        <div class="img-group">
                            <span class="mode active">
                                <img src="images/wxpay.png" alt="1">
                                <i class="select-icon"></i>
                            </span>
                            <span class="mode ">
                                <img src="images/alipay.png" alt="2">
                                <i class="select-icon"></i>
                            </span>
                        </div>
                        <span class="title">
                            <!-- react-text: 23 -->
                            充值金额
                            <!-- /react-text -->
                            <span>（1元=100双溪币）</span>
                        </span>
                        <form target="_blank" action="{:url('Recharge/goPay')}" class="form_click" method="get">
                            <input type="hidden" id="type" name="type" value="1" />
                            <input type="hidden" id="amount" name="amount" value="30" />
                            <div class="pay-list">
                                <span class="sum" data-id="10"><b> ￥10</b>
                                    <!-- react-text: 74 -->（1000双溪币）
                                    <!-- /react-text -->
                                    <i class="select-icon"></i>
                                </span>
                                <span class="sum active" data-id="30">
                                    <b> ￥30</b>
                                    <!-- react-text: 76 -->（3000双溪币）<!-- /react-text -->
                                    <i class="select-icon"></i>
                                </span>
                                <span class="sum " data-id="50">
                                    <b> ￥50</b>
                                    <!-- react-text: 78 -->（5000双溪币）<!-- /react-text -->
                                    <i class="select-icon"></i>
                                </span>
                                <span class=sum "" data-id="100">
                                    <b> ￥100</b>
                                    <!-- react-text: 80 -->（10000双溪币）<!-- /react-text -->
                                    <i class="select-icon"></i>
                                </span>
                                <span class="sum " data-id="200">
                                    <b> ￥200</b>
                                    <!-- react-text: 82 -->（20000双溪币）<!-- /react-text -->
                                    <i class="select-icon"></i>
                                </span>
                            </div>
                            <span class="btn">立即充值￥30</span>
                        </form>
                    </div>
                    <div class="notice">
                        <!-- react-text: 63 -->*温馨提示：<!-- /react-text --><br><!-- react-text: 65 -->
                        1、双溪币属于虚拟商品，一经购买不得退换；<!-- /react-text --><br><!-- react-text: 67 -->
                        2、充值后书币到账可能有延迟，1小时内未到账请联系客服电话：{$tel}，或咨询客服QQ：{$qq}<!-- /react-text --><br>
                        <!-- react-text: 69 -->
                        3、工作时间：周一到周五 9:00 - 18:00<!-- /react-text --><br>
                    </div>
                </div>
                <div class="account-footer">
                    <p>
                        Copyright © 2017-2018 www.sxiwx.com All rights reserved {$site_name}
                        {$site_icp}
                    </p>
                </div>
                <!-- react-empty: 71 -->
                <!-- react-empty: 72 -->
                <!-- react-empty: 73 -->
            </div>
        </div>
    </div>
</div>
<div>
    <div data-reactroot="" class="rc-notification" style="top: 65px; left: 50%;"><span></span></div>
</div>
<script>
    $('.mode').on('click',function () {
        $(this).addClass('active').siblings().removeClass('active');
    })
    $('.sum').on('click',function () {
        $(this).addClass('active').siblings().removeClass('active');
        var num = $(this).attr('data-id');
        $('.btn').html('立即充值￥'+num);
    })


    $('.btn').on('click',function () {
        var cs = $('.img-group').find('span');
        var type = '';
        var amount = '';
        cs.each(function (index,item) {
            if ($(item).hasClass('active')){
                type = $(item).find('img').attr('alt');
                $('#type').val(type);
            }
        })

        var sp = $('.pay-list').find('span');
        sp.each(function (index,item) {
            if ($(item).hasClass('active')){
                amount = $(item).attr('data-id');
                $('#amount').val(amount);
            }
        })
        $('.form_click').submit();
    })
</script>
</body>