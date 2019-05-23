<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>创作平台</title>
    <link href="css/app_1f306cd5.css" rel="stylesheet">
</head>
<body><!--[if lt IE 10]>
<script src="js/leie9.js"></script><![endif]-->
<!--[if lte IE 11]>
<script src="https:js/es6-shim.min.js"></script>
<![endif]-->
<div id="root">
    <div class="app-wrap">
        <include file="common:users_header"/>
        <div class="main-wrap">
            <include file="common:users_nav"/>
            <section class="main-content">
                <div class="writer-info-wrap">
                    <h2 class="title" style="margin-bottom: 50px;">作家资料</h2>
                    <div class="ant-row ant-form-item" style="margin-bottom: 16px;">
                        <div class="ant-col-2 ant-col-offset-6 ant-form-item-label">
                            <label class="" title="作者ID">作者ID</label>
                        </div>
                        <div class="ant-col-10 ant-form-item-control-wrapper">
                            <div class="ant-form-item-control">
                                <span class="ant-form-item-children">
                                    <input disabled="" type="text"  class="ant-input ant-input-lg ant-input-disabled" value="{$data['id']}">
                                </span>
                            </div>
                        </div>
                    </div>
                    <div class="ant-row ant-form-item" style="margin-bottom: 16px;">
                        <div class="ant-col-2 ant-col-offset-6 ant-form-item-label">
                            <label class="" title="笔名">笔名</label>
                        </div>
                        <div class="ant-col-10 ant-form-item-control-wrapper">
                            <div class="ant-form-item-control">
                                <span class="ant-form-item-children">
                                    <input type="text" class="ant-input ant-input-lg ant-input-disabled" value="{$data['pen_name']}">
                                </span>
                            </div>
                        </div>
                    </div>
                    <div class="ant-row ant-form-item" style="margin-bottom: 16px;">
                        <div class="ant-col-2 ant-col-offset-6 ant-form-item-label">
                            <label class="" title="QQ">QQ</label>
                        </div>
                        <div class="ant-col-10 ant-form-item-control-wrapper">
                            <div class="ant-form-item-control">
                                <span class="ant-form-item-children">
                                    <input placeholder="请输入QQ号" type="text" class="ant-input ant-input-lg ant-input-disabled" value="{$data['qq']}">
                                </span>
                            </div>
                        </div>
                    </div>
                    <div class="ant-row ant-form-item" style="margin-bottom: 16px;">
                        <div class="ant-col-2 ant-col-offset-6 ant-form-item-label">
                            <label class="" title="微信">微信</label>
                        </div>
                        <div class="ant-col-10 ant-form-item-control-wrapper">
                            <div class="ant-form-item-control">
                                <span class="ant-form-item-children">
                                    <input placeholder="请输入微信号（选填）" type="text" class="ant-input ant-input-lg ant-input-disabled" value="{$data['wechat']}">
                                </span>
                            </div>
                        </div>
                    </div>
                    <div class="ant-row ant-form-item" style="margin-bottom: 16px;">
                        <div class="ant-col-2 ant-col-offset-6 ant-form-item-label">
                            <label class="" title="真实姓名">真实姓名</label>
                        </div>
                        <div class="ant-col-10 ant-form-item-control-wrapper">
                            <div class="ant-form-item-control">
                                <span class="ant-form-item-children">
                                    <input disabled="" type="text" class="ant-input ant-input-lg ant-input-disabled" value="{$data['name']}">
                                </span>
                            </div>
                        </div>
                    </div>
                    <div class="ant-row ant-form-item" style="margin-bottom: 16px;">
                        <div class="ant-col-2 ant-col-offset-6 ant-form-item-label">
                            <label class="" title="身份证号">身份证号</label>
                        </div>
                        <div class="ant-col-10 ant-form-item-control-wrapper">
                            <div class="ant-form-item-control">
                                <span class="ant-form-item-children">
                                    <input disabled="" type="text" class="ant-input ant-input-lg ant-input-disabled" value="{$data['id_num']}"></span>
                            </div>
                        </div>
                    </div>
                    <div class="ant-row ant-form-item" style="margin-bottom: 16px;">
                        <div class="ant-col-2 ant-col-offset-6 ant-form-item-label">
                            <label class="" title="详细地址">详细地址</label>
                        </div>
                        <div class="ant-col-10 ant-form-item-control-wrapper">
                            <div class="ant-form-item-control">
                                <span class="ant-form-item-children">
                                    <textarea rows="4" placeholder="请输入详细地址" class="ant-input ant-input-disabled" style="resize: none;">{$data['address']}</textarea>
                                </span>
                            </div>
                        </div>
                    </div>
                    <div class="ant-row ant-form-item">
                        <div class="ant-col-offset-8 ant-form-item-control-wrapper">
                            <div class="ant-form-item-control">
                                <span class="ant-form-item-children">
                                   <button type="button" class="ant-btn ant-btn-lg" style="width: 160px;">
                                       <span>修改资料</span>
                                   </button>
                                </span>
                            </div>
                        </div>
                    </div>
                    <div class="ant-row">
                        <div class="ant-col-offset-8"><span style="color: rgb(160, 165, 174);">提示：如需修改笔名、真实姓名、身份证号，请联系小编进行修改。</span>
                        </div>
                    </div>
                </div>
            </section>
        </div>
        <footer class="text-center">Copyright © 2017-2018 {$site_name} All Rights Reserved</footer>
    </div>
</div>

<script>
    $('.ant-btn-lg').click(function () {
        setTimeout(function(){ window.location.href = "{:url('users/editWriter')}"; }, 0);
    })
</script>
</body>