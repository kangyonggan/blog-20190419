<a href="${ctx}/">首页</a>
&gt;
<a href="${ctx}/life" <#if categoryCode == ''>class="active"</#if>>全部栏目</a>
<#if categoryCode != ''>
&gt;
<a href="<#if article??>${ctx}/life?categoryCode=${categoryCode}<#else>javascript:</#if>" <#if !article??>class="active"</#if>>
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