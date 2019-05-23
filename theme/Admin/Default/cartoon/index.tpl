<div class="nav"><span>歌词管理</span></div>
<div class="explain">
	<div class="name"><span>操作提示</span></div>
	<div class="con">
		<p>歌词管理主要负责只有歌词信息展示等</p>
	</div> 
</div>
<form method="get" action="{:url(SYS_PATH.'/'.CONTROLLER.'/add')}" class="ajaxSearchFrom">
	<div class="filter">
		<a href="javascript:void(0);" data-url="{:url(SYS_PATH.'/'.CONTROLLER.'/edit')}" class="add dialog"
		   data-height="500px" data-width="850px" title="添加歌词">歌词</a>
	</div>
</form>
<form action="{:url(SYS_PATH."/".CONTROLLER."/listDelete")}" id="formsubmit" class="formvalidate2">
<div class="main"> 
	<table width="100%" class="ltable">
	  	<thead>
		  	<tr> 
            	<th width="50"><input type="checkbox" class="checked_all" id="checkboxall"></th>
				<th width="80">编号</th>
				<th width="100">歌词分类</th>
                <th width="100">歌词名称</th>
				<th width="100">封面</th>
				<th width="100">是否推荐</th>
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
							<if condition="isset($vo['cid'])&&$vo['cid']">
								<a data-url="{:url(SYS_PATH."/".CONTROLLER."/index",array("cid"=>$vo['cid']))}"
								   href="javascript:void(0);">
									<zhimeng table="poetry_category" where="['id','=',$vo['cid']]">
                                        {$r.title}
									</zhimeng>
								</a>
								<else/>
								<span style="color:red;">未选择分类</span>
							</if>
						</td>
						<td>{$vo.title}</td>
						<td>
							<if condition="$vo.image">
								<img src="{$vo.image}" width="20" height="20" />
								<else />
								无
							</if>
						</td>
						<td width="250">
							<img class="pointer"
								 data-url='{:url(SYS_PATH."/".CONTROLLER."/reStatus",array("id"=>$vo["id"]))}'
								 data-id="{$vo.id}" style="cursor: pointer;" data-field="is_recommend" data-value="{$vo.is_recommend}"
								 src="/public/admin/default/images/icon_{$vo.is_recommend}.png"
								 alt="{$vl['is_recommend'] == 1 ? '启用' : '停用'}" title="{$vl['is_recommend'] == 1 ? '启用' : '停用'}"/>
						</td>
						<td>
                            {$vo.sort}
						</td>

						<td>{$vo.create_time|date='Y-m-d H:i:s'}</td>
						<td>
                              <a href='javascript:void(0);'  data-url='{:url(SYS_PATH."/".CONTROLLER."/edit",array("id"=>$vo["id"]))}'  class='dialog edit' alt='编辑' title='编缉'  data-height="500px" data-width="850px">编缉</a>
							 <a href='javascript:void(0);' data-url='{:url(SYS_PATH."/".CONTROLLER."/doDelete","id=$vo[id]")}' class='remove doDel del' val='{$vo.id}' title='删除'>删除</a>
						</td>
					</tr> 
       </volist>
				 
			 
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