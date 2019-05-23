<div class="explain">
	<div class="name"><span>操作提示</span></div>
	<div class="con">
		<p>自定义设置参数在全局模型中管理</p>
	</div> 
</div>
<style type="text/css">
.upload_button input{ height:16px;}
</style>
<div class="main">
	<div class="nav">
    	<include file="setting:tab" />
	</div>  
<form action="{:url(SYS_PATH."/".CONTROLLER."/index")}" method="post" class="formvalidate" id="DataFromSubmit" isajax="true"> 
<input type="hidden" name="act" value="customize" />
		<table width="100%" class="etable">       
            <include file="common:block" />
			<tr>
				<td width="120">&nbsp;</td>
				<td><input type="button" id="webSiteSubmit" class="submit webSiteSubmit" value="提交"/></td>
			</tr>
		</table>
	</form> 
</div>
<script src="/public/admin/default/js/ajaxfileupload.js"></script>