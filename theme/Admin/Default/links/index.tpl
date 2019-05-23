<div class="nav"><span>友情链接</span></div>
<form class="ajaxSearchFrom">
<div class="query">
	<div class="query-conditions ue-clear">

        <div class="conditions name ue-clear">
            <label>类型筛选：</label>
            <div class="select-wrap">
                <div class="select-title ue-clear"><span><if condition="!isset($display_type)||$display_type==0">全部</if><if condition="isset($display_type)&&$display_type eq 1">首页</if><if condition="isset($display_type)&&$display_type==2">全站</if> </span><i class="icon"></i></div>
                <ul class="select-list" style="display: none;" data-url="{:url(SYS_PATH."/".CONTROLLER."/index",array("status"=>$status,"p"=>$p))}" data-name="display_type">
                   <li value="0">全部</li>
                   <li value="1">首页</li>
                   <li value="2">全站</li>
                   
                </ul>
            </div>
        </div>

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
        <!--
        <div class="conditions operate-time ue-clear">
            <label>操作时间：</label>
            <div class="select-wrap">
                <div class="select-title ue-clear"><span>大于或等于</span><i class="icon"></i></div>
                <ul class="select-list" style="display: none;">
                    <li>呵呵</li>
                    <li>哈哈</li>
                    <li>嘻嘻</li>
                </ul>
            </div>
            <div class="input-box ue-clear">
                <input type="text">
                <span>小时</span>
            </div>
        </div> -->
        <div style="clear: both;"></div>
        <div class="conditions staff ue-clear">
            <label>关键词：</label>
            <input type="text" name="keyword" value="{$keyword|default=''}"  placeholder="搜索关键词">
        </div>
        <!--
        <div class="conditions time ue-clear">
            <label>添加时间：</label>
            <div class="time-select">
            	<input type="text"  placeholder="开始时间">
                <i class="icon"></i>
            </div>
            <span class="line">-</span>
            <div class="time-select">
            	<input type="text"  placeholder="开始时间">
                <i class="icon"></i>
            </div>
        </div>
        -->

    </div>
    <div class="query-btn ue-clear">
    	<a href="javascript:;" class="confirm searchButton" data-url="{:url(SYS_PATH."/".CONTROLLER."/index")}">查询</a>
    </div>
</div>
</form>
<div class="filter">
    	<a href="javascript:;"  title='添加友情链接'  class="add dialog" data-url='{:url(SYS_PATH."/links/add")}' data-height='450px' data-width='650px'>添加友情链接</a>
</div>
<div class="main">  
	<table class="ltable">
	  	<thead>
		  	<tr>
            	<th width="50">ID标识</td>
				<th width="150">链接类型</td> 
                <th width="150">链接名称</td> 
				<th width="400">链接地址</td> 
				<th width="150">添加时间</td> 
                <th width="150">状态</td> 
                <th width="50">排序</td> 
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
                        <td><if condition="$vo.display_type eq 1">首页显示<else />全站显示</if></td>
                        <td>{$vo.title}</td>
                        <td style="text-align:center;">{$vo.link}</td>
						<td style="text-align:center;">{$vo.create_time|date='Y-m-d H:i:s'}</td>	
                        <td><img class="pointer" data-id="{$vo.id}"  data-url="{:url(SYS_PATH."/".CONTROLLER."/dostatus")}" style="cursor: pointer;" data-value="{$vo.status}" src="/public/admin/default/images/icon_{$vo.status}.png"> </td> 
                        <td>{$vo.sort} </td> 
                        <td style="text-align:center;">
							<a href="javascrip:;" data-url='{:url(SYS_PATH."/links/edit",array("id"=>$vo["id"]))}'  class='dialog edit' alt='编辑' title='编辑'  data-height='450px' data-width='650px'>编辑</a>
							<a href="javascript:;" data-url='{:url(SYS_PATH."/links/doDelete","id=$vo[id]")}' class='remove doDel del' val='{$vo.id}' title='删除'>删除</a>
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
