<#assign ctx="${(rca.contextPath)!''}">

<tr id="guest-${guest.id}">
    <td>${guest.id}</td>
    <td>${guest.realname}</td>
    <td>${guest.email}</td>
    <td><@c.substring guest.content 20/></td>
    <td>${guest.ip}
        <small>&nbsp;${guest.ipInfo}</small>
    </td>
    <td><#include "status.ftl"></td>
    <td><#include "delete.ftl"></td>
    <td><@c.relative_date datetime=guest.createdTime/></td>
    <td><@c.relative_date datetime=guest.updatedTime/></td>
    <td>
        <div class="btn-group">
            <a class="btn btn-xs btn-inverse" href="${ctx}#manage/guest/${guest.id}">查看</a>

            <button data-toggle="dropdown" class="btn btn-xs btn-inverse dropdown-toggle">
                <span class="ace-icon fa fa-caret-down icon-only"></span>
            </button>

            <ul class="dropdown-menu dropdown-menu-right dropdown-inverse">
            <#if guest.status=="WAITING">
                <!--待审核-->
                <li>
                    <a href="javascript:" data-role="guest-tr" title="审核通过"
                       data-url="${ctx}/dashboard/manage/guest/${guest.id}/COMPLETE">审核通过</a>
                </li>
                <li>
                    <a href="javascript:" data-role="guest-tr" title="拒绝"
                       data-url="${ctx}/dashboard/manage/guest/${guest.id}/REJECT">拒绝</a>
                </li>
            <#elseif guest.status=="REJECT" || guest.status=="COMPLETE">
                <!--拒绝 和 审核通过-->
                <li>
                    <a href="javascript:" data-role="guest-tr" title="撤销审核"
                       data-url="${ctx}/dashboard/manage/guest/${guest.id}/WAITING">撤销审核</a>
                </li>
            </#if>

            <#if guest.isDeleted==1>
                <li>
                    <a href="javascript:" data-role="guest-remove" title="彻底删除"
                       data-url="${ctx}/dashboard/manage/guest/${guest.id}/remove">彻底删除</a>
                </li>
            </#if>
            </ul>
        </div>
    </td>
</tr>