<#list types as t>
<#if t.type==category.type>
    ${t.getName()}[${t.getType()}]
</#if>
</#list>