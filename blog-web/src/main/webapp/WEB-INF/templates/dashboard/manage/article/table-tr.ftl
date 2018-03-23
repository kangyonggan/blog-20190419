<#assign ctx="${(rca.contextPath)!''}">

<tr id="article-${article.id}">
    <td>
        <a href="${ctx}/dashboard#manage/article/${article.id}">${article.title}</a>
    </td>
    <td><#include "category.ftl"></td>
    <td><#include "top.ftl"></td>
    <td><#include "delete.ftl"></td>
    <td><@c.relative_date datetime=article.createdTime/></td>
    <td>
        <div class="btn-group">
            <a class="btn btn-xs btn-inverse" href="${ctx}/dashboard#manage/article/${article.id}/edit">编辑</a>

            <button data-toggle="dropdown" class="btn btn-xs btn-inverse dropdown-toggle">
                <span class="ace-icon fa fa-caret-down icon-only"></span>
            </button>

            <ul class="dropdown-menu dropdown-menu-right dropdown-inverse">
                <#if article.isDeleted==1>
                    <li>
                        <a href="javascript:" data-category="article-remove" title="彻底删除文章"
                           data-url="${ctx}/dashboard/manage/article/${article.id}/remove">
                            彻底删除
                        </a>
                    </li>
                <#else>
                    <li>
                        <a href="javascript:" data-category="article-delete" title="删除文章"
                           data-url="${ctx}/dashboard/manage/article/${article.id}/delete">
                            删除
                        </a>
                    </li>
                </#if>
            </ul>
        </div>
    </td>
</tr>