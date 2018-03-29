<#assign title="上传音乐"/>
<#assign categoryCode=""/>
<#assign active_music="active"/>

<@override name="style">
<link rel="stylesheet" href="${ctx}/static/ace/dist/css/prettify.min.css"/>
<link rel="stylesheet" href="${ctx}/static/ace/dist/css/jquery.gritter.min.css"/>
<link rel="stylesheet" href="${ctx}/static/ace/dist/css/bootstrap.min.css"/>
<link rel="stylesheet" href="${ctx}/static/ace/dist/css/font-awesome.min.css"/>
<link rel="stylesheet" href="${ctx}/static/ace/dist/css/ace.min.css" class="ace-main-stylesheet"
      id="main-ace-style"/>
</@override>

<@override name="breadcrumbs">
<a href="${ctx}/">首页</a>
&gt;
<a href="${ctx}/music">音乐</a>
&gt;
<a href="javascript:" class="active">${title}</a>
</@override>

<@override name="main">
<div id="main">
    <div class="left">
        <#include "categories.ftl"/>
        <#include "top-articles.ftl"/>
    </div>

    <div class="right">
        <div class="content">
            <div class="title">
                <span>${title}</span>
            </div>

            <form id="music-form" class="form-horizontal" action="${ctx}/music/upload" method="post" enctype="multipart/form-data">
                <div class="space-20"></div>
                <div class="row form-group">
                    <div class="col-xs-3 control-label">
                        <label class="required">所属栏目</label>
                    </div>
                    <div class="col-xs-7 controls">
                        <select name="categoryCode" class="form-control">
                            <option value="">-- 选择栏目 --</option>
                            <#list categories as category>
                                <option value="${category.code}">${category.name}</option>
                            </#list>
                        </select>
                    </div>
                </div>
                <div class="row form-group">
                    <div class="col-xs-3 control-label">
                        <label class="required">上传者</label>
                    </div>
                    <div class="col-xs-7 controls">
                        <input class="form-control" name="uploadUsername" placeholder="上传者：最多16个字符"/>
                    </div>
                </div>
                <div class="row form-group">
                    <div class="col-xs-3 control-label">
                        <label class="required">上传备注</label>
                    </div>
                    <div class="col-xs-7 controls">
                        <input class="form-control" name="uploadRemark" placeholder="上传备注：最多256个字符"/>
                    </div>
                </div>

                <div class="form-group">
                    <div class="col-xs-3 control-label">
                        <label class="required">上传音乐</label>
                    </div>
                    <div class="col-xs-7">
                        <input type="file" id="file" name="file"/>
                        <div>请上传 MP3 格式的音乐，文件大小不能超过20MB。</div>
                    </div>
                </div>

                <div class="col-xs-6 col-xs-offset-3">
                    <div class="space-10"></div>
                    <button id="submit" class="btn btn-danger" data-loading-text="正在<@s.message "app.button.save"/>...">
                        提 交
                    </button>
                </div>
            </form>

            <div class="space-10"></div>
        </div>
    </div>

    <div class="space-10"></div>
</div>
</@override>

<@override name="script">
<script src="${ctx}/static/ace/dist/js/bootstrap.min.js"></script>
<script src="${ctx}/static/ace/dist/js/ace-extra.min.js"></script>
<script src="${ctx}/static/ace/dist/js/ace-elements.min.js"></script>
<script src="${ctx}/static/ace/dist/js/jquery.gritter.min.js"></script>
<script src="${ctx}/static/ace/dist/js/ace.min.js"></script>
<script src="${ctx}/static/libs/jquery/jquery.form.min.js"></script>
<script src="${ctx}/static/libs/jquery/jquery.validate.min.js"></script>
<script src="${ctx}/static/libs/jquery/jquery.validate.extends.js"></script>
<script src="${ctx}/static/ace/dist/js/prettify.min.js"></script>
<script src="${ctx}/static/app/js/web/music/upload.js"></script>
</@override>

<@extends name="../layout.ftl"/>