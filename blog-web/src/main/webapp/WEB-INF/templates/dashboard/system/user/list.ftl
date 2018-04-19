<#assign ctx="${(rca.contextPath)!''}">
<#assign username = RequestParameters.username!'' />
<#assign realname = RequestParameters.realname!'' />

<div class="page-header">
    <h1>
        用户列表
        <small class="pull-right">
            <a href="${ctx}/dashboard/system/user/create" class="btn btn-sm btn-pink" data-toggle="modal"
               data-target="#myModal"
               data-backdrop="static">添加</a>
        </small>
    </h1>
</div>

<div class="space-10"></div>

<form class="form-inline" id="user-query-form">
    <div class="form-group">
        <input type="text" class="form-control" name="username" value="${username}" placeholder="用户名"
               autocomplete="off"/>
    </div>
    <div class="form-group">
        <input type="text" class="form-control" name="realname" value="${realname}" placeholder="真实姓名"
               autocomplete="off"/>
    </div>
<@c.search_form_tool search_table_id="user-table"/>
</form>

<div class="space-10"></div>

<@c.table id="user-table" url="${ctx}/dashboard/system/user/list">
    <@c.th field="username" title="用户名" sortable="true"/>
    <@c.th field="realname" title="真实姓名"/>
    <@c.th field="isDeleted" title="逻辑删除" render="true">
        <#include "delete.ftl"/>
    </@c.th>
    <@c.th field="createdTime" title="创建时间" render="true">
    {{value | datetimeFormat}}
    </@c.th>
    <@c.th title="操作" render="true">
    <div class="btn-group">
        <a class="btn btn-xs btn-inverse" href="${ctx}/dashboard/system/user/{{row.username}}/edit"
           data-toggle="modal" data-target="#myModal"
           data-backdrop="static">编辑</a>

        <button data-toggle="dropdown" class="btn btn-xs btn-inverse dropdown-toggle">
            <span class="ace-icon fa fa-caret-down icon-only"></span>
        </button>

        <ul class="dropdown-menu dropdown-menu-right dropdown-inverse">
            <li>
                <a href="${ctx}/dashboard/system/user/{{row.username}}/password" data-toggle="modal"
                   data-target="#myModal"
                   data-backdrop="static">修改密码</a>
            </li>
            <li>
                <a href="${ctx}/dashboard/system/user/{{row.username}}/roles" data-toggle="modal"
                   data-target="#myModal"
                   data-backdrop="static">设置角色</a>
            </li>
            {{if row.isDeleted==1}}
            <li>
                <a href="javascript:" data-role="user-remove" title="彻底删除用户"
                   data-url="${ctx}/dashboard/system/user/{{row.id}}/remove">
                    彻底删除
                </a>
            </li>
            {{/if}}
        </ul>
    </div>
    </@c.th>
</@c.table>

<script src="${ctx}/static/app/js/dashboard/system/user/list.js"></script>
