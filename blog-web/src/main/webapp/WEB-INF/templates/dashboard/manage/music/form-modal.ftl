<#assign ctx="${(rca.contextPath)!''}">
<#assign modal_title="添加音乐" />

<@override name="modal-body">
<form class="form-horizontal" role="form" id="modal-form" method="post"
      action="${ctx}/dashboard/manage/music/save">
    <div class="row">
        <div class="row form-group">
            <div class="col-md-3 control-label">
                <label class="required">所属栏目</label>
            </div>
            <div class="col-md-7 controls">
                <select name="categoryCode" class="form-control">
                    <option value="">-- 选择栏目 --</option>
                    <#list categories as category>
                        <option value="${category.code}">${category.name}</option>
                    </#list>
                </select>
            </div>
        </div>
        <div class="row form-group">
            <div class="col-md-3 control-label">
                <label class="required">上传备注</label>
            </div>
            <div class="col-md-7 controls">
                <input class="form-control" name="uploadRemark" placeholder="上传备注：最多256个字符"/>
            </div>
        </div>
        <div class="row form-group">
            <div class="col-md-3 control-label">
                <label class="required">上传MP3</label>
            </div>
            <div class="col-md-7 controls">
                <input type="file" id="file" name="file"/>
                <div>请上传 MP3 格式的音乐，文件大小不能超过20MB。</div>
            </div>
        </div>
    </div>
</form>
</@override>

<@override name="modal-footer">

    <@c.modal_form_tool/>

<script src="${ctx}/static/app/js/dashboard/manage/music/form-modal.js"></script>
</@override>

<@extends name="../../modal-layout.ftl"/>