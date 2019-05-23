
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>管理中心</title>
<link rel="stylesheet" type="text/css" href="css/common.css"> 
<script type="text/javascript" src="js/jquery-1.9.1.js"></script>
	<script language="javascript" src="/public/layer/layer.js"></script>
	<script type="text/javascript" src="js/common.js"></script>
<script src="/public/vend/Validform/Validform_v5.3.2_min.js"></script>
</head> 
<body> 
  <input type="hidden" name="current_load_url" id="current_load_url" value="" /> 
<div class="nav"><span>操作节点</span></div>  
<div class="explain">
	<div class="name"><span>操作提示</span></div>
	<div class="con">
		<p>添加与编缉都设置为按钮形式，是不需要显示的,此处的节点将在权限分配列表显示</p> 
	</div> 
</div>
<div class="filter">
	<a href="{:url(SYS_PATH."/roleNode/add",array("nav_id"=>$id))}" class="add">添加节点</a>
<form action="{:url(SYS_PATH."/roleNode/index",array("nav_id"=>$id))}" method="get">
		<input type="hidden" name="id" value="{$id}">	
		<div class="sch">
			<input type="text" name="keyword" class="text" value="{$keyword}" placeholder="请输入关键字">
			<input type="submit" class="submit" value="搜索">
		</div>
	</form>    
</div>
<div class="main"> 
	<table width="100%" class="ltable">
	  	<thead>
		  	<tr> 
				<th width="30">编号</td>
				<th width="120">ACTION</td>
				<th>方法名称</th>
				<th width="120">CONTROLLER</th>
                <th width="100">所属菜单</th>
                <th width="60">菜单显示</th>
                <th width="60">状态</th>
				<th width="130">操作</th>
		  	</tr>
	  	</thead>
		<tbody> 
			<empty name="list">
							<tr>
								<td height="50" colspan="8" align="center" style="text-align:center;">没有数据</td>
							</tr>                        
            </empty>           
        <volist name="list" id="vo">
						<tr>
						<td>{$vo.id}</td> 
						<td>{$vo.action}</td> 
						<td>{$vo.action_name}</td>
						<td>{$vo.module}</td>
                        <td>{$vo.nav_name}</td> 
                        <td>
<if condition="$vo.is_show eq 1">
                        <img class="pointer" style="cursor: pointer;"  data-id="{$vo.id}" data-url="{:url(SYS_PATH."/".CONTROLLER."/doShow")}" data-value="{$vo.is_show}" src="/public/admin/default/images/icon_{$vo.is_show}.png">
                        <else /><img class="pointer" style="cursor: pointer;" data-id="{$vo.id}"  data-url="{:url(SYS_PATH."/".CONTROLLER."/doShow")}" data-value="{$vo.is_show}" src="/public/admin/default/images/icon_{$vo.is_show}.png"></if>                        
                        </td> 
						<td>
<if condition="$vo.status eq 1"><img class="pointer"  data-id="{$vo.id}" data-url="{:url(SYS_PATH."/".CONTROLLER."/dostatus")}" style="cursor: pointer;" data-value="{$vo.status}" src="/public/admin/default/images/icon_{$vo.status}.png"><else /><img class="pointer"   data-id="{$vo.id}"  data-url="{:url(SYS_PATH."/".CONTROLLER."/dostatus")}" style="cursor: pointer;" data-value="{$vo.status}" src="/public/admin/default/images/icon_{$vo.status}.png"></if>
						</td> 
						<td>
  <a href='{:url(SYS_PATH."/".CONTROLLER."/edit",array("id"=>$vo["id"]))}' class='edit' alt='编辑' title='编辑'>编缉</a>
 <a href='javascript:void(0);' data-url='{:url(SYS_PATH."/".CONTROLLER."/doDelete","id=$vo[id]")}' class='remove doDel del' val='{$vo.id}' title='删除'>删除</a>                                                     
                        </td>
					</tr>
</volist>                    
		</tbody>
	</table> 
	<div class="page">{$page|raw}</div>
</div>

</body>
</html>
<!--底部--> 