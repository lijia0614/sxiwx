<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>管理中心</title>
<link rel="stylesheet" type="text/css" href="css/edit.css"> 
<script type="text/javascript" src="js/jquery-1.9.1.js"></script> 
<script src="/public/vend/Validform/Validform_v5.3.2_min.js"></script>
<script type="text/javascript" src="js/common.js"></script>
<script language="javascript" src="/public/admin/default/js/ajaxfileupload.js"></script>
<script src="/public/vend/laydate/laydate.js"></script>
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
         <td width="15%">链接名称：</td> 
         <td><input type="text" id="title" class="input-text" datatype="*" nullmsg="请输入链接名称！"  value="<if condition="isset($data)">{$data.title}</if>" name="title" placeholder="请输入链接名称" /> <span id="messageBox" for="title" generated="true" class="Validform_checktip onShow ">请输入链接名称</span> </td> 
        </tr>

        
        
        
		<tr>
			<td>链接地址：</td>
			<td>
<input type="text" style="width:300px;" id="link" class="input-text" datatype="url" nullmsg="请输入链接！"  value="<if condition="isset($data)">{$data.link}<else />http://</if>" name="link" placeholder="链接地址" /> <span id="messageBox" for="title" generated="true" class="Validform_checktip onShow ">请输入链接</span>            
			</td>
	  	</tr>
        
        <tr> 
         <td width="12%">新窗口打开：</td>
         <td> 
		 <div class="onoff">
            <label for="target1" class="cb-enable <if condition="$data.target eq 1">selected</if>">是</label>
            <label for="target0" class="cb-disable  <if condition="$data.target eq 0">selected</if>">否</label>
            <input id="target1" name="target"  value="1" type="radio" <if condition="$data.target eq 1">checked="checked"</if>>
            <input id="target0" name="target" value="0" type="radio"  <if condition="$data.target eq 0">checked="checked"</if>>
          </div>
         </td> 
        </tr>          
           
 
        
        <tr> 
         <td width="12%">状态：</td>
         <td> 
		 <div class="onoff">
            <label for="status1" class="cb-enable <if condition="$data.status eq 1">selected</if>">启用</label>
            <label for="status0" class="cb-disable  <if condition="$data.status eq 0">selected</if>">禁用</label>
            <input id="status1" name="status"  value="1" type="radio" <if condition="$data.status eq 1">checked="checked"</if>>
            <input id="status0" name="status" value="0" type="radio"  <if condition="$data.status eq 0">checked="checked"</if>>
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