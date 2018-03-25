<#assign active_novel="active"/>
<#assign title="${section.title}"/>

<@override name="breadcrumbs">


<a href="${ctx}/">首页</a>
&gt;
<a href="${ctx}/novel">全部栏目</a>
&gt;
<a href="${ctx}/novel?categoryCode=${novel.categoryCode}"><#list categories as category><#if novel.categoryCode==category.code>${category.name}</#if></#list></a>
&gt;
<a href="${ctx}/novel/${novel.code}">${novel.name}</a>
&gt;
<a href="javascript:" class="active">${section.title}</a>
</@override>

<@override name="main">
<div id="main">



    <div class="space-10"></div>
</div>
</@override>

<@extends name="../layout.ftl"/>