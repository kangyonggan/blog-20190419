<#assign ctx="${(rca.contextPath)!''}">
<link rel="stylesheet" href="${ctx}/static/ace/dist/css/prettify.min.css"/>

<div class="row">
    <div class="col-sm-10 col-sm-offset-1">
        <div class="widget-box transparent">
            <div class="widget-header widget-header-large">
                <h3 class="widget-title grey lighter">
                    <i class="ace-icon fa fa-leaf green"></i>
                ${article.title}
                </h3>

                <div class="widget-toolbar no-border invoice-info">
                    <span class="invoice-info-label">发布时间:</span>
                    <span class="red"><@c.relative_date datetime=article.createdTime/></span>

                    <br/>
                    <span class="invoice-info-label">栏目:</span>
                    <span class="blue"><#include "category.ftl"/></span>
                </div>

                <div class="widget-toolbar hidden-480">
                    <a href="javascript:"></a>
                </div>
            </div>

            <div class="widget-body">
                <div class="widget-main padding-24">

                    <div class="space-10"></div>

                    <p class="well">
                        摘要：${article.summary}
                    </p>

                    <div class="space-20"></div>

                    <div class="markdown">
                    ${article.content}
                    </div>

                <#if attachments?size gt 0>
                    <div class="space-20"></div>

                    <div class="hr hr8 hr-double hr-dotted"></div>

                    <div class="space-10"></div>

                    <h4 class="red">附件</h4>

                    <div class="space-4"></div>

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
            </div>
        </div>
    </div>
</div>

<script src="${ctx}/static/ace/dist/js/prettify.min.js"></script>
<script src="${ctx}/static/app/js/dashboard/manage/article/detail.js"></script>