
<div class="explain">
    <div class="name"><span>数据分析</span></div>

</div>   

<div class="title"> 
    <img src="images/in1.png" /> 
    <span>今日数据</span>
</div> 
<div class="index">
    <ul class="tabList">
        <li>
            <div>
                <i class="iconfont icon-user yy" style="background-color: #0e85d5;"></i>
                <div class="numm">
                    <p class="nnn">注册用户</p>
                    <p class="nuuu fdb">{$todayUser} 条记录</p>
                    <p class="nnn"><a href="javascript:void(0);" data-url="{:url(SYS_PATH."/member/all",array("start_date"=>$start_date,"end_date"=>$end_date))}" class="frmrightClass">查看内容列表>></a></p>

                </div>
            </div>
        </li>
        <li> 
            <div> 

                <i class="iconfont icon-alipay yy"  style="background-color: #f9b842;"></i>
                <div class="numm"> 
                    <p class="nnn">充值中心</p>
                    <p class="nuuu fdb">{$todayRecharge} 条记录</p>
                    <p class="nnn"><a href="javascript:void(0);" data-url="{:url(SYS_PATH."/income/recharge",array("start_date"=>$start_date,"end_date"=>$end_date))}" class="frmrightClass">查看内容列表>></a></p>
                </div> 
            </div> </li>

        <li>
            <div>
                <i class="iconfont icon-wenzhang yy" style="background-color: #01c46a;"></i>
                <div class="numm">
                    <p class="nnn">待审核章节</p>
                    <p class="nuuu fe">{$todayChapter}  条记录</p>
                    <p class="nnn"><a href="javascript:void(0);" data-url="{:url(SYS_PATH."/book/examine",array("start_date"=>$start_date,"end_date"=>$end_date))}" class="frmrightClass">查看内容列表>></a></p>
                </div>
            </div>
        </li>

        <li>
            <div>
                <i class="iconfont icon-rmb yy" style="background-color: #b34fbd;"></i>
                <div class="numm">
                    <p class="nnn">打赏列表</p>
                    <p class="nuuu fdb">{$todayReward} 条记录</p>
                    <p class="nnn"><a href="javascript:void(0);" data-url="{:url(SYS_PATH."/income/reward",array("start_date"=>$start_date,"end_date"=>$end_date))}" class="frmrightClass">查看内容列表>></a></p>
                </div>
            </div> </li>


        <li>
            <div>
                <i class="iconfont icon-rmb yy" style="background-color: #0e85d5; "></i>
                <div class="numm">
                    <p class="nnn">订阅列表</p>
                    <p class="nuuu fdb">{$todayDy} 条记录</p>
                    <p class="nnn"><a href="javascript:void(0);" data-url="{:url(SYS_PATH."/income/take",array("start_date"=>$start_date,"end_date"=>$end_date))}" class="frmrightClass">查看内容列表>></a></p>
                </div>
            </div> </li>

    </ul>

    <br>
    <br>
    <div class="title">
        <img src="images/in1.png" />
        <span>累计数据</span>
    </div>
    <div class="index">
        <ul class="tabList">
            <li>
                <div>
                    <i class="iconfont icon-user yy" style="background-color: #0e85d5;"></i>
                    <div class="numm">
                        <p class="nnn">注册用户</p>
                        <p class="nuuu fdb">{$user} 条记录</p>
                        <p class="nnn"><a href="javascript:void(0);" data-url="{:url(SYS_PATH."/member/all")}" class="frmrightClass">查看内容列表>></a></p>

                    </div>
                </div>
            </li>
            <li>
                <div>

                    <i class="iconfont icon-alipay yy"  style="background-color: #f9b842;"></i>
                    <div class="numm">
                        <p class="nnn">充值中心</p>
                        <p class="nuuu fdb">{$recharge} 条记录</p>
                        <p class="nnn"><a href="javascript:void(0);" data-url="{:url(SYS_PATH."/income/recharge")}" class="frmrightClass">查看内容列表>></a></p>
                    </div>
                </div> </li>

            <li>
                <div>
                    <i class="iconfont icon-wenzhang yy" style="background-color: #01c46a;"></i>
                    <div class="numm">
                        <p class="nnn">待审核章节</p>
                        <p class="nuuu fe">{$chapter}  条记录</p>
                        <p class="nnn"><a href="javascript:void(0);" data-url="{:url(SYS_PATH."/book/examine")}" class="frmrightClass">查看内容列表>></a></p>
                    </div>
                </div> </li>

            <li>
                <div>
                    <i class="iconfont icon-rmb yy" style="background-color: #b34fbd;"></i>
                    <div class="numm">
                        <p class="nnn">打赏列表</p>
                        <p class="nuuu fdb">{$reward} 条记录</p>
                        <p class="nnn"><a href="javascript:void(0);" data-url="{:url(SYS_PATH."/income/reward")}" class="frmrightClass">查看内容列表>></a></p>
                    </div>
                </div> </li>


            <li>
                <div>
                    <i class="iconfont icon-rmb yy" style="background-color: #0e85d5; "></i>
                    <div class="numm">
                        <p class="nnn">订阅列表</p>
                        <p class="nuuu fdb">{$dy} 条记录</p>
                        <p class="nnn"><a href="javascript:void(0);" data-url="{:url(SYS_PATH."/income/take")}" class="frmrightClass">查看内容列表>></a></p>
                    </div>
                </div> </li>

        </ul>


    <!--
    <div class="zs">
        <p class="title"> 系统信息 </p>
        <ul>
            <li>
                <div class="img1">
                    系统版本：{:ZMCMS_VERSION}<br>
                    技术支持：四川挚梦科技有限公司<br>
                    联系电话：400-886-3878<br>
                    联系地址：成都市环球中心w3区1212-1214<br>
                </div>
            </li>
            <li>
                <div class="img2">
                    操作系统：<?php $os = explode(" ", php_uname()); echo $os[0];?><br>
                    WEB服务：<?php echo $_SERVER['SERVER_SOFTWARE'];?><br>
                    PHP版本：{:PHP_VERSION}<br>
                    Mysql版本：{:$mysql_version}<br>
                </div>
            </li>
            <li>
                <div class="img3">
                    <span style="font-size: 16px;">组件信息：</span><br>
                    附件上传：<?php echo ini_get('upload_max_filesize');?><br>
                    GD库：<?php $gd=gd_info(); echo $gd['GD Version']; ?><br>
                    allow_url_fopen：<?php if(ini_get("allow_url_fopen")){echo "支持";}else{echo "禁用";} ?><br>
                    curl：<?php echo isfun("curl_init");?>
                </div> </li>
            <li>
                <div class="img4">
                    <span style="font-size: 16px;">系统配置：</span><br>
                    主机名称：<?php if('/'==DIRECTORY_SEPARATOR ){echo $os[1];}else{echo $os[2];} ?><br>
                    POST最大限制：<?php echo ini_get("post_max_size");?><br>
                    上传最大限制：<?php echo ini_get("upload_max_filesize");?><br />
                    脚本超时：<?php echo ini_get("max_execution_time");?> 秒
                </div>
            </li>
        </ul>
    </div>
    -->
</div> 
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
</script>
