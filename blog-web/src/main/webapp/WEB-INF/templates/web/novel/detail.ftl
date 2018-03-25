<#assign active_novel="active"/>
<#assign categoryCode = novel.categoryCode />
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

            <div class="novel-info">
                <div class="img-border">
                    <img src="${ctx}/${novel.picUrl}">
                </div>
                <div class="novel-desc">
                    <div class="novel-name nowrap">${novel.name}</div>
                    <div class="novel-author">
                        <span>作者：${novel.author}</span>
                        <#if lastSection??>
                            <a href="${ctx}/novel/${novel.code}/section/${lastSection.code}">最新章节：${lastSection.title}</a>
                        <#else>
                            <a href="javascript:">暂无最新章节</a>
                        </#if>
                    </div>
                    <p class="novel-descp">
                        ${novel.descp}
                    </p>
                </div>
            </div>

            <ul class="novel-list">
                <#if page.list?size gt 0>
                    <#list page.list as section>
                        <#if section_index % 2 == 0>
                            <li>
                                <a href="${ctx}/novel/${novel.code}/section/${section.code}"
                                   class="section-title nowrap">${section.title}</a>
                                <#if section_has_next>
                                    <a href="${ctx}/novel/${novel.code}/section/${page.list[section_index + 1].code}"
                                       class="section-title nowrap">${page.list[section_index + 1].title}</a>
                                </#if>
                            </li>
                        </#if>
                    </#list>
                <#else>
                    <div class="empty">
                        <div>没有小说章节</div>
                    </div>
                </#if>
            </ul>

            <div class="space-10"></div>
        </div>

        <@c.web_pagination url="${ctx}/novel/${novel.code}"/>
    </div>

    <div class="space-10"></div>
</div>
</@override>

<@extends name="../layout.ftl"/>