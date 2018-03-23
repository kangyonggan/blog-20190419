<#assign title="博文"/>
<#assign categoryCode = RequestParameters.categoryCode!'' />

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
                <span>
                    <#list categories as category>
                        <#if categoryCode==category.code>${category.name}</#if>
                    </#list>
                    <#if categoryCode==''>全部栏目</#if>
                </span>
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
                    <div class="empty">没有内容</div>
                </#if>
            </ul>
        </div>

        <@c.web_pagination url="${ctx}/article" param="categoryCode=${categoryCode}"/>
    </div>

    <div class="space-10"></div>
</div>
</@override>

<@override name="script">

</@override>

<@extends name="../layout.ftl"/>