
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
                <h3>古风歌词管理</h3>
                <h5>编缉内容</h5>
            </div>
        </div>
    </div>
    <div class="common-form">
        <if condition="isset($id)">
            <form action="{:url(SYS_PATH."/cartoon/edit",array('id'=>$id))}" method="post" class="formvalidate" id="DataFromSubmit" isajax="true">
                <input type="hidden" name="id" value="{$id}" />
                <else />
                <form action="{:url(SYS_PATH."/cartoon/add")}" method="post" class="formvalidate" id="DataFromSubmit" isajax="true">
        </if>

        <fieldset>
            <table width="100%" class="table_form">
                <tbody class="maincont">
                <tr>
                    <td width="12%">书籍分类</td>

                    <td>
                        <select name="cid">
                            <zhimeng table="poetry_category" where="[['status','=',1]]" >
                                <option <if condition="$r['id'] eq $data['cid']"> selected </if> value="{$r['id']}">{$r.title}</option>
                            </zhimeng>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td width="12%">名称</td>
                    <td>
                        <input type="text" id="title"  style="width:300px;" class="input-text" datatype="*" nullmsg="请输入标题" value="{$data['title']}" name="title" placeholder="请输入名称" /> <span id="messageBox" for="title" generated="true" class="Validform_checktip onShow ">请输入名称</span>
                    </td>
                </tr>

                <tr>
                    <td width="12%">诗歌作者</td>
                    <td>
                        <input type="text" id="author"  style="width:300px;" class="input-text" datatype="*" nullmsg="请输入标题" value="{$data['author']}" name="author" placeholder="诗歌作者" /> <span id="messageBox" for="title" generated="true" class="Validform_checktip onShow ">诗歌作者</span>
                    </td>
                </tr>

                <tr>
                    <td>封面：</td>
                    <td>
                        <div class="upload_button">
                            <input type="text" style="float:left;" name="image" class="vtip" data-img="{:isset($data['image'])?$data['image']:''}" value="{$data['image']}" id="image" />
                            <a class="file" href="javascript:;">选择文件<input type="file" name="up_image[]" id="up_image" module-name="Goods"  fields-name="image" class="img_file upimg" upkey="image" /></a>
                            <span id="messageBox" for="title" generated="true" class=" Validform_checktip onShow " style="margin-top:5px;">封面图片</span>
                        </div>
                    </td>
                </tr>

                <tr>
                    <td>诗歌内容</td>
                    <td>
                        <textarea style="width:550px; height:550px;" class="editor" name="content" id="content">{:isset($data['content'])&&$data['content']?$data['content']:''}</textarea> </td>
                </tr>

                <tr>
                    <td width="12%">排序</td>
                    <td><input type="text" id="sort" class="input-text" style="width:80px;" value="{:isset($data['sort'])&&$data['sort']?$data['sort']:'1'}" name="sort" placeholder="排序" /> <span id="messageBox" for="title" generated="true" class="onShow Validform_checktip">数字越小，排名越前</span> </td>
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