<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>管理中心</title>
<link rel="stylesheet" type="text/css" href="css/edit.css"> 
<script type="text/javascript" src="js/jquery-1.9.1.js"></script> 
<script src="/public/vend/Validform/Validform_v5.3.2_min.js"></script>
<script type="text/javascript" src="js/common.js"></script>
	<link rel="stylesheet" href="/public/zTree/css/demo.css" type="text/css">
	<link rel="stylesheet" href="/public/zTree/css/zTreeStyle/zTreeStyle.css" type="text/css">
	<script type="text/javascript" src="/public/zTree/js/jquery.ztree.core-3.5.js"></script>
	<script type="text/javascript" src="/public/zTree/js/jquery.ztree.excheck-3.5.js"></script>  
<script type="text/javascript">
		var setting = {
			check: {
				enable: true
			},
			data: {
				simpleData: {
					enable: true
				}
			},
			callback:{
                onCheck:onCheck
            }
		};
		var zNodes ={$nodeLists|raw};
		var code;
		$(document).ready(function(){
			$.fn.zTree.init($("#treeDemo"), setting, zNodes);
			onCheck();		
		});
		function onCheck(e, treeId, treeNode) {
			var treeObj = $.fn.zTree.getZTreeObj("treeDemo"),
			nodes = treeObj.getCheckedNodes(true),
			v = "";
			for (var i = 0; i < nodes.length; i++) {
				v += "<input type='hidden' name='access_node[]' value='"+nodes[i].id+"'>";
			}
			$("#nodesHtml").html(v);
		}
	</script>      
</head> 
<body>
  <input type="hidden" name="current_load_url" id="current_load_url" value="" /> 
  <div class="pad-10"> 
   <div class="common-form"> 
   <if condition="isset($id)">
    <form action="{:url(SYS_PATH."/".CONTROLLER."/edit",array('id'=>$id))}" method="post" class="formvalidate"  id="DataFromSubmit" isajax="true"> 
    <input type="hidden" name="id" value="{$data.id}" />
    <input type="hidden" name="oldname" value="{$data.name}" />    
   <else />
   	<form action="{:url(SYS_PATH."/".CONTROLLER."/add")}" method="post" class="formvalidate" id="DataFromSubmit" isajax="true"> 
   </if>
   <div style="display:none;" id="nodesHtml"></div>
   
     <fieldset> 
      <legend>填写信息</legend> 
      <table width="100%" class="table_form"> 
       <tbody> 
        <tr> 
         <td width="12%">角色名称</td> 
         <td><input type="text" id="name" class="input-text" datatype="*" value="<if condition="isset($data)">{$data.name}</if>" name="name" placeholder="请输入角色名称" /> <span id="messageBox" for="title" generated="true" class="Validform_checktip onShow ">角色名称</span> </td> 
        </tr> 
        </tbody>
        </table>   
		<ul id="treeDemo" class="ztree" style="width:100%; overflow:hidden; height:auto;border:none; background:#FFF;"></ul>
         <input type="hidden" name="dialogid" id="dialogid" value="" /> 
         <input type="submit"  name="dosubmit" id="dosubmit" style="display:none;" value=" 提交 " /> 
    </form> 
     </div> 
  </div>
    <script>
    $(document).on("change",".changeall",function() {
                var name=$(this).attr('tipname');
                var checked=$(this).is(':checked');
                if(checked){
                    $("input[tip='"+name+"']").prop("checked",'true');
                    
                }else{
                    $("input[tip='"+name+"']").removeAttr("checked");
                }   
    })
    </script>  
 </body>
</html>