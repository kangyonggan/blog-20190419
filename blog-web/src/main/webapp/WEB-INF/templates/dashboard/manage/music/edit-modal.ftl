<#assign ctx="${(rca.contextPath)!''}">
<#assign modal_title="编辑音乐" />

<@override name="modal-body">
<form class="form-horizontal" role="form" id="modal-form" method="post"
      action="${ctx}/dashboard/manage/music/update">
    <div class="row">
        <input type="hidden" name="id" value="${music.id}"/>
        <div class="row form-group">
            <div class="col-md-3 control-label">
                <label class="required">所属栏目</label>
            </div>
            <div class="col-md-7 controls">
                <select name="categoryCode" class="form-control">
                    <option value="">-- 选择栏目 --</option>
                    <#list categories as category>
                        <option value="${category.code}" <#if music.categoryCode==category.code>selected</#if>>${category.name}</option>
                    </#list>
                </select>
            </div>
        </div>
        <div class="row form-group">
            <div class="col-md-3 control-label">
                <label class="required">上传者</label>
            </div>
            <div class="col-md-7 controls">
                <input class="form-control" name="uploadUsername" value="${music.uploadUsername!''}" placeholder="上传者：最多16个字符"/>
            </div>
        </div>
        <div class="row form-group">
            <div class="col-md-3 control-label">
                <label class="required">上传备注</label>
            </div>
            <div class="col-md-7 controls">
                <input class="form-control" name="uploadRemark" value="${music.uploadRemark!''}" placeholder="上传备注：最多256个字符"/>
            </div>
        </div>
    </div>
</form>
</@override>

<@override name="modal-footer">

    <@c.modal_form_tool/>

<script src="${ctx}/static/app/js/dashboard/manage/music/edit-modal.js"></script>
</@override>

<@extends name="../../modal-layout.ftl"/>