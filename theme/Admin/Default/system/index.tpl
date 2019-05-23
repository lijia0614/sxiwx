<div class="nav"><span>用户管理</span></div> 
<div class="explain">
	<div class="name"><span>操作提示</span></div>
	<div class="con">
		<p>编号为2的为系统默认管理员，为最高权限!</p>
        <p>不能删除,不能禁用</p>
	</div> 
</div>
<div class="filter"> 
			<a href="javascript:void(0);" data-url="{:url(SYS_PATH."/system/add")}" data-height='420px' data-width='650px' title="添加管理员" class="dialog add">添加用户</a>
	</div>
<div class="main"> 
	<table class="ltable">
	  	<thead>
		  	<tr>
            	<th width="70">选择</th> 
				<th width="70">编号</th> 
				<th width="120">头像</th>
				<th width="150">用户名</th>
				<th width="120">姓名</th> 
				<th width="70">用户组</th> 
				<th width="130">登录次数</th>
				<th width="110">登录IP</th>
                <th width="110">状态</th>
                <th width="200">登录时间</th>
                <th width="200">操作</th>
				<th></th>
		  	</tr>
	  	</thead>
		<tbody>
			<empty name="list">
							<tr>
								<td height="50" colspan="7" align="center" style="text-align:center;">没有数据</td>
							</tr>                        
            </empty>        
 <volist name="list" id="vo">
			<tr>
						<td nowrap="nowrap"><input type="checkbox" name="select" value="{$vo.u_id}" class="checkSon va_m" /></td>
						<td style="text-align:center;">{$vo.u_id}</td>
						<td class="img"><if condition="!empty($vo.u_photo)"><img src="{$vo.u_photo}" /><else />无</if></td>
						<td nowrap="nowrap">{$vo.u_name}</td>	
                        <td nowrap="nowrap">{$vo.u_username}</td>	
                        <td nowrap="nowrap">{$vo.name}</td>	
                        <td nowrap="nowrap">{$vo.u_countlog}</td>		
                        <td nowrap="nowrap">{$vo.u_ip}</td>	                        					
                        <td style="text-align:center;">
<img class="pointer" data-id="{$vo.u_id}"  data-url="{:url(SYS_PATH."/".CONTROLLER."/dostatus")}" style="cursor: pointer;" data-value="{$vo.status}" src="/public/admin/default/images/icon_{$vo.status}.png">                 
                        </td>
						
						<td nowrap="nowrap">{$vo.login_time|date='Y-m-d H:i:s'}</td>						
						<td nowrap="nowrap" style="text-align:center;">
  <a href='javascript:void(0);'  data-url='{:url(SYS_PATH."/".CONTROLLER."/edit",array("id"=>$vo["u_id"]))}'  class='dialog edit' alt='编辑' title='编辑管理员'  data-height='420px' data-width='650px'>编缉</a>
 <a href='javascript:void(0);' data-url='{:url(SYS_PATH."/".CONTROLLER."/doDelete","id=$vo[u_id]")}' class='remove doDel del' val='{$vo.id}' title='删除'>删除</a>  						</td>
					</tr>
                      </volist> 
							</tbody> 
	</table>
</div>
