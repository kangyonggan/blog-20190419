<#assign ctx="${(rca.contextPath)!''}">
<#assign type = RequestParameters.type!'' />
<#assign value = RequestParameters.value!'' />

<div class="page-header">
    <h1>
        字典列表
        <small class="pull-right">
            <a href="${ctx}/dashboard/system/dictionary/create" class="btn btn-sm btn-pink" data-backdrop="static"
               data-toggle="modal"
               data-target="#myModal">添加</a>
        </small>
    </h1>
</div>

<div class="space-10"></div>

<form class="form-inline" method="get" novalidate>
    <div class="form-group">
        <select name="type" class="form-control">
            <option value="">全部类型</option>
        <#list types as t>
            <option value="${t.getType()}" <#if type=='${t.getType()}'>selected</#if>>${t.getName()}</option>
        </#list>
        </select>
    </div>
    <div class="form-group">
        <input type="text" class="form-control" name="value" value="${value}" placeholder="字典的值"/>
    </div>

<@c.search_form_tool/>
</form>

<div class="space-10"></div>

<table id="dictionary-table" class="table table-striped table-bordered table-hover">
    <thead>
    <tr>
        <th>字典类型</th>
        <th>字典代码</th>
        <th>字典的值</th>
        <th>排序</th>
        <th>逻辑删除</th>
        <th>创建时间</th>
        <th>操作</th>
    </tr>
    </thead>
    <tbody>
    <#if page.list?size gt 0>
        <#list page.list as dictionary>
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
<@c.pagination url="${ctx}/dashboard#system/dictionary" param="type=${type}&value=${value}"/>

<script src="${ctx}/static/app/js/dashboard/system/dictionary/list.js"></script>
