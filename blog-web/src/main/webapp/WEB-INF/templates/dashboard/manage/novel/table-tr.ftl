<#assign ctx="${(rca.contextPath)!''}">

<tr id="novel-${novel.id}">
    <td>${novel.code}</td>
    <td>
        <a href="${ctx}/dashboard#manage/novel/${novel.code}">${novel.name}</a>
    </td>
    <td>${novel.author}</td>
    <td><#include "category.ftl"></td>
    <td><#include "delete.ftl"></td>
    <td><@c.relative_date datetime=novel.createdTime/></td>
    <td>
        <div class="btn-group">
            <a class="btn btn-xs btn-inverse" href="${ctx}/dashboard#manage/novel/${novel.code}">章节列表</a>

            <button data-toggle="dropdown" class="btn btn-xs btn-inverse dropdown-toggle">
                <span class="ace-icon fa fa-caret-down icon-only"></span>
            </button>

            <ul class="dropdown-menu dropdown-menu-right dropdown-inverse">
                <li>
                    <a href="javascript:" data-category="novel-update" title="从此处更新小说"
                       data-url="${ctx}/dashboard/manage/novel/${novel.code}/update">
                        从此处更新小说
                    </a>
                </li>
                <li>
                    <a href="javascript:" data-category="novel-update" title="拉取最新章节"
                       data-url="${ctx}/dashboard/manage/novel/${novel.code}/pull">
                        拉取最新章节
                    </a>
                </li>
            <#if novel.isDeleted==1>
                <li>
                    <a href="javascript:" data-category="novel-remove" title="彻底删除小说"
                       data-url="${ctx}/dashboard/manage/novel/${novel.code}/remove">
                        彻底删除
                    </a>
                </li>
            <#else>
                <li>
                    <a href="javascript:" data-category="novel-delete" title="删除小说"
                       data-url="${ctx}/dashboard/manage/novel/${novel.code}/delete">
                        删除
                    </a>
                </li>
            </#if>
            </ul>
        </div>
    </td>
</tr>