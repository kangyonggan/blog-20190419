<#assign data = RequestParameters.data!'' />

<div style="width: 600px;margin: 0 auto">
    <div class="form-group">
        <label class="required">待压缩的CSS：</label>
        <div class="form-input">
            <textarea class="form-control" name="data" rows="5" placeholder="请输入需要压缩的CSS">${data}</textarea>
        </div>
    </div>

<#include "submit.ftl"/>
</div>
