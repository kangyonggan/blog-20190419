<#assign modal_title="${category.code???string('编辑栏目', '添加新栏目')}" />

<@override name="modal-body">
<form class="form-horizontal" category="form" id="modal-form" method="post"
      action="${ctx}/dashboard/system/category/${category.code???string('update', 'save')}">

    <#if category.id??>
        <input type="hidden" name="id" value="${category.id}"/>
    </#if>

    <div class="row">
        <div class="row form-group">
            <div class="col-md-3 control-label">
                <label>栏目类型<span class="red">*</span></label>
            </div>
            <div class="col-md-7 controls">
                <select name="type" class="form-control">
                    <#list types as t>
                        <option value="${t.getType()}"
                                <#if category.code?? && category.type=='${t.getType()}'>selected</#if>>${t.getName()}</option>
                    </#list>
                </select>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="row form-group">
            <div class="col-md-3 control-label">
                <label>栏目代码<span class="red">*</span></label>
            </div>
            <div class="col-md-7 controls">
                <@s.formInput "category.code" 'class="form-control" placeholder="请输入栏目代码"'/>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="row form-group">
            <div class="col-md-3 control-label">
                <label>栏目名称<span class="red">*</span></label>
            </div>
            <div class="col-md-7 controls">
                <@s.formInput "category.name" 'class="form-control" placeholder="请输入栏目名称"'/>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="row form-group">
            <div class="col-md-3 control-label">
                <label for="sort">排序<span class="red">*</span></label>
            </div>

            <div class="col-md-7 controls">
                <@s.formInput "category.sort" 'class="form-control" placeholder="0排在最上面"'/>
            </div>
        </div>
    </div>
</@override>

<@override name="modal-footer">
    <@c.modal_form_tool/>

    <script src="${ctx}/static/app/js/dashboard/system/category/form-modal.js"></script>
</@override>

<@extends name="../../modal-layout.ftl"/>