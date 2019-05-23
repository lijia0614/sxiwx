<div class="nav"><span>私信列表</span></div>

<div class="explain">
	<div class="name"><span>操作提示</span></div>
	<div class="con">
		<p>私信内容只能发送给指定的用户，也只有指定用户能看到</p>
	</div> 
</div>
<form method="get" action="{:url(SYS_PATH.'/'.CONTROLLER.'/letter')}" class="ajaxSearchFrom">
	<div class="query">
		<div class="query-conditions ue-clear">
			<div class="conditions staff ue-clear">
				<label>搜索私信：</label>
				<input type="text" name="keyword" value="{$keyword|default=''}" placeholder="手机号码，私信标题">
			</div>
			<div class="conditions name ue-clear">
				<label>转态：</label>
				<div class="select-wrap">
					<div class="select-title ue-clear">
                        <span>
                             所有
                        </span>
						<i class="icon"></i>
					</div>
					<ul class="select-list" style="display: none;"
						data-url="{:url(SYS_PATH."/".CONTROLLER."/letter",array("status"=>$status))}"
						data-name="status">
						<li value="">所有</li>
						<li value="1">未读</li>
						<li value="2">已读</li>
					</ul>
				</div>
			</div>
			<div class="query-btn ue-clear">
				<a style="margin-top: 5px; margin-left: 20px;" href="javascript:;" class="confirm searchButton"
				   data-url="{:url(SYS_PATH."/".CONTROLLER."/letter")}">查询</a>
			</div>
		</div>
	</div>
</form>

<form action="{:url(SYS_PATH."/".CONTROLLER."/listDelete")}" id="formsubmit" class="formvalidate2">
<div class="main"> 
	<table width="100%" class="ltable">
	  	<thead>
		  	<tr> 
            	<th width="50"><input type="checkbox" class="checked_all" id="checkboxall"></th>
				<th width="50">编号</th>
				<th width="80">用户信息</th>
				<th width="80">真实姓名</th>
				<th width="80">昵称</th>
				<th width="100">私信标题</th>
				<th width="180">私信内容</th>
				<th width="80">是否已读</th>
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
					<if condition="$vo['phone']">
                        {$vo.phone}
						<else/>
						<if condition="$vo['unionid']">
							<span style="color: pink">微信用户</span>
						</if>
					</if>
				<td>
					<if condition="$vo.name">
                        {$vo.name}
						<else/>
						<span style="color: pink">未填</span>
					</if>
				</td>
				<td>
					<if condition="$vo.unionid">
                        {$vo.pen_name}
						<else/>
						<span style="color: pink">未填</span>
					</if>
				</td>
				<td>
					{$vo.title}
				</td>
				<td>
                    {$vo.content|trimhtml=0,200,true}
				</td>
				<td>
					<if condition="$vo.status eq 1">
						<span style="color: pink">未读</span>
						<else/>
						<span style="color: #0789D2">已读</span>
					</if>
				</td>

				<td>
                    {$vo.create_time}
				</td>

				<td>
					  <a href='javascript:void(0);'  data-url='{:url(SYS_PATH."/".CONTROLLER."/editLetter",array("id"=>$vo["id"]))}'  class='dialog edit' alt='编辑' title='编缉'  data-height="500px" data-width="850px">详情</a>
					 <a href='javascript:void(0);' data-url='{:url(SYS_PATH."/".CONTROLLER."/del",array("id"=>$vo["id"]))}' class='remove doDel del' val='{$vo.id}' title='删除'>删除</a>
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