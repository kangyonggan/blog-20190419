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
${title}
</div>
</@override>

<@override name="script">

</@override>

<@extends name="../layout.ftl"/>