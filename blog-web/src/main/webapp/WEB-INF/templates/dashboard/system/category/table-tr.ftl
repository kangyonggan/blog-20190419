<#assign ctx="${(rca.contextPath)!''}">

<tr id="category-${category.id}">
    <td>${category.code}</td>
    <td>${category.name}</td>
    <td><#include "type.ftl"></td>
    <td><#include "delete.ftl"></td>
    <td><@c.relative_date datetime=category.createdTime/></td>
    <td>
        <div class="btn-group">
            <a class="btn btn-xs btn-inverse" href="${ctx}/dashboard/system/category/${category.id}/edit"
               data-toggle="modal" data-target="#myModal"
               data-backdrop="static">编辑</a>

            <button data-toggle="dropdown" class="btn btn-xs btn-inverse dropdown-toggle">
                <span class="ace-icon fa fa-caret-down icon-only"></span>
            </button>

            <ul class="dropdown-menu dropdown-menu-right dropdown-inverse">
                <#if category.isDeleted==1>
                    <li>
                        <a href="javascript:" data-category="category-remove" title="彻底删除栏目"
                           data-url="${ctx}/dashboard/system/category/${category.id}/remove">
                            彻底删除
                        </a>
                    </li>
                <#else>
                    <li>
                        <a href="javascript:" data-category="category-delete" title="删除栏目"
                           data-url="${ctx}/dashboard/system/category/${category.id}/delete">
                            删除
                        </a>
                    </li>
                </#if>
            </ul>
        </div>
    </td>
</tr>