
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
                <h3>轮播推荐排序</h3>
                <h5>排序越小显示越靠前</h5>
            </div>

        </div>
    </div>
    <div class="common-form">
        <if condition="isset($id)">
            <form action="{:url(SYS_PATH."/book/editSort",array('id'=>$id))}" method="post" class="formvalidate" id="DataFromSubmit" isajax="true">

                <else />
                <form action="{:url(SYS_PATH."/book/editSort")}" method="post" class="formvalidate" id="DataFromSubmit" isajax="true">
        </if>

        <fieldset>
            <table width="100%" class="table_form">
                <tbody class="maincont">
                <input type="hidden" name="b_id" id="b_id" value="{$data['id']}"/>
                <input type="hidden" name="type" id="type" value="index_sort"/>
                <tr>
                    <td width="16%">书籍名称</td>
                    <td><input type="text" id="name"  style="width:200px;" class="input-text" datatype="*" nullmsg="请输入标题" value="{$data['name']}" name="name" readonly placeholder="请输入书籍名称" /></td>
                </tr>



                <tr id="price_num">
                    <td width="12%">首页轮播推荐排序</td>
                    <td><input type="number" id="sort"  style="width:150px;" class="input-text"  nullmsg="收费节点(章节数)" value="{$data['index_sort']}" name="sort" placeholder="收费节点(章节数)" /> <span id="messageBox" for="name" generated="true" class="Validform_checktip onShow ">数字越小排序越靠前</span> </td>
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