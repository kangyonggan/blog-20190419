<#if novel.isDeleted == 1>
<a href="javascript:" data-category="novel-delete" title="恢复小说"
   data-url="${ctx}/dashboard/manage/novel/${novel.code}/undelete">
    <span class="label label-danger arrowed-in">已删除</span>
</a>
<#else>
<a href="javascript:" data-category="novel-delete" title="删除小说"
   data-url="${ctx}/dashboard/manage/novel/${novel.code}/delete">
    <span class="label label-success arrowed-in">未删除</span>
</a>
</#if>