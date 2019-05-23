<div class="nav"><span>衍生推荐</span></div>
<div class="explain">
	<div class="name"><span>操作提示</span></div>
	<div class="con">
		<p>衍生推荐管理主要负责前台福利页面中的衍生推荐展示等</p>
	</div>
</div>
<form action="{:url(SYS_PATH."/".CONTROLLER."/listDelete")}" id="formsubmit" class="formvalidate2">
<div class="main"> 
	<table width="100%" class="ltable">
	  	<thead>
		  	<tr> 
            	<th width="50"><input type="checkbox" class="checked_all" id="checkboxall"></th>
				<th width="80">编号</th>
				<th width="120">标题</th>
				<th width="120">图片</th>
				<th width="130">操作</th>
		  	</tr>
	  	</thead>
		<tbody> 
			<empty name="data">
				<tr><td height="50" colspan="9" align="center" style="text-align:center;">没有数据</td></tr>                        
            </empty>         

			<tr>
				<td><input type="checkbox" name="ids[]" value="{$vo.id}" class="checked_list checkAll"/></td>
				<td>{$data.id}</td>

				<td>{$data.title}</td>
				<td><if condition="$data.image"><img src="{$data.image}" width="120" /><else />无</if></td>
				<td>
					  <a href='javascript:void(0);'  data-url='{:url(SYS_PATH."/".CONTROLLER."/edit",array("id"=>$data["id"]))}'  class='dialog edit' alt='编辑' title='编缉'  data-height="500px" data-width="850px">编缉</a>
				</td>
			</tr>

				 
			 
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