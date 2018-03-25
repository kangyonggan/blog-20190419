<#assign active_novel="active"/>
<#assign title="${section.title}"/>

<@override name="breadcrumbs">
<a href="${ctx}/">首页</a>
&gt;
<a href="${ctx}/novel">全部栏目</a>
&gt;
<a href="${ctx}/novel?categoryCode=${novel.categoryCode}"><#list categories as category><#if novel.categoryCode==category.code>${category.name}</#if></#list></a>
&gt;
<a href="${ctx}/novel/${novel.code}">${novel.name}</a>
&gt;
<a href="javascript:" class="active">${section.title}</a>
</@override>

<@override name="main">
<div id="main">
    <div class="s-title">
        ${section.title}
    </div>
    <div class="s-desc">
        <#if prevSection??>
            <a href="${ctx}/novel/${novel.code}/section/${prevSection.code}" class="first">
                上一章：${prevSection.title}
            </a>
        <#else>
            <a href="${ctx}/novel/${novel.code}" class="first">
                上一章：没有章节了
            </a>
        </#if>
        <a href="${ctx}/novel/${novel.code}" class="center">
            章节列表
        </a>

        <#if nextSection??>
            <a href="${ctx}/novel/${novel.code}/section/${nextSection.code}" class="last">
                下一章：${nextSection.title}
            </a>
        <#else>
            <a href="${ctx}/novel/${novel.code}" class="last">
                下一章：没有章节了
            </a>
        </#if>
    </div>

    <div class="s-content">
        ${section.content}
    </div>

    <div class="s-desc">
        <#if prevSection??>
            <a href="${ctx}/novel/${novel.code}/section/${prevSection.code}" class="first">
                上一章：${prevSection.title}
            </a>
        <#else>
            <a href="${ctx}/novel/${novel.code}" class="first">
                上一章：没有章节了
            </a>
        </#if>
        <a href="${ctx}/novel/${novel.code}" class="center">
            章节列表
        </a>

        <#if nextSection??>
            <a href="${ctx}/novel/${novel.code}/section/${nextSection.code}" class="last">
                下一章：${nextSection.title}
            </a>
        <#else>
            <a href="${ctx}/novel/${novel.code}" class="last">
                下一章：没有章节了
            </a>
        </#if>
    </div>

    <div class="space-10"></div>
</div>
</@override>

<@extends name="../layout.ftl"/>