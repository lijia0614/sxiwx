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
<div class="nav"><span>采集管理</span></div>  
<div class="explain">
	<div class="name"><span>操作提示</span></div>
	<div class="con">
		<p>采集规则配置较复杂，请咨询系统管理员</p>
	</div> 
</div>
<div class="filter">
	<a href="{:url(SYS_PATH."/collection/add",array("model"=>$model))}" class="add">添加采集规则</a>
<form action="{:url(SYS_PATH."/collection/index",array("model"=>$model))}" method="get">
		<input type="hidden" name="model" value="{$model}">
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
         <th width="30" nowrap="nowrap"><input type="checkbox" name="checkboxall" id="checkboxall" value="" class="va_m checkboxall" /></td> 
         <th width="50" style="text-align:center;">编号</td> 
         <th width="200" nowrap="nowrap">采集标题</td> 
         <th width="150" nowrap="nowrap">创建时间</td> 
         <th width="150" style="text-align:center;">修改时间</td> 
         <th width="50" style="text-align:center;">状态</td> 
          <th width="50" style="text-align:center;">测试</td> 
          <th width="50" style="text-align:center;">采集</td> 
         <th width="100" style="text-align:center;">操作</td> 
        </tr> 
       </thead> 
       <tbody> 
       <empty name="$lists">
          <tr> 
         <td colspan="7" nowrap="nowrap" style="text-align:center;">暂无记录</td> 
        </tr> 
        </empty>
        
		<volist name="lists" id="vo">
			<tr>
						<td nowrap="nowrap"><input type="checkbox" name="id[]" value="{$vo.id}" class="checkSon va_m" /></td>
						<td style="text-align:center;">{$vo.id}</td>
                        <td nowrap="nowrap">{:isset($vo['collect_title'])&&$vo['collect_title']?$vo['collect_title']:''}</td>	
						<td>{:isset($vo['create_time'])?$vo['create_time']:''}</td>
                        <td>{:isset($vo['update_time'])?$vo['update_time']:''}</td>	                        					
                        <td class="img"><if condition="$vo.status eq 1"><img class="pointer"  data-id="{$vo.id}" data-url="{:url(SYS_PATH."/collection/dostatus")}" style="cursor: pointer;" data-value="{$vo.status}" src="/public/admin/default/images/icon_{$vo.status}.png"><else /><img class="pointer"   data-id="{$vo.id}"  data-url="{:url(SYS_PATH."/collection/dostatus")}" style="cursor: pointer;" data-value="{$vo.status}" src="/public/admin/default/images/icon_{$vo.status}.png"></if></td>	
                        <td><a href='{:url("Home/collection/testCollects","collect_id=$vo[id]")}' val='{$vo.id}' title='测试采集' target="_blank">测试</a></td>
                        <td><a href='{:url("Home/collection/getCollection","collect_id=$vo[id]")}' val='{$vo.id}' title='采集数据' target="_blank">采集</a></td>				
						<td nowrap="nowrap"  style="text-align:center;">	
<a href='{:url(SYS_PATH."/collection/edit",array("id"=>$vo["id"]))}'>编缉</a>
<a href='javascript:void(0);' data-url='{:url(SYS_PATH."/collection/docopy","collect_id=$vo[id]")}' class="collectsCopy" data-id='{$vo.id}' title='复制一条数据'>复制</a>
<a href='javascript:void(0);' data-url='{:url(SYS_PATH."/collection/collectsDelete","id=$vo[id]")}' class='remove doDel' val='{$vo.id}' title='删除'>删除</a>  	
				
 </td>
					</tr>
          </volist>          
       
       </tbody> 
      </table> 
    <!-- </div> --> 
   </div> 
<script language="javascript">

$(document).off("click",".collectsCopy");
$(document).on("click",".collectsCopy",function() {	
    var dataurl = $(this).attr("data-url");
    var dataid = $(this).attr("data-id");
	var obj=$(this);
	if(dataurl.indexOf("?")<0){
		dataurl=dataurl+"?";
	}
	
    $.ajax({
        cache: true,
        type: "post",
        url:dataurl+"&random="+Math.random(),
        data: "collect_id=" + dataid,// 
        async: false,
        error: function(request) {
            $.dialog.tips("提交错误",2,'error.gif');
        },
        success: function(data) {
			var data = $.parseJSON(data);
        	if (data.status == 0) {
				layer.msg(data.msg);	
			} else {
        		layer.msg(data.msg);
				window.location.reload();
				
			}
			
        }
    });
	
	
    
});
</script>
 </body>
</html>