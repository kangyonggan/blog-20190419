<#assign active_novel="active"/>
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

            <ul class="novel-list">
                <#if page.list?size gt 0>
                    <#list page.list as novel>
                        <li>
                            <a href="${ctx}/novel/${novel.code}" class="novel-title nowrap">${novel.name}</a>
                            <#if novel.lastSection??>
                                <a href="${ctx}/novel/${novel.code}/section/${novel.lastSection.code}"
                                   class="new-section nowrap">${novel.lastSection.title}</a>
                            <#else>
                                <a href="javascript:" class="new-section nowrap">暂无最新章节</a>
                            </#if>
                            <span class="author nowrap">${novel.author}</span>
                            <span class="updated-time nowrap">${novel.updatedTime?date}</span>
                        </li>
                    </#list>
                <#else>
                    <div class="empty">没有小说</div>
                </#if>
            </ul>

            <div class="space-10"></div>
        </div>

        <@c.web_pagination url="${ctx}/novel" param="categoryCode=${categoryCode}"/>

        <div style="text-align: center;margin-top: 10px">
            本站所有小说为转载作品，转载至本站只是为了宣传本书让更多读者欣赏。
        </div>
    </div>

    <div class="space-10"></div>
</div>
</@override>

<@extends name="../layout.ftl"/>