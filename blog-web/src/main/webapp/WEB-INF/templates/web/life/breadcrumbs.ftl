<a href="${ctx}/">首页</a>
&gt;
<a href="${ctx}/life" <#if categoryCode == ''>class="active"</#if>>生活</a>
<#if categoryCode != ''>
&gt;
<a href="<#if life??>${ctx}/life?categoryCode=${categoryCode}<#else>javascript:</#if>" <#if !article??>class="active"</#if>>
    <#list categories as category>
        <#if categoryCode==category.code>${category.name}</#if>
    </#list>
</a>
</#if>
<#if life??>
&gt;
<a href="javascript:" class="active">
    ${life.title}
</a>
</#if>