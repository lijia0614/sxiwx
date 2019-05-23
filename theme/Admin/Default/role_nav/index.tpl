<div class="nav"><span>后台菜单</span></div>
<div class="filter"> 
	<a href="javascript:;"  title='添加菜单'  class="add dialog" data-url='{:url(SYS_PATH."/RoleNav/addRoleNav")}' data-height='300px' data-width='750px'>添加菜单</a> 
</div>
<div class="main"> 
	<table class="ltable">
	  	<thead>
		  	<tr>
				<th class="fl">名称</td> 
				<th width="200">图标名</th>
                <th width="100">操作管理</th>
				<th width="50">排序</th>
                <th width="150">添加时间</th>
				<th width="60">状态</th>
				<th width="130">操作</th>
				
		  	</tr>
	  	</thead> 
		<tbody>
        <volist name="list" id="vo">
            <tr>
                        <td class="fl" style="font-weight:bold;">{$vo.name}</td>
                        <td>-</td>
                        <td>-</td>
                        <td>{$vo.sort}</td> 
                        <td>{$vo.create_time|date='Y-m-d'}</td>
                        <td><if condition="$vo.status eq 1"><img class="pointer"  data-id="{$vo.id}" data-url="{:url(SYS_PATH."/".CONTROLLER."/dostatus")}" style="cursor: pointer;" data-value="{$vo.status}" src="/public/admin/default/images/icon_{$vo.status}.png"><else /><img class="pointer"   data-id="{$vo.id}"  data-url="{:url(SYS_PATH."/".CONTROLLER."/dostatus")}" style="cursor: pointer;" data-value="{$vo.status}" src="/public/admin/default/images/icon_{$vo.status}.png"></if>   </td> 
                        <td>
							<a href="javascrip:;" data-url='{:url(SYS_PATH."/RoleNav/editRoleNav",array("id"=>$vo["id"]))}'  class='dialog edit' alt='编辑' title='编辑'  data-height='300px' data-width='750px'>编辑</a>
                            <a href="javascript:;" data-url='{:url(SYS_PATH."/RoleNav/doDelete","id=$vo[id]")}' class='remove doDel del' val='{$vo.id}' title='删除'>删除</a>
                        </td> 
                        
            </tr>
            <volist name="vo.childMenu" id="childMenu">
			<tr>
						<td class="fl">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|-- {$childMenu.name}</td>
						<td align="center">{$childMenu.class_name}</td>
                        <td>
  <a href="javascript:;"  title='{$childMenu.name}菜单-节点'  class="add dialog edit" data-height="500px" data-width="850px" data-url='{:url(SYS_PATH."/RoleNode/index",array('id'=>$childMenu.id))}'>管理</a>                        
                        </td>
						<td>{$childMenu.sort}</td>  
                        <td>{$childMenu.create_time|date='Y-m-d'}</td>
						<td><if condition="$childMenu.status eq 1"><img class="pointer"  data-id="{$childMenu.id}" data-url="{:url(SYS_PATH."/".CONTROLLER."/dostatus")}" style="cursor: pointer;" data-value="{$childMenu.status}" src="/public/admin/default/images/icon_{$childMenu.status}.png"><else /><img class="pointer"   data-id="{$childMenu.id}"  data-url="{:url(SYS_PATH."/".CONTROLLER."/dostatus")}" style="cursor: pointer;" data-value="{$childMenu.status}" src="/public/admin/default/images/icon_{$childMenu.status}.png"></if></td> 
						<td>
							<a href="javascrip:;" data-url='{:url(SYS_PATH."/RoleNav/editRoleNav",array("id"=>$childMenu["id"]))}'  class='dialog edit' alt='编辑' title='编辑'  data-height='300px' data-width='650px'>编辑</a>
							<a href="javascript:;" data-url='{:url(SYS_PATH."/RoleNav/doDelete","id=$childMenu[id]")}' class='remove doDel del' val='{$childMenu.id}' title='删除'>删除</a>
						</td>
						
					</tr> 
            </volist>            
       </volist>    
					
					
				 	
			 
		 
		</tbody>
	</table> 
</div>