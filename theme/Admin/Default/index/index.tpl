<!DOCTYPE html>
<html>
 <head> 
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
  <title>欢迎使用{:ZMCMS_VERSION} &nbsp;系统管理中心</title> 
  <link href="css/common.css" rel="stylesheet" type="text/css" /> 
  <link href="css/index.css" rel="stylesheet" type="text/css" /> 
   <script src="/public/admin/default/js/jquery-1.9.1.js"></script> 
    <script src="/public/vend/lhgDialog/lhgdialog.min.js?skin=b"></script>
    <script src="/public/vend/Validform/Validform_v5.3.2_min.js"></script>
    <script src="/public/admin/default/js/common.js"></script>
    <script language="javascript" src="/public/layer/layer.js"></script>  
     <script src="/public/vend/laydate/laydate.js"></script>
     <link rel="stylesheet" type="text/css" href="/public/fonts/iconfont.css">
 </head> 
 <body> 
 <input type="hidden" name="current_load_url" id="current_load_url" value="" />  
  <div class="top"> 
   <span><img src="images/admin_logo.png" /></span> 
   <ul><include file="common:TopMenu" /></ul> 
   <h3> <a href="javascript:;" data-url="{:url(SYS_PATH."/setting/cache")}"   class="frmrightClass">清除缓存</a><em>|</em> <a href="/" target="_blank">网站首页</a><em>|</em> <a href="{:url(SYS_PATH."/user/doLogout")}">退出登录</a> </h3> 
  </div> 
  <div class="left"> 
   <div class="ltop"> 
   		<include file="common:LeftMenu" />
   </div> 
  </div> 
  <div class="right" style="overflow:auto;"> 
  <!--
   <div class="login_main"> 
    	
   </div> 
   -->
   <include file="index/main" />
  </div> 
  <div id="ajax_box"></div>   
  <script type="text/javascript"> 
window.onload = function() {
	if (!window.applicationCache) {
		alert("你的浏览器不支持HTML5,请使用谷歌为内核的浏览器。");
	}
} 
$(function(){ 
	win_h = $(window).height(); 
	function change_window(){
		win_w = $(window).width();
		if(win_w < 1200){
			$('body').css('width',1200+'px');
		}else{
			$('body').css('width',100+'%'); 
		}
	}
	change_window();
	$(window).resize(function(){ 
		win_w = $(window).width(); 
		if(win_w < 1200){
			$('body').css('width',1200+'px');
		}else{
			$('body').css('width',100+'%'); 
		} 
	}); 
	$(".left_box:first").show();  
	//------------//
	$(".left_box .title a:first").addClass('ch');  
	//顶部操作
	$(".top ul a").click(function(){
		$this = $(this);
		$this.addClass("top_ch").siblings().removeClass("top_ch");
		top_id = $this.attr('parent-id'); 
		$("#top_left_"+top_id).show().siblings().hide(); 
		$("#top_left_"+top_id+" .titlecon ul").hide();
		$("#top_left_"+top_id+" .titlecon ul:eq(0)").show();
		$("#top_left_"+top_id+" .titlecon ul li a").removeClass('ch');
		$("#top_left_"+top_id+" .titlecon ul li:eq(0) a").addClass('ch'); 
		// 地址
		url = $("#top_left_"+top_id+" ul li:first a").attr('data-url'); 
		$("#current_load_url").val(url);
		loding();
        $(".right").load(url, '',function(response) {
            try {
                var response = $.parseJSON(response);
                if (response.status != 1) {
                    window.wxc.xcConfirm(response.msg, window.wxc.xcConfirm.typeEnum.error);
                    lodingok();
                    $(".right").html("<iframe src='/admin/error/index' width='100%' height='100%' frameborder='0' scrolling='0'>");
                    return;
                }
            } catch(e) {
                lodingok();
            }
        });
		// 大标
		$("#top_left_"+top_id+" .title a").removeClass('ch');
		$("#top_left_"+top_id+" .title a:first").addClass('ch');
	}); 
	//左侧部分
	$(".left ul li a").click(function(){ 
		$this = $(this);
		url = $this.attr('data-url');
		$("#current_load_url").val(url);
		//alert(url);
		$this.addClass('ch').parents('li').siblings().find('a').removeClass('ch'); 
	});
	// 左侧大标
	$(".left_box .title a.lname").click(function(){
		id = $(this).attr('data-id'); 
		$(this).siblings().removeClass('ch');
		$(this).addClass("ch");
		
		$(".titlecon ul.in_"+id).show().siblings().hide();
		$(".titlecon ul.in_"+id+" li a").removeClass('ch');
		$(".titlecon ul.in_"+id+" li:eq(0) a").addClass('ch');  
		 
		url = $(".titlecon ul.in_"+id+" li:eq(0) a").attr('data-url');
		$("#current_load_url").val(url);
		loding();
        $(".right").load(url, '',function(response) {
            try {
                var response = $.parseJSON(response);
                if (response.status != 1) {
                    window.wxc.xcConfirm(response.msg, window.wxc.xcConfirm.typeEnum.error);
                    lodingok();
                    $(".right").html("<iframe src='/admin/error/index' width='100%' height='100%' frameborder='0' scrolling='0'>");
                    return;
                }
            } catch(e) {
                lodingok();
            }
        });
	}); 
	// 让第一个显示
	$(".left_box").each(function(){
		$(this).find('.titlecon ul').eq(0).show();
		$(this).find('.titlecon ul').eq(0).find('li a:eq(0)').addClass('ch').show(); 
	}); 
	
});
function clear_cache(){
	$.get("?m=config&a=temp_clear&path=all&jq_time="+new Date().getTime(), function(result){
		data = jQuery.parseJSON(result);
		if(data.error == '0'){
			$.alert('清空成功');
		}else{
			$.alert(data.msg);
		}
	});
}
</script>
<!--遮罩层-->
<div id="BgDiv1"></div>
<div class="U-login-con">
    <div class="DialogDiv" style="display:none; ">
          <div class="U-guodu-box">
                <div>
                        <table width="100%" cellpadding="0" cellspacing="0" border="0">
                            <tbody><tr><td align="center"><img src="/public/admin/default/images/loading.gif"></td></tr>
                            <tr><td valign="middle" align="center" style="line-height:30px;">加载中</td></tr>
                        </tbody></table>
               </div>
         </div>
    </div>
</div>
<!--遮罩层-->
 </body>
</html>