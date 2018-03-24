<#assign data = RequestParameters.data!'' />
<#assign size = RequestParameters.size!'200' />
<div style="width: 600px;margin: 0 auto">
    <div class="form-group">
        <label class="required">待格式化的XML：</label>
        <div class="form-input">
            <textarea class="form-control" name="data" rows="5" placeholder="请输入需要格式化的xml">${data}</textarea>
        </div>
    </div>

<#include "submit.ftl"/>
</div>
