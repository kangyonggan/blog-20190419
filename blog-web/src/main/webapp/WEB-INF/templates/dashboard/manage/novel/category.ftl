<#list categories as category>
<#if category.code==novel.categoryCode>
    ${category.name}[${category.code}]
</#if>
</#list>