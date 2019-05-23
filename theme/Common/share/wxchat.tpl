<script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script language="javascript">
function WeChat(title,ShareLink,ShareImgUrl,desc,backUrl){
        // 微信配置
        wx.config({
            debug: false, 
            appId: "{$info['appId']}",  //公众号的唯一标识
            timestamp: '{$info["timestamp"]}',  //生成签名的时间戳
            nonceStr: '{$info["nonceStr"]}',   //生成签名的随机串
            signature: '{$info["signature"]}',  //签名
            jsApiList: ['onMenuShareTimeline', 'onMenuShareAppMessage','onMenuShareQQ','onMenuShareQZone','hideOptionMenu'] // 功能列表，我们要使用JS-SDK的什么功能
        });
     
    wx.ready(function(){
        // 获取"分享到朋友圈"按钮点击状态及自定义分享内容接口
        wx.onMenuShareTimeline({
            title: title, // 分享标题
            link:ShareLink,
            desc:desc,
            imgUrl:ShareImgUrl, // 分享图标
            success: function () {
                window.location.href=backUrl;
            },
            cancel: function () {
               return false;
            }
        });
 
        // 获取"分享给朋友"按钮点击状态及自定义分享内容接口
        wx.onMenuShareAppMessage({
            title: title, // 分享标题
            desc: desc, // 分享描述
            link:ShareLink,
            imgUrl:ShareImgUrl, // 分享图标
            success: function () {
                    window.location.href=backUrl;
            },
            cancel: function () {
               return false;
            }
        });
        // 分享到QQ
        wx.onMenuShareQQ({
            title: title, // 分享标题
            desc:desc, // 分享描述
            link:ShareLink,
            imgUrl:ShareImgUrl, // 分享图标
            success: function () {
                window.location.href=backUrl;
            },
            cancel: function () {
               return false;
            }
        });
        // 分享到QQ空间
        wx.onMenuShareQZone({
            title: title, // 分享标题
            desc: desc, // 分享描述
            link:ShareLink,
            imgUrl:ShareImgUrl, // 分享图标
            success: function () {
                window.location.href=backUrl;
            },
            cancel: function () {
               return false;
            }
        });
    });
}
WeChat('资源鸟，让编程变得简单',"分享之后点进来的链接","图片地址",'资源鸟，让编程变得简单 群号：623918245',"分享后跳转的链接");
</script>