<#assign title="${life.title}"/>
<#assign active_life="active"/>
<#assign categoryCode="${life.categoryCode}"/>

<@override name="style">
<link rel="stylesheet" href="${ctx}/static/libs/zoomify/zoomify.min.css">
<link rel="stylesheet" href="${ctx}/static/ace/dist/css/prettify.min.css"/>
</@override>

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
                       <#if life.categoryCode==category.code>${category.name}</#if>
                    </#list>
                </span>
            </div>
            <div class="article-title">
                ${life.title}
            </div>

            <div class="article-date">
                【发布时间： ${life.createdTime?date}】
            </div>

            <div class="well article-summary">
                摘要：${life.summary}
            </div>

            <div class="article-content markdown">
                ${life.content}
            </div>

            <#if attachments?size gt 0>
                <div class="space-20"></div>

                <div class="hr hr8 hr-double hr-dotted"></div>

                <div class="space-10"></div>

                <h4 class="attachments-title">附件</h4>

                <ul class="attachments">
                    <#list attachments as attachment>
                        <li>
                            <a href="${ctx}/${attachment.url}" target="_blank">
                            ${attachment.originalFilename}
                                <span>[${attachment.createdTime?datetime}]</span>
                            </a>
                        </li>
                    </#list>
                </ul>
            </#if>
        </div>

        <div class="space-10"></div>
    </div>

    <div class="space-10"></div>
</div>
</@override>

<@override name="script">
<script src="${ctx}/static/libs/zoomify/zoomify.min.js"></script>
<script src="${ctx}/static/ace/dist/js/prettify.min.js"></script>
<script src="${ctx}/static/app/js/web/life/detail.js"></script>
</@override>

<@extends name="../layout.ftl"/>