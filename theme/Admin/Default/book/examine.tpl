<div class="nav"><span>未审核章节列表</span></div>
<div class="explain">
	<div class="name"><span>操作提示</span></div>
	<div class="con">
		<p>章节管理主要负责只有章节信息展示等</p>
	</div>

</div>
<form method="get" action="{:url(SYS_PATH.'/'.CONTROLLER.'/examine')}" class="ajaxSearchFrom">
	<div class="query">
		<div class="query-conditions ue-clear">

			<div class="conditions name ue-clear">
				<label>时间查询：</label>
				<div style="float: left;margin-right: 10px;" class="k_input">
					<input style="height: 18px;" type="text"  class="form_input" onclick="laydate({istime: true, format: 'YYYY-MM-DD'});" validate="{ required:true,maxlength:300}" value="{$start_date}" name="start_date" placeholder="开始时间">
				</div>
				<div style="float: left;margin-right: 10px;" class="k_input">
					<input style="height: 18px;" type="text"  class="form_input" onclick="laydate({istime: true, format: 'YYYY-MM-DD'});" validate="{ required:true,maxlength:300}" value="{$end_date}" name="end_date" placeholder="结束时间">
				</div>
			</div>
			<!--<div style="clear: both;"></div>-->
			<div class="conditions staff ue-clear">
				<label>关键词：</label>
				<input type="text" name="keyword" value="{$keyword|default=''}" placeholder="章节名称、书籍名称">
			</div>
			<div class="query-btn ue-clear">
				<a style="margin-top: 5px; margin-left: 20px;" href="javascript:;" class="confirm searchButton"
				   data-url="{:url(SYS_PATH."/".CONTROLLER."/examine")}">查询</a>
			</div>
		</div>
	</div>
</form>
<form action="{:url(SYS_PATH."/".CONTROLLER."/listDelete")}" id="formsubmit" class="formvalidate2">
<div class="main"> 
	<table width="100%" class="ltable">
	  	<thead>
		  	<tr> 
            	<th width="50"><input type="checkbox" class="checked_all" id="checkboxall"></th>
				<th width="80">编号</th>
                <th width="100">章节名</th>
				<th width="80">书籍名称</th>
				<th width="80">审核</th>
				<th width="80">提交时间</th>
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
					{$vo.name}
				</td>
				<td>
					<a href='javascript:void(0);'  data-url='{:url(SYS_PATH."/".CONTROLLER."/chapter",array("id"=>$vo["b_id"]))}'  class="category_select_class" alt='{$vo.b_name}' title='点击查看所有章节'  data-height="500px" data-width="850px">{$vo.b_name}</a>
				</td>
				<td>
					<img class="pointer" data-url='{:url(SYS_PATH."/".CONTROLLER."/editChapterStatus",array("id"=>$vo["id"]))}' data-id="{$vo.id}" style="cursor: pointer;" data-field="status" data-value="{$vo.status}" src="/public/admin/default/images/icon_{$vo.status}.png" alt="{$vl['status'] == 1 ? '启用' : '停用'}" title="{$vl['status'] == 1 ? '启用' : '停用'}" />
				</td>
				<td>
                    {$vo.time|date='Y-m-d H:i'}
				</td>
				<td>
					  <a href='javascript:void(0);'  data-url='{:url(SYS_PATH."/".CONTROLLER."/chapterEdit",array("id"=>$vo["id"]))}'  class='dialog edit' alt='编辑' title='编缉'  data-height="500px" data-width="850px">编缉</a>
					 <a href='javascript:void(0);' data-url='{:url(SYS_PATH."/".CONTROLLER."/chapterDel",array("id"=>$vo["id"],"b_id"=>$vo["b_id"]))}' class='remove doDel del' val='{$vo.id}' title='删除'>删除</a>
				</td>
			</tr>
       </volist>
				 
			 
		</tbody>
	</table>
    <div class="filter">
    	<div class="button_bottom"><!--<input type="button" class="button" value="导出EXCEL表">--><input type="button" style="background-color:#999; border-color:#999;" class="button listDelete" value="删除选中"></div>
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