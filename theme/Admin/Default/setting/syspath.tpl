<div class="explain">
	<div class="name"><span>操作提示</span></div>
	<div class="con">
		<p>更改后台登录路径</p>
	</div> 
</div>
<div class="main">
	<div class="nav">
    	<include file="setting:tab" />
	</div>  
<form action="{:url(SYS_PATH."/".CONTROLLER."/index")}" method="post" class="formvalidate" id="DataFromSubmit" isajax="true"> 
<input type="hidden" name="act" value="sysPath" />
		<table width="100%" class="etable">       
            <tr>
            <td>管理入口：</td>
            <td><input type="text" name="sysPath" class="input-text" value="{:SYS_PATH}" style="width:300px;"><span id="messageBox" for="title" generated="true" class="onShow Validform_checktip">后台管理登录入口,可以有效防止爆力破解</span></td>
            </tr>
			<tr>
				<td width="120">&nbsp;</td>
				<td><input type="button" id="sysPath" class="submit" value="提交"/></td>
			</tr>
		</table>
	</form> 
</div>

<script language="javascript">
$(document).ready(function () {
	$("#sysPath").click(function(){
			var dataurl = $("#DataFromSubmit").attr('action');
			if (dataurl.indexOf("?") < 0) {
				dataurl = dataurl + "?";
			}
			var postData = $('.formvalidate').serialize();
			$.ajax({
				cache: true,
				type: "post",
				url: dataurl + "&random=" + Math.random(),
				data: postData,
				async: true,
				error: function (request) {
					$.dialog.tips("系统错误", 2, 'error.gif');
				},
				success: function (data) {
					
					var result = $.parseJSON(data);
					var path=result.data.adminPath;
					if (result.status == 1) {
						window.top.layer.msg(result.msg, {icon: 1, shade: [0.8, '#393D49'], time: 1000});
						 layer.confirm("修改成功，请记住后台登录地址！", {
								title: "操作提示",
								btn: ['确定'], //按钮
								icon: 0,
								shade: [0.8, '#393D49']
							}, function () {
								window.top.location.href="/"+path+"/index/index.html";
							});						
										
					} else {
						 window.top.layer.msg(result.msg, {icon: 2, shade: [0.8, '#393D49'], time: 1000});
					}
				}
			});
	});
});

</script>