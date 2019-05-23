<div class="nav"><span>模型管理</span></div>
<div class="filter"> 
	<a href="javascript:;"  title='添加模型'  class="add dialog" data-url="{:url(SYS_PATH."/module/add")}" data-height='350px' data-width='750px'>添加模型</a> 
</div>
<div class="main"> 
	<table width="100%" class="ltable">
	  	<thead>
		  	<tr>
				<th width="30"><input type="checkbox" class="checked_all"/></th>
				<th width="150">模型名称</th>
				<th width="250">模型表名</td>
				<th width="100">模型类型</th>
				<th width="250">模型描述</th>
				<th width="100" class="center">字段管理</th>
				<th width="140">操作</th>
				<th></th>
		  	</tr>
	  	</thead>
		<tbody>
			<empty name="list">
							<tr>
								<td height="50" colspan="8" align="center" style="text-align:center;">没有数据</td>
							</tr>                        
            </empty>
            <volist name="list" id="vo">
			<tr>
						<td nowrap="nowrap" style="text-align:center;"><input type="checkbox" name="id[]" value="{:isset($vo['id'])?$vo['id']:''}" class="checkSon va_m" /></td>
						<td  nowrap="nowrap">{:isset($vo['title'])?$vo['title']:''}</td>
						<td nowrap="nowrap">{:isset($vo['table'])?$vo['table']:''}</td>						
                        <td>
                        <if condition="isset($vo['system'])&&$vo['system']==1"> 系统默认</if>
                        <if condition="isset($vo['system'])&&$vo['system']==0"> 用户定义</if>
                        </td>
						
						<td nowrap="nowrap">{:isset($vo['desc'])?$vo['desc']:''}</td>		
                        <td nowrap="nowrap"><a href="javascript:void(0);" data-height='450px' data-width='800px' class='edit dialog' title="管理字段" data-url="{:url(SYS_PATH."/fields/index",array("module_id"=>$vo["id"]))}">管理字段</a></td>				
						<td nowrap="nowrap">
  <a href='javascript:void(0);'  data-url='{:url(SYS_PATH."/".CONTROLLER."/edit",array("id"=>$vo["id"]))}'  class='edit dialog' alt='编辑' title='编辑'   data-height='350px' data-width='750px'>编缉</a>
 <a href='javascript:void(0);' data-url='{:url(SYS_PATH."/".CONTROLLER."/doDelete","id=$vo[id]")}' class='remove doDel del' val='{$vo.id}' title='删除'>删除</a>  						</td>
						<td></td>
					</tr>
                      </volist>              
		</tbody>
	</table>
</div>

