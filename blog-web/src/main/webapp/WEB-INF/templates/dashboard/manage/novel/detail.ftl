<#assign ctx="${(rca.contextPath)!''}">

<h1 class="text-center">${novel.name}</h1>

<div class="space-20"></div>

<div class="hr hr8 hr-dotted"></div>

<div class="row">
<#list sections as section>
    <a class="col-sm-4 col-xs-12 section"
       href="${ctx}/dashboard#manage/novel/${novel.code}/section/${section.code}">${section.title}</a>
</#list>
</div>

<script src="${ctx}/static/app/js/dashboard/manage/novel/detail.js"></script>