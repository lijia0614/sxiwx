<div class="nav">
	<a class="ch">静态缓存设置</a>
</div>
 
<div class="explain">
	<div class="name"><span>操作提示</span></div>
	<div class="con">
		<p>静态缓存可以大大减轻服务器压力!</p>
	</div>
</div> 
<div class="main">
<form action="{:url(SYS_PATH."/".CONTROLLER."/staticCache")}" method="post" class="formvalidate" id="DataFromSubmit" isajax="true"> 
	<table class="etable">
		<tr>
			<td width="120">缓存时间：</td>
			<td><input type="text" size="10" name="CACHE_TIME" value="{$config.CACHE_TIME}"/><p>以秒为单位</p>	</td>
	  	</tr>
		<tr>
			<td>排除模块：</td>
			<td>
				<textarea name="CACHE_NO_GROUP" id="CACHE_NO_GROUP" style="width:400px; height:100px;">{$config.CACHE_NO_GROUP}</textarea>
				<p>每行一个模块</p>	
			</td>
	  	</tr>
	 	<tr>
			<td>排除控制器：</td>
			<td>
				<textarea name="CACHE_NO_MODULE" id="CACHE_NO_MODULE" style="width:400px; height:100px;">{$config.CACHE_NO_MODULE}</textarea>            
				<p style="color:#F00;">每行一条记录,格式必须为 "/模块/控制器名/"</p>	 
			</td>
	  	</tr> 
	  	<tr>
			<td>排除页面：</td>
			<td><textarea name="CACHE_NO_ACTION" id="CACHE_NO_ACTION" style="width:400px; height:100px;">{$config.CACHE_NO_ACTION}</textarea>     
				<p style="color:#F00;">每行一条记录,格式必须为 "/模块/控制器名/方法名"</p>	 
			</td>
	  	</tr>
		
		<tr>
			<td>状态：</td>
			<td>
				<label><input type="radio" name="CACHE_ON" value="1" <if condition="$config.CACHE_ON eq 1">checked="checked"</if> /> 开启 </label>
				<label><input type="radio" name="CACHE_ON" value="0"  <if condition="$config.CACHE_ON eq 0">checked="checked"</if> /> 关闭 </label>
			</td>
	  	</tr>
	  	<tr>
			<td>&nbsp;</td>
			<td><input type="button" id="webSiteSubmit" class="submit webSiteSubmit" value="提交"/></td>
	 	</tr>
	</table>
</form> 
</div>

</body>
</html>
