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
         <td width="15%">广告位置：</td> 
         <td>
         <select name="postion_id" id="postion_id" style="width:150px;" datatype="*" nullmsg="请选择广告位置">
         	<option value="">请选择</option>
            <volist name="ad_postion" id="vo">
            <option value="{$vo.id}" <if condition="$vo.id eq $data.postion_id"> selected</if>>{$vo.name}</option>
            </volist>
         </select>
         <span id="messageBox" for="title" generated="true" class="Validform_checktip onShow ">广告位置</span> </td> 
        </tr>           
       
        <tr> 
         <td width="15%">广告名称：</td> 
         <td><input type="text" id="name" class="input-text" datatype="*" nullmsg="请输入广告名称！"  value="<if condition="isset($data)">{$data.name}</if>" name="name" placeholder="广告名称" /> <span id="messageBox" for="title" generated="true" class="Validform_checktip onShow ">请输入广告名称</span> </td> 
        </tr>

        <tr> 
         <td>广告类型：</td> 
         <td>
         <select name="type" id="type" style="width:150px;" datatype="*" nullmsg="请选择广告类型">
         	<option value="">请选择</option>
            <option value="1" <if condition="$data.type eq 1"> selected</if>>图片广告</option>
            <option value="2" <if condition="$data.type eq 2"> selected</if>>代码广告</option>
         </select>
         </td> 
        </tr> 
        
		<tr class="postion_type1_tr postion" <if condition="$data.type neq 1">style="display:none;"<else />style="display:;"</if>>
			<td>广告图片：</td>
			<td>
				<div class="upload_button">
					<input type="text" style="float:left;" datatype="*" nullmsg="请上传图片！" id="image" name="image" class="vtip" data-img="{$data.image}" value="{$data.image}" />
					<a class="file" href="javascript:;">选择文件<input type="file" name="imgFile[]" class="img_file upimg" upkey="image"  id="imgFile"/></a>
                    <span id="messageBox" for="title" generated="true" class=" Validform_checktip onShow " style="margin-top:5px;"></span>
				</div>
			</td>
	  	</tr>
        
        
		<tr class="postion_type2_tr postion" <if condition="$data.type neq 2">style="display:none;"<else />style="display:;"</if>>
			<td>广告代码：</td>
			<td>
				<textarea name="content" id="content"  datatype="*" style="width:500px; height:80px;"></textarea><span id="messageBox" for="title" generated="true" class=" Validform_checktip onShow " style="margin-top:5px;">请输入广告代码</span>
			</td>
	  	</tr>     
        
		<tr class="link_tr postion" <if condition="$data.type neq 1&&$data.type neq 3">style="display:none;"<else />style="display:;"</if>>
			<td>链接地址：</td>
			<td>
<input type="text" id="link" class="input-text" datatype="*" nullmsg="请输入链接！"  value="<if condition="isset($data)">{$data.link}</if>" name="link" placeholder="链接地址" /> <span id="messageBox" for="title" generated="true" class="Validform_checktip onShow ">请输入链接</span>            
			</td>
	  	</tr>   
        
		<tr>
			<td>开始时间：</td>
			<td>
<input type="text" class="input-text datetime" datatype="*" nullmsg="选择开始时间！"  value="<if condition="isset($data)">{$data.start_time}</if>" name="start_time" placeholder="开始时间" /> <span id="messageBox" for="title" generated="true" class="Validform_checktip onShow ">选择开始时间</span>            
			</td>
	  	</tr>        
        
		<tr>
			<td>结束时间：</td>
			<td>
<input type="text" id="end_time" class="input-text datetime" datatype="*" nullmsg="选择结束时间！"  value="<if condition="isset($data)">{$data.end_time}</if>" name="end_time" placeholder="结束时间" /> <span id="messageBox" for="title" generated="true" class="Validform_checktip onShow ">选择结束时间</span>            
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
	$(document).ready(function() {
		$("select[name='type']").change(function() {
			 var val = $(this).val();
			 if(val==1){
				 $(".postion").fadeOut();
				 $(".link_tr").fadeIn();
				 $(".postion_type1_tr").fadeIn();

			 }else if(val==2){
				 $(".postion").fadeOut();
				 $(".postion_type2_tr").fadeIn();//fadeOut();
				 
			}else{
				$(".postion").fadeOut();
				$(".link_tr").fadeIn();
				$(".postion_type3_tr").fadeIn();
			}
		});
		
	
	});	
</script>
 </body>
</html>