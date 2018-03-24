<#assign data = RequestParameters.data!'' />
<#assign size = RequestParameters.size!'200' />

<div style="width: 600px;margin: 0 auto">
    <div class="form-group">
        <label class="required">输入URL或其他文本：</label>
        <div class="form-input">
            <input class="form-control" name="data" placeholder="https://kangyonggan.com" value="${data}"/>
        </div>
    </div>

    <div class="form-group">
        <label class="required">选择二维码大小：</label>
        <div class="form-input">
            <select name="size" class="form-control">
            <#list 1..10 as i>
                <option value="${i * 100}" <#if size=='${i * 100}'>selected</#if>>${i * 100}*${i * 100}</option>
            </#list>
            </select>
        </div>
    </div>

<#include "submit.ftl"/>
</div>
