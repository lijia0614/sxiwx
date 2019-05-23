<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
 <head> 
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" /> 
  <title></title> 
  <link href="/public/admin/default/css/edit.css" rel="stylesheet" type="text/css" /> 
   <script src="/public/admin/default/js/jquery-1.9.1.js"></script> 
    <script src="/public/vend/Validform/Validform_v5.3.2_min.js"></script>
    <script src="/public/admin/default/js/common.js"></script>        
  <style>
#FrmContent{height:100%; }
</style> 

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
        <tr> 
         <td width="12%">模型名称</td> 
         <td> <input type="text" id="title" class="input-text"  datatype="*" nullmsg="请输入模型名称！" value="{:isset($data['title'])?$data['title']:''}" name="title" placeholder="请输入模型名称" /><span id="messageBox" for="title" generated="true" class="Validform_checktip onShow ">请输入标题</span> </td> 
        </tr> 
        <tr> 
         <td>模型表名</td> 
         <td><input type="text" id="table" class="input-text"  datatype="/^[a-zA-Z_]{2,10}$/i" errormsg="只能为字母且长度为2-10位" nullmsg="请输入模型表名！" value="{:isset($data['table'])?$data['table']:''}" name="table" placeholder="请输入模型表名" <if condition="isset($data['table'])">  readonly="readonly"</if>  /><span id="messageBox" for="title" generated="true" class="Validform_checktip onShow ">模型表名</span></td> 
        </tr> 
        <tr> 
         <td>模型描述</td> 
         <td> 
         <textarea name="desc" class="textinput"   datatype="*" nullmsg="请输入模型描述！" style="width:350px; height:80px; padding:5px;">{:isset($data['desc'])?$data['desc']:''}</textarea>
       <span id="messageBox" for="title" generated="true" class="Validform_checktip onShow ">模型描述</span> </td> 
        </tr>

        <tr> 
         <td>自定义SEO：</td> 
         <td> 
		 <div class="onoff">
            <label for="seo_status1" class="cb-enable <if condition="$data['seo_status'] eq 1">selected</if>">是</label>
            <label for="seo_status0" class="cb-disable <if condition="($data['seo_status']==0)||empty($data['seo_status'])">selected</if>">否</label>
            <input id="seo_status1"  name="seo_status" <if condition="$data['seo_status'] eq 1">checked="checked"</if> value="1" type="radio">
            <input id="seo_status0"  name="seo_status" value="0" type="radio" <if condition="($data['seo_status']==0)||empty($data['seo_status'])">checked="checked"</if>>
          </div>
         </td> 
        </tr> 
        
        <tr> 
         <td>是否有分类：</td> 
         <td> 
		 <div class="onoff">
            <label for="category_status1" class="cb-enable <if condition="$data['category_status'] eq 1">selected</if>">是</label>
            <label for="category_status0" class="cb-disable <if condition="($data['category_status']==0)||empty($data['category_status'])">selected</if>">否</label>
            <input id="category_status1" class="category_status" name="category_status" <if condition="$data['category_status'] eq 1">checked="checked"</if> value="1" type="radio">
            <input id="category_status0" class="category_status" name="category_status" value="0" type="radio" <if condition="($data['category_status']==0)||empty($data['category_status'])">checked="checked"</if>>
          </div>
         </td> 
        </tr>        
        
        <tr <if condition="$data.category_status neq 1">style="display:none"</if> id="category_alias_tr"> 
         <td>分类别名</td> 
         <td><input type="text" id="category_alias" class="input-text"  datatype="*" nullmsg="分类别名！" value="{:isset($data['category_alias'])?$data['category_alias']:''}" name="category_alias" placeholder="分类别名"  />
       		<span id="messageBox" for="title" generated="true" class="Validform_checktip onShow ">为空将默认为 "分类管理"</span> </td> 
        </tr>        
                  
       </tbody>
      </table> 
     </fieldset> 
     <input type="hidden" name="dialogid" id="dialogid" value="" /> 
     <input type="submit" style="display:none;" name="dosubmit" id="dosubmit" value=" 提交 " /> 
    </form> 
   </div> 
  </div>  
  <script language="javascript">
	$(document).ready(function() {
		$(".category_status").change(function() {
			 var val = $(this).val();
			 if(val==1){
				 $("#category_alias_tr").fadeIn();

			 }else if(val==0){
				 $("#category_alias_tr").fadeOut();
				 
			}
		});
		
	
	});	
</script>  
 </body>
</html>