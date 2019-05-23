<div class="nav"><span>{:lang(strtolower(CONTROLLER))}</span></div>  
<div class="explain">
	<div class="name"><span>操作提示</span></div>
	<div class="con">
		<p>产品展示管理主要负责只有产品介绍的内容信息。缩略图，多图展示等</p>
	</div> 
</div>
<form method="get" action="{:url(SYS_PATH."/".CONTROLLER."/index")}" class="formvalidate">
<div class="filter">
		<div class="sch">
			<input type="text" name="keyword" class="text" value="{$keyword|default=''}" placeholder="请输入关键字">
			<input type="button" class="submit searchButton" value="搜索">
		</div>
	<a href="javascript:void(0);" data-url="{:url(SYS_PATH.'/'.CONTROLLER.'/add')}" class="add dialog" data-height="500px" data-width="850px" title="添加产品">添加产品</a>
</div>
</form>
<form action="{:url(SYS_PATH."/".CONTROLLER."/listDelete")}" id="formsubmit" class="formvalidate2">
<div class="main"> 
	<table width="100%" class="ltable">
	  	<thead>
		  	<tr> 
            	<th width="50"><input type="checkbox" class="checked_all" id="checkboxall"></th>
				<th width="80">编号</th>
				<th width="100">分类</th>
                <th width="100">图片</th>
				<th>标题</th>
				<th width="120">浏览量</th>
				<th width="60">状态</th>
                <th width="150">添加时间</th>
                <th width="150">修改时间</th>
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
                        <if condition="isset($vo['category_name'])&&$vo['category_name']">
                        <a data-url="{:url(SYS_PATH."/".CONTROLLER."/index",array("cid"=>$vo['cid']))}" href="javascript:void(0);" class="category_select_class">{$vo['category_name']}</a>
                        <else />
                        <span style="color:red;">未选择分类</span>
                        </if>                        
                        </td> 
                        <td><if condition="$vo.image"><img src="{$vo.image}" width="20" height="20" /><else />无</if></td>
						<td>{$vo.title}</td>
						<td>{$vo.click}</td>
						<td><img class="pointer" data-id="{$vo.id}"  data-url="{:url(SYS_PATH."/".CONTROLLER."/dostatus")}" style="cursor: pointer;" data-value="{$vo.status}" src="/public/admin/default/images/icon_{$vo.status}.png"> </td> 
                        <td>{$vo.create_time|date='Y-m-d H:i:s'}</td>
                        <td>{$vo.update_time|date='Y-m-d H:i:s'}</td>
						<td>
                              <a href='javascript:void(0);'  data-url='{:url(SYS_PATH."/".CONTROLLER."/edit",array("id"=>$vo["id"]))}'  class='dialog edit' alt='编辑' title='编缉'  data-height="500px" data-width="850px">编缉</a>
							 <a href='javascript:void(0);' data-url='{:url(SYS_PATH."/".CONTROLLER."/doDelete","id=$vo[id]")}' class='remove doDel del' val='{$vo.id}' title='删除'>删除</a>
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