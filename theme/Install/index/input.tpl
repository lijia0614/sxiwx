<!DOCTYPE html>
<html>
<head>
<title>配置系统-系统安装</title>
<style type="text/css">
*{font-family:"microsoft yahei"; font-size:12px; margin:0; padding:0; border:0; }
body{ background:#0972A3; }
.main{ width:800px; margin:0 auto; }
.maincon{ width:100%; background:#F3FBFE; margin:50px 0; float:left; } 
.head{ width:100%; background:#30ACE6; color:#fff; background: linear-gradient(to top right,#2C9ED3, #35B6F3, #35B6F3); border-bottom:1px solid #efefef; padding:25px 0 23px; float:left; }
.head .logo{ margin:10px 0 0 50px; float:left; }
.head .lname{ font-size:26px; margin:5px 0 0 20px; border-left:1px solid #58C5F8; padding:0 0 5px 20px; float:left; }
.head .rhelp a{ text-decoration:none; color:#fff; font-size:12px; margin:15px 20px 0 0; float:right; }
.head .rhelp a i{ background:#fff; width:15px; height:15px; color:#30ACE6; text-align:center; line-height:15px; border-radius:15px; margin:2px 5px 0 0; float: left; }

.navigation{ width:80%; padding:20px 10% 18px; border-bottom:1px solid #eee; float: left; }
.navigation span{ width:25%; float:left; }
.navigation span i{ width:30px; height:30px; text-align:center; line-height:30px; font-size:22px; background:#ddd; border-radius:30px; color:#999; font-family: "宋体"; float:left; } 
.navigation span.ch i{ width:30px; height:30px; background:#30ACE6; color:#fff; float:left; } 
.navigation span.ch{ color:#3399FF; }
.navigation span em{ font-size:18px; font-style:inherit; padding:5px 0 0 10px; float:left; } 

input[type="text"]{ border:1px solid #ddd; padding:6px; border-radius:2px; }
input[type="password"]{ border:1px solid #ddd; padding:6px; border-radius:2px; } 
.action{ margin:0 80px; padding:20px 0 30px; float:left; } 
.action .name{ width:100%; color:#333; padding:10px 0; font-size:14px; color:#1080B5; float:left; }
table.etable tr td{ padding:3px 0; }
table.etable tr td:first-child{ text-align:right; color:#888; padding-right:10px; }
table.etable tr td span{ padding:6px 0 0 10px; color:#666666; float:left; }
table.etable tr td  .tips_error{font-weight:bold; color:#F00;}
table.etable tr td  .tips_success{font-weight:bold; color:#093;}
table.etable tr td input{ float:left; } 
table.ltable{ border-bottom:1px solid #efefef; padding-bottom:10px; margin-bottom:20px; }
table.ltable thead tr th{ padding:3px 0; text-align:left; background:#E9F8FE; padding:10px 0 10px 10px; color:#0A88CA;  }
table.ltable tbody tr td{ padding:10px 0 10px 10px; } 
 
.es{ width:680px; margin:0 0 0 55px; float:left; } 
.agreenBox{ width:680px; color:#555; margin:10px 50px 10px; border:1px solid #ddd; padding:10px; height:300px; overflow-y:scroll; border:px solid #efefef; float:left; }
.agreenBox p{ color:#555; } 
.endbox{ width:600px; margin:30px 90px 50px; padding:10px; border:px solid #efefef; float:left; }
.endbox .h3{ width:100%; font-size:22px; float:left; }
.endbox .h4{ width:100%; padding:10px 0; color:#666; float:left; }
.endbox .shpx{ width:100%; padding:10px 0; float:left; }
.endbox .shpx a{ border:1px solid #FF9900; background:#FF9900; color:#fff; text-decoration:none; border-radius:1px; padding:10px 20px; margin-right:20px; float:left; }
.next{ width:100%; text-align:center; margin:10px 0 20px; float:left; }
span.error{ color:#FF0000; font-weight:bold; } 

/*协议*/
.ament{ background:#fff; border:1px solid #efefef; margin-top:30px; margin-bottom:20px; float:left; }
.ament p{ color:#888; line-height:22px; }
.ament strong{ color:#333; } 
input.submit{ padding:10px 20px; background:#FF9900; margin-bottom:10px; color:#6B3C03; font-size:16px; }
input.submit:disabled{ background:#ddd; }


</style>
</head>
<body>
<div class="main">
<div class="maincon">
	<div class="head">
		<div class="logo"><img src="/public/admin/default/images/copyright_logo.png"/></div> 
		<div class="lname">系统安装</div> 
		<div class="rhelp"><a href="javascript:void(0);" target="_blank"><i>？</i>安装帮助</a></div>
	</div>
		<div class="navigation">
			<span class="ch"><i>√</i><em>环境检测</em></span>
			<span class="ch"><i>√</i><em>配置参数</em></span>
			<span ><i>√</i><em>安装执行</em></span>
			<span ><i>√</i><em>安装完成</em></span>
		</div> 
		<div class="action">
        <form id="J_install_form" action="{:url('Install/index/index',array('step'=>4))}" method="post">
          <input type="hidden" name="force" value="0" />
				<div class="name">连接数据库</div>
				<table class="etable" width="100%"> 
					<tr><td width="180">地址：</td>	<td><input type="text" size="32" name="dbhost" id="dbhost" value="127.0.0.1"/></td></tr> 
                    <tr><td>数据库端口：</td>						<td><input type="text" size="32" name="dbport" id="dbport" value="3306"/><span>默认3306</span></td></tr>
					<tr>
                    <td>用户名：</td>	
                    <td><input type="text" size="32" name="dbuser" id="dbuser" value="root"/><div id="J_install_tip_dbuser"></div></td></tr>
					<tr>
                    <td>密码：</td>
                    <td><input type="text" size="32" name="dbpw" id="dbpw" value=""  autocomplete="off" onblur="TestDbPwd()" />
                    <div id="J_install_tip_dbpw"></div>
                    </td>
                    </tr>
					<tr>
                    <td>数据库：</td>	
                    <td><input type="text" size="32" name="dbname" id="dbname" value=""/>
                    <div id="J_install_tip_dbname"></div>
                    </td></tr> 
					<tr><td>数据库表前缀：</td>					<td><input type="text" size="32" name="dbprefix" id="dbprefix" value="zhimeng_"/></td></tr>
					<!--<tr><td>安装测试数据：</td>			<td><input name="demo_data" type="checkbox" value="1"></td></tr>  -->
                    <tr><td>&nbsp;</td><td>
                    <tr><td>&nbsp;</td><td>
                    <tr><td>&nbsp;</td><td>
                    <tr><td>&nbsp;</td><td>
                    <input type="submit" name="install" class="submit J_install_btn" style="cursor:pointer;" value="提交安装"/></td></tr>
				</table> 
				<!--<div class="name">管理员账号</div>
				<table class="etable">
					<tr><td width="180">管理员账号：</td>	<td><input type="text" size="32" name="admin" id="admin_user" value="admin"/></td></tr>
					<tr><td>管理员密码：</td>				<td><input type="text" size="32" name="admin_pass" id="admin_pass" value=""/></td></tr>
					<tr><td>确认新密码：</td>				<td><input type="text" size="32" name="admin_repass" id="admin_pass2" value=""/></td></tr>  
					<tr><td>&nbsp;</td><td>
                    <input type="submit" name="install" class="submit J_install_btn" value="提交安装"/></td></tr>
				</table>-->
			</form>
		</div>

      <script src="/public/install/js/jquery.js?v=9.0"></script>
      <script src="/public/install/js/validate.js?v=9.0"></script>
      <script src="/public/install/js/ajaxForm.js?v=9.0"></script>         
<script>
	  function TestDbPwd() {
          var dbHost = $('#dbhost').val();
          var dbUser = $('#dbuser').val();
          var dbPwd = $('#dbpw').val();
          var dbName = $('#dbname').val();
          var dbPort = $('#dbport').val();
          data = {
            'dbHost': dbHost,
            'dbUser': dbUser,
            'dbPwd': dbPwd,
            'dbName': dbName,
            'dbPort': dbPort
          };
          var url = "{:url('Install/index/index',array('step'=>3,'testdbpwd'=>1))}&randdom=" + Math.random();
          $.ajax({
            type: "POST",
            url: url,
            data: data,
            beforeSend: function() {},
            success: function(msg) {
              if (msg == "true") {
                $('#J_install_tip_dbpw').html('<span for="dbname" generated="true" class="tips_success" style="">数据库链接成功</span>')
              } else {
                $('#dbpw').val("");
                $('#J_install_tip_dbpw').html('<span for="dbname" generated="true" class="tips_error" style="">数据库链接配置失败</span>')
              }
            },
            complete: function() {},
            error: function() {
              $('#J_install_tip_dbpw').html('<span for="dbname" generated="true" class="tips_error" style="">数据库链接配置失败</span>');
              $('#dbpw').val("")
            }
          })
        }
        $(function() {
          var focus_tips = {
            dbhost: '数据库服务器地址，一般为localhost',
            dbport: '数据库服务器端口，一般为3306',
            dbuser: '',
            dbpw: '',
            dbname: '',
            dbprefix: '建议使用默认，同一数据库安装多个时需修改',
            manager: '创始人帐号，拥有站点后台所有管理权限',
            manager_pwd: '',
            manager_ckpwd: '',
            site_name: '',
            site_url: '请以“/”结尾',
            site_keyword: '',
            site_description: '',
            manager_email: ''
          };
          var install_form = $("#J_install_form"),
          reg_username = $('#J_reg_username'),
          reg_password = $('#J_reg_password'),
          reg_tip_password = $('#J_reg_tip_password'),
          response_tips = $('#J_response_tips');
          install_form.validate({
            errorPlacement: function(error, element) {
              $('#J_install_tip_' + element[0].name).html(error)
            },
            errorElement: 'span',
            errorClass: 'tips_error',
            validClass: 'tips_error',
            onkeyup: false,
            focusInvalid: false,
            rules: {
              dbhost: {
                required: true
              },
              dbport: {
                required: true
              },
              dbuser: {
                required: true
              },
              dbname: {
                required: true
              },
              dbprefix: {
                required: true
              },
              manager: {
                required: true
              },
              manager_pwd: {
                required: true
              },
              manager_ckpwd: {
                required: true,
                equalTo: '#J_manager_pwd'
              },
              manager_email: {
                required: true,
              }
            },
            highlight: false,
            unhighlight: function(element, errorClass, validClass) {
              var tip_elem = $('#J_install_tip_' + element.name);
              tip_elem.html('<span class="' + validClass + '" data-text="text"><span>')
            },
            onfocusin: function(element) {
              var name = element.name;
              $('#J_install_tip_' + name).html('<span data-text="text">' + focus_tips[name] + '</span>');
              $(element).parents('tr').addClass('current')
            },
            onfocusout: function(element) {
              var _this = this;
              $(element).parents('tr').removeClass('current');
              if (element.name === 'email') {
                setTimeout(function() {
                  _this.element(element)
                },
                150)
              } else {
                _this.element(element)
              }
            },
            messages: {
              dbhost: {
                required: '数据库服务器地址不能为空'
              },
              dbport: {
                required: '数据库服务器端口不能为空'
              },
              dbuser: {
                required: '数据库用户名不能为空'
              },
              dbpw: {
                required: '数据库密码不能为空'
              },
              dbname: {
                required: '数据库名不能为空'
              },
              dbprefix: {
                required: '数据库表前缀不能为空'
              },
              manager: {
                required: '管理员帐号不能为空'
              },
              manager_pwd: {
                required: '密码不能为空'
              },
              manager_ckpwd: {
                required: '重复密码不能为空',
                equalTo: '两次输入的密码不一致。请重新输入'
              },
              manager_email: {
                required: '管理员帐号不能为空'
              }
            },
            submitHandler: function(form) {
              form.submit();
              return true
            }
          });
          var _data = {}
        });
</script>
 
</div>
</div>
</body>
</html>

