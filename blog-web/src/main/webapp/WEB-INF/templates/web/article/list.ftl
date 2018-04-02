<#assign active_article="active"/>
<#assign categoryCode = RequestParameters.categoryCode!'' />
<#assign key = RequestParameters.key!'' />
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
        <#assign title="文章"/>
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
            </div>

            <ul class="list">
                <#if page.list?size gt 0>
                    <#list page.list as article>
                        <li>
                            <a href="${ctx}/article/${article.id}" class="nowrap">${article.title}</a>
                            <div class="desc">
                            ${article.summary}
                            </div>
                            <div class="date">
                            ${article.createdTime?date}
                            </div>
                        </li>
                    </#list>
                <#else>
                    <div class="empty">没有文章</div>
                </#if>
            </ul>
        </div>

        <#if key != ''>
            <@c.web_pagination url="${ctx}/search" param="key=${key}"/>
        <#else>
            <@c.web_pagination url="${ctx}/article" param="categoryCode=${categoryCode}&type=${type}"/>
        </#if>
    </div>

    <div class="space-10"></div>
</div>
</@override>

<@extends name="../layout.ftl"/>