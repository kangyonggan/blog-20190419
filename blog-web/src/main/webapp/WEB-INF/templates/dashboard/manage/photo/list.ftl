<#assign ctx="${(rca.contextPath)!''}">
<#assign title = RequestParameters.title!'' />

<div class="page-header">
    <h1>
        相册列表
        <small class="pull-right">
            <a href="${ctx}/dashboard/manage/photo/create" class="btn btn-sm btn-pink" data-toggle="modal"
               data-target="#myModal"
               data-backdrop="static">添加</a>
        </small>
    </h1>
</div>

<div class="space-10"></div>

<form class="form-inline" method="get">
    <div class="form-group">
        <input type="text" class="form-control" name="title" value="${title}" placeholder="相册标题"/>
    </div>

<@c.search_form_tool/>
</form>

<div class="space-10"></div>

<table id="photo-table" class="table table-striped table-bordered table-hover">
    <thead>
    <tr>
        <th width="45%">相册标题</th>
        <th>相册封面</th>
        <th>逻辑删除</th>
        <th>创建时间</th>
        <th>操作</th>
    </tr>
    </thead>
    <tbody>
    <#if page.list?size gt 0>
        <#list page.list as photo>
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
<@c.pagination url="${ctx}/dashboard#manage/photo" param="title=${title}"/>

<script src="${ctx}/static/app/js/dashboard/manage/photo/list.js"></script>

