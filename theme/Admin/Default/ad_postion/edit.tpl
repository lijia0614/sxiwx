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
    <form action="{:url(SYS_PATH.'/AdPostion/edit',array('id'=>$id))}" method="post" class="formvalidate" id="DataFromSubmit" isajax="true"> 
    <input type="hidden" name="id" value="{$id}" />
   <else />
   	<form action="{:url(SYS_PATH.'/AdPostion/add')}" method="post" class="formvalidate" id="DataFromSubmit" isajax="true"> 
   </if>
     
     <fieldset> 
      <legend>填写信息</legend> 
      <table width="100%" class="table_form"> 
       <tbody> 
       
        <tr> 
         <td width="15%">广告位名称</td> 
         <td><input type="text" id="name" class="input-text" datatype="*" nullmsg="请输入广告位名称！"  value="<if condition="isset($data)">{$data.name}</if>" name="name" placeholder="广告位名称" /> <span id="messageBox" for="title" generated="true" class="Validform_checktip onShow ">请输入广告位名称</span> </td> 
        </tr>
        
        <tr> 
         <td width="15%">广告位标签</td> 
         <td><input type="text" id="alias" class="input-text" datatype="*" nullmsg="请输入广告位标签！"  value="<if condition="isset($data)">{$data.alias}</if>" name="alias" placeholder="广告位标签" /> <span id="messageBox" for="title" generated="true" class="Validform_checktip onShow ">请输入广告位标签</span> </td> 
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

 </body>
</html>