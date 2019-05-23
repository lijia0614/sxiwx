<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>我的钱包</title>
    <link href="css/app_f7319b21.css" rel="stylesheet">
</head>
<body style="font-size: 12px;"><!--[if lt IE 10]>
<![endif]-->
<div id="root">
    <div class="user-manage-wrap">
        <include file="common:info_header"/>
        <section class="main-wrap">
            <include file="common:info_left"/>
            <div class="wallet-wrap"><h3 class="title">我的钱包</h3>
                <h3 class="m-title text-center">
                    <span class="fl" style="position: absolute; z-index: 1;"></span>
                    <div class="">消费记录</div>
                    <div class="active">充值记录</div>
                </h3>
                <div class="top-area">账户余额：
                    <span class="balance">{$user['money']} 豌豆</span>
                    <a target="_blank" href="{:url('recharge/recharge')}" class="ant-btn fr ant-btn-primary">
                        <span>充 值</span>
                    </a>
                </div>
                <div class="ant-tabs ant-tabs-top tabs-wrap ant-tabs-line">
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
                                             style="display: block; transform: translate3d(120px, 0px, 0px); width: 88px;"></div>
                                        <div role="tab" aria-disabled="false" aria-selected="false"
                                             class=" ant-tabs-tab">
                                            <a style="color: #778090" href="{:url('info/xiaofei')}">消费记录</a>
                                        </div>
                                        <div role="tab" aria-disabled="false" aria-selected="true"
                                             class="ant-tabs-tab-active ant-tabs-tab">
                                            <a href="{:url('info/wallet')}">充值记录</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="ant-tabs-content ant-tabs-content-animated" style="margin-left: 0%;">
                        <div role="tabpanel" aria-hidden="false" class="ant-tabs-tabpane ant-tabs-tabpane-active"></div>
                        <div role="tabpanel" aria-hidden="true"
                             class="ant-tabs-tabpane ant-tabs-tabpane-inactive"></div>
                    </div>
                </div>
                <div class="table-wrap">
                    <div class="ant-table-wrapper">
                        <div class="ant-spin-nested-loading">
                            <div class="ant-spin-container">
                                <div class="ant-table ant-table-large ant-table-empty ant-table-scroll-position-left">
                                    <div class="ant-table-content">
                                        <div class="ant-table-body">
                                            <table class="">
                                                <colgroup>
                                                    <col style="width: 22%; min-width: 22%;">
                                                    <col style="width: 22%; min-width: 22%;">
                                                    <col style="width: 34%; min-width: 34%;">
                                                    <col style="width: 22%; min-width: 22%;">
                                                </colgroup>
                                                <thead class="ant-table-thead">
                                                <tr>
                                                    <th class=""><span>充值金额</span></th>
                                                    <th class=""><span>书币数量</span></th>
                                                    <th class=""><span>充值时间</span></th>
                                                </tr>
                                                </thead>
                                                <tbody class="ant-table-tbody">
                                                <volist name="list" id="vo">
                                                    <div class="library-list">
                                                        <tr>
                                                            <td style="">{$vo.amount}</td>
                                                            <td style="">{$vo.amount * 100}</td>
                                                            <td style="">
                                                                {$vo.create_time|date='Y-m-d H:i:s'}
                                                            </td>
                                                        </tr>
                                                    </div>
                                                </volist>
                                                </tbody>

                                            </table>

                                        </div>

                                        <if condition="!$list">
                                            <div class="ant-table-placeholder">暂无数据</div>
                                        </if>

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="list-wrap"></div>
                <if condition="!$list">
                <div class="no-data text-center">
                    <img src="//s.weituibao.com/static/twx12.png">
                    <p>暂无消费记录</p></div>
                </if>
                <div class="pageList">&nbsp;&nbsp;{$page|raw}</div>
            </div>
        </section>
        <footer class="text-center">Copyright © 2017-2018 {$site_name} All Rights Reserved</footer>
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