<#assign title="相册"/>
<#assign active_photo="active"/>

<@override name="breadcrumbs">
<a href="${ctx}/">首页</a>
&gt;
<a href="javascript:" class="active">${title}</a>
</@override>

<@override name="main">
<div id="main">
    <div class="photos">
        <#list photos as photo>
            <dl>
                <dd>
                    <a href="${ctx}/photo/${photo.id}">
                        <img src="${ctx}/${photo.coverImg}" title="${photo.title}"/>
                    </a>
                </dd>
                <dt>${photo.title}</dt>
            </dl>
        </#list>
    </div>

    <div class="space-10"></div>
</div>
</@override>


<@extends name="../layout.ftl"/>