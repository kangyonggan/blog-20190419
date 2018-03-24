<#assign data = RequestParameters.data!'' />
<#assign dialect = RequestParameters.dialect!'MySQL' />

<div style="width: 600px;margin: 0 auto">
    <div class="form-group">
        <label class="required">待格式化的SQL：</label>
        <div class="form-input">
            <textarea class="form-control" name="data" rows="5" placeholder="请输入需要格式化的SQL">${data}</textarea>
        </div>
    </div>

    <div class="form-group">
        <label class="required">选择数据库方言：</label>
        <div class="form-input">
            <select name="dialect" class="form-control">
                <#list dialects as d>
                    <option value="${d.getDialect()}" <#if dialect=='${d.getDialect()}'>selected</#if>>${d.getDialect()}</option>
                </#list>
            </select>
        </div>
    </div>

<#include "submit.ftl"/>
</div>
