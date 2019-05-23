<div class="nav"><span>添加私信</span></div>

<div class="explain">
    <div class="name"><span>操作提示</span></div>
    <div class="con">
        <p>私信内容只能发送给指定的用户，也只有指定用户能看到</p>
    </div>
</div>
<form method="get" action="{:url(SYS_PATH.'/'.CONTROLLER.'/index')}" class="ajaxSearchFrom">
    <div class="query">
        <div class="query-conditions ue-clear">
            <div class="conditions name ue-clear">
                <label>用户列表：</label>
                <div class="select-wrap">
                    <div class="select-title ue-clear">
                        <span>
                             用户列表
                        </span>
                        <i class="icon"></i>
                    </div>
                    <ul class="select-list" style="display: none;"
                        data-url="{:url(SYS_PATH."/".CONTROLLER."/addLetter",array("id"=>$id))}"
                        data-name="id">

                        <li value="">用户列表</li>
                        <zhimeng table="member" where="['status','=',1]">
                            <li value="{$r.id}">{$r.phone}</li>
                        </zhimeng>
                    </ul>
                </div>
            </div>
            <!--<div style="clear: both;"></div>-->
            <div class="conditions staff ue-clear">
                <label style="width: 110px;">用户信息搜索：</label>
                <input type="text" name="keyword" value="{$keyword|default=''}" placeholder="手机号码，真实姓名，昵称">
            </div>
            <div class="query-btn ue-clear">
                <a style="margin-top: 5px; margin-left: 20px;" href="javascript:;" class="confirm searchButton"
                   data-url="{:url(SYS_PATH."/".CONTROLLER."/addLetter")}">查询用户</a>
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
                <th width="100">创建私信</th>
            </tr>
            </thead>
            <tbody>
            <empty name="user">
                <tr><td height="50" colspan="9" align="center" style="text-align:center;">没有数据</td></tr>
            </empty>
            <volist name="user" id="vo">
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

                    </td>
                    <td>
                        <if condition="$vo.name">
                            {$vo.name}
                            <else/>
                            <span style="color: pink">未填</span>
                        </if>
                    </td>

                    <td>
                        {$vo.pen_name}
                    </td>

                    <td>
                        <a href='javascript:void(0);'  data-url='{:url(SYS_PATH."/".CONTROLLER."/edit",array("id"=>$vo["id"]))}'  class='dialog edit' alt='添加私信' title='添加私信'  data-height="500px" data-width="850px">添加私信</a>
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