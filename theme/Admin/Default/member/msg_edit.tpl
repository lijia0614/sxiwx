
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
                <h3>评论详情</h3>
            </div>
        </div>
    </div>
    <div class="common-form">
        <if condition="isset($id)">
            <form action="{:url(SYS_PATH."/member/msgEdit",array('id'=>$id))}" method="post" class="formvalidate" id="DataFromSubmit" isajax="true">
                <input type="hidden" name="id" value="{$id}" />
                <else />
                <form action="{:url(SYS_PATH."/member/msgEdit",array('id'=>$id))}" method="post" class="formvalidate" id="DataFromSubmit" isajax="true">
        </if>

        <fieldset>
            <table width="100%" class="table_form">
                <tbody class="maincont">

                <tr>
                    <td width="16%">用户信息</td>
                    <td>
                        <input readonly style="width:200px;" class="input-text" value="{$data['phone']}"/>
                        <span id="messageBox" for="name" generated="true" class="Validform_checktip onShow ">
                            用户信息不可编辑
                        </span>
                    </td>
                </tr>

                <tr>
                    <td width="16%">书籍信息</td>
                    <td>
                        <input  style="width:200px;" name="qq" class="input-text" value="{$data['book']}"/>
                    </td>
                </tr>
                <tr>
                    <td>内容详情：</td>
                    <td>
                        <textarea style="width:370px; height:50px;"  datatype="*"  name="content" id="content">{$data['content']}</textarea> <span id="messageBox" for="title" generated="true" class="Validform_checktip onShow ">内容详情</span></td>
                </tr>



                <tr>
                    <td width="16%">评论时间</td>
                    <td>
                        <input readonly  style="width:200px;" name="address" class="input-text" value="{$data.time|date='Y-m-d H:i'}"/>
                    </td>
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