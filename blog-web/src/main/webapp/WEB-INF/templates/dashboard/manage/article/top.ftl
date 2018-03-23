<#if article.isTop == 1>
<a href="javascript:" data-category="article-delete" title="取消推荐"
   data-url="${ctx}/dashboard/manage/article/${article.id}/untop">
    <span class="label label-danger arrowed-in">推荐</span>
</a>
<#else>
<a href="javascript:" data-category="article-delete" title="推荐"
   data-url="${ctx}/dashboard/manage/article/${article.id}/top">
    <span class="label label-grey arrowed-in">不推荐</span>
</a>
</#if>