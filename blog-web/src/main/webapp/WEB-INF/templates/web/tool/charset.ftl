<#assign data = RequestParameters.data!'' />
<#assign charset = RequestParameters.charset!'1' />

<div style="width: 600px;margin: 0 auto">
    <div class="form-group">
        <label class="required">待转码的字符串：</label>
        <div class="form-input">
            <textarea class="form-control" name="data" rows="5" placeholder="请输入需要转码的字符串">${data}</textarea>
        </div>
    </div>

    <div class="form-group">
        <label class="required">选择转码方式：</label>
        <div class="form-input">
            <select name="charset" class="form-control">
                <option value="1" <#if charset=='1'>selected</#if>>UTF-8 转 GBK</option>
                <option value="2" <#if charset=='2'>selected</#if>>UTF-8 转 IOS-8859-1</option>
                <option value="3" <#if charset=='3'>selected</#if>>GBK 转 UTF-8</option>
                <option value="4" <#if charset=='4'>selected</#if>>GBK 转 IOS-8859-1</option>
                <option value="5" <#if charset=='5'>selected</#if>>IOS-8859-1 转 UTF-8</option>
                <option value="6" <#if charset=='6'>selected</#if>>IOS-8859-1 转 GBK</option>
                <option value="7" <#if charset=='7'>selected</#if>>字符串 转 unicode</option>
                <option value="8" <#if charset=='8'>selected</#if>>unicode 转 字符串</option>
            </select>
        </div>
    </div>

<#include "submit.ftl"/>
</div>
