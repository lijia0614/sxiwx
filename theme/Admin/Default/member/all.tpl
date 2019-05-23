<div class="nav"><span>用户列表</span></div>

<div class="explain">
	<div class="name"><span>操作提示</span></div>
	<div class="con">
		<p>用户列表主要为用户信息展示等</p>
	</div> 
</div>

<form method="get" action="{:url(SYS_PATH."/".CONTROLLER."/index")}" class="ajaxSearchFrom">

<div class="filter">
	<div class="sch">
		<div style="float: left;margin-right: 10px;" class="k_input">
			<input type="text"  class="form_input" onclick="laydate({istime: true, format: 'YYYY-MM-DD'});" validate="{ required:true,maxlength:300}" value="{$start_date}" name="start_date" placeholder="注册开始时间">
		</div>
		<div style="float: left;margin-right: 10px;" class="k_input">
			<input type="text"  class="form_input" onclick="laydate({istime: true, format: 'YYYY-MM-DD'});" validate="{ required:true,maxlength:300}" value="{$end_date}" name="end_date" placeholder="注册结束时间">
		</div>
		<input type="text" style="width: 200px;" name="keyword" class="text" value="{$keyword|default=''}" placeholder="手机号、姓名">
		<input type="button" data-url="{:url(SYS_PATH."/".CONTROLLER."/index")}" class="submit searchButton" value="搜索">
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
				<th width="80">手机号码</th>
				<th width="80">真实姓名</th>
				<th width="80">昵称</th>
				<th width="100">性别</th>
				<th width="80">微信用户</th>
				<th width="100">余额(书币)</th>
				<th width="80">注册时间</th>
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
					{$vo.phone}
				</td>
				<td>
					<if condition="$vo.name">
                        {$vo.name}
						<else/>
						<span style="color: pink">未填</span>
					</if>
				</td>
				<td>
					<if condition="$vo.unionid">
                        {$vo.pen_name}
						<else/>
						<span style="color: pink">未填</span>
					</if>
				</td>
				<td>
					<if condition="$vo.sex eq 1">
                        男
						<elseif($vo.sex eq 2)/>
						女
						<else/>
						<span style="color: pink">未填</span>
					</if>
				</td>
				<td>
					<if condition="$vo.unionid">
                        是
						<else/>
						<span style="color: pink">否</span>
					</if>
				</td>
				<td>
                    {$vo.money}
				</td>

				<td>
                    {$vo.time|date='Y-m-d H:i'}
				</td>

				<td>
					  <a href='javascript:void(0);'  data-url='{:url(SYS_PATH."/".CONTROLLER."/edit",array("id"=>$vo["id"]))}'  class='dialog edit' alt='编辑' title='编缉'  data-height="500px" data-width="850px">编缉</a>
					 <a href='javascript:void(0);' data-url='{:url(SYS_PATH."/".CONTROLLER."/del",array("id"=>$vo["id"]))}' class='remove doDel del' val='{$vo.id}' title='删除'>删除</a>
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