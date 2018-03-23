<#assign title="工具"/>
<#assign active_tool="active"/>

<@override name="breadcrumbs">
<a href="${ctx}/">首页</a>
&gt;
<a class="active" href="javascript:">常用工具</a>
</@override>

<@override name="main">
<div id="main">
    <div class="tools-list">
        <#if tools?size gt 0>
            <#list tools as tool>
                <div class="item">
                    <a href="${ctx}/tool/${tool.code}">
                        <img src="${ctx}/${tool.icon}"/>
                        <p>${tool.name}</p>
                    </a>
                </div>
            </#list>
        <#else>
            <div class="empty">
                没有工具
            </div>
        </#if>
    </div>

    <div class="space-10"></div>
</div>
</@override>

<@override name="script">

</@override>

<@extends name="../layout.ftl"/>