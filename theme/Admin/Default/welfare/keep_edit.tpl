
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title></title>
    <link href="/public/admin/default/css/edit.css" rel="stylesheet" type="text/css" />
    <script src="/public/admin/default/js/jquery-1.9.1.js"></script>
    <script src="/public/vend/Validform/Validform_v5.3.2_min.js"></script>
    <script src="/public/admin/default/js/common.js"></script>
    <script src="/public/vend/kindeditor/kindeditor-min.js" type="text/javascript"></script>
    <script language="javascript" src="/public/admin/default/js/ajaxfileupload.js"></script>
    <script src="/public/vend/laydate/laydate.js"></script>
    <style>
        #FrmContent{height:100%; }
    </style>
    <script language="javascript">
        var editor;
        KindEditor.ready(function(K) {
            editor = K.create('.editor', {
                resizeType: 1,
                allowPreviewEmoticons: false,
                allowImageUpload: false,
                afterBlur: function() {
                    this.sync();
                }
            });
        });
    </script>

</head>
<body>

<input type="hidden" name="current_load_url" id="current_load_url" value="" />
<div class="pad-10">
    <div class="fixed-bar">
        <div class="item-title">
            <div class="subject">
                <h3>续约奖励管理</h3>
                <h5>编缉续约奖励</h5>
            </div>
        </div>
    </div>
    <div class="common-form">
        <form action="{:url(SYS_PATH."/welfare/keepEdit",array('id'=>$id))}" method="post" class="formvalidate" id="DataFromSubmit" isajax="true">
        <fieldset>
            <table width="100%" class="table_form">
                <tbody class="maincont">
                <input type="hidden" name="id" id="id" value="{$data['id']}"/>
                <tr>
                    <td width="12%">模式名称</td>
                    <td><input type="text" id="title"  style="width:300px;" class="input-text" datatype="*" nullmsg="请输入完本字数" value="{$data['title']}" name="title" placeholder="请输入完本字数" /> <span id="messageBox" for="title" generated="true" class="Validform_checktip onShow ">请输入完本字数</span> </td>
                </tr>


                <tr>
                    <td width="12%">奖励金额</td>
                    <td><input type="text" id="info"  style="width:300px;" class="input-text" datatype="*" nullmsg="请输入奖励金额" value="{$data['info']}" name="info" placeholder="请输入奖励金额" /> <span id="messageBox" for="title" generated="true" class="Validform_checktip onShow ">请输入奖励金额</span> </td>
                </tr>

                </tbody>
                <tbody class="maincont none">
                <include file="block::is_seo" />
                </tbody>
            </table>
        </fieldset>
        <input type="hidden" name="dialogid" id="dialogid" value="" />
        <input type="submit" style="display:none;" name="dosubmit" id="dosubmit" value=" 提交 " />
        </form>
    </div>
</div>
<style>
    .none{
        display: none;
    }
</style>
</body>
<script>
    $(".tab-base a").click(function () {
        var index =$(this).parent().index();
        var indexs =$(this).parent().parent();
        indexs.find('a').removeClass("current");
        $(this).addClass("current");
        $(".maincont").addClass("none").eq(index).removeClass("none");
    })
</script>
</html>