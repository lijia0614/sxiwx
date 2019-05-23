
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
<div class="nav"><span>编缉</span><a href="javascript:window.history.go(-1);" class="right">返回</a></div>
  <input type="hidden" name="current_load_url" id="current_load_url" value="" /> 
  <div class="pad-10"> 
   <div class="common-form"> 
   <if condition="isset($id)">
    <form action="{:url(SYS_PATH."/".CONTROLLER."/edit",array('id'=>$id))}" method="post" class="formvalidate" id="DataFromSubmit" isajax="true"> 
    <input type="hidden" name="id" value="{$id}" />
    <input type="hidden" name="nav_id" id="nav_id" value="{$data.nav_id}" />
   <else />
   	<form action="{:url(SYS_PATH."/".CONTROLLER."/add")}" method="post" class="formvalidate" id="DataFromSubmit" isajax="true"> 
    <input type="hidden" name="nav_id" id="nav_id" value="{$nav_id}" />
   </if>
   
     <fieldset> 
      <legend>填写信息</legend> 
      <table width="100%" class="table_form"> 
       <tbody> 
        <tr> 
         <td width="12%">ACTION</td> 
         <td> <input type="text" id="action" value="{:isset($data.action)?$data.action:''}" class="input-text" datatype="*" name="action" placeholder="请输入节点控制器" /> <span id="messageBox" for="title" generated="true" class="Validform_checktip onShow ">方法ACTION</span> </td> 
        </tr> 
        <tr> 
         <td>方法名称</td> 
         <td> <input type="text" id="action_name" value="{:isset($data.action_name)?$data.action_name:''}" class="input-text"  datatype="*" name="action_name" placeholder="方法的中文名称描述" /> <span id="messageBox" for="title" generated="true" class="Validform_checktip onShow ">方法名称</span></td> 
        </tr> 
        <tr> 
         <td>CONTROLLER</td> 
         <td><input type="text" id="module" value="{:isset($data.module)?$data.module:''}" class="input-text" datatype="*" name="module" placeholder="请输入CONTROLLER" /> <span id="messageBox" for="title" generated="true" class="Validform_checktip onShow ">控制器CONTROLLER</span> </td> 
        </tr> 

        <tr> 
         <td>状态</td> 
         <td> <input type="radio" value="1" <if condition="(isset($data.status)&&$data.status eq 1)||!isset($data)">checked="checked"</if> name="status" id="status" />&nbsp;&nbsp;启用&nbsp;&nbsp; <input type="radio" value="0" name="status" <if condition="isset($data.status)&&$data.status eq 0">checked="checked"</if> />&nbsp;&nbsp;禁用 </td> 
        </tr> 
        <tr> 
         <td>菜单显示</td> 
         <td> <input type="radio" value="1" <if condition="(isset($data.is_show)&&$data.is_show eq 1)||!isset($data)">checked="checked"</if> name="is_show" id="is_show" />&nbsp;&nbsp;显示&nbsp;&nbsp; <input type="radio" value="0" name="is_show" <if condition="isset($data.is_show)&&$data.is_show eq 0">checked="checked"</if> />&nbsp;&nbsp;隐藏 </td> 
        </tr>
        <tr> 
         <td>排序</td> 
         <td> <input type="text" style="width:50px" id="sort" value="{:isset($data.sort)?$data.sort:'100'}" class="input-text" validate="{ required:true,maxlength:30}" name="sort" placeholder="排序数字" /> <span id="messageBox" for="title" generated="true" class="onShow ">数字越小排名越前</span> </td> 
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