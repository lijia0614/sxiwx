<div class="nav"><span>缓存清除</span></div>
<style type="text/css">
td.span{ color:#666666; }
a.do{ border:1px solid #0D92C5; background:#179ED2; color:#fff; padding:3px 10px; font-size:12px; border-radius:2px; }
</style>
<div class="filter"> 
<a href="javascript:;" class="button clear_ck" id="checkboxall" >全选/反选</a>
	<a href="javascript:;" class="button clear_ck" id="clearCache">清除选中</a>
</div>
<div class="main"> 
	<table class="ltable">  
		<thead>
			<tr>
				<th width="50">选择</th>
				<th width="150">名称</th>
				<th>描述</th>
                <th width="120">状态</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td height="30"><input type="checkbox" name="type"  data-uri="{:url(SYS_PATH.'/Setting/cache',array('type'=>'data'))}" value="data" class="checked_list checkAll"/></td>
				<td>数据缓存</td>
				<td class="fl">数据生成的文件缓存。提高访问效率本地化缓存的一种方法。</td>
                <td><span id="data_ifm"></span></td>

			</tr>
			<tr>
				<td height="30"><input type="checkbox" data-uri="{:url(SYS_PATH.'/Setting/cache',array('type'=>'tpl'))}" name="type" value="tpl" class="checked_list checkAll"/></td>
				<td>编译文件</td>
				<td class="fl">程序代码模板分离，编译好的文件可以直接访问，减少了程序执行过程中模板替换的过程，减少代码执行量。</td>
                <td><span id="tpl_ifm"></span></td>

			</tr>
			<tr>
			<td height="30"><input type="checkbox" name="type"  data-uri="{:url(SYS_PATH.'/Setting/cache',array('type'=>'html'))}" value="html"  class="checked_list checkAll"/></td>
				<td>静态缓存</td>
				<td class="fl">静态缓存的HTML页面。</td>
                <td><span id="html_ifm"></span></td>

			</tr>
			<tr>
				<td height="30"><input type="checkbox" name="type" value="field"  data-uri="{:url(SYS_PATH.'/Setting/cache',array('type'=>'field'))}"  class="checked_list checkAll"/></td>
				<td>字段缓存</td>
				<td class="fl">清除数据库字段缓存</td>
                <td><span id="field_ifm"></span></td>

			</tr>
			<tr>
				<td height="30"><input type="checkbox" data-uri="{:url(SYS_PATH.'/Setting/cache',array('type'=>'logs'))}" name="type" value="logs" class="checked_list checkAll"/></td>
				<td>日志文件</td>
				<td class="fl">记录数据出错、报错、访问记录等的文件。主要作用为管理员排查程序错误的文件。</td>
                <td><span id="logs_ifm"></span></td>

			</tr>
		</tbody> 
	</table> 
</div>
<!--底部--> 
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
			$(document).ready(function() {
				$('#clearCache').on('click',function() {
					$('input[name="type"]:checked').each(function() {
						var type = $(this).val();
						uri = $(this).attr('data-uri');
						$('#' + type + '_ifm').html("清理中...");
						try{
							$.getJSON(uri, {type: type},function(result) {
								if (result.status == 1) {
									$('#' + type + '_ifm').addClass('onCorrect').html("清理成功");
								} else {
									$('#' + type + '_ifm').addClass('onError').html("清理失败,可能是没有权限");
								}
							});
						}catch(e){
							//alert(e);	
						}
					});
				});
			});
    </script>

