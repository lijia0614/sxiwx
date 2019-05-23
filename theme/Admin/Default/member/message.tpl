<div class="nav"><span>用户评论</span></div>
<div class="explain">
	<div class="name"><span>操作提示</span></div>
	<div class="con">
		<p>用户评论列表主要为书籍评论信息展示等</p>
	</div>
</div>
<form method="get" action="{:url(SYS_PATH.'/'.CONTROLLER.'/message')}" class="ajaxSearchFrom">
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
				<input type="text" name="keyword" value="{$keyword|default=''}" placeholder="手机号、书籍名">
			</div>
			<div class="query-btn ue-clear">
				<a style="margin-top: 5px; margin-left: 20px;" href="javascript:;" class="confirm searchButton"
				   data-url="{:url(SYS_PATH."/".CONTROLLER."/message")}">查询</a>
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
				<th width="80">评论书籍</th>
				<th width="120">用户信息</th>
				<th width="280">评论内容</th>
				<th width="80">评论时间</th>
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
				<td>
                    {$vo.id}
				</td>
				<td>
					{$vo.b_name}
				</td>
				<td>
					<if condition="$vo.phone">
						{$vo.phone}
						<else/>
						<if condition="$vo.unionid">
							{$vo.pen_name}-<span style="color: pink">微信用户</span>
						</if>
					</if>
				</td>
				<td>
					{$vo.content|trimhtml=0,50,true}
				</td>

				<td>
                    {$vo.time|date='Y-m-d H:i'}
				</td>

				<td>
					  <a href='javascript:void(0);'  data-url='{:url(SYS_PATH."/".CONTROLLER."/msgEdit",array("id"=>$vo["id"]))}'  class='dialog edit' alt='编辑' title='编缉'  data-height="500px" data-width="850px">详情</a>
					 <a href='javascript:void(0);' data-url='{:url(SYS_PATH."/".CONTROLLER."/delMsg",array("id"=>$vo["id"]))}' class='remove doDel del' val='{$vo.id}' title='删除'>删除</a>
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