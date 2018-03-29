<#assign ctx="${(rca.contextPath)!''}">
<#assign name = RequestParameters.name!'' />
<#assign singer = RequestParameters.singer!'' />
<#assign album = RequestParameters.album!'' />
<#assign categoryCode = RequestParameters.categoryCode!'' />

<div class="page-header">
    <h1>
        音乐列表
        <small class="pull-right">
            <a href="${ctx}/dashboard/manage/music/create" class="btn btn-sm btn-pink" data-toggle="modal"
               data-target="#myModal"
               data-backdrop="static">添加</a>
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
        <input type="text" class="form-control" name="name" value="${name}" placeholder="歌曲名"/>
    </div>
    <div class="form-group">
        <input type="text" class="form-control" name="singer" value="${singer}" placeholder="歌手"/>
    </div>
    <div class="form-group">
        <input type="text" class="form-control" name="album" value="${album}" placeholder="专辑"/>
    </div>

<@c.search_form_tool/>
</form>

<div class="space-10"></div>

<table id="music-table" class="table table-striped table-bordered table-hover">
    <thead>
    <tr>
        <th>歌曲名</th>
        <th>歌手</th>
        <th>专辑</th>
        <th>时长(s)</th>
        <th>大小(byte)</th>
        <th>上传者</th>
        <th>栏目</th>
        <th>状态</th>
        <th>逻辑删除</th>
        <th>创建时间</th>
        <th>操作</th>
    </tr>
    </thead>
    <tbody>
    <#if page.list?size gt 0>
        <#list page.list as music>
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
<@c.pagination url="${ctx}/dashboard#manage/music" param="name=${name}&singer=${singer}&album=${album}&categoryCode=${categoryCode}"/>

<script src="${ctx}/static/app/js/dashboard/manage/music/list.js"></script>

