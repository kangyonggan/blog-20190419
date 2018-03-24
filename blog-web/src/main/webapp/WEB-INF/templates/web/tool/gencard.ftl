<#assign prov = RequestParameters.prov!'' />
<#assign startAge = RequestParameters.startAge!'1' />
<#assign endAge = RequestParameters.endAge!'100' />
<#assign sex = RequestParameters.sex!'' />
<#assign len = RequestParameters.len!'18' />
<#assign count = RequestParameters.count!'10' />

<div style="width: 600px;margin: 0 auto">
    <div class="form-group">
        <label class="required">选择省份：</label>
        <div class="form-input">
            <select name="prov" class="form-control">
                <option value="">-- 随机 --</option>
            <#list cityCodes?keys as key>
                <option value="${key}" <#if key==prov>selected</#if>>${cityCodes["${key}"]}</option>
            </#list>
            </select>
        </div>
    </div>
    <div class="form-group">
        <label class="required">起始年龄：</label>
        <div class="form-input">
            <input type="number" class="form-control" name="startAge" value="${startAge}"/>
        </div>
    </div>
    <div class="form-group">
        <label class="required">截止年龄：</label>
        <div class="form-input">
            <input type="number" class="form-control" name="endAge" value="${endAge}"/>
        </div>
    </div>
    <div class="form-group">
        <label class="required">性别：</label>
        <div class="form-input">
            <select name="sex" class="form-control">
                <option value="-1">随机</option>
                <option value="0" <#if sex=="0">selected</#if>>男</option>
                <option value="1" <#if sex=="1">selected</#if>>女</option>
            </select>
        </div>
    </div>
    <div class="form-group">
        <label class="required">身份证位数：</label>
        <div class="form-input">
            <select name="len" class="form-control">
                <option value="-1">随机</option>
                <option value="15" <#if len=="15">selected</#if>>15位</option>
                <option value="18" <#if len=="18">selected</#if>>18位</option>
            </select>
        </div>
    </div>
    <div class="form-group">
        <label class="required">生成数量（1~100）：</label>
        <div class="form-input">
            <input type="number" class="form-control" name="count" placeholder="生成数量" value="${count}"/>
        </div>
    </div>

<#include "submit.ftl"/>
</div>
