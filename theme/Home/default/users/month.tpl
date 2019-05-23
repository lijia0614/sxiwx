<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>收入日报</title>
    <link href="css/app_1f306cd5.css?" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="css/0_8b3eb11c.css">
    <link rel="stylesheet" type="text/css" href="/public/layui/css/layui.css">
    <script charset="utf-8" src="js/0_8b3eb11c.js"></script>
    <script src="js/jquery-3.1.1.min.js"></script>
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
                <div class="daily-income-wrap"><h2 class="title">收入月报</h2>
                    <div style="margin-top: 20px;">
                        <span class="ant-calendar-picker">
                            <div>
                                <div class="layui-input-inline">
                                    <input type="text" class="layui-input" id="month" value="{$date}" placeholder="{$date}">
                                  </div>
                                <span class="ant-calendar-picker-icon"></span>
                            </div>
                        </span>
                        <span id="dans" class="fr">单位：{$today['count']}书币</span>
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
                                                    </colgroup>
                                                    <thead class="ant-table-thead">
                                                    <tr>
                                                        <th style="text-align: center" class="">
                                                            <span>作品ID</span>
                                                        </th>
                                                        <th style="text-align: center" class="">
                                                            <span>作品名称</span>
                                                        </th>
                                                        <th style="text-align: center" class="">
                                                            <span>收入类型</span>
                                                        </th>
                                                        <th style="text-align: center" class="">
                                                            <span>收入金额(书币)</span>
                                                        </th>
                                                    </tr>

                                                    </thead>
                                                    <tbody class="ant-table-tbody">
                                                    <volist name="today" id="vo">
                                                        <div class="library-list">
                                                            <tr>
                                                                <td style="text-align: center">{$vo.b_id}</td>
                                                                <td style="text-align: center">{$vo.b_name}</td>
                                                                <td style="text-align: center">
                                                                    {$vo.type}
                                                                </td>
                                                                <td class="sum" style="text-align: center">
                                                                    {$vo.total}
                                                                </td>
                                                            </tr>
                                                        </div>
                                                    </volist>
                                                    </tbody>
                                                </table>
                                            </div>
                                            <if condition="!$today">
                                                <div class="ant-table-placeholder">暂无数据</div>
                                            </if>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
        </div>
        <footer class="text-center">Copyright © 2017-2018 {$site_name} All Rights Reserved</footer>
    </div>
</div>
<script src="/public/layer/layer.js"></script>
<script src="/public/layui/layui.js"></script>
<script>
    layui.use('laydate', function() {
        var laydate = layui.laydate;
        //常规用法
        laydate.render({
            elem: '#month',
            type: 'month',
            istime: true, //必须填入时
            done:function(value){
                $.ajax({
                    url:"{:url('users/monthly')}",
                    data:{"date":value},
                    type:"POST",
                    success:function(req){
                        var c = JSON.parse(req);
                        if (c.status == 0){
                            $('.ant-table-tbody').html('');
                            $('#dans').html('单位:0书币');
                            layer.msg(c.msg, { offset: '300px' });return;
                        }
                        if (c.status == 1){
                            $('.ant-table-tbody').html('');
                            $('.ant-table-placeholder').html('');
                            var book = c.data.book;
                            var sum = c.data.count;
                            $('#dans').html('单位:'+sum+'书币');
                            var html = '';
                            for (var x in book) {
                                html +=
                                    '<tr>'+
                                    '<td style="text-align: center">'+book[x].b_id+'</td>'+
                                    '<td style="text-align: center">'+book[x].b_name+'</td>'+
                                    '<td style="text-align: center">'+book[x].type+
                                    '</td>'+
                                    '<td style="text-align: center">'+book[x].total+
                                    '</td>'+
                                    '</tr>'
                            }
                            $('.ant-table-tbody').append(html);
                        }
                    }
                });
            }
        });

    })


</script>

</body>