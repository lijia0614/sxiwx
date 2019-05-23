<header  class="component-header-wrap">

    <div class="content clearfix">
        <a href="{:url('index/index')}"><img src="{$logo}"></a>
        <div class="fr ">
            <if condition="$user['image']">
                <img src="{$user['image']}">
                <else/>
                <img src="images/touxiang.png">
            </if>

            <if condition="$user['pen_name']">
                {$user['pen_name']}
                <else/>
                {$user['id']}
            </if>

            <i class="anticon anticon-caret-down"></i>
            <div class="overlayer text-center">
                <ul>
                    <li>
                        <a id="loginOut" href="javascript:void(0)">退出登录</a>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</header>
<script>
    // 设置rem字号
    ;(function(doc,win){
        'use strict';
        var docEl = doc.documentElement;
        var resizeEvt =  'resize';
        function recalc() {
            var clientWidth = docEl.clientWidth;
            if (!clientWidth) return;
            docEl.style.fontSize = (100 * clientWidth / 750) + 'px';
        }

        recalc();
        win.addEventListener(resizeEvt, recalc, false);
    })(document,window);

</script>

<script src="js/jquery-1.9.1.js"></script>
<script src="/public/layer/layer.js"></script>


<script>
    $('#loginOut').click(function () {
        $.ajax({
            url:"{:url('Login/loginOut')}",
            success:function(req){
                if (req.code == 0){
                    layer.alert(req.msg); return false;
                }
                if (req.code == 1){
                    layer.alert(req.msg);
                    setTimeout(function(){ window.location.href = "{:url('index/index')}"; }, 1000);
                }
            }
        });
    })
</script>