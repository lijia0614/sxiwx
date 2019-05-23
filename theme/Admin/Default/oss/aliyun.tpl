
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
    <form action="{:url(SYS_PATH."/".CONTROLLER."/".ACTION,array('id'=>$id))}" method="post" class="formvalidate" id="DataFromSubmit" isajax="true"> 
   <else />
   	<form action="{:url(SYS_PATH."/".CONTROLLER."/".ACTION)}" method="post" class="formvalidate" id="DataFromSubmit" isajax="true"> 
   </if>
   
     <fieldset> 
      <legend>填写信息</legend> 
      <table width="100%" class="table_form"> 
       <tbody> 
        <tr> 
         <td width="15%">存储名称</td> 
         <td>{:isset($data['name'])&&$data['name']?$data['name']:''} </td> 
        </tr>       
        
 		<tr> 
         <td>AccessKeyID：</td> 
         <td>
<input name="AccessKeyID" style="width:200px;" class="input-text" type="text" value="{$data['AccessKeyID']}" placeholder="Access KeyId" datatype="*" /> <span id="messageBox" for="title" generated="true" class="Validform_checktip onShow ">您的AccessKeyID</span>
         </td> 
        </tr>
		<tr> 
         <td>AccessKeySecret：</td> 
         <td>
         	<input name="AccessKeySecret" style="width:300px;" class="input-text" type="text" value="{$data['AccessKeySecret']}" placeholder="AccessKeySecret" datatype="*" /> <span id="messageBox" for="title" generated="true" class="Validform_checktip onShow ">您的AccessKeySecret</span>
         </td> 
        </tr>
		<tr> 
         <td>Endpoint：</td> 
         <td>
<input name="Endpoint" style="width:300px;" class="input-text" type="text" nullmsg="请填写外网地址endpoint" value="{$data['Endpoint']}" placeholder="阿里云oss外网地址,需要去掉空间的名称以及第一个点" datatype="*"  /> <span id="messageBox" for="title" generated="true" class="Validform_checktip onShow ">阿里云oss外网地址endpoint</span>
         </td> 
        </tr>   
		<tr class="SITE_UPLOAD_YUN_ALIYUN"> 
         <td>Bucket：</td> 
         <td>
<input name="Bucket" style="width:200px;" datatype="*" nullmsg="请填写Bucket名称" class="input-text" type="text" value="{$data['Bucket']}" placeholder="存储空间名称"  /> <span id="messageBox" for="title" generated="true" class="Validform_checktip onShow ">Bucket名称,存储空间名称</span>
         </td> 
        </tr> 
		<tr > 
         <td>外网域名：</td> 
         <td>
<input name="DOMAIN" style="width:300px;" class="input-text"  type="text" value="{:isset($data['DOMAIN'])?$data['DOMAIN']:'http://'}" placeholder="外网域名"  /> <span id="messageBox" for="title" generated="true" class="onShow ">调用的域名地址,不填则使用默认oss域名</span>
         </td> 
        </tr>
		<tr > 
         <td>保留本地：</td> 
         <td>
<label><input type="radio" name="local_file_save" value="1" <if condition="$data.local_file_save==1"> checked="checked"</if> />保留</label>
					<label><input type="radio" name="local_file_save" value="0" <if condition="$data.local_file_save==0"> checked="checked"</if>  />删除</label>
			<span id="messageBox" for="title" generated="true" class="onShow ">是否将文件保留在服务器</span>
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