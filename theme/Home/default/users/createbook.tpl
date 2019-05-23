<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>创作平台</title>
    <link href="css/app_1f306cd5.css?" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="css/0_8b3eb11c.css">
    <script src="/public/admin/default/js/jquery-1.9.1.js"></script>
    <script src="/public/vend/laydate/laydate.js"></script>

    <style>
        #pic{
            position: absolute;
            left: 0;
            top: 0;
            width: 90px;
            height: 90px;
            display: block;
            opacity: 0;
        }
    </style>
</head>

<body><!--[if lt IE 10]>
<![endif]-->
<div id="root">
    <div class="app-wrap">
        <include file="common:users_header"/>
        <div class="main-wrap">
            <include file="common:users_nav"/>
            <section class="main-content">
                <div class="create-book-wrap"><h2 class="title">创建作品</h2>

                    <div class="step-1">
                        <div class="ant-row ant-form-item ant-form-item-with-help" style="margin-bottom: 30px;">
                            <div class="ant-col-2 ant-col-offset-5 ant-form-item-label">
                                <label class="ant-form-item-required" title="作品名称">作品名称</label>
                            </div>
                            <div class="ant-col-11 ant-form-item-control-wrapper" style="margin-left: 10px;">
                                <div class="ant-form-item-control">
                                    <span class="ant-form-item-children">
                                        <input type="text" id="name" class="ant-input ant-input-lg" value="">
                                    </span>
                                    <div class="ant-form-explain">15字内，请勿添加书名号等特殊符号</div>
                                </div>
                            </div>
                        </div>
                        <div class="ant-row ant-form-item" style="margin-bottom: 30px;">
                            <div class="ant-col-2 ant-col-offset-5 ant-form-item-label">
                                <label class="ant-form-item-required" title="作品类型">作品类型</label>
                            </div>
                            <div class="ant-col-11 ant-form-item-control-wrapper" style="margin-left: 10px;">
                                <div class="ant-form-item-control">
                                    <span class="ant-form-item-children">
                                        <div class="ant-select-lg ant-select ant-select-enabled" style="width: 140px;">
                                            <select id="category" style="width: 150px;" class="ant-select-selection ant-select-selection--single">
                                              <option  value ="0">请选择</option>
                                                <zhimeng table="book_category" where="['status','=',1]">
                                                <option value ="{$r.id}">{$r.name}</option>
                                                </zhimeng>
                                            </select>
                                        </div>
                                    </span>
                                </div>
                            </div>
                        </div>
                        <div class="ant-row ant-form-item" style="margin-bottom: 30px;">
                            <div class="ant-col-2 ant-col-offset-5 ant-form-item-label">
                                <label class="ant-form-item-required" title="授权">授权</label>
                            </div>
                            <div class="ant-col-11 ant-form-item-control-wrapper" style="margin-left: 10px;">
                                <div class="ant-form-item-control">
                                    <span class="ant-form-item-children">
                                        <div class="ant-radio-group">

                                            <label name="type" class="ant-radio-wrapper ant-radio-wrapper-checked">
                                                    <span class="ant-radio ">
                                                        <input type="radio" class="ant-radio-input" value="1">
                                                        <span class="ant-radio-inner"></span>
                                                    </span>
                                                <span>独家首发</span>
                                            </label>
                                            <label name="type" class="ant-radio-wrapper">
                                                    <span class="ant-radio">
                                                        <input type="radio" class="ant-radio-input" value="2">
                                                        <span class="ant-radio-inner"></span>
                                                    </span>
                                                <span>驻站作品</span>
                                            </label>

                                        </div>
                                    </span>
                                </div>
                            </div>
                        </div>
                        <div class="ant-row ant-form-item ant-form-item-with-help" style="margin-bottom: 30px;">
                            <div class="ant-col-2 ant-col-offset-5 ant-form-item-label">
                                <label class="ant-form-item-required" title="作品介绍">作品介绍</label>
                            </div>
                            <div class="ant-col-11 ant-form-item-control-wrapper" style="margin-left: 10px;">
                                <div class="ant-form-item-control">
                                    <span class="ant-form-item-children">
                                        <textarea id="info" rows="4" class="ant-input" style="resize: none;"></textarea>
                                    </span>
                                    <div class="ant-form-explain">20-300字</div>
                                </div>
                            </div>
                        </div>
                        <div class="ant-row ant-form-item ant-form-item-with-help" style="margin-bottom: 30px;">
                            <div class="ant-col-2 ant-col-offset-5 ant-form-item-label">
                                <label class="" title="封面">封面</label>
                            </div>
                            <div class="ant-col-11 ant-form-item-control-wrapper" style="margin-left: 10px;">
                                <div class="ant-form-item-control">
                                    <div class="upload_button">
                                        <input type="hidden" style="float:left;" name="" class="vtip" id="pic1" value="{$data['image']}" />
                                        <span class="ant-form-item-children">
                                            <span class="">
                                                <div style=" position: relative;" class="ant-upload ant-upload-select ant-upload-select-text">
                                                    <span tabindex="0" class="ant-upload" role="button">
                                                        <img src="images/7e0wy.png" style="width: 90px; cursor: pointer; vertical-align: sub;" id="pics" >
                                                        <input id="pic" type="file" name="uplodePhoto" class="img_file upimg"/>
                                                    </span>
                                                </div>
                                            </span>
                                        </span>
                                    </div>
                                    <div class="ant-form-explain">图片尺寸600*800像素, 不超过3M的图片</div>
                                </div>
                            </div>
                        </div>
                        <div class="ant-row ant-form-item">
                            <div class="ant-col-offset-7 ant-form-item-control-wrapper">
                                <div class="ant-form-item-control">
                                    <span class="ant-form-item-children">
                                        <button type="button" class="ant-btn ant-btn-primary ant-btn-lg" style="width: 160px; margin-left: 10px;">
                                            <span>提交创建</span>
                                        </button>
                                        <a style="color: rgb(119, 128, 144); margin-left: 20px;" onclick="javascript:history.back(-1);">返回上一步</a>
                                    </span>
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
<script>
    $('.ant-radio-group label').on('click',function () {
        $(this).addClass('ant-radio-wrapper-checked').siblings().removeClass('ant-radio-wrapper-checked');
        $(this).find('span.ant-radio').addClass('ant-radio-checked').parents('label').siblings('label').find('span.ant-radio').removeClass('ant-radio-checked');
        $(this).find("input.ant-radio-input").attr("checked",true).parents('label').siblings('label').find("input.ant-radio-input").attr("checked",false)
    });


    //更换头像
    $("#pics").click(function()
    {
        $('#pic').trigger('click');
        return false;
    });
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
                console.log(obj.data);
                if(obj.status){
                    data = obj.data;
                    $("#pics").attr("src",data);
                    $("#pic1").val(data);
                    return false;
                }
                layer.msg(obj.msg);
                return false;
            }
        });
    });
</script>
<script>
    $('.ant-btn-lg').click(function () {
        var name = $('#name').val();
        var cid = $("#category option:selected").val();
        var type = $("input[type='radio']:checked").val();
        var info = $('#info').val();
        var image = $('#pic1').val();
        if (name.length > 15){
            layer.msg('书名字数不得超过15字'); return false;
        }
        if (cid == 0){
            layer.msg('请选择书籍类型'); return false;
        }
        if (type == undefined){
            layer.msg('请选择授权'); return false;
        }
        if (info == ''){
            layer.msg('请填写作品介绍'); return false;
        }
        if (info.length > 300 || info.length < 20){
            layer.msg('作品介绍应在20-300字以内'); return false;
        }
        if (image == ''){
            layer.msg('请选择作品封面'); return false;
        }
        $.ajax({
            url:"{:url('users/createbook')}",
            data:{"name":name,"cid":cid,"type":type,"info":info,"image":image},
            type:"POST",
            success:function(req){
//                console.log(c);return;
                if (req.code == 0){
                    layer.msg(req.msg); return false;
                }
                if (req.code == 1){
                    setTimeout(function(){ window.location.href = "{:url('users/succ')}"+'&id='+req.data; }, 0000);
                }
            }
        });
    })

</script>
<script src="js/ajaxfileupload.js"></script>
</body>