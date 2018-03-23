<#assign title="${tool.name}"/>
<#assign active_tool="active"/>

<@override name="breadcrumbs">
<a href="${ctx}/">首页</a>
&gt;
<a href="${ctx}/tool">常用工具</a>
&gt;
<a href="javascript:" class="active">${title}</a>
</@override>

<@override name="main">
<div id="main">
    <div class="space-20"></div>
    <form id="tool-form" action="${ctx}/tool/${tool.id}" method="post" class="tool-form">
        <#include "${tool.code}.ftl"/>

        <div class="space-10"></div>
        <button id="submit" data-loading-text="正在<@s.message "app.button.save"/>...">
            <@s.message "app.button.save"/>
        </button>
    </form>

    <#if resultMap??>
        <div class="space-20"></div>
        <div class="tool-result">
            <#include "result/${tool.code}.ftl"/>
        </div>
        <div class="space-20"></div>
    </#if>
</div>
</@override>

<@override name="script">
<script src="${ctx}/static/libs/jquery/jquery.form.min.js"></script>
<script src="${ctx}/static/libs/jquery/jquery.validate.min.js"></script>
<script src="${ctx}/static/libs/jquery/jquery.validate.extends.js"></script>
<script src="${ctx}/static/app/js/web/tool/detail.js"></script>
</@override>

<@extends name="../layout.ftl"/>