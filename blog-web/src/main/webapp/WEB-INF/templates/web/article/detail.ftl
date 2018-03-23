<#assign title="博文"/>

<@override name="style">
<link rel="stylesheet" href="${ctx}/static/ace/dist/css/prettify.min.css"/>
</@override>

<@override name="main">
<div id="main">
    <div class="left">
        <div class="category-name">
            <span>栏目中心</span>
        </div>
        <ul class="category-nav">
            <#list categories as category>
                <li <#if article.categoryCode==category.code>class="active"</#if>><a
                        href="${ctx}/article/category/${category.code}">${category.name}</a></li>
            </#list>
        </ul>
        <div class="hot">
            <div class="title">
                <span>推荐内容</span>
            </div>
            <ul class="list">
                <li><a href="#">热烈祝贺闵行88家企业获得上海市</a></li>
                <li><a href="#">热烈祝贺闵行88家企业获得上海市</a></li>
                <li><a href="#">热烈祝贺闵行88家企业获得上海市</a></li>
                <li><a href="#">热烈祝贺闵行88家企业获得上海市</a></li>
                <li><a href="#">热烈祝贺闵行88家企业获得上海市</a></li>
            </ul>
        </div>
    </div>

    <div class="right">
        <div class="content">
            <div class="title">
                <span>
                    <#list categories as category>
                       <#if article.categoryCode==category.code>${category.name}</#if>
                    </#list>
                </span>
            </div>
            <div class="article-title">
                ${article.title}
            </div>

            <div class="article-date">
                【发布时间： ${article.createdTime?date}】
            </div>

            <div class="well article-summary">
                摘要：${article.summary}
            </div>

            <div class="article-content markdown">
                ${article.content}
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
<script src="${ctx}/static/ace/dist/js/prettify.min.js"></script>
<script src="${ctx}/static/app/js/web/article/detail.js"></script>
</@override>

<@extends name="../layout.ftl"/>