<nav class="component-nav-wrap">
    <ul class="menu">
        <li <if condition="$action eq 'home'"> class="active" </if> ><a href="{:url('users/home')}">首页</a></li>
        <li <if condition="$action eq 'bookmanage'"> class="active" </if> ><a href="{:url('users/bookmanage')}">作品管理</a></li>
        <li><a>我的收入</a></li>
        <li <if condition="$action eq 'day'"> class="submenu active" </if> ><a href="{:url('users/day')}">收入日报</a></li>
        <li <if condition="$action eq 'month'"> class="submenu active" </if> ><a href="{:url('users/month')}">收入月报</a></li>
        <!--
        <li <if condition="$action eq 'extract'"> class="submenu active" </if> ><a href="{:url('users/extract')}">提现记录</a></li>
        -->
        <li hidden class="active"><a href="/comment">读者评论</a></li>

        <li <if condition="$action eq 'writerinfo'"> class="active" </if> ><a href="{:url('users/writerinfo')}">作家资料</a></li>

        <li <if condition="$action eq 'comment'"> class="active" </if> ><a href="{:url('users/comment')}">读者评论</a></li>
        <!--
        <li <if condition="$action eq 'message'"> class="active" </if> ><a href="{:url('users/message')}">站内信</a></li>
        -->
    </ul>
</nav>
