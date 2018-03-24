<#assign ctx="${(rca.contextPath)!''}">

<tr id="life-${life.id}">
    <td>
        <a href="${ctx}/dashboard#manage/life/${life.id}">${life.title}</a>
    </td>
    <td><#include "category.ftl"></td>
    <td><#include "delete.ftl"></td>
    <td><@c.relative_date datetime=life.createdTime/></td>
    <td>
        <div class="btn-group">
            <a class="btn btn-xs btn-inverse" href="${ctx}/dashboard#manage/life/${life.id}/edit">编辑</a>

            <button data-toggle="dropdown" class="btn btn-xs btn-inverse dropdown-toggle">
                <span class="ace-icon fa fa-caret-down icon-only"></span>
            </button>

            <ul class="dropdown-menu dropdown-menu-right dropdown-inverse">
                <#if life.isDeleted==1>
                    <li>
                        <a href="javascript:" data-category="life-remove" title="彻底删除生活"
                           data-url="${ctx}/dashboard/manage/life/${life.id}/remove">
                            彻底删除
                        </a>
                    </li>
                <#else>
                    <li>
                        <a href="javascript:" data-category="life-delete" title="删除生活"
                           data-url="${ctx}/dashboard/manage/life/${life.id}/delete">
                            删除
                        </a>
                    </li>
                </#if>
            </ul>
        </div>
    </td>
</tr>