<#if tool.isTop == 1>
<a href="javascript:" data-category="tool-delete" title="取消推荐"
   data-url="${ctx}/dashboard/manage/tool/${tool.id}/untop">
    <span class="badge badge-danger">推荐</span>
</a>
<#else>
<a href="javascript:" data-category="tool-delete" title="推荐"
   data-url="${ctx}/dashboard/manage/tool/${tool.id}/top">
    <span class="badge badge-grey">不推荐</span>
</a>
</#if>