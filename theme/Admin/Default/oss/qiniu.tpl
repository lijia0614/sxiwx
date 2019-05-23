
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
         <td>accessKey：</td> 
         <td>
<input name="accessKey" style="width:350px;" class="input-text" id="accessKey" type="text" value="{$data['accessKey']}" placeholder="accessKey" /> <span id="messageBox" for="title" generated="true" class="onShow ">您的accessKey</span>
         </td> 
        </tr>
		<tr> 
         <td>secretKey：</td> 
         <td>
         	<input name="secretKey" style="width:350px;" class="input-text" id="secretKey" type="text" value="{$data.secretKey}" placeholder="secretKey" /> <span id="messageBox" for="title" generated="true" class="onShow ">您的secretKey</span>
         </td> 
        </tr>
        
		<tr> 
         <td>访问网址：</td> 
         <td>
<input name="ENDPOINT" style="width:400px;" class="input-text" id="ENDPOINT" type="text" value="{$data.ENDPOINT}" placeholder="您的空间外网访问地址" /> <span id="messageBox" for="title" generated="true" class="onShow ">您的空间外网访问地址</span>
         </td> 
        </tr>         
  
		<tr> 
         <td>Bucket：</td> 
         <td>
<input name="Bucket" style="width:200px;" class="input-text" id="Bucket" type="text" value="{$data.Bucket}" placeholder="存储空间名称" /> <span id="messageBox" for="title" generated="true" class="onShow ">Bucket名称,存储空间名称</span>
         </td> 
        </tr>   
        
		<tr> 
         <td>外网域名：</td> 
         <td>
<input name="DOMAIN" style="width:300px;" class="input-text" id="DOMAIN" type="text" value="{:isset($data['DOMAIN'])?$data['DOMAIN']:'http://'}" placeholder="外网域名" /> <span id="messageBox" for="title" generated="true" class="onShow ">调用的域名地址,不填则使用默认oss域名</span>
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