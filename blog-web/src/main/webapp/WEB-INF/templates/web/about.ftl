<#assign title="关于我"/>
<#assign active_about="active"/>

<@override name="breadcrumbs">
<a href="${ctx}/">首页</a>
&gt;
<a href="javascript:" class="active">${title}</a>
</@override>

<@override name="main">
<div id="main">
    关于我
</div>
</@override>


<@extends name="layout.ftl"/>