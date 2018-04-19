<#assign title='文章'/>

<@override name="main">
<form class="filter-form" action="${ctx}/wap/article" method="get">
    <input type="hidden" name="categoryCode">
    <div class="down">
        全部栏目
    </div>
    <ul class="down-list">
        <li data-code="" class="active">全部栏目</li>
        <#list categories as category>
            <li data-code="${category.code}">${category.name}</li>
        </#list>
    </ul>
    <div class="sort">降序</div>
</form>

<div class="article-list">
    <#if page.size gt 0>
        <#list page.list as article>
            <div class="item">
                <#if article.picture??>
                    <div class="left">
                        <img src="${article.picture}">
                    </div>
                </#if>
                <div class="right">
                    <a href="${ctx}/wap/article/${article.id}">
                        <div class="title nowrap" title="${article.title}">${article.title}</div>
                        <div class="summary">${article.summary}</div>
                    </a>
                </div>
            </div>
        </#list>
        <#if page.hasNextPage>
            <div class="more">上滑加载更多</div>
        <#else>
            <div class="no-more-content">没有更多内容了</div>
        </#if>
    <#else>
        <div class="empty">
            暂无查询记录
        </div>
    </#if>
</div>
</@override>

<@override name="script">
<script>
    var sort = "desc";
    var categoryCode = "";
    var hasNextPage = "${page.hasNextPage?c}";
    var pageNum = "${page.pageNum}";
</script>
<script src="${ctx}/static/app/js/wap/article/list.js"></script>
</@override>

<@extends name="../layout.ftl"/>