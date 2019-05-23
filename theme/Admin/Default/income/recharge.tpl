<div class="nav"><span>充值列表</span></div>
<form method="get" action="{:url(SYS_PATH.'/'.CONTROLLER.'/index')}" class="ajaxSearchFrom">
	<div class="query">
		<div class="query-conditions ue-clear">

			<div class="conditions name ue-clear">
				<label>时间查询：</label>
				<div style="float: left;margin-right: 10px;" class="k_input">
					<input style="height: 18px;" type="text"  class="form_input" onclick="laydate({istime: true, format: 'YYYY-MM-DD'});" validate="{ required:true,maxlength:300}" value="{$start_date}" name="start_date" placeholder="开始时间">
				</div>
				<div style="float: left;margin-right: 10px;" class="k_input">
					<input style="height: 18px;" type="text"  class="form_input" onclick="laydate({istime: true, format: 'YYYY-MM-DD'});" validate="{ required:true,maxlength:300}" value="{$end_date}" name="end_date" placeholder="结束时间">
				</div>
			</div>
			<!--<div style="clear: both;"></div>-->
			<div class="conditions staff ue-clear">
				<label>关键词：</label>
				<input type="text" name="keyword" value="{$keyword|default=''}" placeholder="手机号、订单号">
			</div>
			<div class="query-btn ue-clear">
				<a style="margin-top: 5px; margin-left: 20px;" href="javascript:;" class="confirm searchButton"
				   data-url="{:url(SYS_PATH."/".CONTROLLER."/recharge")}">查询</a>
			</div>
		</div>
	</div>
</form>

<div class="filter">
	<div class="button_bottom"><input type="button" class="button" value="总充值额 : {$total} RMB"></div>
	<div class="button_bottom"><input type="button" class="button" value="当前页充值额 : {$now_total} RMB"></div>
</div>

<form action="{:url(SYS_PATH."/".CONTROLLER."/listDelete")}" id="formsubmit" class="formvalidate2">
<div class="main"> 
	<table width="100%" class="ltable">
	  	<thead>
		  	<tr>
				<th width="50"><input type="checkbox" class="checked_all" id="checkboxall"></th>
				<th width="80">订单号</th>
				<th width="80">卖方订单号</th>
				<th width="80">真实姓名</th>
				<th width="80">昵称</th>
				<th width="80">手机号码</th>
				<th width="100">充值金额(RMB)</th>
				<th width="100">余额(书币)</th>
				<th width="100">充值类型</th>
				<th width="80">充值时间</th>
		  	</tr>
	  	</thead>
		<tbody> 
			<empty name="list">
				<tr><td height="50" colspan="9" align="center" style="text-align:center;">没有数据</td></tr>                        
            </empty>         
        <volist name="list" id="vo">
			<tr>
				<td><input type="checkbox" name="ids[]" value="{$vo.id}" class="checked_list checkAll"/></td>
				<td>{$vo.order_num}</td>

				<td>
                    {$vo.seller_id}
				</td>
				<td>
                    {$vo.name}
				</td>
				<td>
                    {$vo.pen_name}
				</td>
				<td>
					<if condition="!$vo['phone']">

						<if condition="$vo['unionid']">
							<span style="color: pink">微信用户</span>
						</if>
						<else/>
                        {$vo.phone}
					</if>
				</td>
				<td>
                    {$vo.total_fee}
				</td>
				<td>
                    {$vo.money}
				</td>
				<td>
                    <if condition="$vo.type eq 1">
						微信
						<elseif condition="$vo.type eq 2"/>
						支付宝
						<elseif condition="$vo.type eq 5"/>
						开通会员
					</if>
				</td>
				<td>
                    {$vo.create_time}
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
    $(document).ready(function () {
        $('#checkboxall').click(function () {
            $('.checkAll').each(function () {
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