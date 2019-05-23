<div class="nav"><span>广告位置管理</span></div>  
<div class="explain">
	<div class="name"><span>操作提示</span></div>
	<div class="con">
		<p>图片轮换广告，代码广告</p> 
	</div> 
</div>
<div class="filter">
	<a data-url="{:url(SYS_PATH."/ad/add")}" class="add dialog" style="cursor:pointer;" title="添加广告">添加广告</a>
<form method="get"  class="ajaxSearchFrom">
		<div class="sch">
			<input type="text" name="keyword" class="text" value="{$keyword}" placeholder="请输入关键字">
			<input type="button"  data-url="{:url(SYS_PATH."/ad/lists")}" class="submit searchButton" value="搜索">
		</div>
	</form>    
</div>
<div class="main"> 
	<table width="100%" class="ltable">
	  	<thead>
		  	<tr> 
				<th width="30">编号</td>
				<th width="120">广告位置</td>
				<th width="120">广告类型</th>
				<th width="120">名称</th>
                <th width="100">图片</th>
                <th width="150">链接</th>
                <th width="100">开始时间</th>
                <th width="100">结束时间</th>
				<th width="130">操作</th>
		  	</tr>
	  	</thead>
		<tbody> 
			<empty name="list">
				<tr>
				<td height="50" colspan="7" align="center" style="text-align:center;">没有数据</td>
				</tr>                        
            </empty>
            <volist name="list" id="vo">
			<tr>
						<td>{$vo.id}</td>
                        <td>
                         <a data-url="{:url(SYS_PATH."/".CONTROLLER."/lists",array("postion_id"=>$vo['postion_id']))}" href="javascript:void(0);" class="category_select_class">{$vo.postion_name}</a>
                        </td>
                        
                        <td style="text-align:center;">
                        <if condition="$vo.type eq 1">图片广告</if>
                        <if condition="$vo.type eq 2">代码广告</if>
                        </td>
                        <td style="text-align:center;">{$vo.name}</td>
                        <td style="text-align:center;"><if condition="$vo.image"><img src="{$vo.image}" width="30" height="30" class="vtip" data-img="{$vo.image}" /><else />无</if></td>
                        <td style="text-align:center;"><if condition="$vo.link">{$vo.link}<else />无</if></td>
						<td style="text-align:center;">{$vo.start_time|date="Y-m-d H:i:s"}</td>	
                        <td style="text-align:center;">{$vo.end_time|date="Y-m-d H:i:s"}</td>	
                        <td style="text-align:center;">
							<a href="javascrip:;" data-url='{:url(SYS_PATH."/Ad/edit",array("id"=>$vo["id"]))}'  class='dialog edit' alt='编辑' title='编辑' >编辑</a>
							<a href="javascript:;" data-url='{:url(SYS_PATH."/Ad/doDelete","id=$vo[id]")}' class='remove doDel del' val='{$vo.id}' title='删除'>删除</a>
                        </td>	                       										
			</tr>
        </volist>   
                                
                       
         </tbody> 
      </table> 
	<div class="page"></div>
</div>