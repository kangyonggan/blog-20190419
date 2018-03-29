<#assign ctx="${(rca.contextPath)!''}">
<#assign modal_title="${photo.id???string('编辑', '添加新')}相册" />

<@override name="modal-body">
<form class="form-horizontal" role="form" id="modal-form" method="post" enctype="multipart/form-data"
      action="${ctx}/dashboard/manage/photo/${photo.id???string('update', 'save')}">
    <div class="row">
        <#if photo.id??>
            <input type="hidden" name="id" value="${photo.id}"/>
        </#if>
        <div class="row form-group">
            <div class="col-md-3 control-label">
                <label class="required">相册标题</label>
            </div>
            <div class="col-md-7 controls">
                <input class="form-control" name="title" value="${photo.title!''}" placeholder="相册标题：最多64个字符"/>
            </div>
        </div>
        <div class="row form-group">
            <div class="col-md-3 control-label">
                <label>相册封面</label>
            </div>
            <div class="col-md-7 controls">
                <input type="file" id="file" name="file"/>
                <div>请上传 png、gif、jpg 格式的图片文件，文件大小不能超过10MB。建议上传一张 320*240 像素或等比例的图片。</div>
            </div>
        </div>
    </div>
</form>
</@override>

<@override name="modal-footer">

    <@c.modal_form_tool/>

<script src="${ctx}/static/app/js/dashboard/manage/photo/form-modal.js"></script>
</@override>

<@extends name="../../modal-layout.ftl"/>