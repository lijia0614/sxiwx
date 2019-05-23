<!DOCTYPE html>
<html>
 <head> 
  <meta charset="UTF-8" /> 
  <title>采集页</title> 
  <link rel="stylesheet" href="/Public/collects/css/css.css" /> 
  <script src="/public/admin/default/js/jquery-1.9.1.js"></script> 
 </head> 
 <body> 
  <div class="wrap"> 
      <div class="header">
        <h2 class="logo">四川挚梦科技有限公司</h2>
        <div class=""></div>
        <div class="version">数据采集</div>
      </div>
   <section class="section"> 
    <div class="step"> 
     <ul> 
      <li class="on"><em>1</em>内容采集</li> 
     </ul> 
    </div> 
    <div class="install" id="log"> 
     <ul id="loginner"> 
     </ul> 
    </div> 
    <div class="bottom tac"> 
     <a href="javascript:;" class="btn_old"><img src="/public/install/images/loading.gif" align="absmiddle" />&nbsp;正在采集...</a> 
    </div> 
   </section> 
   <script type="text/javascript">
    var data = <?php echo json_encode($_POST);?>;
    $.ajaxSetup ({ cache: false });
    function reloads() {
        var url =  "/Home/Collection/datadown.html?random="+Math.random();
        $.ajax({
            type: "POST",
			timeout : 10000, //超时时间设置，单位毫秒
            url: url,
            data: data,
            dataType: 'json',
            beforeSend:function(){
            },
		　　complete : function(XMLHttpRequest,status){ //请求完成后最终执行参数
		　　　　if(status=='timeout'){
				//超时,status还有success,error等值的情况
		 　　　　//　 ajaxTimeoutTest.abort();
		　　　　　//  alert("超时");
				$('#loginner').append('<li><span class="correct_span error_span">&radic;</span>请求超时,重新请求</li>');
				reloads(0);
		　　　　}
		　　},			
            success: function(result){
                if(result.status==9999){
                    $('#dosubmit').attr("disabled",false);
                    $('#dosubmit').removeAttr("disabled");
                    $('#dosubmit').removeClass("nonext");
					$('#loginner').append(result.msg);
					$(".install").scrollTop($(".install").prop("scrollHeight"));
					$(".tac").html('<a href="javascript:;" class="btn_old">采集完成</a>');
                }else if(result.status==1){
                    $('#loginner').append(result.msg);
					$(".install").scrollTop($(".install").prop("scrollHeight"));				
                    reloads(0);
                }else{
					$('#loginner').append(result.msg);
					(".install").scrollTop($(".install").prop("scrollHeight"));		
                }
            }
        });
    }

    $(document).ready(function(){
        reloads();
    })
</script> 
  </div> 
<div class="footer"> &copy; 2016 - 2017 <a href="http://www.zhi-meng.cn" target="_blank">www.zhi-meng.cn</a></div>
 </body>
</html>