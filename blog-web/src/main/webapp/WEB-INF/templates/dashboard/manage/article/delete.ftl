<#if article.isDeleted == 1>
<a href="javascript:" data-article="article-delete" title="恢复文章"
   data-url="${ctx}/dashboard/system/article/${article.id}/undelete">
    <span class="label label-danger arrowed-in">已删除</span>
</a>
<#else>
<a href="javascript:" data-article="article-delete" title="删除文章"
   data-url="${ctx}/dashboard/system/article/${article.id}/delete">
    <span class="label label-success arrowed-in">未删除</span>
</a>
</#if>