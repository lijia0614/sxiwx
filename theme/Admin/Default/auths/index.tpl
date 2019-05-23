<div class="nav"><span>第三方登录接口</span></div> 
<div class="explain">
	<div class="name"><span>操作提示</span></div>
	<div class="con">
		<p>需要到各第三方平台注册帐号。</p>
		<p>不要忘记设置当前域名为信任域名</p> 
	</div> 
</div>
<div class="main"> 
	<table class="ltable">
	  	<thead>
		  	<tr> 
				<th width="200">名称</th>  
				<th width="200">别名</th> 
				<th>描述</th>
				<th width="100">编辑</th>
				<th width="200">状态</th>
		  	</tr>
	  	</thead>
		<tbody>
	 <volist name="list" id="vo">
		<tr>
				<td>{$vo.name}</td> 
				<td>{$vo.module}</td> 
				<td>{$vo.desc}</td> 
				<td>
<a href="javascript:void(0);" data-url="{:url(SYS_PATH.'/auths/'.$vo.module)}" data-width="700px" title="配置{$vo.name}" data-height="250px" class="dialog edit">配置</a>
				</td> 
				<td>
<if condition="$vo.status eq 1"><img class="pointer"  data-id="{$vo.id}" data-url="{:url(SYS_PATH."/".CONTROLLER."/dostatus")}" style="cursor: pointer;" data-value="{$vo.status}" src="/public/admin/default/images/icon_{$vo.status}.png"><else /><img class="pointer"   data-id="{$vo.id}"  data-url="{:url(SYS_PATH."/".CONTROLLER."/dostatus")}" style="cursor: pointer;" data-value="{$vo.status}" src="/public/admin/default/images/icon_{$vo.status}.png"></if>
                </td>
				<td></td>
			</tr>
            </volist>        
							</tbody> 
	</table> 
</div>
<!--底部--> 