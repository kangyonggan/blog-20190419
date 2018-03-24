<#assign ctx="${(rca.contextPath)!''}">
<#assign status = RequestParameters.status!'' />

<div class="page-header">
    <h1>
        留言列表
    </h1>
</div>

<div class="space-10"></div>

<form class="form-inline" method="get"><div class="form-group">
    <select name="status" class="form-control">
        <option value="">-- 全部状态 --</option>
        <#list statuses as s>
            <option value="${s.getStatus()}" <#if status=='${s.getStatus()}'>selected</#if>>${s.getName()}</option>
        </#list>
        </select>
    </div>

<@c.search_form_tool/>
</form>

<div class="space-10"></div>

<table id="guest-table" class="table table-striped table-bordered table-hover">
    <thead>
    <tr>
        <th>ID</th>
        <th>昵称</th>
        <th>邮件</th>
        <th>内容</th>
        <th>IP信息</th>
        <th>审核状态</th>
        <th>逻辑删除</th>
        <th>留言时间</th>
        <th>更新时间</th>
        <th>操作</th>
    </tr>
    </thead>
    <tbody>
    <#if page.list?? && page.list?size gt 0>
        <#list page.list as guest>
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
<@c.pagination url="${ctx}/dashboard#manage/guest" param="status=${status}"/>

<script src="${ctx}/static/app/js/dashboard/manage/guest/list.js"></script>
