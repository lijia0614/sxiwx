<div class="nav"><span>歌曲管理</span></div>
<div class="explain">
	<div class="name"><span>操作提示</span></div>
	<div class="con">
		<p>歌曲管理主要负责只有歌曲信息等</p>
	</div> 
</div>
<form method="get" action="{:url(SYS_PATH.'/'.CONTROLLER.'/addMusic')}" class="ajaxSearchFrom">
	<div class="filter">
		<a href="javascript:void(0);" data-url="{:url(SYS_PATH.'/'.CONTROLLER.'/addMusic')}" class="add dialog"
		   data-height="500px" data-width="850px" title="添加歌曲">歌曲</a>
	</div>
</form>
<form action="{:url(SYS_PATH."/".CONTROLLER."/listDelete")}" id="formsubmit" class="formvalidate2">
<div class="main"> 
	<table width="100%" class="ltable">
	  	<thead>
		  	<tr> 
            	<th width="50"><input type="checkbox" class="checked_all" id="checkboxall"></th>
				<th width="80">编号</th>
				<th width="100">语种</th>
                <th width="100">风格</th>
				<th width="100">情感</th>
				<th width="100">封面</th>
				<th width="100">歌曲</th>
				<th width="80">排序</th>
				<th width="80">创建时间</th>
				<th width="130">操作</th>
		  	</tr>
	  	</thead>
		<tbody> 
			<empty name="list">
				<tr><td height="50" colspan="9" align="center" style="text-align:center;">没有数据</td></tr>                        
            </empty>         
			<volist name="list" id="vo">
				<tr>
					<td><input type="checkbox" name="ids[]" value="{$vo.id}" class="checked_list checkAll"/></td>
					<td>{$vo.id}</td>
					<td>
                        {$vo.lang}
					</td>
					<td>{$vo.type}</td>
					<td>
                        {$vo.feel}
					</td>
					<td>
                        <image style="max-height: 75px;" src="{$vo.image}"/>
					</td>
					<td width="250">
                        {$vo.title}
					</td>
					<td>
						{$vo.sort}
					</td>

					<td>{$vo.create_time|date='Y-m-d H:i:s'}</td>
					<td>
						  <a href='javascript:void(0);'  data-url='{:url(SYS_PATH."/".CONTROLLER."/editMusic",array("id"=>$vo["id"]))}'  class='dialog edit' alt='编辑' title='编缉'  data-height="500px" data-width="850px">编缉</a>
						 <a href='javascript:void(0);' data-url='{:url(SYS_PATH."/".CONTROLLER."/delMusic","id=$vo[id]")}' class='remove doDel del' val='{$vo.id}' title='删除'>删除</a>
					</td>
				</tr>
		   </volist>
		</tbody>
	</table>
	<div class="filter">
		<div class="pageList">&nbsp;&nbsp;{$page|raw}</div>
	</div>
   
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