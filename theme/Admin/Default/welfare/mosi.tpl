<div class="nav"><span>模式管理</span></div>
<div class="explain">
	<div class="name"><span>操作提示</span></div>
	<div class="con">
		<p>模式管理主要负责签约模式的类型</p>
	</div>
</div>
<form method="get" action="{:url(SYS_PATH."/".CONTROLLER."/index")}" class="formvalidate">
	<div class="filter">
		<a href="javascript:void(0);" data-url="{:url(SYS_PATH.'/'.CONTROLLER.'/addMosi')}" class="add dialog" data-height="500px" data-width="850px" title="添加模式">添加模式</a>
	</div>
</form>
<form action="{:url(SYS_PATH."/".CONTROLLER."/listDelete")}" id="formsubmit" class="formvalidate2">
<div class="main"> 
	<table width="100%" class="ltable">
	  	<thead>
		  	<tr> 
            	<th width="50"><input type="checkbox" class="checked_all" id="checkboxall"></th>
				<th width="80">编号</th>
				<th width="120">标题</th>
				<th width="120">图片</th>
				<th width="120">类型</th>
				<th width="130">操作</th>
		  	</tr>
	  	</thead>
		<tbody> 
			<empty name="data">
				<tr><td height="50" colspan="9" align="center" style="text-align:center;">没有数据</td></tr>                        
            </empty>         
			<volist name="data" id="vo">
				<tr>
					<td><input type="checkbox" name="ids[]" value="{$vo.id}" class="checked_list checkAll"/></td>
					<td>{$vo.id}</td>

					<td>{$vo.title}</td>
					<td><if condition="$vo.image"><img src="{$vo.image}" width="120" /><else />无</if></td>
					<td>{$vo.type}</td>
					<td>
						<a href='javascript:void(0);'  data-url='{:url(SYS_PATH."/".CONTROLLER."/mosiEdit",array("id"=>$vo["id"]))}'  class='dialog edit' alt='编辑' title='编缉'  data-height="500px" data-width="850px">编缉</a>
						<a href='javascript:void(0);'  data-url='{:url(SYS_PATH."/".CONTROLLER."/delMosi",array("id"=>$vo["id"]))}'  class='remove doDel del' alt='删除' title='删除'  data-height="500px" data-width="850px">删除</a>
					</td>
				</tr>
			</volist>
		</tbody>
	</table>

   
</div>
</form>
<script language="javascript">
		$(document).ready(function() {
				$('#checkboxall').click(function() {
					$('.checkAll').each(function() {
						if ($(this).is(':checked') == true) {
							$(this).removeAttr('checked')
						} else {
							$(this).prop('checked', 'true');
						}
					})
				});
			});
</script>