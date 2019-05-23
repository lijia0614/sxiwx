
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
    var editor = K.editor({
      allowFileManager: true
    });
  });
</script>

 </head> 
<body>
  <input type="hidden" name="current_load_url" id="current_load_url" value="" /> 
  <div class="pad-10"> 
   <div class="common-form"> 
   <if condition="isset($id)">
    <form action="{:url(SYS_PATH."/".CONTROLLER."/editType")}" method="post" class="formvalidate" id="DataFromSubmit" isajax="true">
    <input type="hidden" name="id" value="{$id}" />
   <else />
   	<form action="{:url(SYS_PATH."/".CONTROLLER."/editType")}" method="post" class="formvalidate" id="DataFromSubmit" isajax="true">
    <input type="hidden" name="model" value="{:strtolower(CONTROLLER)}" /> 
   </if>
     
     <fieldset> 
      <legend>填写信息</legend> 
      <table width="100%" class="table_form"> 
       <tbody> 

        <tr> 
         <td width="12%">风格名称</td>
         <td><input type="text" id="title"  style="width:300px;" class="input-text topinyin" datatype="*" value="{$data['title']}" name="title" placeholder="请输入风格名称" /><span id="messageBox" for="name" generated="true" class="Validform_checktip onShow ">风格名称</span> </td>
        </tr>


        <tr> 
         <td width="12%">排序</td> 
         <td><input type="text" id="sort" class="input-text" style="width:80px;" value="{$data['sort']}" name="sort" placeholder="排序" /> <span id="messageBox" for="title" generated="true" class="onShow ">数字越小，排名越前</span> </td>
        </tr>          
      

       </tbody>
      </table> 
     </fieldset> 
     <input type="hidden" name="dialogid" id="dialogid" value="" /> 
     <input type="submit" style="display:none;" name="dosubmit" id="dosubmit" value=" 提交 " /> 
    </form> 
   </div> 
  </div>  
 </body>
</html>