<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>修改头像</title>
    <link href="css/app_f7319b21.css" rel="stylesheet">
    <style>
        .avatar-wrap .preview-avatar img.addimg{
            width: 254px;
            margin: 0 auto;
        }
    </style>
</head>
<body style="font-size: 12px;"><!--[if lt IE 10]>
<![endif]-->
<div id="root">
    <div class="user-manage-wrap">
        <include file="common:info_header"/>
        <section class="main-wrap">
            <include file="common:info_left"/>
            <div class="avatar-wrap">
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
                                             style="display: block; transform: translate3d(120px, 0px, 0px); width: 88px;"></div>
                                        <div role="tab" aria-disabled="false" aria-selected="false"
                                             class=" ant-tabs-tab">
                                            <a href="{:url('info/baseInfo')}">基本信息</a>
                                        </div>
                                        <div role="tab" aria-disabled="false" aria-selected="true"
                                             class="ant-tabs-tab-active ant-tabs-tab">修改头像
                                        </div>
                                        <div role="tab" aria-disabled="false" aria-selected="false"
                                             class=" ant-tabs-tab"><a href="{:url('info/updatePwd')}">修改密码</a></div>
                                        <div role="tab" aria-disabled="false" aria-selected="false"
                                             class=" ant-tabs-tab"><a href="{:url('info/bind')}">账号绑定</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="ant-tabs-content ant-tabs-content-animated" style="margin-left: -100%;">
                        <div role="tabpanel" aria-hidden="true"
                             class="ant-tabs-tabpane ant-tabs-tabpane-inactive"></div>
                        <div role="tabpanel" aria-hidden="false" class="ant-tabs-tabpane ant-tabs-tabpane-active"></div>
                        <div role="tabpanel" aria-hidden="true"
                             class="ant-tabs-tabpane ant-tabs-tabpane-inactive"></div>
                        <div role="tabpanel" aria-hidden="true"
                             class="ant-tabs-tabpane ant-tabs-tabpane-inactive"></div>
                    </div>
                </div>
                <div class="ant-row ant-form-item ant-form-item-with-help" style="margin-top: 50px;">
                    <div class="ant-col-3 ant-form-item-label">
                        <label class="" title="选择本地图片">选择本地图片</label>
                    </div>
                    <div class="ant-form-item-control-wrapper">
                        <div class="ant-form-item-control">
                            <span class="ant-form-item-children">
                                <input name="user-avatar" disabled="" id="pic1" type="text" class="ant-input ant-input-disabled" value="" style="width: 340px;">
                                <button type="button"  class="ant-btn" style="margin-left: 20px;">
                                    <span>浏览...</span>
                                </button>

                                    <input class="upload-input" id="pic" name="uplodePhoto" type="file" accept=".png, .jpg, .jpeg, .gif">

                            </span>
                            <div class="ant-form-explain">支持JPG、PNG、GIF、JPEG，单张图片大小不超过2M，建议尺寸不低于120*120像素</div>
                        </div>
                    </div>
                </div>
                <div class="ant-row ant-form-item" style="margin-top: 40px;">
                    <div class="ant-col-3 ant-form-item-label"><label class="" title="效果预览">效果预览</label>
                    </div>
                    <div class="ant-form-item-control-wrapper">
                        <div class="ant-form-item-control">
                            <span class="ant-form-item-children">
                                <div class="preview-avatar" style="background-image: url(&quot;null&quot;);">
                                    <img id="pics" class=" " src="images/xia9w.png">
                                </div>
                            </span>
                        </div>
                    </div>
                </div>
                <div class="ant-row ant-form-item" style="margin-top: 30px;">
                    <div class="ant-col-4 ant-col-offset-3 ant-form-item-control-wrapper">
                        <div class="ant-form-item-control">
                            <span class="ant-form-item-children">
                                <button id="save" type="button" class="ant-btn ant-btn-primary ant-btn-lg" style="width: 100%;">
                                    <span class="ant-btn-lg">确定修改</span>
                                </button>
                            </span>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <footer class="text-center">Copyright © 2017-2018 {$site_name} All Rights Reserved</footer>
    </div>
</div>

<script>
    //更换头像
    $('#pic').change(function()
    {
        $.ajaxFileUpload({
            url:'uplodePhoto',//用于文件上传的服务器端请求地址
            secureuri:false ,//一般设置为false
            fileElementId:'pic',//文件上传控件的id属性  <input type="file" id="upload" name="upload" />
            dataType: 'JSON',//返回值类型 一般设置为json
            success:function(data){
                var obj = $.parseJSON(data);
                if(obj.status){
                    data = obj.data;
                    $("#pics").addClass('addimg');
                    $("#pics").attr("src",data);
                    $("#pic1").val(data);
                    return false;
                }
                layer.msg(obj.msg);
                return false;
            }
        });
    });

    $('#save').click(function () {
        var image = $('#pic1').val();
        if (image == ''){
            layer.msg('您还没有选择图片');return false;
        }
        $.ajax({
            url:"{:url('info/avatar')}",
            data:{"image":image},
            type:"POST",
            success:function(req){
                var c = JSON.parse(req);
                if (c.status == 0){
                    layer.alert(req.msg); return false;
                }
                if (c.status == 1){
                    layer.msg('更新成功');
                    setTimeout(function(){ window.location.reload(); }, 1000);
                }
            }
        });
    })
</script>
<script src="js/ajaxfileupload.js"></script>
</body>