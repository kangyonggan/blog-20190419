<#list categories as category>
<#if category.code==music.categoryCode>
    ${category.name}[${category.code}]
</#if>
</#list>