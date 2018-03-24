<#assign lunar = RequestParameters.lunar!'0' />
<#assign year = RequestParameters.year!'' />
<#assign month = RequestParameters.month!'' />
<#assign day = RequestParameters.day!'' />
<#assign hour = RequestParameters.hour!'' />

<div style="width: 600px;margin: 0 auto">
    <div class="form-group">
        <label class="required">阴/阳历：</label>
        <div class="form-input">
            <select name="lunar" class="form-control">
                <option value="0" <#if lunar=='0'>selected</#if>>阴历（小的那个）</option>
                <option value="1" <#if lunar=='1'>selected</#if>>阳历（大的那个）</option>
            </select>
        </div>
    </div>
    <div class="form-group">
        <label class="required">出身年份（1900~2049）：</label>
        <div class="form-input">
            <input type="number" class="form-control" name="year" value="${year}" placeholder="例如：1992"/>
        </div>
    </div>
    <div class="form-group">
        <label class="required">出生月份（1~12）：</label>
        <div class="form-input">
            <input type="number" class="form-control" name="month" value="${month}" placeholder="例如：3"/>
        </div>
    </div>
    <div class="form-group">
        <label class="required">出生日期（1~31）：</label>
        <div class="form-input">
            <input type="number" class="form-control" name="day" value="${day}" placeholder="例如：17"/>
        </div>
    </div>
    <div class="form-group">
        <label class="required">出生时辰（0~23）：</label>
        <div class="form-input">
            <input type="number" class="form-control" name="hour" value="${hour}" placeholder="例如：17"/>
        </div>
    </div>

<#include "submit.ftl"/>
</div>
