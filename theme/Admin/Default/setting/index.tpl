<div class="explain">
	<div class="name"><span>操作提示</span></div>
	<div class="con">
		<p>网站名称与标题设置，对网站SEO有影响。</p>
	</div> 
</div>
<div class="main">
	<div class="nav">
    	<include file="setting:tab" />
	</div>  
<form action="{:url(SYS_PATH."/".CONTROLLER."/index")}" method="post" class="formvalidate" id="DataFromSubmit" isajax="true"> 
<input type="hidden" name="act" value="index" />
		<table width="100%" class="etable"> 
			<tr>
				<td width="120">网站名称：</td>
				<td><input type="text" size="50" name="site_name" datatype="*" value="{$config['site_name']}" /> <span id="messageBox" for="title" generated="true" class="Validform_checktip onShow ">网站名称</span></td>
			</tr> 
			<tr>
				<td>网站域名：</td>
				<td><input type="text" size="50" name="site_url" value="{$config['site_url']}" /><span id="messageBox" for="title" generated="true" class="Validform_checktip onShow ">网站域名</span></td>
			</tr>

			<tr>
				<td>标题：</td>
				<td><input type="text" size="50" name="site_title" value="{$config['site_title']}" /><span id="messageBox" for="title" generated="true" class="Validform_checktip onShow ">网站标题，SEO重要</span></td>
			</tr>
			<tr>
				<td>关键字：</td>
				<td><textarea name="site_keywords" cols="50" rows="3">{$config['site_keywords']}</textarea></td>
			</tr>
			<tr>
				<td>描述：</td>
				<td><textarea name="site_description" cols="50" rows="5">{$config['site_description']}</textarea></td>
			</tr>
			<tr>
				<td>ICP备案号：</td>
				<td><input type="text" size="50" name="site_icp" value="{$config['site_icp']}" /><span id="messageBox" for="title" generated="true" class="Validform_checktip onShow ">工信部要求必须在底部展示</span></td>
			</tr>
			<tr>
				<td>版权：</td>
				<td><input type="text" size="50" name="site_copyright" value="{$config['site_copyright']}" /></td>
			</tr>

			<tr>
				<td valign="top" style="padding-top:8px;">插件代码：</td>
				<td><textarea name="site_tongji" cols="50" rows="5">{$config['site_tongji']}</textarea><p>第三方统计代码，客服代码等</p></td>
			</tr>

			
			<tr>
				<td>网站状态：</td>
				<td>
					<div class="onoff">
						<label for="site_status1" class="cb-enable <if condition="isset($config['site_status'])&&$config['site_status']==1"> selected</if>">开启</label>
						<label for="site_status0" class="cb-disable  <if condition="isset($config['site_status'])&&$config['site_status']==2"> selected</if>">关闭</label>
						<input id="site_status1" name="site_status" value="1" type="radio" <if condition="isset($config['site_status'])&&$config['site_status']==1"> checked="checked"</if>>
						<input id="site_status0" name="site_status" value="2" type="radio" <if condition="isset($config['site_status'])&&$config['site_status']==2"> checked="checked"</if>>
					</div>
					<p>是否关闭系统</p>
					<!--
					<label><input type="radio" name="site_status" value="1" <if condition="isset($config['site_status'])&&$config['site_status']==1"> checked="checked"</if> />开启</label>
					<label><input type="radio" name="site_status" value="2" <if condition="isset($config['site_status'])&&$config['site_status']==2"> checked="checked"</if>  />关闭</label>
					-->
				</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td><input type="button" id="webSiteSubmit" class="submit webSiteSubmit" value="提交"/></td>
			</tr>
		</table>
	</form> 
</div>