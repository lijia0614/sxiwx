<div class="nav"><span>《{$book['name']}》本月更新详情</span></div>
<div class="explain">
	<div class="name"><span>操作提示</span></div>
	<div class="con">
		<p>当前稿费率：每千字￥{$fee}</p>
		<p>计算方式：稿费 = 通过审核的总字数/1000*稿费率</p>
		<p>修改高费率：系统配置 -> 全局设置 -> 自定义设置 -> 千字稿费</p>
	</div> 
</div>
<form method="get" action="{:url(SYS_PATH."/income/feeInfo")}" class="ajaxSearchFrom">
	<div class="query">
		<div class="query-conditions ue-clear">

			<div class="conditions name ue-clear">
				<label>时间查询：</label>
				<input type="hidden" name="id" value="{$book['id']}">
				<div style="float: left;margin-right: 10px;" class="k_input">
					<input style="height: 18px;" type="text"  class="form_input" onclick="laydate({istime: true, format: 'YYYY-MM-DD'});" validate="{ required:true,maxlength:300}" value="{$start_date}" name="start_date" placeholder="开始时间">
				</div>
				<div style="float: left;margin-right: 10px;" class="k_input">
					<input style="height: 18px;" type="text"  class="form_input" onclick="laydate({istime: true, format: 'YYYY-MM-DD'});" validate="{ required:true,maxlength:300}" value="{$end_date}" name="end_date" placeholder="结束时间">
				</div>
			</div>
			<!--<div style="clear: both;"></div>-->

			<div class="query-btn ue-clear">
				<a style="margin-top: 5px; margin-left: 20px;" href="javascript:;" class="confirm searchButton"
				   data-url="{:url(SYS_PATH."/income/feeInfo")}">查询</a>
			</div>
		</div>
	</div>
</form>
<form method="get" action="{:url(SYS_PATH."/".CONTROLLER."/chapter",['b_id'=>$b_id])}" class="ajaxSearchFrom">
	<div class="filter">
		<div class="button_bottom"><input type="button" class="button" value="本月更新总章数 : {$count} "></div>
		<div class="button_bottom"><input type="button" class="button" value="本月更新总字数: {$worlds} "></div>
		<div class="button_bottom"><input type="button" class="button" value="本月合计稿费: {$price} "></div>
	</div>
</form>
<form action="{:url(SYS_PATH."/".CONTROLLER."/listDelete")}" id="formsubmit" class="formvalidate2">
<div class="main"> 
	<table width="100%" class="ltable">
	  	<thead>
		  	<tr>
				<th width="100">书名</th>
                <th width="100">章节名</th>
				<th width="80">字数</th>
				<th width="80">稿费(￥)</th>
				<th width="80">提交时间</th>
				
		  	</tr>
	  	</thead>
		<tbody> 
			<empty name="list">
				<tr><td height="50" colspan="9" align="center" style="text-align:center;">没有数据</td></tr>                        
            </empty>         
        <volist name="list" id="vo">
			<tr>
				<td>
				<a href='javascript:void(0);'
				   class="category_select_class" >{$book['name']}
				</a>
				</td>
				<td>{$vo.name}</td>
				<td>
					{$vo.words_num}字
				</td>
				<td>
                    {$vo.fee}
				</td>
				<td>
                    {$vo.time|date='Y-m-d H:i'}
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