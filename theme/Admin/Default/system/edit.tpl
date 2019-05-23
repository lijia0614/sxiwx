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
         <td width="12%">用户名</td> 
         <td><input type="text" id="u_name" class="input-text" datatype="*" value="<if condition="isset($data)">{$data.u_name}</if>" name="u_name" placeholder="请输入用户名称" /> <span id="messageBox" for="title" generated="true" class="Validform_checktip onShow ">请输入用户登录名称</span> </td> 
        </tr> 
        
        <tr> 
         <td width="12%">真实姓名</td> 
         <td><input type="text" id="u_username" class="input-text" <if condition="empty($data)">datatype="*"</if> value="{$data.u_username}" name="u_username" placeholder="请输入真实姓名" /> <span id="messageBox" for="title" generated="true" class="Validform_checktip onShow ">请输入真实姓名</span> </td> 
        </tr>         
        
        <tr> 
         <td width="12%">密　　码</td> 
         <td><input type="password" id="u_password" <if condition="empty($data)">datatype="*"</if> class="input-text"  name="u_password" placeholder="请输入密码" /> <span id="messageBox" for="title" generated="true" class="Validform_checktip onShow ">请输入密码</span> </td> 
        </tr> 
        
        <tr> 
         <td width="12%">确认密码</td> 
         <td><input type="password" id="confirm_password" <if condition="empty($data)">datatype="*"</if> class="input-text" name="confirm_password" placeholder="请重新输入密码" /> <span id="messageBox" for="title" generated="true" class="Validform_checktip onShow ">请重新输入密码</span> </td> 
        </tr>                 
        
        
        <tr> 
         <td width="12%">用户组</td> 
         <td>
         <select name="role_id" id="role_id" style="width:150px;">
         	<option value="">选择用户组</option>
            <volist id="vo" name="role">
            <option value="{$vo.id}" <if condition="isset($data)&&$data.role_id eq $vo.id"> selected="selected"</if>>{$vo.name}</option>
            </volist>
         </select><span id="messageBox" for="title" generated="true" class="onShow ">请选择用户组</span> 
         </td> 
        </tr> 
        
        <tr> 
         <td>手机号码</td> 
         <td> <input name="u_phone" id="u_phone" class="input-text" type="text" value="<if condition="isset($data)">{$data.u_phone}</if>" placeholder="请输入QQ号码" /> <span id="messageBox" for="title" generated="true" class="Validform_checktip onShow ">请输入手机号码</span> </td> 
        </tr>         
        
        <tr> 
         <td>QQ号码</td> 
         <td> <input name="u_qq" id="u_qq" class="input-text" type="text" value="<if condition="isset($data)">{$data.u_qq}</if>" placeholder="请输入QQ号码" /> <span id="messageBox" for="title" generated="true" class="onShow ">请输入QQ号码</span> </td> 
        </tr> 
        
        <tr> 
         <td>Email</td> 
         <td> <input name="u_email" id="u_email" class="input-text" type="text" value="<if condition="isset($data)">{$data.u_email}</if>" placeholder="请输入QQ号码" /> <span id="messageBox" for="title" generated="true" class="onShow ">请输入Email</span> </td> 
        </tr>                          
        
        <tr> 
         <td>状态</td> 
         <td> <input type="radio" value="1" <if condition="$data.status eq 1||empty($data.status)">checked="checked"</if> name="status" id="status" />&nbsp;&nbsp;启用&nbsp;&nbsp; <input type="radio" value="0" name="status" <if condition="isset($data.status)&&$data.status eq 0">checked="checked"</if> />&nbsp;&nbsp;禁用 </td> 
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