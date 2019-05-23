<div class="nav"><span>系统登录日志</span></div>
<div class="explain">
	<div class="name"><span>提示</span></div>
	<div class="con">
		<p>查看是用户登录时间, 系统是否被别人使用 。</p>
	</div> 
</div>
<div class="main"> 
	<table width="100%" class="ltable">
		<thead>
			<tr>
				<th width="130">编号</th>
				<th width="150">用户名</th> 
				<th width="200">登录时间</th> 
				<th width="400">登录IP</th> 
				<th></th>
			</tr>
		</thead>
		<tbody>            
			<empty name="list">
				<tr>
				<td height="50" colspan="4" align="center" style="text-align:center;">没有数据</td>
				</tr>                        
            </empty>
            <volist name="list" id="vo">
			<tr>
						<td style="text-align:center;">{$vo.id}</td>
                        <td style="text-align:center;">{$vo.u_name}</td>
						<td  style="text-align:center;">{$vo.create_time|date='Y-m-d H:i:s'}</td>
                        <td  style="text-align:center;">{$vo.log_ip}</td>	                       										
			</tr>
        </volist>             
				</tbody>
</table> 
<div class="pageList">{$page|raw}</div>
</div>
