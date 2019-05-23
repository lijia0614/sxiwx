
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
 <head> 
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" /> 
  <title></title> 
  <link href="/public/admin/default/css/edit.css" rel="stylesheet" type="text/css" /> 
   <script src="/public/admin/default/js/jquery-1.9.1.js"></script> 
    <script src="/public/vend/Validform/Validform_v5.3.2_min.js"></script>
    <script src="/public/admin/default/js/common.js"></script>        
 </head> 
<body>
  <input type="hidden" name="current_load_url" id="current_load_url" value="" /> 
  <div class="pad-10"> 
   <div class="common-form"> 
   <if condition="isset($id)">
    <form action="{:url(SYS_PATH."/".CONTROLLER."/".ACTION,array('id'=>$id))}" method="post" class="formvalidate" id="DataFromSubmit" isajax="true"> 
    <input type="hidden" name="id" value="{$id}" />
   <else />
   	<form action="{:url(SYS_PATH."/".CONTROLLER."/".ACTION)}" method="post" class="formvalidate" id="DataFromSubmit" isajax="true"> 
   </if>
     
     <fieldset> 
      <legend>填写信息</legend> 
      <table width="100%" class="table_form"> 
       <tbody> 
            
        <tr> 
         <td width="17%">APP ID</td> 
         <td width="83%"><input type="text" id="appid"  style="width:200px;" class="input-text"  datatype="*" nullmsg="请输入APP ID"  value="{:isset($data['appid'])&&$data['appid']?$data['appid']:''}" name="appid" placeholder="请输入APP ID" /> <span id="messageBox" for="title" generated="true" class="onShow Validform_checktip">请输入APP ID</span> </td> 
        </tr>    
        
        <tr> 
         <td width="17%">AppSecret</td> 
         <td><input type="text" id="AppSecret" style="width:260px;"  datatype="*" nullmsg="请输入AppSecret"  class="input-text" value="{:isset($data['AppSecret'])&&$data['AppSecret']?$data['AppSecret']:''}" name="AppSecret" placeholder="AppSecret" /> <span id="messageBox" for="title" generated="true" class="onShow Validform_checktip">请输入AppSecret</span>  </td> 
        </tr>
        
        <tr> 
         <td width="17%">状态</td> 
         <td>
		 <div class="onoff">
            <label for="status1" class="cb-enable <if condition="$status eq 1">selected</if>">是</label>
            <label for="status0" class="cb-disable <if condition="$status eq 0">selected</if>">否</label>
            <input id="status1" name="status" <if condition="$status eq 1">checked="checked"</if> value="1" type="radio">
            <input id="status0" name="status" value="0" type="radio" <if condition="$status==0">checked="checked"</if>>
          </div>
         </td> 
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