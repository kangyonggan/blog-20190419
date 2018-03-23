<#if tool.isDeleted == 1>
<a href="javascript:" data-category="tool-delete" title="恢复工具"
   data-url="${ctx}/dashboard/manage/tool/${tool.id}/undelete">
    <span class="label label-danger arrowed-in">已删除</span>
</a>
<#else>
<a href="javascript:" data-category="tool-delete" title="删除工具"
   data-url="${ctx}/dashboard/manage/tool/${tool.id}/delete">
    <span class="label label-success arrowed-in">未删除</span>
</a>
</#if>