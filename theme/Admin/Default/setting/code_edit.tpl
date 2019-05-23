
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
 </head> 
<body>
  <input type="hidden" name="current_load_url" id="current_load_url" value="" /> 
  <div class="pad-10"> 
   <div class="common-form"> 
   <if condition="isset($id)">
    <form action="{:url(SYS_PATH."/".CONTROLLER."/code_edit",array('c_key'=>$c_key))}" method="post" class="formvalidate" id="DataFromSubmit" isajax="true"> 
    <input type="hidden" name="id" value="{$id}" />
   <else />
   	<form action="{:url(SYS_PATH."/".CONTROLLER."/code_edit")}" method="post" class="formvalidate" id="DataFromSubmit" isajax="true"> 
   </if>
   <input type="hidden" name="c_key" value="{$c_key}">
     <fieldset> 
      <legend>编缉</legend>
      <table width="100%" class="table_form"> 
       <tbody> 
       
        <tr> 
         <td width="12%">验证码类型</td> 
         <td>
				<select name="code_type" style="width: 150px;">
					<option value="0" <if condition="$data['code_type']==0">selected</if>>大小写字母</option>
					<option value="1" <if condition="$data['code_type']==1">selected</if>>纯数字</option>
					<option value="2" <if condition="$data['code_type']==2">selected</if>>大写字母</option>
					<option value="3" <if condition="$data['code_type']==3">selected</if>>小写字母</option>
					<option value="4" <if condition="$data['code_type']==4">selected</if>>中文字符</option>

				</select>         
          </td> 
        </tr> 
        
        <tr> 
         <td>验证码位数</td> 
         <td>
         <select name="code_length" id="code_length">
         	<option value="2"<if condition="$data.code_length eq 2"> selected="selected"</if>>2位</option>
            <option value="3"<if condition="$data.code_length eq 3"> selected="selected"</if>>3位</option>
            <option value="4"<if condition="$data.code_length eq 4"> selected="selected"</if>>4位</option>
            <option value="5"<if condition="$data.code_length eq 5"> selected="selected"</if>>5位</option>
            <option value="6"<if condition="$data.code_length eq 6"> selected="selected"</if>>6位</option>
            <option value="7"<if condition="$data.code_length eq 7"> selected="selected"</if>>7位</option>
            <option value="8"<if condition="$data.code_length eq 8"> selected="selected"</if>>8位</option>
            <option value="9"<if condition="$data.code_length eq 9"> selected="selected"</if>>9位</option>
         </select>         
         <span id="messageBox" for="title" generated="true" class="Validform_checktip onShow ">验证码位数</span> </td> 
        </tr>          
        
        <tr> 
         <td>验证码宽高</td> 
         <td><input type="text" style="width:40px;" id="code_width" value="{:isset($data.code_width)?$data.code_width:''}" class="input-text" datatype="*" name="code_width" placeholder="宽" />&nbsp;px &nbsp;<input type="text" style="width:40px;" id="code_height" value="{:isset($data.code_height)?$data.code_height:''}" class="input-text" datatype="*" name="code_height" placeholder="高" />&nbsp;px&nbsp;</td>
        </tr>
        <tr> 
         <td>是否启用</td> 
         <td> 
		 <div class="onoff">
            <label for="status1" class="cb-enable <if condition="$data['status'] eq 1">selected</if>">启用</label>
            <label for="status0" class="cb-disable <if condition="($data['status']==0)||empty($data['status'])">selected</if>">禁用</label>
            <input id="status1" name="status" <if condition="$data['status'] eq 1">checked="checked"</if> value="1" type="radio">
            <input id="status0" name="status" value="0" type="radio" <if condition="($data['status']==0)||empty($data['status'])">checked="checked"</if>>
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
  <script language="javascript">
  	$(document).off("click", "input[name='water_status']");
	$(document).on("click", "input[name='water_status']", function () {
        var val = $(this).val();
        if (val == 1) {
            $(".water_tr").fadeIn();
        } else {
	    	$(".water_tr").fadeOut();
        }
	
	});	
  </script>

 </body>
</html>