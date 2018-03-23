<#assign ctx="${(rca.contextPath)!''}">
<#assign name = RequestParameters.name!'' />

<div class="page-header">
    <h1>
        工具列表
        <small class="pull-right">
            <a href="${ctx}/dashboard#manage/tool/create" class="btn btn-sm btn-pink">添加</a>
        </small>
    </h1>
</div>

<div class="space-10"></div>

<form class="form-inline" method="get">
    <div class="form-group">
        <input type="text" class="form-control" name="name" value="${name}" placeholder="工具名称"/>
    </div>

<@c.search_form_tool/>
</form>

<div class="space-10"></div>

<table id="tool-table" class="table table-striped table-bordered table-hover">
    <thead>
    <tr>
        <th>工具名称</th>
        <th>工具图片</th>
        <th>是否推荐</th>
        <th>逻辑删除</th>
        <th>创建时间</th>
        <th>操作</th>
    </tr>
    </thead>
    <tbody>
    <#if page.list?size gt 0>
        <#list page.list as tool>
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
<@c.pagination url="${ctx}/dashboard#manage/tool" param="name=${name}"/>

<script src="${ctx}/static/app/js/dashboard/manage/tool/list.js"></script>

