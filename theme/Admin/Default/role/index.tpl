<div class="nav"><span>角色管理</span></div> 
<div class="explain">
	<div class="name"><span>操作提示</span></div>
	<div class="con">
		<p>系统中用户的操作权限是通过角色来控制，角色可以理解为具备一定操作权限的用户组</p>
	</div> 
</div>
<div class="filter"> 
			<a href="javascript:void(0);" data-url="{:url(SYS_PATH."/role/add")}" class="dialog add" data-width="550px" title="添加角色" data-height="400px">添加角色</a>
	</div>
<div class="main"> 
	<table class="ltable">
	  	<thead>
		  	<tr>
				<th width="70">编号</th> 
				<th width="120">角色名称</th>
				<th width="200">状态</th>
				<th width="120">操作</th> 
		  	</tr>
	  	</thead>
		<tbody>
			<empty name="list">
							<tr>
								<td height="50" colspan="4" align="center" style="text-align:center;">没有数据</td>
							</tr>                        
            </empty>
            <volist name="list" id="vo">
			<tr>
						<td>{:isset($vo['id'])?$vo['id']:''}</td>
						<td nowrap="nowrap">{$vo.name}</td>		                     					
                        <td><if condition="isset($vo.status)&&$vo.status eq 1">已启用<else />已禁用</if></td>						
						<td nowrap="nowrap">
  <a href='javascript:void(0);'  data-url='{:url(SYS_PATH."/".CONTROLLER."/edit",array("id"=>$vo["id"]))}'  class='dialog edit' alt='编辑' title='编辑'  data-height='400px' data-width='550px'>编缉</a>
 <a href='javascript:void(0);' data-url='{:url(SYS_PATH."/".CONTROLLER."/doDelete","id=$vo[id]")}' class='remove doDel del' val='{$vo.id}' title='删除'>删除</a>  						</td>
					</tr>
                      </volist> 
							</tbody> 
	</table>
</div>
