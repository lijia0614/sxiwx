<nav style="float: left;" class="component-nav-wrap">
    <div class="info text-center">
        <if condition="$user['image']">
            <img src="{$user['image']}" class="avatar">
            <else/>
            <img src="images/touxiang.png" class="avatar">
        </if>
        <div class="name">{$user['pen_name']}</div>
        <div class="id">用户ID：{$user['id']}</div>
    </div>
    <ul class="menu">
        <li <if condition="$action eq 'bookshelf'"> class="active" </if> ><a href="{:url('info/bookShelf')}">我的书架</a></li>
        <li <if condition="$action eq 'wallet'"> class="active" </if> ><a href="{:url('info/wallet')}">我的钱包</a></li>
        <li <if condition="$action eq 'baseinfo'"> class="active" </if> ><a href="{:url('info/baseInfo')}">个人信息</a></li>
        <li <if condition="$action eq 'reply'"> class="active" </if> ><a href="{:url('info/reply')}">我的消息</a></li>
    </ul>
</nav>