<#assign data = RequestParameters.data!'' />
<#assign size = RequestParameters.size!'200' />

<div class="form-group">
    <label class="required">上传二维码：</label>
    <div class="form-input">
        <input type="file" id="file" name="file" class="ace ace-file-input"/>
        <div>请上传 png、gif、jpg 格式的图片文件，文件大小不能超过10MB。</div>
    </div>
</div>

