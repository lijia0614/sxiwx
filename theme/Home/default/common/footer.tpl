<div class="footer">
    <div class="footer-content clearfix">
        <div style="display: none" class="footer-link">
            <span>友情链接：</span>
            <zhimeng table="links" where="[['display_type','=',2],['status','=',1]]" order="sort desc" >
                <a href="{$r.link}" rel="noopener noreferrer" target="_blank">{$r.title}</a>
            </zhimeng>
        </div>
        <div class="footer-nav">
            <a target="_blank" href="{:url('welfare/welfare')}">作者福利</a>
            <zhimeng table="webpage" where="['pid','=',186]" order="sort desc">
            <a target="_blank" href="{:url('about/about',['id'=>$r['id']])}">{$r.title}</a>
            </zhimeng>
        </div>
        <section>
            <p>
                Copyright © 2017-2018 sxiwx.com All rights reserved {$site_name} {$site_icp}<br>
                公司名称：{$company}   |   {$site_address}   |   联系电话：{$site_tel}
            </p>
        </section>
    </div>
</div>
<div class="m-footer">
    <ul>
        <zhimeng table="webpage" where="['pid','=',186]" order="sort desc">
        <li>
            <a href="{:url('about/about',['id'=>$r['id']])}">
                {$r.title}
                <i class="iconfont icon-fs-line"></i>
            </a>
        </li>
        </zhimeng>

    </ul>
    <p>{$site_name} {$site_icp} </p>
</div>
