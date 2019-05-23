<div class="nav"><span>列表中心</span></div>  
<form class="ajaxSearchFrom">
<div class="query">
	<div class="query-conditions ue-clear">


        <div class="conditions name ue-clear">
            <label>状态筛选：</label>
            <div class="select-wrap">
                <div class="select-title ue-clear"><span><if condition="isset($status)&&$status eq 0">禁用</if><if condition="!isset($status)||$status==3">全部</if><if condition="$status eq 1">启用</if></span><i class="icon"></i></div>
                <ul class="select-list" style="display: none;" data-url="{:url(SYS_PATH."/".CONTROLLER."/index",array("cid"=>$cid,"p"=>$p))}" data-name="status">
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

<form method="get" action="{:url(SYS_PATH."/".CONTROLLER."/index")}" class="formvalidate">
<div class="filter">
		<!--<div class="sch">
			<input type="text" name="keyword" class="text" value="{$keyword|default=''}" placeholder="请输入关键字">
			<input type="button" class="submit searchButton" value="搜索">
		</div>-->
	<a href="javascript:void(0);" data-url="{:url(SYS_PATH.'/'.CONTROLLER.'/add')}" class="add dialog" data-height="500px" data-width="850px" title="添加内容">添加内容</a>
</div>
</form>
<form action="{:url(SYS_PATH."/".CONTROLLER."/listDelete")}" id="formsubmit" class="formvalidate2">
<div class="main"> 
	<table width="100%" class="ltable">
	  	<thead>
		  	<tr> 
            	<th width="50"><input type="checkbox" class="checked_all" id="checkboxall"></th>
				<th width="80">编号</th>
                <if condition="$modules.category_status eq 1">
				<th width="100">分类</th>
                </if>
				<th>标题</th>
                    <if condition="isset($moduleFields)">
                    <volist name="$moduleFields" id="listvo">
                    <if condition="$listvo.list_show eq 1">
                    <th width="{$listvo.list_width}"  style="text-align:center;">{$listvo.title}</th>    
                    </if>
                    </volist>
                    </if>                
				<th width="120">浏览量</th>
				<th width="60">状态</th>
                <th width="150">添加时间</th>
                <th width="150">修改时间</th>
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
						<td>{$vo.id}</td> 
                        <if condition="$modules.category_status eq 1">
						<td>
                        <if condition="isset($vo['category_name'])&&$vo['category_name']">
                        <a data-url="{:url(SYS_PATH."/".CONTROLLER."/index",array("cid"=>$vo['cid']))}" href="javascript:void(0);" class="category_select_class">{$vo['category_name']}</a>
                        <else />
                        <span style="color:red;">未选择分类</span>
                        </if>                        
                        </td> 
                        </if>
						<td>{$vo.title}</td>
                        <if condition="isset($moduleFields)">
                        <volist name="$moduleFields" id="listvo">   
                        <if condition="$listvo.list_show eq 1"> 
                        <td>{$vo[$listvo['fields']]}</td>    
                        </if>
                        </volist>
                        </if>                            
						<td>{$vo.click}</td>
						<td><img class="pointer" data-id="{$vo.id}"  data-url="{:url(SYS_PATH."/".CONTROLLER."/dostatus")}" style="cursor: pointer;" data-value="{$vo.status}" src="/public/admin/default/images/icon_{$vo.status}.png"> </td> 
                        <td>{$vo.create_time|date='Y-m-d H:i:s'}</td>
                        <td>{$vo.update_time|date='Y-m-d H:i:s'}</td>
						<td>
                              <a href='javascript:void(0);'  data-url='{:url(SYS_PATH."/".CONTROLLER."/edit",array("id"=>$vo["id"]))}'  class='dialog edit' alt='编辑' title='编缉'  data-height="500px" data-width="850px">编缉</a>
							 <a href='javascript:void(0);' data-url='{:url(SYS_PATH."/".CONTROLLER."/doDelete","id=$vo[id]")}' class='remove doDel del' val='{$vo.id}' title='删除'>删除</a>
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
                            window.wxc.xcConfirm(response.msg, window.wxc.xcConfirm.typeEnum.error);
                            return;
                        }
                    } catch (e) {
                        lodingok();
                    }
                    $("ul[data-name='"+name+"']").siblings($(".select-title")).find("span").text(text);
                });

            }
</script>
