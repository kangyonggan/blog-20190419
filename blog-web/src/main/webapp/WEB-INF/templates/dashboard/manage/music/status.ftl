<#if music.status == "WAITING">
<span class="label label-purple arrowed-in-right">待审核</span>
<#elseif music.status == "REJECT">
<span class="label label-danger arrowed-in-right">拒绝</span>
<#elseif music.status == "COMPLETE">
<span class="label label-success arrowed-in-right">审核通过</span>
<#else>
<span class="label label-warning arrowed-in-right">${music.status}</span>
</#if>