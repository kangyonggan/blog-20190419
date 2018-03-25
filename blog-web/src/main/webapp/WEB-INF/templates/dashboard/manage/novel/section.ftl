<#assign ctx="${(rca.contextPath)!''}">

<div class="row text-center">
    <h1>${section.title}</h1>
    <div>
    <#if prevSection??>
        <a class="pull-left" href="${ctx}/dashboard#manage/novel/${novel.code}/section/${prevSection.code}">上一章: ${prevSection.title}</a>
    <#else>
        <a class="pull-left" href="${ctx}/dashboard#manage/novel/${novel.code}">章节列表</a>
    </#if>
        &nbsp;
    <#if nextSection??>
        <a class="pull-right" href="${ctx}/dashboard#manage/novel/${novel.code}/section/${nextSection.code}">下一章: ${nextSection.title}</a>
    <#else>
        <a class="pull-right" href="${ctx}/dashboard#manage/novel/${novel.code}">章节列表</a>
    </#if>
    </div>
</div>

<div class="hr hr8 hr-dotted"></div>

<div class="row">
${section.content}
</div>

<div class="hr hr8 hr-double hr-dotted"></div>

<div>
<#if prevSection??>
    <a class="pull-left" href="${ctx}/dashboard#manage/novel/${novel.code}/section/${prevSection.code}">上一章: ${prevSection.title}</a>
<#else>
    <a class="pull-left" href="${ctx}/dashboard#manage/novel/${novel.code}">章节列表</a>
</#if>
    &nbsp;
<#if nextSection??>
    <a class="pull-right" href="${ctx}/dashboard#manage/novel/${novel.code}/section/${nextSection.code}">下一章: ${nextSection.title}</a>
<#else>
    <a class="pull-right" href="${ctx}/dashboard#manage/novel/${novel.code}">章节列表</a>
</#if>
</div>


<script src="${ctx}/static/app/js/dashboard/manage/novel/section.js"></script>