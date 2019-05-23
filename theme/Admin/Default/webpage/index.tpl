<div class="nav"><span>单页信息管理</span></div>
<div class="explain">
	<div class="name"><span>操作提示</span></div>
	<div class="con">
		<p>单页信息管理主要负责只有单页介绍的内容信息。比如：公司介绍，注册协议等。</p>
	</div>
</div>
<form method="get" action="{:url(SYS_PATH."/".CONTROLLER."/index")}" class="ajaxSearchFrom">
<div class="filter"> 
		<div class="sch">
			<input type="text" name="keyword" class="text" value="{$keyword|default=''}" placeholder="请输入关键字">
			<input type="button" class="submit searchButton" data-url="{:url(SYS_PATH."/".CONTROLLER."/index")}" value="搜索">
		</div>
	<a href="javascript:;"  title='添加单页'  class="add dialog" data-url='{:url(SYS_PATH."/".CONTROLLER."/add")}' data-height='500px' data-width='850px'>添加单页</a> 
</div>
</form>
<div class="main"> 
	<table class="ltable">
       <thead> 
        <tr> 
            <th width="100">ID</th>
            <th width="200" class='fl'>单页名称</th>
            <th width="200">图片</th>
            <th width="50">浏览量</th>
            <th width="150">修改时间</th>
            <th width="50">排序</th>
            <th width="100">状态</th>
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