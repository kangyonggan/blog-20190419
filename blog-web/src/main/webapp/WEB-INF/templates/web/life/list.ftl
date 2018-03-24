<#assign active_life="active"/>
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

            <ul class="list">
                <#if page.list?size gt 0>
                    <#list page.list as life>
                        <li>
                            <a href="${ctx}/life/${life.id}" class="nowrap">${life.title}</a>
                            <div class="desc">
                            ${life.summary}
                            </div>
                            <div class="date">
                            ${life.createdTime?date}
                            </div>
                        </li>
                    </#list>
                <#else>
                    <div class="empty">没有生活动态</div>
                </#if>
            </ul>
        </div>

        <@c.web_pagination url="${ctx}/life" param="categoryCode=${categoryCode}"/>
    </div>

    <div class="space-10"></div>
</div>
</@override>

<@extends name="../layout.ftl"/>