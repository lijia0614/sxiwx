
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
    <form action="{:url(SYS_PATH."/".CONTROLLER."/edit",array('id'=>$id))}" method="post" class="formvalidate" id="DataFromSubmit" isajax="true"> 
    <input type="hidden" name="id" value="{$id}" />
   <else />
   	<form action="{:url(SYS_PATH."/".CONTROLLER."/add")}" method="post" class="formvalidate" id="DataFromSubmit" isajax="true">
   </if>
     
     <fieldset> 
      <legend>填写信息</legend> 
      <table width="100%" class="table_form"> 
       <tbody> 
        <if condition="$modules.category_status eq 1">
        <tr> 
         <td width="12%">内容分类</td> 
         <td>
         {$category|raw}
         </td> 
        </tr> 
        </if>       
      
        <tr>
         <td width="12%">内容标题</td> 
         <td><input type="text" id="title"  style="width:300px;" class="input-text" datatype="*" nullmsg="请输入标题" value="{$data['title']}" name="title" placeholder="请输入内容标题" /> <span id="messageBox" for="title" generated="true" class="Validform_checktip onShow ">请输入内容标题</span> </td> 
        </tr>                           
        
        
        <tr> 
         <td>内容详情</td> 
         <td> 
         <textarea style="width:670px; height:350px;" class="editor" name="content" id="content">{:isset($data['content'])&&$data['content']?$data['content']:''}</textarea> </td> 
        </tr>    
        <include file="common:block" />
        <tr> 
         <td width="12%">排序</td> 
         <td><input type="text" id="sort" class="input-text" style="width:80px;" value="{:isset($data['sort'])&&$data['sort']?$data['sort']:'1'}" name="sort" placeholder="排序" /> <span id="messageBox" for="title" generated="true" class="onShow ">数字越小，排名越前</span> </td> 
        </tr>        
        
        <tr> 
         <td>推荐：</td> 
         <td> 
		 <div class="onoff">
            <label for="site_status1" class="cb-enable <if condition="$data['is_recommend'] eq 1">selected</if>">是</label>
            <label for="site_status0" class="cb-disable <if condition="($data['is_recommend']==0)||empty($data['is_recommend'])">selected</if>">否</label>
            <input id="site_status1" name="is_recommend" <if condition="$data['is_recommend'] eq 1">checked="checked"</if> value="1" type="radio">
            <input id="site_status0" name="is_recommend" value="0" type="radio" <if condition="($data['is_recommend']==0)||empty($data['is_recommend'])">checked="checked"</if>>
          </div>
         </td> 
        </tr>
        <if condition="$modules.seo_status eq 1">
        	<include file="block::is_seo" />
        </if>
      

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