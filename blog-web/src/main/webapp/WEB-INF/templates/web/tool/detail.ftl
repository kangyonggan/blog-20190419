<#assign title="${tool.name}"/>
<#assign active_tool="active"/>

<@override name="style">
<link rel="stylesheet" href="${ctx}/static/ace/dist/css/prettify.min.css"/>
<link rel="stylesheet" href="${ctx}/static/ace/dist/css/bootstrap.min.css"/>
<link rel="stylesheet" href="${ctx}/static/ace/dist/css/font-awesome.min.css"/>
<link rel="stylesheet" href="${ctx}/static/ace/dist/css/ace.min.css" class="ace-main-stylesheet"
      id="main-ace-style"/>
</@override>

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
    <form id="tool-form" action="${ctx}/tool/${tool.id}" method="post" enctype="multipart/form-data" class="tool-form">
        <#include "${tool.code}.ftl"/>
    </form>

    <div class="space-20"></div>

    <#if respCo??>
        <div class="tool-result">
            <pre><code><#if respCo=='0000'><#include "result/${tool.code}.ftl"/><#else>${respMsg}</#if></code></pre>
        </div>
        <div class="space-20"></div>
    </#if>
</div>
</@override>

<@override name="script">
<script src="${ctx}/static/ace/dist/js/bootstrap.min.js"></script>
<script src="${ctx}/static/ace/dist/js/ace-extra.min.js"></script>
<script src="${ctx}/static/ace/dist/js/ace-elements.min.js"></script>
<script src="${ctx}/static/ace/dist/js/ace.min.js"></script>
<script src="${ctx}/static/libs/jquery/jquery.form.min.js"></script>
<script src="${ctx}/static/libs/jquery/jquery.validate.min.js"></script>
<script src="${ctx}/static/libs/jquery/jquery.validate.extends.js"></script>
<script src="${ctx}/static/ace/dist/js/prettify.min.js"></script>
<script src="${ctx}/static/app/js/web/tool/detail.js"></script>
</@override>

<@extends name="../layout.ftl"/>