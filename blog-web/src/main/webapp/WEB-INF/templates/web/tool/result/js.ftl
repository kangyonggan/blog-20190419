<#if result.data??>
<h4>压缩结果：</h4>
${result.data?html}
</#if>

<#if result.warningMsg??>
<h4>警告：</h4>
${result.warningMsg?html}
</#if>

<#if result.errorMsg??>
<h4>错误：</h4>
${result.errorMsg?html}
</#if>
