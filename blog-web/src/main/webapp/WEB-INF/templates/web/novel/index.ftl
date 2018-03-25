<#assign title="工具"/>
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

        <ul class="pagination">
            <li><a href="#">首页</a></li>
            <li><a href="#">上一页</a></li>
            <li class="active"><a href="#">1</a></li>
            <li><a href="#">2</a></li>
            <li><a href="#">3</a></li>
            <li><a href="#">4</a></li>
            <li><a href="#">5</a></li>
            <li><a href="#">6</a></li>
            <li><a href="#">7</a></li>
            <li><a href="#">8</a></li>
            <li><a href="#">下一页</a></li>
            <li><a href="#">尾页</a></li>
        </ul>
    </div>

    <div class="space-10"></div>
</div>
</@override>

<@override name="script">

</@override>

<@extends name="../layout.ftl"/>