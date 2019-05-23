<div class="ant-breadcrumb" style="background-color: rgb(250, 250, 250); padding: 12px 18px; border-bottom: 1px solid rgb(233, 233, 233);">
    <span>
        <span class="ant-breadcrumb-link">作品管理</span>
        <span class="ant-breadcrumb-separator">/</span>
    </span>
    <span>
        <span class="ant-breadcrumb-link">{$book['name']}</span>
        <span class="ant-breadcrumb-separator">/</span>
    </span>
</div>
<div class="book-wrap">
    <div class="menu-wrap">
        <ul class="ant-menu ant-menu-light ant-menu-root ant-menu-horizontal" role="menu"
            aria-activedescendant="" tabindex="0">
            <li class="ant-menu-item <if condition="$action eq 'setting'"> ant-menu-item-selected </if> " role="menuitem" aria-selected="false">
                <a href="{:url('book/setting',['id'=>$id])}">作品设置</a>
            </li>
            <li class="ant-menu-item <if condition="$action eq 'draft'"> ant-menu-item-selected </if> " role="menuitem" aria-selected="true">
                <a href="{:url('book/draft',['id'=>$id])}">草稿箱</a>
            </li>
            <li class="ant-menu-item <if condition="$action eq 'publishing'"> ant-menu-item-selected </if> " role="menuitem" aria-selected="false">
                <a href="{:url('book/publishing',['id'=>$id])}">待发布章节</a>
            </li>
            <li class="ant-menu-item <if condition="$action eq 'published'"> ant-menu-item-selected </if> " role="menuitem" aria-selected="false">
                <a href="{:url('book/published',['id'=>$id])}">已发布章节</a>
            </li>
        </ul>
        <div class="fr" style="margin-top: -46px;">
            <a href="{:url('book/draft',['id'=>$id])}">
                <button type="button" class="ant-btn ant-btn-primary">
                    <img width="16" src="//s.weituibao.com/static/e4amw.png" style="vertical-align: sub;">
                    <span> 新建章节</span>
                </button>
            </a>
        </div>
    </div>
</div>