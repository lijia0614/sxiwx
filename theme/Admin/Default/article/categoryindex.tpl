<div class="nav"><span>分类管理</span></div>
<div class="filter"> 
	<a href="javascript:;"  title='添加菜单'  class="add dialog" data-url='{:url(SYS_PATH."/article/categoryAdd")}' data-height='400px' data-width='750px'>添加分类</a> 
</div>
<div class="main"> 
	<table class="ltable">
       <thead> 
        <tr> 
            <th width="30" class="fl"><input type="checkbox" name="checkboxall" id="checkboxall" value="" class="va_m checkboxall" /></th> 
            <th width="100">标识</th>
            <th width="400">分类名称</th>
            <th width="200">分类别名</th>
            <th width="50">排序</th>
            <th width="150">状态</th>
            <th width="130">操作</th>
            <th></th>        
        </tr> 
       </thead> 
       <tbody> 
       <empty name="$list">
        <tr> 
         	<td colspan="8" nowrap="nowrap" style="text-align:center;">暂无记录</td> 
        </tr> 
        </empty>
       {$list|raw}
		</tbody>
	</table> 
</div>