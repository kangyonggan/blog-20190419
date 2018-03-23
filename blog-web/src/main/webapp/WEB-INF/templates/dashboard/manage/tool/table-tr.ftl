<#assign ctx="${(rca.contextPath)!''}">

<tr id="tool-${tool.id}">
    <td>
        <a href="${ctx}/dashboard#manage/tool/${tool.id}">${tool.name}</a>
    </td>
    <td>
        <#if tool.icon==''>
            暂无图标
        <#else>
            <a href="${ctx}/${tool.icon}" target="_blank">查看图标</a>
        </#if>
    </td>
    <td><#include "top.ftl"></td>
    <td><#include "delete.ftl"></td>
    <td><@c.relative_date datetime=tool.createdTime/></td>
    <td>
        <div class="btn-group">
            <a class="btn btn-xs btn-inverse" href="${ctx}/dashboard#manage/tool/${tool.id}/edit">编辑</a>

            <button data-toggle="dropdown" class="btn btn-xs btn-inverse dropdown-toggle">
                <span class="ace-icon fa fa-caret-down icon-only"></span>
            </button>

            <ul class="dropdown-menu dropdown-menu-right dropdown-inverse">
            <#if tool.isDeleted==1>
                <li>
                    <a href="javascript:" data-category="tool-remove" title="彻底删除工具"
                       data-url="${ctx}/dashboard/manage/tool/${tool.id}/remove">
                        彻底删除
                    </a>
                </li>
            <#else>
                <li>
                    <a href="javascript:" data-category="tool-delete" title="删除工具"
                       data-url="${ctx}/dashboard/manage/tool/${tool.id}/delete">
                        删除
                    </a>
                </li>
            </#if>
            </ul>
        </div>
    </td>
</tr>