<div class="nav"><span>上传设置</span></div>
<div class="explain">
	<div class="name"><span>操作提示</span></div>
	<div class="con">
		<p>配置各模块图片上传的裁剪像素。</p>
		<p>配置各模块图片上传的水印。</p> 
	</div> 
</div>
<div class="filter"> 
	<a href="javascript:;" title="添加配置" class="add dialog" data-url="{:url(SYS_PATH."/".CONTROLLER."/imgset_edit")}" data-height="420px" data-width="750px">添加配置</a> 
</div>
<div class="main"> 
	<table width="100%" class="ltable">
		<thead>
			<tr>
				<th width="130">别名名称</th>
				<th width="100">宽度</th> 
				<th width="100">高度</th>
                <th width="50">水印状态</th>
				<th width="200">水印位置</th>
                <th width="100">添加时间</th>
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
				<td>{$vo.data.width}px</td> 
				<td>{$vo.data.height}px</td> 
                <td><img src="/public/admin/default/images/icon_{$vo.data.water_status}.png"></td>
				<td>
                <if condition="$vo.data.water_position eq 1"> 左上角水印</if>
                <if condition="$vo.data.water_position eq 2"> 上居中水印</if>
                <if condition="$vo.data.water_position eq 3"> 右上角水印</if>
                <if condition="$vo.data.water_position eq 4"> 左居中水印</if>
                <if condition="$vo.data.water_position eq 5"> 居中水印</if>
                <if condition="$vo.data.water_position eq 6"> 右居中水印</if>
                <if condition="$vo.data.water_position eq 7"> 左下角水印</if>
                <if condition="$vo.data.water_position eq 8"> 下居中水印</if>
                <if condition="$vo.data.water_position eq 9"> 右下角水印</if>            
            </td> 
                <td style=" text-align:left; padding-left:15px;">{$vo.c_create_time|date='Y-m-d'}</td> 
				<td><img class="pointer" data-id="{$vo.id}"  data-url="{:url(SYS_PATH."/".CONTROLLER."/imgset_dostatus")}" style="cursor: pointer;" data-value="{$vo.status}" src="/public/admin/default/images/icon_{$vo.status}.png">
                </td>                
				<td>
					<a href="javascript:void(0);" data-url="{:url(SYS_PATH.'/setting/imgset_edit',array('c_key'=>$vo.c_key))}" data-width="750px" title="配置{$vo.c_value_desc}" data-height="420px" class="dialog edit">编缉</a>
					<a href="javascript:void(0);" data-url="{:url(SYS_PATH.'/setting/imgsetDelete',array('c_key'=>$vo.c_key))}" title="{$vo.name}" class="del remove">删除</a>
				</td> 

				<td></td>
			</tr>
            </volist>
	</tbody>
</table> 
<script language="javascript">
$(document).ready(function() {
	 $(document).off("click", ".setting_button");
	 $(document).on("click", ".setting_button", function () {
		var dataurl = $(this).attr("data-url");
		var dataid = $(this).attr("data-id");
		var txt = "确定更改短信接口吗？";
		var option = {
			btn: parseInt("0011", 2),
			onOk: function() {
				$.getJSON(dataurl, {
					dataid: dataid
				},
				function(data) {
					if (data.status == 0) {
						window.wxc.xcConfirm(data.msg, window.wxc.xcConfirm.typeEnum.error);
					} else {
						var current_load_url = $("#current_load_url").val();
						window.wxc.xcConfirm(data.msg, window.wxc.xcConfirm.typeEnum.success, {
							onOk: function() {
								if (current_load_url != "") {
									$(".right").load(current_load_url);
								} else {
									window.location.reload();
								}
							}
						});
	
					}
				});
			}
		}
		window.top.wxc.xcConfirm(txt, window.top.wxc.xcConfirm.typeEnum.confirm, option);		
	
	});
});
</script>
