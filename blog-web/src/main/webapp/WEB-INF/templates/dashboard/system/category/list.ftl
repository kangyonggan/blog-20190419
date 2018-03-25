<#assign ctx="${(rca.contextPath)!''}">
<#assign code = RequestParameters.code!'' />
<#assign name = RequestParameters.name!'' />
<#assign type = RequestParameters.type!'' />

<div class="page-header">
    <h1>
        栏目列表
        <small class="pull-right">
            <a href="${ctx}/dashboard/system/category/create" class="btn btn-sm btn-pink" data-backdrop="static"
               data-toggle="modal"
               data-target="#myModal">添加</a>
        </small>
    </h1>
</div>

<div class="space-10"></div>

<form class="form-inline" method="get">
    <div class="form-group">
        <select name="type" class="form-control">
            <option value="">-- 全部类型 --</option>
        <#list types as t>
            <option value="${t.getType()}" <#if type=='${t.getType()}'>selected</#if>>${t.getName()}</option>
        </#list>
        </select>
    </div>
    <div class="form-group">
        <input type="text" class="form-control" name="code" value="${code}" placeholder="栏目代码"/>
    </div>
    <div class="form-group">
        <input type="text" class="form-control" name="name" value="${name}" placeholder="栏目名称"/>
    </div>

<@c.search_form_tool/>
</form>

<div class="space-10"></div>

<table id="category-table" class="table table-striped table-bordered table-hover">
    <thead>
    <tr>
        <th>栏目代码</th>
        <th>栏目名称</th>
        <th>栏目类型</th>
        <th>逻辑删除</th>
        <th>创建时间</th>
        <th>操作</th>
    </tr>
    </thead>
    <tbody>
    <#if page.list?size gt 0>
        <#list page.list as category>
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
<@c.pagination url="${ctx}/dashboard#system/category" param="code=${code}&name=${name}&type=${type}"/>

<script src="${ctx}/static/app/js/dashboard/system/category/list.js"></script>

