
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
    <form action="{:url(SYS_PATH."/".CONTROLLER."/imgset_edit",array('c_key'=>$c_key))}" method="post" class="formvalidate" id="DataFromSubmit" isajax="true"> 
    <input type="hidden" name="id" value="{$id}" />
   <else />
   	<form action="{:url(SYS_PATH."/".CONTROLLER."/imgset_edit")}" method="post" class="formvalidate" id="DataFromSubmit" isajax="true"> 
   </if>
   
     <fieldset> 
      <legend>填写信息</legend> 
      <table width="100%" class="table_form"> 
       <tbody> 
       
        <tr> 
         <td width="12%">裁剪名称</td> 
         <td> <input type="text" id="title" value="{:isset($data.title)?$data.title:''}" class="input-text" datatype="*" name="title" placeholder="请输入裁剪名称" /> <span id="messageBox" for="title" generated="true" class="Validform_checktip onShow ">裁剪名称</span> </td> 
        </tr>        
        <tr> 
         <td width="12%">控制器名称</td> 
         <td> <input type="text" id="module" value="{:isset($data.module)?$data.module:''}" class="input-text" datatype="*" name="module" placeholder="请输入控制器名称" /> <span id="messageBox" for="title" generated="true" class="Validform_checktip onShow ">控制器名称</span> </td> 
        </tr> 
        <tr> 
         <td>字段名称</td> 
         <td> <input type="text" id="action" value="{:isset($data.action)?$data.action:''}" class="input-text" datatype="*" name="action" placeholder="请输入字段名称" /> <span id="messageBox" for="title" generated="true" class="Validform_checktip onShow ">字段名称</span> </td> 
        </tr> 
        
        <tr> 
         <td>裁剪宽高</td> 
         <td><input type="text" style="width:40px;" id="width" value="{:isset($data.width)?$data.width:''}" class="input-text" datatype="*" name="width" placeholder="宽" />&nbsp;px &nbsp;<input type="text" style="width:40px;" id="height" value="{:isset($data.height)?$data.height:''}" class="input-text" datatype="*" name="height" placeholder="高" />&nbsp;px&nbsp;</td> 
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
        
        <tr> 
         <td>图片水印</td> 
         <td> 
		 <div class="onoff">
            <label for="water_status1" class="cb-enable <if condition="$data['water_status'] eq 1">selected</if>">启用</label>
            <label for="water_status0" class="cb-disable <if condition="($data['water_status']==0)||empty($data['water_status'])">selected</if>">禁用</label>
            <input id="water_status1" name="water_status" <if condition="$data['water_status'] eq 1">checked="checked"</if> value="1" type="radio">
            <input id="water_status0" name="water_status" value="0" type="radio" <if condition="($data['water_status']==0)||empty($data['water_status'])">checked="checked"</if>>
          </div>         
          </td> 
        </tr>    
        
        <tr class="water_tr" <if condition="$data.water_status neq 1||empty($data.water_status)"> style="display:none;"</if>> 
         <td width="12%">水印图片</td> 
         <td>
			<div class="upload_button">
					<input type="text" style="float:left;" datatype="*" name="waterImage" class="vtip" data-img="{$data.waterImage}" value="{$data.waterImage}" id="waterImage" />
					<a class="file" href="javascript:;">选择文件<input type="file" name="up_waterImage[]" id="up_waterImage" class="img_file upimg" upkey="waterImage" /></a>
                    <span id="messageBox" for="title" generated="true" class=" Validform_checktip onShow " style="margin-top:5px;">上传水印图片</span>
				</div>
          </td> 
        </tr> 
        
        <tr class="water_tr"  <if condition="$data.water_status neq 1||empty($data.water_status)"> style="display:none;"</if>> 
         <td width="12%">水印位置</td> 
         <td>
         <select name="water_position" id="water_position">
         	<option value="1"<if condition="$data.water_position eq 1"> selected="selected"</if>>左上角水印</option>
            <option value="2"<if condition="$data.water_position eq 2"> selected="selected"</if>>上居中水印</option>
            <option value="3"<if condition="$data.water_position eq 3"> selected="selected"</if>>右上角水印</option>
            <option value="4"<if condition="$data.water_position eq 4"> selected="selected"</if>>左居中水印</option>
            <option value="5"<if condition="$data.water_position eq 5"> selected="selected"</if>>居中水印</option>
            <option value="6"<if condition="$data.water_position eq 6"> selected="selected"</if>>右居中水印</option>
            <option value="7"<if condition="$data.water_position eq 7"> selected="selected"</if>>左下角水印</option>
            <option value="8"<if condition="$data.water_position eq 8"> selected="selected"</if>>下居中水印</option>
            <option value="9"<if condition="$data.water_position eq 9"> selected="selected"</if>>右下角水印</option>
         </select>
          </td> 
        </tr> 
        
        <tr class="water_tr"  <if condition="$data.water_status neq 1||empty($data.water_status)"> style="display:none;"</if>> 
         <td>透明度</td> 
         <td>
         <select name="water_op" id="water_op">
         	<option value="10"<if condition="$data.water_op eq 10"> selected="selected"</if>>10</option>
            <option value="20"<if condition="$data.water_op eq 20"> selected="selected"</if>>20</option>
            <option value="30"<if condition="$data.water_op eq 30"> selected="selected"</if>>30</option>
            <option value="40"<if condition="$data.water_op eq 40"> selected="selected"</if>>40</option>
            <option value="50"<if condition="$data.water_op eq 50"> selected="selected"</if>>50</option>
            <option value="60"<if condition="$data.water_op eq 60"> selected="selected"</if>>60</option>
            <option value="70"<if condition="$data.water_op eq 70"> selected="selected"</if>>70</option>
            <option value="80"<if condition="$data.water_op eq 80"> selected="selected"</if>>80</option>
            <option value="90"<if condition="$data.water_op eq 90"> selected="selected"</if>>90</option>
            <option value="100"<if condition="$data.water_op eq 90"> selected="selected"</if>>100</option>
         </select>         
         <span id="messageBox" for="title" generated="true" class="Validform_checktip onShow ">数字越小越透明</span> </td> 
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