<#assign active_music="active"/>
<#assign categoryCode = RequestParameters.categoryCode!'' />
<#assign type = RequestParameters.type!'' />

<#list categories as category>
    <#if categoryCode==category.code>
        <#assign title="${category.name}"/>
    </#if>
</#list>
<#if categoryCode==''>
    <#if key != ''>
        <#assign title="搜索结果"/>
    <#else>
        <#assign title="音乐"/>
    </#if>
</#if>

<@override name="breadcrumbs">
    <#include "breadcrumbs.ftl"/>
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
                <a href="${ctx}/music/upload">上传音乐</a>
            </div>

            <ul class="music-list">
                <#if page.list?size gt 0>
                    <#list page.list as music>
                        <li>
                            <span class="music-name nowrap">${music.name}</span>
                            <span class="music-singer nowrap">${music.singer}</span>

                            <audio controls="controls">
                                <source src="${ctx}/${music.musicPath}" type="audio/mpeg">
                                你的浏览器不支持，建议使用谷歌浏览器.
                            </audio>
                        </li>
                    </#list>
                <#else>
                    <div class="empty">没有音乐</div>
                </#if>
            </ul>

            <div class="space-10"></div>
        </div>

        <@c.web_pagination url="${ctx}/music" param="categoryCode=${categoryCode}&type=${type}"/>

    </div>

    <div class="space-10"></div>
</div>
</@override>

<@extends name="../layout.ftl"/>