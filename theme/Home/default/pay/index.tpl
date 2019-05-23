</html>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>微信扫码支付-{$site_name}</title>
    <script type="text/javascript" src="/public/default/js/jquery-1.9.1.js"></script>
</head>
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
<!--头部-->
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
<!--头部-->
<!--主题-->
<div class="main">

    <div class="main_left">
        <div class="zf_sus">
            <img src="images/5111.png" style=" float:left;margin-right:10px;width:36px;height:36px;margin-left: 40px; margin-top: 20px;">
            支付成功，<span id="daojishi" style="padding:0 3px;color:#FF5409;"></span>秒后自动返回订单页面
        </div>
        <div class="ewm_box gy_ewm">
            <div style="width:100%;height:100%;position: relative;">
                <img alt="扫码支付" style="width:100%; height:100%" src="{:url('home/Pay/phpqrcode',['data'=>$code_url])}" />
            </div>
        </div>
        <div class="danjia gy_ewm">
            付款金额：<span class="danjia_con">￥{$data['amount']|number_format=2}					</span>
        </div>
        <div class="tishi_box gy_ewm">
            <img src="images/3111.png" style="float:left;margin-right:12px;width: 32px;">使用微信扫一扫二维码安全支付
        </div>
        <div id="showbox"></div>
    </div>
    <div class="main_right">
        <div class="main_right_con" style="width:333px">
            <div class="dd_title">订单信息</div>
            <table class="dd_table">
                <tr>
                    <td style="width:86px">
                        订单类型：
                    </td>
                    <td>
                        书币充值
                    </td>
                </tr>
                <tr>
                    <td>
                        订单号：
                    </td>
                    <td>
                        {$order_sn}
                    </td>
                </tr>
                <tr>
                    <td>
                        创建时间：
                    </td>
                    <td>
                        {$data['create_time']|date='Y-m-d H:i:s'}
                    </td>
                </tr>
            </table>
            <div class="tel_box">
            </div>
        </div>
    </div>
</div>
<div class="bottom">
    <div class="bottom_con">
        版权所有：{$site_name}<span style="display: inline-block;width:30px"></span>备案号：{$site_icp}		</div>
</div>
<!--主题结束-->
</body>
<script src="/public/layer/layer.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript">
    $(function(){
        setInterval('checkweipay()',5000);
    });
    function checkweipay(){
        var order_sn = "{$order_sn}";
        var url = "{:url('home/pay/orderquery')}";
        var param = {order_sn:order_sn};
        $.get(url,param,function(data){
            if(data){
                console.log(data);
                if(data.code == 1){
                    layer.alert(data.msg,{icon: 1},function(index){
                        layer.close(index);
                        window.location.href = "{:url('info/wallet')}";
                        return;
                    });
                    return false;
                }else{
                    layer.alert(data.msg);
                    return false;
                }
            }
        });
    }
</script>
</html>
