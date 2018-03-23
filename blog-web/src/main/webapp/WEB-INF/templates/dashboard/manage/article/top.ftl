<#if article.isTop == 1>
<a href="javascript:" data-category="article-delete" title="取消推荐"
   data-url="${ctx}/dashboard/manage/article/${article.id}/untop">
    <span class="badge badge-danger">推荐</span>
</a>
<#else>
<a href="javascript:" data-category="article-delete" title="推荐"
   data-url="${ctx}/dashboard/manage/article/${article.id}/top">
    <span class="badge badge-grey">不推荐</span>
</a>
</#if>