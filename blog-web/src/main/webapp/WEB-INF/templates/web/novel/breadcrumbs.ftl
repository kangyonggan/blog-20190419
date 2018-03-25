<a href="${ctx}/">首页</a>
&gt;
<a href="${ctx}/novel" <#if categoryCode == ''>class="active"</#if>>全部栏目</a>
<#if categoryCode != ''>
&gt;
<a href="<#if novel??>${ctx}/novel?categoryCode=${categoryCode}<#else>javascript:</#if>" <#if !novel??>class="active"</#if>>
    <#list categories as category>
        <#if categoryCode==category.code>${category.name}</#if>
    </#list>
</a>
</#if>
<#if novel??>
&gt;
<a href="javascript:" class="active">
    ${novel.name}
</a>
</#if>