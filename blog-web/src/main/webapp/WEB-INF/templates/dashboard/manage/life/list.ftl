<#assign ctx="${(rca.contextPath)!''}">
<#assign title = RequestParameters.title!'' />
<#assign categoryCode = RequestParameters.categoryCode!'' />

<div class="page-header">
    <h1>
        生活列表
        <small class="pull-right">
            <a href="${ctx}/dashboard#manage/life/create" class="btn btn-sm btn-pink">添加</a>
        </small>
    </h1>
</div>

<div class="space-10"></div>

<form class="form-inline" method="get">
    <div class="form-group">
        <select name="categoryCode" class="form-control" style="min-width: 162px;">
            <option value="">-- 全部栏目 --</option>
        <#list categories as category>
            <option value="${category.code}" <#if categoryCode==category.code>selected</#if>>${category.name}</option>
        </#list>
        </select>
    </div>
    <div class="form-group">
        <input type="text" class="form-control" name="title" value="${title}" placeholder="标题"/>
    </div>

<@c.search_form_tool/>
</form>

<div class="space-10"></div>

<table id="life-table" class="table table-striped table-bordered table-hover">
    <thead>
    <tr>
        <th width="45%">标题</th>
        <th>栏目名称</th>
        <th>逻辑删除</th>
        <th>创建时间</th>
        <th>操作</th>
    </tr>
    </thead>
    <tbody>
    <#if page.list?size gt 0>
        <#list page.list as life>
            <#include "table-tr.ftl"/>
        </#list>
    <#else>
    <tr>
        <td colspan="20">
            <div class="empty">暂无查询记录</div>
        </td>
    </tr>
    </#if>
    </tbody>
</table>
<@c.pagination url="${ctx}/dashboard#manage/life" param="title=${title}&categoryCode=${categoryCode}"/>

<script src="${ctx}/static/app/js/dashboard/manage/life/list.js"></script>

