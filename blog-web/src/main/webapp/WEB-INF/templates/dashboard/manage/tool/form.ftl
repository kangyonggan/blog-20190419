<#assign ctx="${(rca.contextPath)!''}">

<div class="page-header">
    <h1>
    ${tool.id???string('编辑', '添加')}工具
    </h1>
</div>

<div class="space-10"></div>

<div class="col-xs-12">
    <form id="tool-form" method="post" class="form-horizontal" enctype="multipart/form-data"
          action="${ctx}/dashboard/manage/tool/${tool.id???string('update', 'save')}">

    <#if tool.id??>
        <input type="hidden" name="id" value="${tool.id}"/>
    </#if>

        <div class="form-group">
            <label for="title" class="col-sm-3 control-label no-padding-right required">工具代码</label>
            <div class="col-xs-12 col-sm-5">
            <#if tool.id??>
                <@s.formInput "tool.code" 'class="form-control" readonly placeholder="请输入工具代码，最多32个字符"' />
            <#else>
                <@s.formInput "tool.code" 'class="form-control" placeholder="请输入工具代码，最多32个字符"' />
            </#if>
                <input type="hidden" id="old-code" value="${tool.code!''}"/>
            </div>
        </div>

        <div class="form-group">
            <label for="title" class="col-sm-3 control-label no-padding-right required">工具名称</label>
            <div class="col-xs-12 col-sm-5">
            <@s.formInput "tool.name" 'class="form-control" placeholder="请输入工具名称，最多32个字符"' />
            </div>
        </div>

        <div class="form-group" style="position: relative;">
            <label class="col-sm-3 control-label no-padding-right required">是否推荐</label>
            <div class="col-xs-12 col-sm-5">
                <select name="isTop" class="form-control">
                    <option value="0">不推荐</option>
                    <option value="1" <#if tool.id?? && tool.isTop==1>selected</#if>>推荐</option>
                </select>
            </div>
        </div>

        <div class="form-group">
            <label class="col-sm-3 control-label no-padding-right">上传图标</label>

            <div class="col-xs-12 col-sm-5">
                <input type="file" id="iconFile" name="iconFile" class="ace ace-file-input"/>
                <div>请上传 png、gif、jpg 格式的图片文件，文件大小不能超过10MB。建议上传一张 200*200 像素或等比例的图片。</div>
            </div>
        </div>

        <div class="clearfix form-actions">
            <div class="col-xs-10 align-center">
                <button class="btn btn-success" id="submit" data-toggle="form-submit"
                        data-loading-text="正在<@s.message "app.button.save"/>...">
                    <i class="ace-icon fa fa-check bigger-110"></i>
                <@s.message "app.button.save"/>
                </button>
            </div>
        </div>
    </form>
</div>

<script src="${ctx}/static/app/js/dashboard/manage/tool/form.js"></script>