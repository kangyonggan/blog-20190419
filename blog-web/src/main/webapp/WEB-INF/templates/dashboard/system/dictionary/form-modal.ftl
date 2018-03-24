<#assign modal_title="${dictionary.id???string('编辑字典', '添加新字典')}" />

<@override name="modal-body">
<form class="form-horizontal" role="form" id="modal-form" method="post"
      action="${ctx}/dashboard/system/dictionary/${dictionary.id???string('update', 'save')}">
    <div class="row">
        <div class="row form-group">
            <div class="col-md-3 control-label">
                <label class="required">字典类型</label>
            </div>
            <div class="col-md-7 controls">
                <select name="type" class="form-control">
                    <#list types as t>
                        <option value="${t.getType()}"
                                <#if dictionary.id?? && dictionary.type=='${t.getType()}'>selected</#if>>${t.getName()}</option>
                    </#list>
                </select>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="row form-group">
            <div class="col-md-3 control-label">
                <label class="required">字典代码</label>
            </div>
            <div class="col-md-7 controls">
                <@s.formInput "dictionary.code" 'class="form-control" placeholder="1至32位以字母开头的小写字母和数字的组合"'/>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="row form-group">
            <div class="col-md-3 control-label">
                <label class="required">字典的值</label>
            </div>
            <div class="col-md-7 controls">
                <@s.formInput "dictionary.value" 'class="form-control" placeholder="1至64个字符"'/>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="row form-group">
            <div class="col-md-3 control-label">
                <label class="required">排序</label>
            </div>

            <div class="col-md-7 controls">
                <@s.formInput "dictionary.sort" 'class="form-control" placeholder="0排在最上面"'/>
            </div>
        </div>
    </div>
</form>
</@override>

<@override name="modal-footer">
    <@c.modal_form_tool/>

<script src="${ctx}/static/app/js/dashboard/system/dictionary/form-modal.js"></script>
</@override>

<@extends name="../../modal-layout.ftl"/>