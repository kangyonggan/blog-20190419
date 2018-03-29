<a href="${ctx}/">首页</a>
&gt;
<a href="${ctx}/music" <#if categoryCode == ''>class="active"</#if>>音乐</a>
<#if categoryCode != ''>
&gt;
<a href="<#if music??>${ctx}/music?categoryCode=${categoryCode}<#else>javascript:</#if>" <#if !novel??>class="active"</#if>>
    <#list categories as category>
        <#if categoryCode==category.code>${category.name}</#if>
    </#list>
</a>
</#if>
<#if music??>
&gt;
<a href="javascript:" class="active">
    ${music.name}
</a>
</#if>