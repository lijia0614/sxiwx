<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>体现记录</title>
    <link href="css/app_1f306cd5.css?" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="css/0_8b3eb11c.css">
    <script charset="utf-8" src="js/0_8b3eb11c.js"></script>
</head>
<body><!--[if lt IE 10]>
<script src="js/leie9.js"></script><![endif]-->
<!--[if lte IE 11]>
<script src="js/es6-shim.min.js"></script>
<![endif]-->
<div id="root">
    <div class="app-wrap">
        <include file="common:users_header"/>
        <div class="main-wrap">
            <include file="common:users_nav"/>
            <section class="main-content">
                <div class="daily-income-wrap"><h2 class="title">收入日报</h2>
                    <div style="margin-top: 20px;">
                        <span class="ant-calendar-picker">
                            <div>
                                <input readonly="" placeholder="请选择日期" class="ant-calendar-picker-input ant-input" value="2018-10-21">
                                <span class="ant-calendar-picker-icon"></span>
                            </div>
                        </span>
                        <span class="fr">单位：元</span>
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
                                                        <col style="width: 16%; min-width: 16%;">
                                                        <col style="width: 20%; min-width: 20%;">
                                                        <col style="width: 16%; min-width: 16%;">
                                                        <col style="width: 16%; min-width: 16%;">
                                                        <col style="width: 16%; min-width: 16%;">
                                                        <col style="width: 16%; min-width: 16%;">
                                                        <col style="width: 20%; min-width: 16%;">
                                                    </colgroup>
                                                    <thead class="ant-table-thead">
                                                    <tr>
                                                        <th class=""><span>提现流水ID</span></th>
                                                        <th class=""><span>提现时间</span></th>
                                                        <th class=""><span>提现金额</span></th>
                                                        <th class=""><span>扣除稿税</span></th>
                                                        <th class=""><span>实际打款</span></th>
                                                        <th class=""><span>状态</span></th>
                                                        <th class=""><span>备注</span></th>
                                                    </tr>
                                                    </thead>
                                                    <tbody class="ant-table-tbody"></tbody>
                                                </table>
                                            </div>
                                            <div class="ant-table-placeholder">暂无数据</div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
        </div>
        <footer class="text-center">Copyright © 2017-2018 杭州文心网络科技有限公司 All Rights Reserved</footer>
    </div>
</div>


</body>