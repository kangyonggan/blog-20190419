<div class="hot">
    <div class="title">
        <span>推荐内容</span>
    </div>
    <ul class="list">
    <#list topArticles as article>
        <li><a href="${ctx}/article/${article.id}" class="nowrap">${article.title}</a></li>
    </#list>
    </ul>
</div>