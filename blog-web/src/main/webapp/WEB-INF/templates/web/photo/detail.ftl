<#assign title="${photo.title}"/>
<#assign active_photo="active"/>

<@override name="style">
<link rel="stylesheet" href="${ctx}/static/libs/zoomify/zoomify.min.css">
</@override>

<@override name="breadcrumbs">
<a href="${ctx}/">首页</a>
&gt;
<a href="${ctx}/photo">相册</a>
&gt;
<a href="javascript:" class="active">${title}</a>
</@override>

<@override name="main">
<div id="main">
    <div class="fall-list">
        <#assign total=attachments?size / 3/>
        <div>
            <#list 0..total-1 as index>
                <#assign attachment=attachments[index]/>
                <img src="${ctx}/${attachment.url}" data-url="${ctx}/${attachment.url}"
                     data-thumb="${ctx}/${attachment.thumb}">
            </#list>
        </div>
        <div>
            <#list total..2*total-1 as index>
                <#assign attachment=attachments[index]/>
                <img src="${ctx}/${attachment.url}" data-url="${ctx}/${attachment.url}"
                     data-thumb="${ctx}/${attachment.thumb}">
            </#list>
        </div>
        <div>
            <#list 2*total..attachments?size-1 as index>
                <#assign attachment=attachments[index]/>
                <img src="${ctx}/${attachment.url}" data-url="${ctx}/${attachment.url}"
                     data-thumb="${ctx}/${attachment.thumb}">
            </#list>
        </div>
    </div>

    <div class="space-10"></div>
</div>
</@override>

<@override name="script">
<script src="${ctx}/static/libs/zoomify/zoomify.min.js"></script>
<script>
    $('.fall-list img').zoomify();
</script>
</@override>

<@extends name="../layout.ftl"/>