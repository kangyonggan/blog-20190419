<#list categories as category>
<#if category.code==article.categoryCode>
    ${category.name}[${category.code}]
</#if>
</#list>