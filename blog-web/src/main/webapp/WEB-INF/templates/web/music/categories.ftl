<div class="category-name">
    <span>栏目中心</span>
</div>
<ul class="category-nav">
<#list categories as category>
    <li <#if categoryCode==category.code>class="active"</#if>><a
            href="${ctx}/music?categoryCode=${category.code}">${category.name}</a></li>
</#list>
</ul>