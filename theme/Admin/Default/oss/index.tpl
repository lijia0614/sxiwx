<div class="nav"><span>云存储配置</span></div>
<div class="explain">
	<div class="name"><span>操作提示</span></div>
	<div class="con">
		<p>短信为第三方短信服务，短信服务更好的能验证会员的真实性。</p>
		<p>短信主要用到验证码，各类交易通知，更好的让用户感受到方便。短信服务为国内优势比较大的平台服务商。</p> 
		<p>每次请选择一个服务商提供短信服务支持。</p> 
	</div> 
</div>
<div class="main"> 
	<table width="100%" class="ltable">
		<thead>
			<tr>
				<th width="130">别名</th>
				<th width="150">存储名称</th> 
				<th width="400">描述</th> 
				<th width="150">操作</th> 
				<th width="80">开启状态</th> 
				<th></th>
			</tr>
		</thead>
		<tbody>
	 <volist name="list" id="vo">
		<tr>
				<td>{$vo.alias}</td> 
				<td>{$vo.name}</td> 
				<td>{$vo.desc}</td> 

				<td>
                <if condition="$vo.alias eq 'local'">
                无
                <else />
					<a href="javascript:void(0);" data-url="{:url(SYS_PATH.'/oss/'.$vo.alias)}" data-width="800px" title="配置{$vo.name}" data-height="300px" class="dialog edit">配置</a>
                </if>
				</td> 
				<td>
                <if condition="$vo.status eq 1"><strong style="color:#F00;">使用中</strong><else /><input data-url="{:url(SYS_PATH.'/oss/doSetting')}" data-id="{$vo.alias}" type="button" class="setting_button" value="设置"></if>
                </td>
				<td></td>
			</tr>
            </volist>
	</tbody>
</table> 
<script language="javascript">
$(document).ready(function() {
	 $(document).off("click", ".setting_button");
	 $(document).on("click", ".setting_button", function () {
		var dataurl = $(this).attr("data-url");
		var dataid = $(this).attr("data-id");
		var txt = "确定更改存储方式吗？";
        var dataurl = $(this).attr("data-url");
		var data="dataid="+dataid;
        zmCmsConfirm(dataurl, "确定更改存储方式吗?",data);		
	});
});
</script>
