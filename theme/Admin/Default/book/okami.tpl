<div class="nav"><span>大神专区管理</span></div>
<div class="explain">
	<div class="name"><span>操作提示</span></div>
	<div class="con">
		<p>大神专区管理主要负责首页大神专区书籍(数量6个)</p>
	</div> 
</div>

<form method="get" action="{:url(SYS_PATH.'/'.CONTROLLER.'/index')}" class="ajaxSearchFrom">
	<div class="query">
		<div class="query-conditions ue-clear">
			<div class="conditions name ue-clear">
				<label>书籍分类：</label>
				<div class="select-wrap">
					<div class="select-title ue-clear">
                        <span>
                             所有分类
                        </span>
						<i class="icon"></i>
					</div>
					<ul class="select-list" style="display: none;"
						data-url="{:url(SYS_PATH."/".CONTROLLER."/index",array("cid"=>$cid,"p"=>$p))}"
						data-name="c_id">

						<li value="">所有分类</li>
						<zhimeng table="book_category" where="[['status','=',1],['is_del','=',0]]">
							<li value="{$r.id}">{$r.name}</li>
						</zhimeng>
					</ul>
				</div>
			</div>
			<div class="conditions name ue-clear">
				<label>推荐类别：</label>
				<div class="select-wrap">
					<div class="select-title ue-clear">
                        <span>
                             请选择推荐
                        </span>
						<i class="icon"></i>
					</div>
					<ul class="select-list" style="display: none;"
						data-url="{:url(SYS_PATH."/".CONTROLLER."/index",array("type"=>$type))}"
						data-name="type">
						<li value="">所有</li>
						<li value="1">首页推荐</li>
						<li value="2">编辑力荐</li>
						<li value="3">精品推荐</li>
						<li value="4">原创新品</li>
						<li value="5">大神推荐</li>
					</ul>
				</div>
			</div>
			<!--<div style="clear: both;"></div>-->
			<div class="conditions staff ue-clear">
				<label>关键词：</label>
				<input type="text" name="keyword" value="{$keyword|default=''}" placeholder="书籍名称、作者">
			</div>
			<div class="query-btn ue-clear">
				<a style="margin-top: 5px; margin-left: 20px;" href="javascript:;" class="confirm searchButton"
				   data-url="{:url(SYS_PATH."/".CONTROLLER."/index")}">查询</a>
			</div>
		</div>
	</div>
</form>

<form method="get"  action="{:url(SYS_PATH.'/'.CONTROLLER.'/index')}" class="ajaxSearchFrom">
<div class="filter">
	<a href="javascript:void(0);" data-url="{:url(SYS_PATH.'/'.CONTROLLER.'/addOkami')}" class="add dialog" data-height="500px" data-width="850px" title="添加书籍">添加书籍到大神推荐</a>
</div>
</form>
<form action="{:url(SYS_PATH."/".CONTROLLER."/listDelete")}" id="formsubmit" class="formvalidate2">
<div class="main"> 
	<table width="100%" class="ltable">
	  	<thead>
		  	<tr> 
            	<th width="50"><input type="checkbox" class="checked_all" id="checkboxall"></th>
				<th width="80">编号</th>
				<th width="100">分类</th>
                <th width="100">书名</th>
				<th width="100">作者</th>
				<th width="100">排序</th>
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
						<td>
                        <if condition="isset($vo['cid'])&&$vo['cid']">
                        <a data-url="{:url(SYS_PATH."/".CONTROLLER."/index",array("cid"=>$vo['cid']))}" href="javascript:void(0);">
							<zhimeng table="book_category" where="['id','=',$vo['cid']]">
								{$r.name}
							</zhimeng>
						</a>
                        <else />
                        <span style="color:red;">未选择分类</span>
                        </if>                        
                        </td> 
                        <td>

							<a href='javascript:void(0);'  data-url='{:url(SYS_PATH."/".CONTROLLER."/chapter",array("id"=>$vo["id"]))}'  class="category_select_class" alt='{$vo.name}' title='点击查看章节'  data-height="500px" data-width="850px">{$vo.name}</a>

						</td>
						<td>{$vo.author}</td>
						<td><a href="javascript:void(0);" data-url="{:url(SYS_PATH."/".CONTROLLER."/okami_sort",array("id"=>$vo["id"]))}" class="dialog edit" alt="编辑排序" title="编辑排序" data-height="300px" data-width="550px">{$vo.okami_sort}</a></td>
						<td>
							 <a href='javascript:void(0);' data-url='{:url(SYS_PATH."/".CONTROLLER."/outOkami","id=$vo[id]")}' class='remove doDel del' val='{$vo.id}' title='移出此管理'>移出此管理</a>
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
			});
</script>

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