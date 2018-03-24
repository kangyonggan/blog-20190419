<#assign data = RequestParameters.data!'' />

<div style="width: 600px;margin: 0 auto">
    <div class="form-group">
        <label class="required">待查询的身份证：</label>
        <div class="form-input">
            <input class="form-control" name="data" placeholder="请输入身份证号码" value="${data}"/>
        </div>
    </div>

<#include "submit.ftl"/>
</div>
