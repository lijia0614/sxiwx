

<!DOCTYPE html>
<html>
<head>
<title>安装环境检测-ZmCMS</title>
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
.submit{ padding:10px 20px; background:#FF9900; margin-bottom:10px; color:#6B3C03; font-size:16px; text-decoration:none; }
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
			<span ><i>√</i><em>配置参数</em></span>
			<span ><i>√</i><em>安装执行</em></span>
			<span ><i>√</i><em>安装完成</em></span>

		</div> 

		<div class="es" style="padding:20px 0 0 0;">
			<table width="100%" class="ltable">
				<thead>
					<tr>
						<th width="220">项目</th>
						<th width="180">当前配置</th>
						<th width="120">参考配置</th> 
						<th>支持功能</th> 
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>操作系统</td>
						<td><?php $os = explode(" ", php_uname()); echo $os[0];?></td>
						<td>不限制</td>
						<td>推荐Linux</td>
					</tr>
					<tr>
						<td>服务器环境</td>
						<td><?php echo $_SERVER['SERVER_SOFTWARE'];?></td>
						<td>apache2.0/nginx1.6以上</td>
						<td>推荐nginx</td>
					</tr>
					<tr>
						<td>PHP版本</td>
						<td>{:PHP_VERSION}</td>
						<td>5.6.0以上</td>
						<td>运行条件</td>
					</tr>
					<tr>
						<td>附件上传</td>
						<td>{$uploadSize|raw}</td>
						<td>不低于2M</td>
						<td>上传本地文件</td>
					</tr>
					<tr>
						<td>GD库</td>
						<td>{$gd|raw}</td>
						<td>1.0</td>
						<td>图形验证码</td>
					</tr>
					<tr>
						<td>CURL</td>
						<td>{$allow_url_fopen|raw}</td>
						<td>启用</td>
						<td>数据请求</td>
					</tr>                    
					<tr>
						<td>mysqli</td>
						<td>{$mysql|raw}</td>
						<td>启用</td>
						<td>数据储存</td>
					</tr> 
				</tbody> 
			</table>
						<table class="ltable" width="100%">
				<thead>
					<tr>
						<th width="220">目录文件</th> 
						<th width="180">写入权限</th> 
						<th width="120">读取权限</th> 
					</tr>
				</thead>
				<tbody>
                {$folderCheck|raw} 
					
								</tbody> 
			</table>
		</div>
		<div class="next" style="padding:0 0 20px 0;">
			<a href="{:url("Install/index/index",array('step'=>3))}"  class="submit">同意并开始安装</a>
		</div>  
        
 
</div>
</div>
</body>
</html>
