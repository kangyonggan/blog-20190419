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
    <div class="photos photos-sm">
        <#list attachments as attachment>
            <dl>
                <dd>
                    <img src="${ctx}/${attachment.thumb}" data-thumb="${ctx}/${attachment.thumb}"
                         data-url="${ctx}/${attachment.url}" title="${attachment.originalFilename}"/>
                </dd>
                <dt>${attachment.createdTime?date}</dt>
            </dl>
        </#list>
    </div>

    <div class="space-10"></div>
</div>
</@override>

<@override name="script">
<script src="${ctx}/static/libs/zoomify/zoomify.min.js"></script>
<script>
    $('.photos img').mouseenter(function () {
        $(this).attr("src", $(this).attr("data-url"));
    });
    $('.photos img').mouseleave(function () {
        $(this).attr("src", $(this).attr("data-thumb"));
    });
    $('.photos img').zoomify();
</script>
</@override>

<@extends name="../layout.ftl"/>