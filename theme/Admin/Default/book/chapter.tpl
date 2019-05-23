<div class="nav"><span>{$book}</span></div>
<script src="/public/layer/layer.js"></script>
<div class="explain">
	<div class="name"><span>操作提示</span></div>
	<div class="con">
		<p>章节管理主要负责只有章节信息展示等</p>
	</div> 
</div>
<form method="get" action="{:url(SYS_PATH."/".CONTROLLER."/chapter",['b_id'=>$b_id])}" class="ajaxSearchFrom">
<div class="filter">
		<div class="sch">
			<input name="id" type="hidden" value="{$b_id}">
			<input type="text" name="keyword" class="text" value="{$keyword|default=''}" placeholder="章节名称">
			<input type="button" data-url="{:url(SYS_PATH."/".CONTROLLER."/chapter")}" class="submit searchButton" value="搜索">
		</div>
	<a href="javascript:void(0);" data-url="{:url(SYS_PATH.'/'.CONTROLLER.'/addChapter',['b_id'=>$b_id])}" class="add dialog" data-height="650px" data-width="950px" title="添加章节">添加章节</a>
	<a href="javascript:void(0);" data-url="{:url(SYS_PATH.'/'.CONTROLLER.'/chapter',['type'=>3,'id'=>$b_id])}" style="padding: 7px 15px; background: {$color1}; color: #fff; margin-right: 10px;" class="submit searchButton" title="未审核章节">
		未审核章节({$wei})
	</a>
	<a href="javascript:void(0);" data-url="{:url(SYS_PATH.'/'.CONTROLLER.'/chapter',['type'=>1,'id'=>$b_id])}" style="padding: 7px 15px; background: {$color2}; color: #fff; margin-right: 10px;" class="submit searchButton" title="已审核章节">
		已审核章节({$count})
	</a>

</div>
</form>
<form action="{:url(SYS_PATH."/".CONTROLLER."/listDelete")}" id="formsubmit" class="formvalidate2">
<div class="main"> 
	<table width="100%" class="ltable">
	  	<thead>
		  	<tr> 
            	<th width="50"><input type="checkbox" class="checked_all" id="checkboxall"></th>
                <th width="100">章节名</th>
				<th width="80">是否审核</th>
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
				<td>
					<if condition="$type eq 3">
						{$vo.title}
						<elseif condition="$type eq 4"/>
                        {$vo.chaptername}
						<else/>
                        {$vo.name}
					</if>
				</td>
				<td>
					<if condition="$type eq 3 || $type eq 4">
						<img class="pointer"  data-id="{$vo.id}" style="cursor: pointer;" data-field="status" data-value="{$vo.status}" src="/public/admin/default/images/icon_1.png" alt="{$vl['status'] == 1 ? '启用' : '停用'}" title="{$vl['status'] == 1 ? '启用' : '停用'}" />
						<else/>
						<img class="pointer" data-url='{:url(SYS_PATH."/".CONTROLLER."/editChapterStatus",array("id"=>$vo["id"]))}' data-id="{$vo.id}" style="cursor: pointer;" data-field="status" data-value="{$vo.status}" src="/public/admin/default/images/icon_{$vo.status}.png" alt="{$vl['status'] == 1 ? '启用' : '停用'}" title="{$vl['status'] == 1 ? '启用' : '停用'}" />
					</if>
				</td>
				<td>
					<if condition="$type eq 3">
                        {$vo.updateTime|date='Y-m-d H:i'}
						<elseif condition="$type eq 4"/>
						{$vo.postdate}
						<else/>
                        {$vo.time|date='Y-m-d H:i'}
					</if>
				</td>
				<td>
					<if condition="$type eq 3 || $type eq 4">
							<a href='javascript:void(0);' data-book-id="{$book_other_id}" data-type="{$type}" data-title="{$vo.title}" date-name="{$vo.chaptername}" data-id="{$vo["chapterid"]}" class='chapter_show other_show'>查看</a>
						<else/>
							<a href='javascript:void(0);' data-id="{$vo["id"]}" class='chapter_show this_show'>查看</a>
							<a href='javascript:void(0);' data-url='{:url(SYS_PATH."/".CONTROLLER."/chapterEdit",array("id"=>$vo["id"]))}'  class='dialog edit' alt='编辑' title='编缉' data-height="650px" data-width="950px">编缉</a>
							<a href='javascript:void(0);' data-url='{:url(SYS_PATH."/".CONTROLLER."/chapterDel",array("id"=>$vo["id"],"b_id"=>$vo["b_id"]))}' class='remove doDel del' val='{$vo.id}' title='删除'>删除</a>
					</if>
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
<script>
	$('.other_show').click(function () {
		var id = $(this).attr('data-id');
        var type = $(this).attr('data-type');
		var book_id = $(this).attr('data-book-id');
        var title = $(this).attr('data-title');
		if (type == 4){
		    title = $(this).attr('data-name');
        }
        $.ajax({
            url: "{:url(SYS_PATH."/".CONTROLLER."/getOtherChapter")}",
            data:{"id":id,"book_id":book_id,"title":title,"type":type},
            type: "POST",
            success: function (req) {
                var c = JSON.parse(req);
				console.log(c);
                if (c.status == 1) {
                    layer.open({
                        type: 1 //Page层类型
                        ,area: ['800px', '900px']
                        ,title: c.hidden
                        ,shade: 0.6 //遮罩透明度
                        ,maxmin: true //允许全屏最小化
                        ,anim: 1 //0-6的动画形式，-1不开启
                        ,content: c.data
                    });
                }
            }
        });
    })

    $('.this_show').click(function () {
        var id = $(this).attr('data-id');
        $.ajax({
            url: "{:url(SYS_PATH."/".CONTROLLER."/getChapter")}",
            data:{"id":id},
            type: "POST",
            success: function (req) {
                var c = JSON.parse(req);
                if (c.status == 1) {
                    layer.open({
                        type: 1 //Page层类型
                        ,area: ['800px', '900px']
                        ,title: c.data.name
                        ,shade: 0.6 //遮罩透明度
                        ,maxmin: true //允许全屏最小化
                        ,anim: 1 //0-6的动画形式，-1不开启
                        ,content: c.data.content
                    });
                }
            }
        });
    })
</script>