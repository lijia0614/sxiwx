<div class="nav"><span>友情链接</span></div>
<div class="explain">
	<div class="name"><span>操作提示</span></div>
	<div class="con">
		<p>站内链接会全局替换添加的关键词，包括数据库的数据以及模板当中的静态文字</p>
	</div>
</div>
<form class="ajaxSearchFrom">
<div class="query">
	<div class="query-conditions ue-clear">
        <div class="conditions name ue-clear">
            <label>状态筛选：</label>
            <div class="select-wrap">
                <div class="select-title ue-clear"><span><if condition="isset($status)&&$status eq 0">禁用</if><if condition="!isset($status)||$status==3">全部</if><if condition="$status eq 1">启用</if></span><i class="icon"></i></div>
                <ul class="select-list" style="display: none;" data-url="{:url(SYS_PATH."/".CONTROLLER."/index",array("display_type"=>$display_type,"p"=>$p))}" data-name="status">
                    <li value="3">全部</li>
                    <li value="1">启用</li>
                    <li value="0">禁用</li>
                </ul>
            </div>
        </div>
        
        <div class="conditions staff ue-clear">
            <label>关键词：</label>
            <input type="text" name="keyword" value="{$keyword|default=''}"  placeholder="搜索关键词">
        </div>

    </div>
    <div class="query-btn ue-clear">
    	<a href="javascript:;" class="confirm searchButton" data-url="{:url(SYS_PATH."/".CONTROLLER."/index")}">查询</a>
    </div>
</div>
</form>
<div class="filter">
    	<a href="javascript:;"  title='添加站内链接'  class="add dialog" data-url='{:url(SYS_PATH."/SeoLinks/add")}' data-height='250px' data-width='650px'>添加站内链接</a>
</div>
<div class="main">  
	<table class="ltable">
	  	<thead>
		  	<tr>
            	<th width="50">ID标识</td>
                <th width="150">链接名称</td> 
				<th width="400">链接地址</td> 
				<th width="150">添加时间</td> 
                <th width="150">状态</td> 
				<th width="150">操作</td> 
				<th></th>
		  	</tr>
	  	</thead>
		<tbody>
			<empty name="list">
				<tr>
				<td height="50" colspan="9" align="center" style="text-align:center;">没有数据</td>
				</tr>                        
            </empty>
            <volist name="list" id="vo">
			<tr>
						<td>{$vo.id}</td>
                        <td>{$vo.title}</td>
                        <td style="text-align:center;">{$vo.link}</td>
						<td style="text-align:center;">{$vo.create_time|date='Y-m-d H:i:s'}</td>	
                        <td><img class="pointer" data-id="{$vo.id}"  data-url="{:url(SYS_PATH."/".CONTROLLER."/dostatus")}" style="cursor: pointer;" data-value="{$vo.status}" src="/public/admin/default/images/icon_{$vo.status}.png"> </td> 
                        <td style="text-align:center;">
							<a href="javascrip:;" data-url='{:url(SYS_PATH."/".CONTROLLER."/edit",array("id"=>$vo["id"]))}'  class='dialog edit' alt='编辑' title='编辑'  data-height='250px' data-width='650px'>编辑</a>
							<a href="javascript:;" data-url='{:url(SYS_PATH."/".CONTROLLER."/doDelete","id=$vo[id]")}' class='remove doDel del' val='{$vo.id}' title='删除'>删除</a>
                        </td>	   
                        <td></td>                    										
			</tr>
        </volist> 
				</tr>
		</tbody> 
	</table> 
	<div class="page">{$page|raw}</div>
</div>
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
				
			$(".select-title").on("click",function(){
				$(".select-list").hide();
				$(this).siblings($(".select-list")).show();
				return false;
			})
			$(".select-list").on("click","li",function(){
				var text = $(this).text();
                var value = $(this).attr("value");
                var url=$(this).parent().attr("data-url");
                var name=$(this).parent().attr("data-name");
                ajaxSelect(url,name,text,value);
                $(this).parent($(".select-list")).siblings($(".select-title")).find("span").text(text);
			})
			
				
			});
            showRemind('input[type=text], textarea','placeholder');
            function ajaxSelect(url,name,text,value){
                if (url.indexOf("?") <=0) {
                    url = url + "?"+name+"=" + value;
                }else{
                    url = url + "&"+name+"=" + value;
                }
                $("#current_load_url").val(url);
                loding();
                $(".right").load(url, '', function (response) {
                    try {
                        var response = $.parseJSON(response);
                        if (response.status != 1) {
							 window.top.layer.msg(response.msg, {icon: 2, shade: [0.8, '#393D49'], time: 1000});
                            return;
                        }
                    } catch (e) {
                        lodingok();
                    }
                    $("ul[data-name='"+name+"']").siblings($(".select-title")).find("span").text(text);
                });

            }
</script>
