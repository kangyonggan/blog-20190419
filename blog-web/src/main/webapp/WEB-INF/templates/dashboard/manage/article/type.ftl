<#list types as t>
<#if t.type==article.categoryCode>
    ${t.getName()}[${t.getType()}]
</#if>
</#list>