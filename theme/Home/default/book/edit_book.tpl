<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>修改设置</title>
    <link href="css/app_1f306cd5.css?" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="css/0_8b3eb11c.css">
    <script charset="utf-8" src="js/0_8b3eb11c.js"></script>
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
<body style=""><!--[if lt IE 10]>
<![endif]-->
<div id="root">
    <div class="app-wrap">
        <include file="common:users_header"/>
        <div class="main-wrap">
            <include file="common:users_nav"/>
            <section class="main-content">
                <include file="common:book_nav"/>
                <div class="book-setting-wrap">
                    <img class="book-cover" id="pics" src="{$book['image']}">
                    <span class="upload-btn">
                        <div class="ant-upload ant-upload-select ant-upload-select-text">
                            <span tabindex="0" class="ant-upload" role="button">

                                <button type="button" class="ant-btn ant-btn-lg" style="width: 150px;">
                                    <span> 修改封面</span>
                                    <input id="pic" type="file" name="uplodePhoto" class="img_file upimg"/>
                                    <input  type="hidden" class="vtip" id="pic1" value="{:isset($data['image'])?$data['image']:$book['image']}" />
                                </button>
                            </span>
                        </div>
                    </span>
                    <div class="detail">
                        <div class="ant-row ant-form-item"
                             style="margin-bottom: 10px; height: 40px; color: rgb(68, 78, 94);">
                            <div class="ant-col-3 ant-col-offset-1 ant-form-item-label">
                                <label class="" title="作品名称">作品名称</label>
                            </div>
                            <div class="ant-col-19 ant-form-item-control-wrapper" style="margin-left: 10px;">
                                <div class="ant-form-item-control">
                                    <span class="ant-form-item-children">
                                        <input type="text" id="name" class="ant-input" value="{$book['name']}"
                                                style="height: 36px; color: rgb(68, 78, 94);">
                                    </span>
                                </div>
                            </div>
                        </div>
                        <div class="ant-row ant-form-item"
                             style="margin-bottom: 10px; height: 40px; color: rgb(68, 78, 94);">
                            <div class="ant-col-3 ant-col-offset-1 ant-form-item-label">
                                <label class="" title="类型">类型</label>
                            </div>
                            <div class="ant-col-19 ant-form-item-control-wrapper" style="margin-left: 10px;">
                                <div class="ant-form-item-control">
                                    <span class="ant-form-item-children">
                                        <div class="ant-select ant-select-enabled" style="width: 140px; color: rgb(68, 78, 94);">
                                            <select style="width: 140px;" id="category" class="aant-select-selection ant-select-selection--single"  role="combobox" aria-autocomplete="list" aria-haspopup="true" aria-expanded="false" tabindex="0">
                                                <zhimeng table="book_category" where="['status','=',1]">
                                                    <option <if condition="$book['cid'] eq $r['id']">selected</if> value ="{$r.id}">{$r.name}</option>
                                                </zhimeng>
                                            </select>
                                        </div>
                                    </span>
                                </div>
                            </div>
                        </div>
                        <div class="ant-row ant-form-item"
                             style="margin-bottom: 10px; height: 40px; color: rgb(68, 78, 94);">
                            <div class="ant-col-3 ant-col-offset-1 ant-form-item-label">
                                <label class="" title="授权类型">授权类型</label>
                            </div>
                            <div class="ant-col-19 ant-form-item-control-wrapper" style="margin-left: 10px;">
                                <div class="ant-form-item-control">
                                    <span class="ant-form-item-children">
                                        <div class="ant-select ant-select-enabled" style="width: 140px; color: rgb(68, 78, 94);">
                                            <select style="width: 140px;" id="type" class="aant-select-selection ant-select-selection--single"  role="combobox" aria-autocomplete="list" aria-haspopup="true" aria-expanded="false" tabindex="0">

                                                <option <if condition="$book['type'] eq 1">selected</if> value ="1">独家首发</option>
                                                <option <if condition="$book['type'] eq 2">selected</if> value ="2">驻站作品</option>

                                            </select>
                                        </div>
                                    </span>
                                </div>
                            </div>
                        </div>
                        <div class="ant-row ant-form-item"
                             style="margin-bottom: 10px; height: 40px; color: rgb(68, 78, 94);">
                            <div class="ant-col-3 ant-col-offset-1 ant-form-item-label">
                                <label class="" title="字数">字数</label>
                            </div>
                            <div class="ant-col-19 ant-form-item-control-wrapper" style="margin-left: 10px;">
                                <div class="ant-form-item-control">
                                    <span class="ant-form-item-children">
                                        <div>{$num}</div>
                                    </span>
                                </div>
                            </div>
                        </div>
                        <div class="ant-row ant-form-item"
                             style="margin-bottom: 10px; height: 40px; color: rgb(68, 78, 94);">
                            <div class="ant-col-3 ant-col-offset-1 ant-form-item-label">
                                <label class="" title="介绍">介绍</label>
                            </div>
                            <div class="ant-col-19 ant-form-item-control-wrapper" style="margin-left: 10px;">
                                <div class="ant-form-item-control">
                                    <span class="ant-form-item-children">
                                        <textarea id="info" rows="4" class="ant-input" style="resize: none; color: rgb(68, 78, 94); padding: 8px 10px;">{$book['info']}</textarea>
                                    </span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <input id="book_id" type="hidden" value="{$book['id']}">
                    <button type="button" class="ant-btn edit-btn ant-btn-primary ant-btn-lg">
                        <span>保存修改</span>
                    </button>
                    <button onclick="javascript:history.back(-1);" type="button" class="ant-btn  edit-btn ant-btn-lg" style="margin-left: 10px;">
                        <span>取 消</span>
                    </button>
                </div>
            </section>
        </div>
        <footer class="text-center">Copyright © 2017-2018 {$site_name} All Rights Reserved</footer>
    </div>
</div>


<div>
    <div class="ant-message"><span></span></div>
</div>
<script>
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
//                console.log(obj.data);
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
    $('.ant-btn-primary').click(function () {
        var image = $('#pic1').val();
        var name = $('#name').val();
        var cid = $("#category option:selected").val();
        var type = $("#type option:selected").val();
        var info = $('#info').val();
        var id =  $('#book_id').val();
        if (name.length > 15){
            layer.alert('书名字数不得超过15字'); return false;
        }
        if (name == ''){
            layer.alert('请填写书名'); return false;
        }
        if (cid == 0){
            layer.alert('请选择书籍类型'); return false;
        }
        if (type == undefined){
            layer.alert('请选择授权'); return false;
        }
        if (info == ''){
            layer.alert('请填写作品介绍'); return false;
        }
        if (info.length > 300 || info.length < 20){
            layer.alert('作品介绍应在20-300字以内'); return false;
        }
        if (image == ''){
            layer.alert('请选择作品封面'); return false;
        }
        $.ajax({
            url:"{:url('book/editBook')}",
            data:{"name":name,"cid":cid,"type":type,"info":info,"image":image,id:id},
            type:"POST",
            success:function(req){

                var c = JSON.parse(req);
                if (c.status == 0){
                    layer.alert(req.msg); return false;
                }
                if (c.status == 1){
                    setTimeout(function(){ window.location.href = "{:url('book/setting')}"+'&id='+c.data; }, 0);
                }
            }
        });
    })

</script>
<script src="js/ajaxfileupload.js"></script>
</body>