<style>
	.jyboxplat1{
		margin-top:20px;
	}
	.jyboxplat1 h1 {
		font-size: 24px;
		color: #000;
	}
	.jyboxplat1 h2 {
		margin-top: 10px;
		font-size: 14px;
	}
	.jyboxplat1 h2 span {
		margin-right: 20px;
	}
	.jyboxplat1 h2 span:first-child {
		color: #000;
		font-weight: 600;
	}
	.statijy {
		height: 80px;
		line-height: 80px;
		font-size: 18px;
		font-weight: 600;
		color: #000;
	}
	.jyboxplat2 {
		overflow: hidden;
		padding: 20px;
		border: 1px solid #e7e7e7;
		border-radius: 4px;
	}
	.jyboxplat2 .jyboxplat2-ul {
		overflow: hidden;
	}
	.jyboxplat2 .jyboxplat2-ul li {
		width: 20%;
		height: 150px;
		float: left;
		text-align: center;
	}
	.jyboxplat2 .jyboxplat2-ul li img {
		margin-top: 20px;
		height: 30px;
	}
	.jyboxplat2 .jyboxplat2-ul li p {
		margin-top: 10px;
		margin-bottom: 10px;
		font-size: 16px;
		color: #0a6efa;
	}
	.jyboxplat2 .jyboxplat2-ul li  h2 {
		font-size: 30px;
		font-weight: 600;
	}
	.jyboxplat2 .jyboxplat2-ul li h2 span {
		font-size: 14px;
		color: #96a0b4;
	}
	.jyboxplat2 .jyboxplat2-ul .jybulon {
		background: #0a6efa;
		color: #ffffff;
	}
	.jyboxplat2 .jyboxplat2-ul .jybulon p {
		color: #ffffff;
	}

	.jyboxplat2 .jyboxplat2-ul .jybulon h2 {
		color: #ffffff;
	}
	.jyboxplat2 .jyboxplat2-ul .jybulon a h2 {
		color: #ffffff;
	}
	.jybicn {
		margin-bottom: 25px;
	}
	.jybicn img {
		width: 20px;
		margin-right: 5px;
		vertical-align: middle;
	}
	.jybicn span {
		vertical-align: middle;
	}
	.jybicn1 {
		margin-top: 25px;
	}
	.jyboxplat2-ul2 li {
		width: 20%;
		height: 100px;
		float: left;
		text-align: center;
	}
	.jyboxplat2-ul2 li p {
		margin-top: 10px;
		margin-bottom: 10px;
		font-size: 16px;
		color: #50576e;
	}
	.jyboxplat2-ul2 li h2 {
		margin-top: 10px;
		font-size: 30px;
		font-weight: 600;
	}
	.jyboxplat2-ul2 li h2 span {
		font-size: 14px;
		color: #96a0b4;
	}
	.checkupdbox {
		margin-top: 20px;
		background: #fbfcfd;
	}
	.checkupdate h1 {
		font-size: 18px;
		color: #000;
	}
	.checkupdate h1 span {
		display: inline-block;
		width: 84px;
		height: 36px;
		line-height: 36px;
		border-radius: 4px;
		background: #0a6efa;
		color: #ffffff;
		text-align: center;
		font-size: 14px;
		margin-left: 10px;
		cursor: pointer;
	}
	.checkupdate h2 {
		margin: 10px 0;
		color: #50576e;
	}
	.checkupdate p {
		margin-top: 10px;
		font-size: 14px;
		color: #f03c00;
	}
	.checkupdate .checkorange {
		display: inline-block;
		width: 128px;
		height: 36px;
		background: #f03c00;
		color: #ffffff;
		text-align: center;
		line-height: 36px;
		border-radius: 4px;
		cursor: pointer;
	}
	.stayjyft {
		margin-bottom: 50px;
		overflow: hidden;
	}
	.stayjyft dl {
		float: left;
		width: 33.33333333%;
	}
	.stayjyft dl dt {
		font-size: 14px;
		color: #50576e;
		font-weight: 800;
	}
	.stayjyft dl dd {
		margin-top: 10px;
		font-size: 14px;
		color: #50576e;
	}
	@media screen and (max-width: 1200px) {
		.right .jyboxplat2-ul > li {
			width: 33.33333333%;
		}
		.right .jyboxplat2-ul2 > li {
			width: 33.33333333%;
		}
	}
</style>
<div class="jyboxplat1">
	<h1>你好，{$users.u_name}欢迎登录</h1>
	<h2>
		<span>管理权限： {$role.name}</span>
		<span>上次登录时间：{$lastLogin['create_time']|date='Y-m-d H:i:s'}</span>
		<span>登录IP地址：{$lastLogin['log_ip']}</span>
	</h2>
</div>
<div class="statijy">数据统计</div>
<div class="jyboxplat2">
	<div class="jybicn"><img src="images/jytim.png" alt=""> <span>今日数据</span></div>
	<ul class="jyboxplat2-ul">
		<li class="ftIcn">
			<img src="images/jyicn1.png" alt="">
			<p>注册用户数</p>
			<a href="javascript:void(0);" data-url="{:url(SYS_PATH."/member/all",array("start_date"=>$start_date,"end_date"=>$end_date))}" class="frmrightClass">
				<h2 >
					{$todayUser}
					<span>人</span>
				</h2>
			</a>
		</li>
		<if condition="$users['role_id'] eq 1">
			<li class="ftIcn jybulon">
				<img src="images/jyicn2c.png" alt="">
				<p>充值中心</p>
				<a href="javascript:void(0);" data-url="{:url(SYS_PATH."/income/recharge",array("start_date"=>$start_date,"end_date"=>$end_date))}" class="frmrightClass">
					<h2 >
						<if condition="$todayRecharge['total']">
                            {$todayRecharge['total']}
							<else/>
							0
						</if>
						<span>元</span>
					</h2>
				</a>
			</li>
		</if>

		<li class="ftIcn">
			<img src="images/jyicn3.png" alt="">
			<p>待审核章节</p>
			<a href="javascript:void(0);" data-url="{:url(SYS_PATH."/book/examine",array("start_date"=>$start_date,"end_date"=>$end_date))}" class="frmrightClass">
				<h2 >{$todayChapter} <span>条</span></h2>
			</a>
		</li>
		<li class="ftIcn">
			<img src="images/jyicn4.png" alt="">
			<p>打赏统计</p>
			<a href="javascript:void(0);" data-url="{:url(SYS_PATH."/income/reward",array("start_date"=>$start_date,"end_date"=>$end_date))}" class="frmrightClass">
				<h2 >
					<if condition="$todayReward['total']">
						{$todayReward['total']}
						<else/>
						0
					</if>
					<span>书币</span>
				</h2>
			</a>
		</li>
		<li class="ftIcn">
			<img src="images/jyicn5.png" alt="">
			<p>订阅统计</p>
			<a href="javascript:void(0);" data-url="{:url(SYS_PATH."/income/take",array("start_date"=>$start_date,"end_date"=>$end_date))}" class="frmrightClass">
				<h2 >
					<if condition="$todayDy['price']">
						{$todayDy['price']}
						<else/>
						0
					</if>
					<span>书币</span>
				</h2>
			</a>
		</li>
	</ul>
	<div class="jybicn jybicn1"><img src="images/jydata.png" alt=""> <span>累计数据</span></div>
	<ul class="jyboxplat2-ul2 ">
		<li>
			<a href="javascript:void(0);" data-url="{:url(SYS_PATH."/member/all")}" class="frmrightClass">
				<h2 style="color:#5f5d5d">
					{$user}
					<span>人</span>
				</h2>
			</a>
			<p>
				<a href="javascript:void(0);" data-url="{:url(SYS_PATH."/member/all")}" class="frmrightClass">
				注册用户数
				</a>
			</p>
		</li>
		<if condition="$users['role_id'] eq 1">
			<li>
				<a href="javascript:void(0);" data-url="{:url(SYS_PATH."/income/recharge")}" class="frmrightClass">
					<h2 style="color:#5f5d5d">{$recharge['total']} <span>元</span></h2>
				</a>
				<p>
					充值中心
				</p>
			</li>
		</if>

		<li>
			<a href="javascript:void(0);" data-url="{:url(SYS_PATH."/book/examine")}" class="frmrightClass">
				<h2 style="color:#5f5d5d">{$chapter} <span>条</span></h2>
			</a>
			<p>待审核章节</p>
		</li>
		<li>
			<a href="javascript:void(0);" data-url="{:url(SYS_PATH."/income/reward")}" class="frmrightClass">
				<h2 style="color:#5f5d5d">{$reward['total']} <span>书币</span></h2>
			</a>
			<p>打赏列表</p>
		</li>
		<li>
			<a href="javascript:void(0);" data-url="{:url(SYS_PATH."/income/take")}" class="frmrightClass">
				<h2 style="color:#5f5d5d">{$dy['price']}<span>书币</span></h2>
			</a>
			<p>订阅列表</p>
		</li>
	</ul>
</div>
<div class="jyboxplat2 checkupdbox">
	<div class="checkupdate">
		<h1>欢迎使用ZMCMS，版本信息 {:ZMCMS_VERSION} <span id="updateVersion">检查更新</span></h1>
		<h2>计算机软件著作权证书号：软著登字第1308074号</h2>
		<div id="inputCode" class="checkorange">检查软件授权></div>
		<p>未获商业授权之前，不得将本软件用作 商业用途，购买商业授权请登录www.zhi-meng.cn了解最新说明。</p>
	</div>
</div>
<div class="statijy">系统信息</div>
<div class="stayjyft">
	<dl>
		<dt>软件信息</dt>
		<dd><span>操作系统：</span><?php $os = explode(" ", php_uname()); echo $os[0];?></dd>
		<dd><span>WEB服务：</span><?php echo $_SERVER['SERVER_SOFTWARE'];?></dd>
		<dd><span>PHP版本：</span>{:PHP_VERSION}</dd>
		<dd><span>Mysqsl版本：</span>{:$mysql_version}</dd>
	</dl>
	<dl>
		<dt>组件信息</dt>
		<dd><span>附件上传：</span><?php echo ini_get('upload_max_filesize');?></dd>
		<dd><span>GD库：</span><?php $gd=gd_info(); echo $gd['GD Version']; ?></dd>
		<dd><span>allow-url-fopen：</span><?php if(ini_get("allow_url_fopen")){echo "支持";}else{echo "禁用";} ?></dd>
		<dd><span>curl：</span><?php echo isfun("curl_init");?></dd>
	</dl>
	<dl>
		<dt>系统设置</dt>
		<dd><span>主机名称：</span><?php if('/'==DIRECTORY_SEPARATOR ){echo $os[1];}else{echo $os[2];} ?></dd>
		<dd><span>POST最大限制：</span><?php echo ini_get("post_max_size");?></dd>
		<dd><span>上传最大限制：</span><?php echo ini_get("upload_max_filesize");?></dd>
		<dd><span>脚本超时：</span><?php echo ini_get("max_execution_time");?></dd>
	</dl>
</div>
<script>
	
	$('.jyboxplat2-ul').on('mouseover','.ftIcn',function() {
		$(this).addClass("jybulon").siblings().removeClass("jybulon");
		for(var i = 0; i < $('.ftIcn').length; i++) {
			var img_src = $('.ftIcn img').eq(i).attr('src').split('.')[0];
			var img_src_len = img_src.length;
			if('c' == img_src[img_src_len - 1]) {
				img_src = img_src.split('');
				img_src.pop();
				img_src = img_src.join('');
			}
			$('.ftIcn img').eq(i).attr('src',img_src + '.png');
		}
		var src_this = $(this).find('img').attr('src').split('.')[0];
		src_len = src_this.length;
		if('c' == src_this[src_len - 1]) return;
		$(this).find('img').attr('src',src_this + 'c.png');
	});
</script>
<script language="javascript">
    $(document).ready(function () {
        $("#updateVersion").click(function () {
            layer.confirm('升级前请做好系统备份,确定吗？', {
                title:"操作提示",
                btn: ['确定', '取消'], //按钮
                icon: 0,
                shade: [0.8, '#393D49']
            }, function () {
                var loadingUpdate = layer.load();
                update(loadingUpdate);
            }, function () {

            });

        });
        $("#inputCode").click(function () {
            layer.prompt({
                formType: 2,
                value: '32位授权码',
                title: '请输入授权码',
                shade: [0.8, '#393D49']
            }, function (value, index, elem) {
                $.getJSON("{:url(SYS_PATH.'/update/authCodeSave')}?ram=" + Math.random(),{code:value}, function (json) {
                    if (json.status == 0) {
                        layer.msg(json.msg, {icon: 2,shade: [0.8, '#393D49']});
                    } else {
                        layer.msg(json.msg, {icon: 1,shade: [0.8, '#393D49']});
                    }
                });
                layer.close(index);
            });
        });
        function update(loadingUpdate) {
            $.getJSON("{:url(SYS_PATH.'/update/updateSystem')}?ram=" + Math.random(), function (json) {
                if (json.status == 0) {
                    layer.msg(json.msg, {icon: 2,shade: [0.8, '#393D49'],time:1000});
                } else {
                    layer.msg(json.msg, {icon: 1,shade: [0.8, '#393D49'],time:1000});
                }
                layer.close(loadingUpdate);
            });

        }
    });
    function systemStatus(){
        try{
            $.getJSON("{:url(SYS_PATH.'/Update/versionCheck')}?ram=" + Math.random(), function (json) {
                $("#oauth").html(json.msg);
                if(json.status==0){
                    $("#inputCode").html("输入授权码");
                }
            });
        }catch(e){
            console.log(e);
        }
    }
    setTimeout("systemStatus()",1000);



    // ces
//    $(function(){
//        var html = '';
//        html +=
//            '<div class="item" data-id="665">'+
//			'</div>'
//        $('.library-list').append(html);
//    })
</script>