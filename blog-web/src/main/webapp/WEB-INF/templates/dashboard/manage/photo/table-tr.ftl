<#assign ctx="${(rca.contextPath)!''}">

<tr id="photo-${photo.id}">
    <td>${photo.title}</td>
    <td>
        <#if photo.coverImg != ''>
            <a href="${ctx}/${photo.coverImg}" target="_blank">查看封面</a>
        <#else>
            暂无封面
        </#if>
    </td>
    <td><#include "delete.ftl"></td>
    <td><@c.relative_date datetime=photo.createdTime/></td>
    <td>
        <div class="btn-group">
            <a class="btn btn-xs btn-inverse" href="${ctx}/dashboard#manage/photo/${photo.id}/manage">
                管理相册
            </a>

            <button data-toggle="dropdown" class="btn btn-xs btn-inverse dropdown-toggle">
                <span class="ace-icon fa fa-caret-down icon-only"></span>
            </button>

            <ul class="dropdown-menu dropdown-menu-right dropdown-inverse">
                <li>
                    <a href="${ctx}/dashboard/manage/photo/${photo.id}/edit" data-toggle="modal"
                       data-target="#myModal"
                       data-backdrop="static">编辑</a>
                </li>
                <#if photo.isDeleted==1>
                    <li>
                        <a href="javascript:" data-category="photo-remove" title="彻底删除相册"
                           data-url="${ctx}/dashboard/manage/photo/${photo.id}/remove">
                            彻底删除
                        </a>
                    </li>
                <#else>
                    <li>
                        <a href="javascript:" data-category="photo-delete" title="删除相册"
                           data-url="${ctx}/dashboard/manage/photo/${photo.id}/delete">
                            删除
                        </a>
                    </li>
                </#if>
            </ul>
        </div>
    </td>
</tr>