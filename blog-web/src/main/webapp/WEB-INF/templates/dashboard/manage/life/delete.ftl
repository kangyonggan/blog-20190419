<#if life.isDeleted == 1>
<a href="javascript:" data-category="life-delete" title="恢复生活"
   data-url="${ctx}/dashboard/manage/life/${life.id}/undelete">
    <span class="label label-danger arrowed-in">已删除</span>
</a>
<#else>
<a href="javascript:" data-category="life-delete" title="删除生活"
   data-url="${ctx}/dashboard/manage/life/${life.id}/delete">
    <span class="label label-success arrowed-in">未删除</span>
</a>
</#if>