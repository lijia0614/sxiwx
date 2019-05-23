
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
<div class="nav"><span>字段管理</span></div>  
<div class="explain">
	<div class="name"><span>操作提示</span></div>
	<div class="con">
		<p>非专业人士请忽随意添加删除字段，该操作会出现数据丢失</p>
	</div> 
</div>
<div class="filter">
	<a href="{:url(SYS_PATH."/fields/add",array("module_id"=>$module_id))}" class="add">添加字段</a>
<form action="{:url(SYS_PATH."/fields/index",array("module_id"=>$module_id))}" method="get">
		<input type="hidden" name="module_id" value="{$module_id}">
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
                <th width="50">选择</td>
				<th width="50">编号</td>
				<th width="120">模型名称</td>
				<th>显示名称</th>
				<th width="120">字段名</th>
                <th width="50">显示</th>
                <th width="100">描述</th>
				<th width="100">操作</th>
		  	</tr>
	  	</thead>
		<tbody> 
			<empty name="list">
							<tr>
								<td height="50" colspan="8" align="center" style="text-align:center;">没有数据</td>
							</tr>                        
            </empty>       
       
       <volist name="list" id="vo">
       <tr id='list_{$vo.id}' >
                        <td class='align-center'>
                            <input type='checkbox' value='{$vo.id}' name='ids[]' class='checkSon' data-xid='checkSon_x'/>
                        </td>
                        <td style='text-align:center;'>{$vo.id}</td>
                        <td class='align-center'>{:isset($module['title'])?$module['title']:''}</td>
                        <td class='align-center'>{:isset($vo['title'])?$vo['title']:''}</td>
                        <td style='text-align:center;'>{:isset($vo['fields'])?$vo['fields']:''}</td>
                        <td style='text-align:center;'><if condition="$vo.is_show eq 1">
                        <img class="pointer" style="cursor: pointer;"  data-id="{$vo.id}" data-url="{:url(SYS_PATH."/".CONTROLLER."/isshow")}" data-value="{$vo.is_show}" src="/public/admin/default/images/icon_{$vo.is_show}.png">
                        <else /><img class="pointer" style="cursor: pointer;" data-id="{$vo.id}"  data-url="{:url(SYS_PATH."/".CONTROLLER."/isshow")}" data-value="{$vo.is_show}" src="/public/admin/default/images/icon_{$vo.is_show}.png"></if></td>
                        <td style='text-align:center;'>{:isset($vo['info'])?$vo['info']:''}</td>
                        <td style='text-align:center;'>
                            <div class='button-group'>
                                <a href="{:url(SYS_PATH."/".CONTROLLER."/edit",array('id'=>$vo.id))}" title="编辑">编辑</a> <a href="javascript:void(0);" data-url="{:url(SYS_PATH."/".CONTROLLER."/doDelete","id=$vo[id]")}" val="{$vo.id}" class="remove doDel" title="删除">删除</a> 
                            </div>
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