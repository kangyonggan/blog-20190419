<a href="${ctx}/">首页</a>
&gt;
<a href="${ctx}/article" <#if categoryCode == ''>class="active"</#if>>
    <#if key?? && key != ''>
        搜索结果
    <#else>
        全部栏目
    </#if>
</a>
<#if categoryCode != ''>
&gt;
<a href="<#if article??>${ctx}/article?categoryCode=${categoryCode}<#else>javascript:</#if>" <#if !article??>class="active"</#if>>
    <#list categories as category>
        <#if categoryCode==category.code>${category.name}</#if>
    </#list>
</a>
</#if>
<#if article??>
&gt;
<a href="javascript:" class="active">
    详情
</a>
</#if>