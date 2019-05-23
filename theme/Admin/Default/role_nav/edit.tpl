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
</head> 
<body> 
  <input type="hidden" name="current_load_url" id="current_load_url" value="" /> 
  <div class="pad-10"> 
   <div class="common-form"> 
   <if condition="isset($id)">
    <form action="{:url(SYS_PATH.'/RoleNav/editrolenav',array('id'=>$id))}" method="post" class="formvalidate" id="DataFromSubmit" isajax="true"> 
    <input type="hidden" name="id" value="{$id}" />
   <else />
   	<form action="{:url(SYS_PATH.'/RoleNav/addRoleNav')}" method="post" class="formvalidate" id="DataFromSubmit" isajax="true"> 
   </if>
     
     <fieldset> 
      <legend>填写信息</legend> 
      <table width="100%" class="table_form"> 
       <tbody> 
       
			<tr>
			<td  width="12%">菜单类型：</td>
			<td class="fl">
				<select name="pid" id="pid">
					<option value="0" >项级菜单</option>
                    <volist name="menus" id="vo">
                    <option value="{$vo.id}" <if condition="$vo.id eq $data.pid">selected</if>>{$vo.name}</option>
                    </volist>
                </select> 
			</td>
	  	</tr>        
        <tr> 
         <td width="12%">菜单名称</td> 
         <td><input type="text" id="name" class="input-text" datatype="*" nullmsg="请输入菜单名称！"  value="<if condition="isset($data)">{$data.name}</if>" name="name" placeholder="请输入菜单名称" /> <span id="messageBox" for="title" generated="true" class="Validform_checktip onShow ">请输入菜单名称</span> </td> 
        </tr> 
        
		<tr id="menu_ico_tr" <if condition="$data.pid eq 0">style="display:none;"<else />style="display:;"</if>>
			<td>菜单图标：</td>
			<td>
				<!--<div class="upload_button">
					<input type="text" style="float:left;" datatype="*" nullmsg="请上传图标！" name="image" id="image" class="vtip" data-img="{$data.image}" value="{$data.image}" />
					<a class="file" href="javascript:;">选择文件<input type="file" name="imgFile[]" class="img_file upimg" upkey="image"  id="imgFile"/></a>
                    <span id="messageBox" for="title" generated="true" class=" Validform_checktip onShow " style="margin-top:5px;">建议尺寸：50*50</span>
				</div>-->
                <input type="text" id="class_name" style="width:150px;" class="input-text"  datatype="*"   nullmsg="请输入图标class名！" value="<if condition="isset($data)">{$data.class_name}</if>" name="class_name" placeholder="请输入class_name" /><span id="messageBox" for="title" generated="true" class=" Validform_checktip onShow ">如: icon-case </span>
                <a href="/public/fonts/demo_fontclass.html" target="_blank" style="color:#F00;">查看图标</a>
			</td>
	  	</tr>             
        
        <tr> 
         <td>状态</td> 
         <td> <input type="radio" value="1" <if condition="$data.status eq 1||empty($data)">checked="checked"</if> name="status" id="status" />&nbsp;&nbsp;启用&nbsp;&nbsp; <input type="radio" value="0" name="status" <if condition="isset($data)&&$data.status eq 0">checked="checked"</if> />&nbsp;&nbsp;禁用 </td> 
        </tr> 
        <tr> 
         <td>排序</td> 
         <td> <input type="text" id="sort" style="width:100px;" class="input-text"  datatype="*"   nullmsg="请输入排序！" value="<if condition="isset($data)">{$data.sort}</if>" name="sort" placeholder="请输入排序" /><span id="messageBox" for="title" generated="true" class=" Validform_checktip onShow ">升序排列,越小越靠前</span> </td> 
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
		$("select[name='pid']").change(function() {
			 var val = $(this).val();
			 if(val==0){
				 $("#menu_ico_tr").fadeOut();
			 }else{
				 $("#menu_ico_tr").fadeIn();
			}	
		});
	});	
</script>
 </body>
</html>