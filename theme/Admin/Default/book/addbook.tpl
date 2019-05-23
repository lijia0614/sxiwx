
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
                <h3>添加书籍</h3>
                <h5>添加书籍内容</h5>
            </div>

        </div>
    </div>
    <div class="common-form">
        <if condition="isset($id)">
            <form action="{:url(SYS_PATH."/book/addbook")}" method="post" class="formvalidate" id="DataFromSubmit" isajax="true">
                <input type="hidden" name="id" value="{$id}" />
                <else />
                <form action="{:url(SYS_PATH."/book/addbook")}" method="post" class="formvalidate" id="DataFromSubmit" isajax="true">
        </if>

        <fieldset>
            <table width="100%" class="table_form">
                <tbody class="maincont">
                <tr>
                    <td width="12%">书籍分类</td>
                    <td>
                        <select name="category">
                            <zhimeng table="book_category" where="[['status','=',1],['is_del','=',0]]" >
                                <option <if condition="$r['id'] eq $data['cid']"> selected </if> value="{$r['id']}">{$r.name}</option>
                            </zhimeng>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td width="12%">书籍名称</td>
                    <td><input type="text" id="name"  style="width:200px;" class="input-text" datatype="*" nullmsg="请输入标题" value="{$data['name']}" name="name" placeholder="请输入书籍名称" /> <span id="messageBox" for="name" generated="true" class="Validform_checktip onShow ">请输入书籍名称</span> </td>
                </tr>

                <tr id="price">
                    <td width="12%">书籍整本价格</td>
                    <td><input type="number" id="price"  style="width:150px;" class="input-text" nullmsg="书籍整本价格" value="{$data['price']}" name="price" placeholder="书籍整本价格" /> <span id="messageBox" for="name" generated="true" class="Validform_checktip onShow ">书籍整本价格，不选择请不填</span> </td>
                </tr>

                <tr id="price_num">
                    <td width="12%">收费节点(章节数)</td>
                    <td><input type="number" id="node"  style="width:150px;" class="input-text"  nullmsg="收费节点(章节数)" value="{$data['node']}" name="node" placeholder="收费节点(章节数)" /> <span id="messageBox" for="name" generated="true" class="Validform_checktip onShow ">收费节点(章节数，不选择请不填)</span> </td>
                </tr>

                <tr>
                    <td>书籍封面：</td>
                    <td>
                        <div class="upload_button">
                            <input type="text" style="float:left;" name="image" class="vtip" data-img="{:isset($data['image'])?$data['image']:''}" value="{$data['image']}" id="image" />
                            <a class="file" href="javascript:;">选择封面<input type="file" name="up_image[]" id="up_image" module-name="Goods"  fields-name="image" class="img_file upimg" upkey="image" /></a>
                            <span id="messageBox" for="title" generated="true" class=" Validform_checktip onShow " style="margin-top:5px;">书籍封面</span>
                        </div>
                    </td>
                </tr>

                <tr>
                    <td width="12%">书籍作者</td>
                    <td><input type="text" id="author"  style="width:150px;" class="input-text" datatype="*" nullmsg="请输入作者" value="{$data['author']}" name="author" placeholder="请输入书籍作者" /> <span id="messageBox" for="name" generated="true" class="Validform_checktip onShow ">请输入书籍作者</span> </td>
                </tr>

                <tr>
                    <td style="height: 30px">作品类型</td>

                    <td style="height: 30px;position: absolute;">
                        <input style="position: relative;top: 2px;" type="radio" name="type" value="1" title="独家首发" <if condition="$data['type'] eq 1">checked</if> >
                        <span style="height: 30px;line-height: 30px;">独家首发</span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <input style="position: relative;top: 2px;" type="radio" name="type" value="2" title="驻站作品" <if condition="$data['type'] eq 2">checked</if>  >
                        <span style="height: 30px;line-height: 30px;">驻站作品</span>
                    </td>
                </tr>

                <tr>
                    <td>内容简介</td>
                    <td>
                        <textarea style="width:550px; height:100px;"  name="info" id="info">{:isset($data['info'])&&$data['info']?$data['info']:''}</textarea> </td>
                </tr>


                <tr>
                    <td width="12%">排序</td>
                    <td><input type="text" id="sort" class="input-text" style="width:80px;" value="{:isset($data['sort'])&&$data['sort']?$data['sort']:'1'}" name="sort" placeholder="排序" /> <span id="messageBox" for="title" generated="true" class="onShow Validform_checktip">数字越小，排名越前</span> </td>
                </tr>

                <tr>
                    <td>是否推荐：</td>
                    <td>
                        <div class="onoff">
                            <label for="site_status1" class="cb-enable <if condition="$data['is_recommend'] eq 1">selected</if>">是</label>
                            <label for="site_status0" class="cb-disable <if condition="($data['is_recommend']==0)||empty($data['is_recommend'])">selected</if>">否</label>
                            <input id="site_status1" name="is_recommend" <if condition="$data['is_recommend'] eq 1">checked="checked"</if> value="1" type="radio">
                            <input id="site_status0" name="is_recommend" value="0" type="radio" <if condition="($data['is_recommend']==0)||empty($data['is_recommend'])">checked="checked"</if>>
                            <span id="messageBox" for="title" generated="true" class="onShow Validform_checktip">数量不能超过8个</span>
                        </div>
                    </td>
                </tr>

                <tr>
                    <td>首页轮播展示：</td>
                    <td>
                        <div class="onoff">
                            <label for="is_index1" class="cb-enable <if condition="$data['is_index'] eq 1">selected</if>">是</label>
                            <label for="is_index0" class="cb-disable <if condition="($data['is_index']==0)||empty($data['is_index'])">selected</if>">否</label>
                            <input id="is_index1" name="is_index" <if condition="$data['is_index'] eq 1">checked="checked"</if> value="1" type="radio">
                            <input id="is_index0" name="is_index" value="0" type="radio" <if condition="($data['is_index']==0)||empty($data['is_index'])">checked="checked"</if>>
                            <span id="messageBox" for="title" generated="true" class="onShow Validform_checktip">数量不能超过5个</span>
                        </div>

                    </td>
                </tr>

                <tr>
                    <td>是否精品：</td>
                    <td>
                        <div class="onoff">
                            <label for="is_fine1" class="cb-enable <if condition="$data['is_fine'] eq 1">selected</if>">是</label>
                            <label for="is_fine0" class="cb-disable <if condition="($data['is_fine']==0)||empty($data['is_fine'])">selected</if>">否</label>
                            <input id="is_fine1" name="is_fine" <if condition="$data['is_fine'] eq 1">checked="checked"</if> value="1" type="radio">
                            <input id="is_fine0" name="is_fine" value="0" type="radio" <if condition="($data['is_fine']==0)||empty($data['is_fine'])">checked="checked"</if>>

                        </div>

                    </td>
                </tr>


                <tr>
                    <td>是否原创：</td>
                    <td>
                        <div class="onoff">
                            <label for="is_original1" class="cb-enable <if condition="$data['is_original'] eq 1">selected</if>">是</label>
                            <label for="is_original0" class="cb-disable <if condition="($data['is_original']==0)||empty($data['is_original'])">selected</if>">否</label>
                            <input id="is_original1" name="is_original" <if condition="$data['is_original'] eq 1">checked="checked"</if> value="1" type="radio">
                            <input id="is_original0" name="is_original" value="0" type="radio" <if condition="($data['is_original']==0)||empty($data['is_original'])">checked="checked"</if>>
                        </div>
                    </td>
                </tr>

                <tr>
                    <td>是否大神推荐：</td>
                    <td>
                        <div class="onoff">
                            <label for="is_okami1" class="cb-enable <if condition="$data['is_okami'] eq 1">selected</if>">是</label>
                            <label for="is_okami0" class="cb-disable <if condition="($data['is_okami']==0)||empty($data['is_okami'])">selected</if>">否</label>
                            <input id="is_okami1" name="is_okami" <if condition="$data['is_okami'] eq 1">checked="checked"</if> value="1" type="radio">
                            <input id="is_okami0" name="is_okami" value="0" type="radio" <if condition="($data['is_okami']==0)||empty($data['is_okami'])">checked="checked"</if>>
                        </div>
                    </td>
                </tr>

                <tr>
                    <td>是否完结：</td>
                    <td>
                        <div class="onoff">
                            <label for="is_end1" class="cb-enable <if condition="$data['is_end'] eq 1">selected</if>">是</label>
                            <label for="is_end0" class="cb-disable <if condition="($data['is_end']==0)||empty($data['is_end'])">selected</if>">否</label>
                            <input id="is_end1" name="is_end" <if condition="$data['is_end'] eq 1">checked="checked"</if> value="1" type="radio">
                            <input id="is_end0" name="is_end" value="0" type="radio" <if condition="($data['is_end']==0)||empty($data['is_end'])">checked="checked"</if>>
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