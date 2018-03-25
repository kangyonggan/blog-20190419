<#assign title="搜索结果"/>
<#assign active_index="active"/>

<@override name="breadcrumbs">
<a href="${ctx}/">首页</a>
&gt;
<a href="javascript:" class="active">${title}</a>
</@override>

<@override name="main">
<div id="main">
    正在开发中...
</div>
</@override>

<@extends name="../layout.ftl"/>