
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
                items: ["source", "undo", "redo", "preview", "cut","copy", "paste", "plainpaste", "wordpaste", "justifyleft", "justifycenter", "justifyright", "justifyfull", "indent", "outdent", "subscript", "superscript", "clearhtml","quickformat", "selectall", "|", "fullscreen", "formatblock", "fontname", "fontsize","forecolor", "strikethrough", "lineheight","removeformat",  "hr"],
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
                <h3>书籍名称：{$data['b_name']}</h3>
            </div>

        </div>
    </div>
    <div class="common-form">
       <form action="{:url(SYS_PATH."/book/chapteredit",array('id'=>$data['id']))}" method="post" class="formvalidate" id="DataFromSubmit" isajax="true">

        <fieldset>
            <table width="100%" class="table_form">
                <tbody class="maincont">
                <!--
                <tr>
                    <td width="12%">章节数</td>
                    <td><input type="text" id="number" style="width:200px;" class="input-text" datatype="*"  value="{$data['number']}" readonly="readonly" name="number"  /> <span id="messageBox" for="number" generated="true" class="Validform_checktip onShow ">章节数不可更改</span> </td>
                </tr>
                -->
                <tr>
                    <td width="12%">章节名称</td>
                    <td><input type="text" id="name" style="width:200px;" class="input-text" datatype="*"  value="{$data['name']}"  name="name"  /> <span id="messageBox" for="name" generated="true" class="Validform_checktip onShow ">请填写章节名称</span> </td>
                </tr>
                <input type="hidden" name="b_id" id="b_id" value="{$data['b_id']}"/>
                <tr>
                    <td>内容详情</td>
                    <td>
                        <textarea style="width:750px; height:500px;" class="editor" name="content" id="content">{:isset($data['content'])&&$data['content']?$data['content']:''}</textarea> </td>
                </tr>

                <tr>
                    <td>作者有话说</td>
                    <td>
                        <textarea style="width:750px; height:25px;" class="editor" name="say" id="content">{:isset($data['say'])&&$data['say']?$data['say']:''}</textarea> </td>
                </tr>
                <tr>
                    <td>是否通过审核：</td>
                    <td>
                        <div class="onoff">
                            <label for="site_status1" class="cb-enable <if condition="$data['status'] eq 1">selected</if>">是</label>
                            <label for="site_status0" class="cb-disable <if condition="($data['status']==0)||empty($data['status'])">selected</if>">否</label>
                            <input id="site_status1" name="status" <if condition="$data['status'] eq 1">checked="checked"</if> value="1" type="radio">
                            <input id="site_status0" name="status" value="0" type="radio" <if condition="($data['status']==0)||empty($data['status'])">checked="checked"</if>>
                        </div>
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