<div class="nav"><span>追书推送书籍列表</span></div>

<div class="explain">
	<div class="name"><span>操作提示</span></div>
	<div class="con">
		<p>只有选中的书籍才能被对方获取，接口被关闭之后对方将不能访问接口获取数据</p>
	</div> 
</div>


<form method="get" action="" class="ajaxSearchFrom">
	<div class="query">
		<div class="query-conditions ue-clear">

			<div class="conditions name ue-clear">
				<label>接口状态：</label>
				<div class="select-wrap">
					<select id="status" name="status" lay-verify="">
						<option value="1" <if condition="$status eq 1"> selected </if> >  &nbsp;&nbsp;开启&nbsp;&nbsp;  </option>
						<option value="0" <if condition="$status eq 0"> selected </if>  >  &nbsp;&nbsp;关闭&nbsp;&nbsp;  </option>
					</select>
				</div>
			</div>

			<div class="query-btn ue-clear">
				<a style="margin-top: 5px; margin-left: 20px;" href="javascript:;" class="confirm editStatus searchButton">更新状态</a>
			</div>
		</div>
	</div>
</form>


<form action="{:url(SYS_PATH."/".CONTROLLER."/zhuishu")}" id="formsubmit" class="formvalidate2">
<div class="main"> 

	<empty name="list">
		<tr><td height="50" colspan="9" align="center" style="text-align:center;">没有数据</td></tr>
	</empty>

		<ul class="bchsboxmes">
			<volist name="list" id="vo">
				<li style="width: 25%;float: left;margin-top: 15px;">
					<input type="checkbox" name="ids[]" value="{$vo.id}"
					<php>
						if(in_array($vo['id'],$ids)){
						echo "checked";
						}
					</php>
						 class="checked_list <php>
							if(in_array($vo['id'],$ids)){
								echo "check";
					}
					</php> checkAll"/>
					{$vo.id}-{$vo.name}
				</li>
			</volist>
		</ul>
	<div class="filter">
		<br>
		<div class="button_bottom">
			<input type="button" style="background-color:#0789D2; border-color:#999;" class="button editLc" value="确认修改">
		</div>
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

	$('.bchsboxmes').on('click', '.checked_list', function () {
		$(this).toggleClass("check");
	});


	$('.editLc').click(function () {
		var id = [];
		$(".checked_list").each(function (index, e) {
			if ($(e).hasClass('check')) {
				id.push($(e).val())
			}
		});
		var ids = (id.join(','));
		$.ajax({
			url: "{:url(SYS_PATH."/".CONTROLLER."/zhuishu")}",
			data:{"ids":ids},
			type: "POST",
			success: function (req) {
				console.log(req);
				if (req.code == 0) {
					layer.msg(req.msg);
				}
				if (req.code == 1) {
					layer.msg(req.msg);

				}
			}
		});
	})
	
	$('.editStatus').click(function () {
		var status = $("#status").find("option:selected").val();
        $.ajax({
            url: "{:url(SYS_PATH."/".CONTROLLER."/editStatusZs")}",
            data:{"status":status},
            type: "POST",
            success: function (req) {
                console.log(req);
                if (req.code == 0) {
                    layer.msg(req.msg);
                }
                if (req.code == 1) {
                    layer.msg(req.msg);

                }
            }
        });
    })
	
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
