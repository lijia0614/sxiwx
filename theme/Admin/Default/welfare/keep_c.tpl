<div class="nav"><span>类型管理</span></div>
<div class="explain">
	<div class="name"><span>操作提示</span></div>
	<div class="con">
		<p>类型主要负责续约奖励的类型</p>
	</div>
</div>
<form method="get" action="{:url(SYS_PATH."/".CONTROLLER."/index")}" class="formvalidate">
	<div class="filter">
		<a href="javascript:void(0);" data-url="{:url(SYS_PATH.'/'.CONTROLLER.'/addKeep')}" class="add dialog" data-height="500px" data-width="850px" title="添加类型">添加类型</a>
	</div>
</form>
<form action="{:url(SYS_PATH."/".CONTROLLER."/listDelete")}" id="formsubmit" class="formvalidate2">
<div class="main"> 
	<table width="100%" class="ltable">
	  	<thead>
		  	<tr> 
            	<th width="50"><input type="checkbox" class="checked_all" id="checkboxall"></th>
				<th width="80">编号</th>
				<th width="120">前一部签约作品完本字数</th>
				<th width="120">奖励金额</th>
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
					<td>{$vo.info}</td>
					<td>
						<a href='javascript:void(0);'  data-url='{:url(SYS_PATH."/".CONTROLLER."/keepEdit",array("id"=>$vo["id"]))}'  class='dialog edit' alt='编辑' title='编缉'  data-height="500px" data-width="850px">编缉</a>
						<a href='javascript:void(0);'  data-url='{:url(SYS_PATH."/".CONTROLLER."/delkeep",array("id"=>$vo["id"]))}'  class='remove doDel del' alt='删除' title='删除'  data-height="500px" data-width="850px">删除</a>
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