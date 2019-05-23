<div class="nav"><span>打赏列表</span></div>
<form method="get" action="{:url(SYS_PATH.'/'.CONTROLLER.'/reward')}" class="ajaxSearchFrom">
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
				<input type="text" name="keyword" value="{$keyword|default=''}" placeholder="书籍、手机号、作者、礼物">
			</div>
			<div class="query-btn ue-clear">
				<a style="margin-top: 5px; margin-left: 20px;" href="javascript:;" class="confirm searchButton"
				   data-url="{:url(SYS_PATH."/".CONTROLLER."/reward")}">查询</a>
			</div>
		</div>
	</div>
</form>
	<div class="filter">
		<div class="button_bottom"><input type="button" class="button" value="总打赏量 : {$total} 书币"></div>
		<div class="button_bottom"><input type="button" class="button" value="当前页打赏量 : {$now_total} 书币"></div>
	</div>

<form action="{:url(SYS_PATH."/".CONTROLLER."/listDelete")}" id="formsubmit" class="formvalidate2">
<div class="main"> 
	<table width="100%" class="ltable">
	  	<thead>
		  	<tr> 
            	<th width="50"><input type="checkbox" class="checked_all" id="checkboxall"></th>
				<th width="80">编号</th>
				<th width="80">书籍名称</th>
				<th width="80">作者</th>
				<th width="100">打赏用户(手机号码)</th>
				<th width="100">用户真实姓名</th>
				<th width="100">用户昵称</th>
				<th width="100">打赏物品</th>
				<th width="100">打赏数量</th>
				<th width="100">打赏总额(书币)</th>
				<th width="100">用户余额(书币)</th>
				<th width="80">打赏时间</th>
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
					<a href='javascript:void(0);'  data-url='{:url(SYS_PATH."/book/chapter",array("id"=>$vo["b_id"]))}'  class="category_select_class" alt='{$vo.name}' title='点击查看该书'  data-height="500px" data-width="850px">{$vo.name}</a>

				</td>
				<td>
                    {$vo.author}
				</td>
				<td>
					<if condition="!$vo['phone']">

						<if condition="$vo['unionid']">
							<span style="color: pink">微信用户</span>
						</if>
						<else/>
                        {$vo.phone}
					</if>
				</td>
				<td>
                    {$vo.u_name}
				</td>
				<td>
                    {$vo.pen_name}
				</td>
				<td>
                    {$vo.gift_name}
				</td>
				<td>
                    {$vo.number}
				</td>
				<td>
                    {$vo.total}
				</td>
				<td>
                    {$vo.money}
				</td>
				<td>
                    {$vo.time|date='Y-m-d H:i'}
				</td>
				<td>
					  <a href='javascript:void(0);'  data-url='{:url(SYS_PATH."/".CONTROLLER."/rewardEdit",array("id"=>$vo["id"]))}'  class='dialog edit' alt='编辑' title='编缉'  data-height="500px" data-width="850px">编缉</a>
					 <a href='javascript:void(0);' data-url='{:url(SYS_PATH."/".CONTROLLER."/rewardDel",array("id"=>$vo["id"]))}' class='remove doDel del' val='{$vo.id}' title='删除'>删除</a>
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