(function(){
    var html = [
        '<div style="position:fixed;width:100%;height:100%;z-index:10;background:#000;opacity:0.5;filter: alpha(opacity=50)"></div>',
        '<div style="width:500px;background-color: #fff;border: 1px solid #e9e9e9;border-radius: 3px;color: #666;position:fixed;top:50%;left:50%;margin-top:-60px;margin-left:-250px;z-index:100;">',
            '<div style="padding: 14px 16px;border-bottom: 1px solid #e9e9e9;font-size:14px;font-weight:bold;">提示</div>',
            '<div style="padding: 16px;font-size: 14px;line-height: 1.2;">',
                '<p>非常抱歉，您当前的浏览器版本太低，无法访问我们的网页.</p>',
                '<p>请升级浏览器至<a style="color:#47c68c;" target="_blank" href="http://windows.microsoft.com/zh-CN/internet-explorer/download-ie">最新版Internet Explorer</a>.</p>',
                '<p>或者下载使用<a style="color:#47c68c;" target="_blank" href="http://rj.baidu.com/soft/detail/14744.html">Chrome 浏览器</a>、<a style="color:#47c68c;" target="_blank" href="http://se.360.cn/">360</a>、<a style="color:#47c68c;" target="_blank" href="http://ie.sogou.com/">搜狗 </a>等浏览器，并使用极速模式.</p>',
            '<div>',
        '</div>'
    ];
    document.body.innerHTML = html.join('');
})();
