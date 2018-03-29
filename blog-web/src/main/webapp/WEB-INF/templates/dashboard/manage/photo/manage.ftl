<#assign ctx="${(rca.contextPath)!''}">

<link rel="stylesheet" href=".${ctx}/static/ace/dist/css/dropzone.min.css"/>

<div class="space-10"></div>

<div class="col-xs-12">
    <div class="row">
        <div class="col-xs-12">
            <div>
                <form action="${ctx}/dashboard/manage/photo/upload" class="dropzone" id="photo-form">
                    <div class="fallback">
                        <input name="file" type="file" multiple=""/>
                        <input type="hidden" id="photoId" name="id" value="${photo.id}"/>
                    </div>
                    <#list attachments as attachment>
                        <div class="dz-preview dz-success dz-image-preview">
                            <div class="dz-details">
                                <div class="dz-size" data-dz-size="">${attachment.createdTime?date}</div>
                                <img alt="${attachment.originalFilename!''}" src="${ctx}/${attachment.url}">
                            </div>
                            <a class="dz-remove dz-remove-old" href="javascript:" data-file-id="${attachment.id}">删除文件</a>
                        </div>
                    </#list>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
    var attachmentsLen = '${attachments?size}';
    var photoId = '${photo.id}';
</script>
<script src="${ctx}/static/ace/dist/js/dropzone.min.js"></script>
<script src="${ctx}/static/app/js/dashboard/manage/photo/manage.js"></script>