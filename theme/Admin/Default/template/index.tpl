<div class="nav">
	<a href="?m=config&a=template" class="ch">模板设置</a> 
</div> 
<style type="text/css">
label.mbox{ width:120px; border-bottom:none; float:left;}
label.mbox .images{ width:100%; float:left; }
label.mbox .xz{ width:100%; padding:10px 0 5px 0; float:left;} 
</style>
<div class="explain">
	<div class="name"><span>操作提示</span></div>
	<div class="con">
		<p>模板目前只支持PC前端和WAP前端，会员中心和商户中心不支持模板。</p>  
		<p>只需要把模板重新命名到模板目录下即可，然后后台设置下即可切换模板。</p>
	</div> 
</div> 
<div class="main"> 
<form action="{:url(SYS_PATH."/".CONTROLLER."/index")}" method="post" class="formvalidate" id="DataFromSubmit" isajax="true"> 
		<table class="etable">  
	
    
	 <tr>
		<td width="100" valign="top" style="padding-top:10px;">电脑端模板：</td>
				<td> 
                <volist name="pcThemes" id="vo">
                    <label><input type="radio" name="pc_template" <if condition="$config['pc_template']==$vo">  checked</if>  value="{$vo}"  />{$vo}</label>
                </volist>   
				</td>
	</tr>  
    <tr>   
			<td width="100" valign="top" style="padding-top:10px;">移动端模板：</td>
					<td> 
                <volist name="mobileThemes" id="vo">
                    <label><input type="radio" name="mobile_template" <if condition="$config['mobile_template']==$vo">  checked</if>  value="{$vo}"  />{$vo}</label>
                </volist>  	
					</td>
	</tr> 
    <!--
    <tr>   
			<td width="100" valign="top" style="padding-top:10px;">会员端模板：</td>
					<td> 
                <volist name="membersThemes" id="vo">
                    <label><input type="radio" name="members_template" <if condition="$config['members_template']==$vo">  checked</if>  value="{$vo}"  />{$vo}</label>
                </volist>  	
					</td>
	</tr>     -->

	 		 
			<tr>
				<td>&nbsp;</td>
				<td><input type="button" id="webSiteSubmit" class="submit webSiteSubmit" value="提交"/></td>
			</tr>
		</table>
	</form> 
</div>

