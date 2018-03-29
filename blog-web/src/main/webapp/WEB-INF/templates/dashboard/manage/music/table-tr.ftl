<#assign ctx="${(rca.contextPath)!''}">

<tr id="music-${music.id}">
    <td>
        <a href="${ctx}/music/${music.album} - ${music.name}.mp3" target="_blank">${music.name}</a>
    </td>
    <td>${music.singer}</td>
    <td>${music.album}</td>
    <td>${music.duration}</td>
    <td>${music.size}</td>
    <td>${music.uploadUsername}</td>
    <td><#include "category.ftl"></td>
    <td><#include "status.ftl"></td>
    <td><#include "delete.ftl"></td>
    <td><@c.relative_date datetime=music.createdTime/></td>
    <td>
        <div class="btn-group">
            <a class="btn btn-xs btn-inverse" href="${ctx}/dashboard/manage/music/${music.id}/edit" data-toggle="modal"
               data-target="#myModal"
               data-backdrop="static">编辑</a>

            <button data-toggle="dropdown" class="btn btn-xs btn-inverse dropdown-toggle">
                <span class="ace-icon fa fa-caret-down icon-only"></span>
            </button>

            <ul class="dropdown-menu dropdown-menu-right dropdown-inverse">
            <#if music.status=="WAITING">
                <!--待审核-->
                <li>
                    <a href="javascript:" data-role="music-tr" title="审核通过"
                       data-url="${ctx}/dashboard/manage/music/${music.id}/COMPLETE">审核通过</a>
                </li>
                <li>
                    <a href="javascript:" data-role="music-tr" title="拒绝"
                       data-url="${ctx}/dashboard/manage/music/${music.id}/REJECT">拒绝</a>
                </li>
            <#elseif music.status=="REJECT" || music.status=="COMPLETE">
                <!--拒绝 和 审核通过-->
                <li>
                    <a href="javascript:" data-role="music-tr" title="撤销审核"
                       data-url="${ctx}/dashboard/manage/music/${music.id}/WAITING">撤销审核</a>
                </li>
            </#if>
            <#if music.isDeleted==1>
                <li>
                    <a href="javascript:" data-category="music-remove" title="彻底删除音乐"
                       data-url="${ctx}/dashboard/manage/music/${music.id}/remove">
                        彻底删除
                    </a>
                </li>
            <#else>
                <li>
                    <a href="javascript:" data-category="music-delete" title="删除音乐"
                       data-url="${ctx}/dashboard/manage/music/${music.id}/delete">
                        删除
                    </a>
                </li>
            </#if>
            </ul>
        </div>
    </td>
</tr>