<div class="hot">
    <div class="title">
        <span>推荐内容</span>
    </div>
    <ul class="list">
    <#if topArticles?size gt 0>
        <#list topArticles as article>
            <li><a href="${ctx}/article/${article.id}" class="nowrap">${article.title}</a></li>
        </#list>
    <#else>
        <div class="empty">没有推荐文章</div>
    </#if>
    </ul>
</div>