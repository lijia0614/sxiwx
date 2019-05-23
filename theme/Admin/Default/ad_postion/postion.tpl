<div class="nav"><span>广告位列表</span></div>  
<div class="filter">
    	<a href="javascript:;"  title='添加广告位'  class="add dialog" data-url='{:url(SYS_PATH."/AdPostion/add")}' data-height='200px' data-width='600px'>添加广告位</a> 
</div>
<div class="main">  
	<table class="ltable">
	  	<thead>
		  	<tr>
            	<th width="150">ID标识</td>
				<th width="150">广告位标签</td> 
				<th width="300">广告位名称</td> 
				<th width="150">添加时间</td> 
				<th width="150">操作</td> 
				<th></th>
		  	</tr>
	  	</thead>
		<tbody>
			<empty name="list">
				<tr>
				<td height="50" colspan="5" align="center" style="text-align:center;">没有数据</td>
				</tr>                        
            </empty>
            <volist name="list" id="vo">
			<tr>
						<td>{$vo.id}</td>
                        <td>{$vo.alias}</td>
                        <td style="text-align:center;">{$vo.name}</td>
						<td style="text-align:center;">{$vo.create_time|date='Y-m-d H:i:s'}</td>	
                        <td style="text-align:center;">
							<a href="javascrip:;" data-url='{:url(SYS_PATH."/AdPostion/edit",array("id"=>$vo["id"]))}'  class='dialog edit' alt='编辑' title='编辑'  data-height='200px' data-width='600px'>编辑</a>
							<a href="javascript:;" data-url='{:url(SYS_PATH."/AdPostion/doDelete","id=$vo[id]")}' class='remove doDel del' val='{$vo.id}' title='删除'>删除</a>
                        </td>	                       										
			</tr>
        </volist> 
				</tr>
		</tbody> 
	</table> 
	<div class="page">{$page|raw}</div>
</div>
