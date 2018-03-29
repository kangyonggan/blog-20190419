<#assign title="上传结果"/>
<#assign categoryCode=""/>
<#assign active_music="active"/>

<@override name="breadcrumbs">
<a href="${ctx}/">首页</a>
&gt;
<a href="${ctx}/music">音乐</a>
&gt;
<a href="javascript:" class="active">${title}</a>
</@override>

<@override name="main">
<div id="main">
    <div class="left">
        <#include "categories.ftl"/>
        <#include "top-articles.ftl"/>
    </div>

    <div class="right">
        <div class="content">
            <div class="title">
                <span>${title}</span>
            </div>

            <ul class="list">
                <div class="empty">${respMsg}</div>
            </ul>

            <div class="space-10"></div>
        </div>
    </div>

    <div class="space-10"></div>
</div>
</@override>

<@extends name="../layout.ftl"/>