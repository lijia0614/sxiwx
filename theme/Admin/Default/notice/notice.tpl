<div class="nav"><span>私信列表</span></div>

<div class="explain">
	<div class="name"><span>操作提示</span></div>
	<div class="con">
		<p>公告内容会发送给所有用户</p>
	</div> 
</div>
<form method="get" action="{:url(SYS_PATH.'/'.CONTROLLER.'/letter')}" class="ajaxSearchFrom">
	<div class="query">
		<div class="query-conditions ue-clear">
			<div class="conditions staff ue-clear">
				<label>搜索公告：</label>
				<input type="text" name="keyword" value="{$keyword|default=''}" placeholder="标题">
			</div>

			<div class="query-btn ue-clear">
				<a style="margin-top: 5px; margin-left: 20px;" href="javascript:;" class="confirm searchButton"
				   data-url="{:url(SYS_PATH."/".CONTROLLER."/notice")}">查询</a>
			</div>
		</div>
	</div>
</form>
<form method="get" action="{:url(SYS_PATH.'/'.CONTROLLER.'/addNotice')}" class="ajaxSearchFrom">
	<div class="filter">
		<a href="javascript:void(0);" data-url="{:url(SYS_PATH.'/'.CONTROLLER.'/addNotice')}" class="add dialog"
		   data-height="500px" data-width="850px" title="添加产品">添加公告</a>
	</div>
</form>
<form action="{:url(SYS_PATH."/".CONTROLLER."/listDelete")}" id="formsubmit" class="formvalidate2">
<div class="main"> 
	<table width="100%" class="ltable">
	  	<thead>
		  	<tr> 
            	<th width="50"><input type="checkbox" class="checked_all" id="checkboxall"></th>
				<th width="50">编号</th>
				<th width="100">公告标题</th>
				<th width="180">公告内容</th>
				<th width="80">创建时间</th>
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
				<td>
                    {$vo.id}
				</td>
				<td>
					{$vo.title}
				</td>
				<td>
                    {$vo.content|trimhtml=0,200,true}
				</td>
				<td>
                    {$vo.create_time}
				</td>

				<td>
					  <a href='javascript:void(0);'  data-url='{:url(SYS_PATH."/".CONTROLLER."/addNotice",array("id"=>$vo["id"]))}'  class='dialog edit' alt='编辑' title='编缉'  data-height="500px" data-width="850px">详情</a>
					 <a href='javascript:void(0);' data-url='{:url(SYS_PATH."/".CONTROLLER."/delNotice",array("id"=>$vo["id"]))}' class='remove doDel del' val='{$vo.id}' title='删除'>删除</a>
				</td>
			</tr>
       </volist>
				 
			 
		</tbody>
	</table>
	<div class="filter">
		<div class="pageList">&nbsp;&nbsp;{$page|raw}</div>
	</div>
   
</div>
</form>
<script language="javascript">
    $(document).ready(function() {

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