<div class="nav"><span>验证码设置</span></div>
<div class="explain">
	<div class="name"><span>操作提示</span></div>
	<div class="con">
		<p>配置前后台验证码的显示。</p>
	</div> 
</div>

<div class="main"> 
	<table width="100%" class="ltable">
		<thead>
			<tr>
				<th width="130">验证码名称</th>
                <th width="130">类型</th>
				<th width="100">宽度</th> 
				<th width="100">高度</th>
                <th width="100">长度</th>
                <th width="80">开启状态</th> 
				<th width="150">操作</th>
				<th></th>
			</tr>
		</thead>
		<tbody>
        
			<empty name="listData">
				<tr><td height="50" colspan="8" align="center" style="text-align:center;">没有数据</td></tr>                        
            </empty>  
		<volist name="listData" id="vo">
			<tr>
				<td>{$vo.c_value_desc}</td> 
                <td>
					<if condition="$vo.data.code_type==0">大小写字母</if>
					<if condition="$vo.data.code_type==1">纯数字</if>
					<if condition="$vo.data.code_type==2">大写字母</if>
					<if condition="$vo.data.code_type==3">小写字母</if>
					<if condition="$vo.data.code_type==4">中文字符</if>
				</td>
				<td>{$vo.data.code_width}px</td>
				<td>{$vo.data.code_height}px</td>
                <td>{$vo.data.code_length}位</td>
				<td><img class="pointer" data-id="{$vo.id}"  data-url="{:url(SYS_PATH."/".CONTROLLER."/code_dostatus")}" style="cursor: pointer;" data-value="{$vo.status}" src="/public/admin/default/images/icon_{$vo.status}.png">
                </td>                
				<td>
					<a href="javascript:void(0);" data-url="{:url(SYS_PATH.'/setting/code_edit',array('c_key'=>$vo.c_key))}" data-width="650px" title="配置{$vo.c_value_desc}" data-height="220px" class="dialog edit">编缉</a>
				</td> 

				<td></td>
			</tr>
            </volist>
	</tbody>
</table> 
