<#assign ctx="${(rca.contextPath)!''}">
<#assign code = RequestParameters.code!'' />
<#assign name = RequestParameters.name!'' />
<#assign author = RequestParameters.author!'' />
<#assign categoryCode = RequestParameters.categoryCode!'' />

<div class="page-header">
    <h1>
        小说列表
        <small class="pull-right">
            <a id="novel-update" href="javascript:" data-category="novel-update" title="更新小说"
               data-url="${ctx}/dashboard/manage/novel/update"  class="btn btn-sm btn-pink">
                更新小说
            </a>
            <a id="novel-update-all" href="javascript:" data-category="novel-update" title="更新全部章节"
               data-url="${ctx}/dashboard/manage/novel/updateSections"  class="btn btn-sm btn-danger">
                更新全部章节
            </a>
        </small>
    </h1>
</div>

<div class="space-10"></div>

<form class="form-inline" method="get">
    <div class="form-group">
        <select name="categoryCode" class="form-control" style="min-width: 162px;">
            <option value="">-- 全部栏目 --</option>
        <#list categories as category>
            <option value="${category.code}" <#if categoryCode==category.code>selected</#if>>${category.name}</option>
        </#list>
        </select>
    </div>
    <div class="form-group">
        <input type="text" class="form-control" name="code" value="${code}" placeholder="小说代码"/>
    </div>
    <div class="form-group">
        <input type="text" class="form-control" name="name" value="${name}" placeholder="小说名称"/>
    </div>
    <div class="form-group">
        <input type="text" class="form-control" name="author" value="${author}" placeholder="作者姓名"/>
    </div>

<@c.search_form_tool/>
</form>

<div class="space-10"></div>

<table id="novel-table" class="table table-striped table-bordered table-hover">
    <thead>
    <tr>
        <th>小说代码</th>
        <th>小说名称</th>
        <th>作者姓名</th>
        <th>栏目</th>
        <th>最新章节</th>
        <th>逻辑删除</th>
        <th>创建时间</th>
        <th>操作</th>
    </tr>
    </thead>
    <tbody>
    <#if page.list?size gt 0>
        <#list page.list as novel>
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
<@c.pagination url="${ctx}/dashboard#manage/novel" param="name=${name}&author=${author}&categoryCode=${categoryCode}"/>

<script src="${ctx}/static/app/js/dashboard/manage/novel/list.js"></script>

