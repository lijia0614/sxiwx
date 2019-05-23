<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>微信支付-{$site_name}</title>
    <script src="js/jquery-1.9.1.js"></script>
    <script src="/public/layer/layer.js"></script>
    <style>
        .VouPay {
            margin-top: 0.2318rem;
            clear: both;
            overflow: hidden;
            background-color: White;
            height: 1.85rem;
        }
        .VouPay p.PP1 {
            width: 1.48rem;
            text-align: center;
        }
        .VouPay p {
            float: left;
        }
        .VouPay p.PP2 {
            padding-top: 0.35rem;
            line-height: 0.61rem;
            color: #999999;
            font-size: 0.3rem;
        }
        .VouPay p.PP2 span {
            color: #333333;
            font-size: 0.39rem;
        }
        .VouPay p.PP1 img {
            height: 0.555rem;
            margin-top: 0.65rem;}
    </style>
    <style>
        *{margin:0px;padding:0px;}
        body{font-size:12px;font-family:"Microsoft YaHei";background:#EFF0F2;}
        a{text-decoration:none;cursor:pointer;color:#666}
        a:hover{color:#019241}
        a:visited{ color:inherit;}
        img{border:none;}
        input{outline:none;border:none;}
        li{list-style-type:none;}
        .con{width:1200px;margin:0px auto;zoom:1;overflow: hidden;}
        .top_1{color:#fff;background:#9E9E9E;}
        .top_1_con{height:27px;line-height:27px;}
        .top_2{background:#fff;box-shadow: 0px -23px 113px #888888;border-bottom:1px solid #D1D1D1;}
        .top_2_con{height:75px;}

        .main{width:1198px;height:498px;border: 1px solid #D8D8DA;background: #fff;margin:33px auto 0 auto;}
        .main_left{width:827px;float:left;height:100%;position: relative;}
        .main_left .zf_sus{width:793px;height:80px;line-height:80px;color:#121212;background:#EDFFCD;font-size:16px;margin:19px auto 0 auto;}
        .main_left .ewm_box{position:absolute;width:235px;height:235px;top:80px;left:300px;background: #fff;overflow: hidden;}
        .main_left .ewm_box .ewm_img{    width: 299px;height: 299px; margin-top: -32px;margin-left: -32px;}
        .main_left .ewm_box .ewm_logo{position:absolute;    top: 92px;left: 92px;width: 49px;height: 49px;}
        .main_left .danjia{line-height:38px;position: absolute;left:296px;top:331px;font-size:18px;color:#121212;position:absolute; }
        .main_left .danjia .danjia_con{font-size:34px;color:#FE7201;float:right;}
        .main_left .tishi_box{position:absolute;left: 249px;bottom:71px;line-height:25px;color:#121212;font-size:22px;}

        .main_right{width:369px;height:100%;background:#7EAD7F;color:#fff;float:right;}
        .main_right_con{width:260px;margin:63px auto 0 auto;}
        .main_right_con .dd_title{font-size:24px;height:49px;border-bottom:1px dashed #fff;}
        .main_right_con .dd_table{width:100%;margin-top:15px;}
        .main_right_con .dd_table td{height:31px;color:#fff;}
        .main_right_con .tel_box{margin-left:5px;height:48px;background:url(../images/4.png) no-repeat;margin-top:40px;font-size:20px; padding-left: 37px;padding-top: 16px;}

        .bottom_con{height:113px;line-height:113px;text-align: center;color:#777;}

        .zf_sus{display:none;}
    </style>
<body>
<div class="top_1">
    <div class="top_1_con con">
        您好，欢迎使用微信安全付款！
    </div>
</div>
<div class="top_2">
    <div class="top_2_con con">
        <img src="images/wx_logo.jpg" style="margin-top:21px;width:130px;">
    </div>
</div>

<script>
    $(document).ready(function(){
        callpay();
    });

    function jsApiCall()
    {
        WeixinJSBridge.invoke(
            'getBrandWCPayRequest',
        <?php echo $jsApiParameters; ?>,
        function(res){
            var order = "{$orders}";
            var pay_type = "{$pay_type}";
            if(res.err_msg == "get_brand_wcpay_request:ok"){
                layer.msg('充值成功',{icon: 1});
                setTimeout(function(){
                    window.location = "{:url('home/info/mcz')}";
                },1000)
            }else{
                layer.msg('充值失败',{icon: 2});
                setTimeout(function(){
                    // window.location = "{:url('home/recharge/recharge')}";
                    window.history.back();
                },1000)
            }
        }
    );
    }

    function callpay()
    {
        //console.log('111');
        if (typeof WeixinJSBridge == "undefined"){
            if( document.addEventListener ){
                document.addEventListener('WeixinJSBridgeReady', jsApiCall, false);
            }else if (document.attachEvent){
                document.attachEvent('WeixinJSBridgeReady', jsApiCall);
                document.attachEvent('onWeixinJSBridgeReady', jsApiCall);
            }
        }else{
            jsApiCall();
        }
    }
</script>
</body>
</html>
