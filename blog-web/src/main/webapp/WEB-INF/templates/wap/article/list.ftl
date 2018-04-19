<#assign title='文章'/>

<@override name="main">
<form class="filter-form" action="${ctx}/wap/article" method="get">
    <input type="hidden" name="categoryCode">
    <div class="down">全部栏目</div>
    <div class="sort">发布时间</div>
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
</script>
<script src="${ctx}/static/app/js/wap/article/list.js"></script>
</@override>

<@extends name="../layout.ftl"/>