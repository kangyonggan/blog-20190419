<#assign active_music="active"/>
<#assign categoryCode = RequestParameters.categoryCode!'' />
<#list categories as category>
    <#if categoryCode==category.code>
        <#assign title="${category.name}"/>
    </#if>
</#list>
<#if categoryCode==''><#assign title="全部栏目"/></#if>

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
            </div>

            <ul class="music-list">
                <#if page.list?size gt 0>
                    <#list page.list as music>
                        <li>
                            <a target="_blank" href="${ctx}/music/${music.album} - ${music.name}.mp3" class="music-album nowrap">${music.album}</a>
                            <a href="${ctx}/music/${music.album} - ${music.name}.mp3" class="music-name nowrap">${music.name}</a>
                            <span class="music-singer nowrap">${music.singer}</span>
                        </li>
                    </#list>
                <#else>
                    <div class="empty">没有音乐</div>
                </#if>
            </ul>

            <div class="space-10"></div>
        </div>

        <@c.web_pagination url="${ctx}/music" param="categoryCode=${categoryCode}"/>

    </div>

    <div class="space-10"></div>
</div>
</@override>

<@extends name="../layout.ftl"/>