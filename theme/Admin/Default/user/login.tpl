<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>{:ZMCMS_VERSION}-后台登录管理</title>
    <link rel="stylesheet" href="css/login.css">
<script>
if(window.top.location != window.self.location){
	window.top.location = window.self.location;
}
window.onload=function(){
		document.getElementById("username").focus();
}
</script>       
</head>
<body>
<div class="login">
    <div class="login_title">
        <p><img src="images/sysUser.png" ></p>
    </div>
    <div class="login_main">

        <div class="main_right">
            <div class="right_title">管理登录</div>
            <form action="{:url($sys_path."/user/login")}" method="post" name="sysLogin" id="sysLogin">
                <div class="username">
                    <img src="images/username.png" alt="">
                    <input type="text" name="username" id="username" placeholder="请输入用户名">
                </div>
                <div class="password">
                    <img src="images/password.png" alt="">
                    <input type="password" name="passwd" id="passwd" placeholder="请输入密码">
                </div>
                <if condition="$codeStatus eq 1">
                <div class="code">
                    <img src="images/code.png" alt="">
                    <input type="text" name="code" id="code" placeholder="请输入验证码">
                    <div class="code_img">
                        <img src="{:url(SYS_PATH."/user/verify")}" onclick='this.src=this.src+"#"+Math.random()'  alt="">
                    </div>
                </div>
                </if>
                <div class="yes_login"><button>登&nbsp;&nbsp;&nbsp;&nbsp;录</button></div>
            </form>
        </div>
        
    </div>

    <div class="login_footer">
        <p class="name">  系统版本：{:ZMCMS_VERSION}</p>
        <p>建议浏览器：IE9以上、Firefox v22</p>
    </div>
</div>
<script type="text/javascript" src="/public/admin/default/js/jquery-1.9.1.js"></script>
<script type="text/javascript" src="/public/layer/layer.js"></script>
<script language="javascript">
$(document).ready(function() {
    $("#sysLogin").submit(function () {
    	var uri=$(this).attr("data-url");
        var txtUser = $.trim($("#username").val());
        var txtPwd = $("#passwd").val();
        
        if ($.trim(txtUser) == "") {
            $("#username").focus();
            layer.msg('请输入账号',{time:1000});
            return false;
        }
        if ($.trim(txtPwd) == "") {
            $("#passwd").focus();
            layer.msg('请输入密码',{time:1000});
            return false;
        }
		<if condition="$codeStatus eq 1">
		var txtCode = $.trim($('#code').val());
        if ($.trim(txtCode) == "") {
            $("#code").focus();
            layer.msg('请输入验证码',{time:1000});
            return false;
        }
		</if>
		return true;
    });
});
</script>
</body>
</html>