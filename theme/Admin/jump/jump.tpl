<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>系统提示</title>
<style type="text/css">
	*{font-family:"微软雅黑";}
	body{background:#777; background-image:url(/public/admin/default/images/banner_1.jpg);}
    .alert{width:auto; margin:50px auto; font-size:12px; line-height:24px;}
    .alert .alert_body{padding:0; height:163px; width:400px;background-color:#fff; border:3px solid #e9f4f7; border-radius:3px;  opacity:0.8;  position:relative; }
    .alert .alert_body h3{font-size:14px; font-weight:bold; margin:0;}
    .alert .alert_body .alertcont{margin:15px 0 0 85px; padding:5px 50px; line-height:30px; color:#666; min-height:30px; _height:30px;}
    .alert .alert_body .alertcont a{color:#000; text-decoration:none;}
    .alert .alert_body .alertcont span{font-size:12px; font-weight:bold; color:#000;}
    .alert .alert_body .btn{text-align:center; padding-top:0px;}
    .alert .alert_body .btn img{border:0;}
    .alert .alert_body .success{ background:url('/public/images/success.gif') left center no-repeat; }
    .alert .alert_body .error{ background:url('/public/images/error.gif') left center no-repeat; }
	#wait{color:#f00; margin:3px;}
    .message{ position:absolute;
             left:50%;/*FF IE7*/
             top: 50%;/*FF IE7*/
             margin-left:-240px!important;/*FF IE7 该值为本身宽的一半 */
             margin-top:-70px!important;/*FF IE7 该值为本身高的一半*/
             margin-top:0;
             position:fixed!important;/*FF IE7*/
             position:absolute;/*IE6*/
             _top:expression(eval(document.compatMode &&
                 document.compatMode=='CSS1Compat') ?
                 documentElement.scrollTop + (document.documentElement.clientHeight-this.offsetHeight)/2 :/*IE6*/
                 document.body.scrollTop + (document.body.clientHeight - this.clientHeight)/2);/*IE5 IE5.5*/}
    .message .alert_body h3{background-color:#e9f4f7; padding:3px 15px;}
</style>



</head>

<body>

<div class="alert message">
    <div class="alert_body">
        <h3>系统提示</h3>
        <?php switch ($code) {?>
            <?php case 1:?> 
            <p class="alertcont success" id="successMsg">
            <span><a href="<?php echo($url);?>"><?php echo(strip_tags($msg));?></a></span>
            </p>
		<?php break;?>
        <?php case 0:?>
            <p class="alertcont error" id="errorMsg">
            <span><a href="<?php echo($url);?>"><?php echo(strip_tags($msg));?></a></span>
            </p>
            <?php break;?>
        <?php } ?>
        <p class="btn">系统会在<b id="wait">3</b>秒内自动跳转，如没有响应<a id="href" href="<?php echo($url);?>">请点击!</a></p>
    </div>
</div>
<if condition="isset($autoset)">
<script style="text/javascript">
function autoset(){
	if(window.top.art.dialog({id:"add"})){
		window.top.main.location.reload();
		window.top.art.dialog({id:"add"}).close();
	}
	
}
setInterval("autoset()",3000);
</script>  
<else />
<script style="text/javascript">
function autoset(){
	if(window.top.art.dialog({id:"add"})){
		window.top.main.location.reload();
		window.top.art.dialog({id:"add"}).close();
	}
	
}
setInterval("autoset()",3000);
</script> 
</if>

<script type="text/javascript">
   (function(){
        var wait = document.getElementById('wait'),href = document.getElementById('href').href;
        var interval = setInterval(function(){
            var time = --wait.innerHTML;
			var time=parseInt(time);
            if(time==0) {
				//autoset();
                location.href = href;
				autoset();
                clearInterval(interval);
            };
        }, 1000);
    })();


    function jumpIt(){
        var wait = document.getElementById('wait'),href = document.getElementById('href').href;
        var interval = setInterval(function(){
            var time = --wait.innerHTML;
			
            if(time == 0) {
                location.href = href;
                clearInterval(interval);
            };
        }, 1000);
    }
</script>

</body>
</html>
