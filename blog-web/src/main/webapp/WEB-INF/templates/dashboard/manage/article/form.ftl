<#assign ctx="${(rca.contextPath)!''}">

<link rel="stylesheet" href="${ctx}/static/libs/bootstrap/css/bootstrap-markdown.min.css"/>

<div class="col-xs-12">
    <form id="article-form" method="post" class="form-horizontal" enctype="multipart/form-data"
          action="${ctx}/dashboard/manage/article/${article.id???string('update', 'save')}">

    <#if article.id??>
        <input type="hidden" name="id" value="${article.id}"/>
    </#if>

        <div class="form-group">
            <label for="title" class="col-sm-3 control-label no-padding-right required">文章标题</label>
            <div class="col-xs-12 col-sm-5">
            <@s.formInput "article.title" 'class="form-control" placeholder="请输入文章标题，最多64个字符"' />
            </div>
        </div>

        <div class="form-group">
            <label for="summary" class="col-sm-3 control-label no-padding-right required">文章摘要</label>
            <div class="col-xs-12 col-sm-5">
            <@s.formInput "article.summary" 'class="form-control" placeholder="请输入文章摘要，最多64个字符"' />
            </div>
        </div>

        <div class="form-group" style="position: relative;">
            <label class="col-sm-3 control-label no-padding-right required">所属栏目</label>
            <div class="col-xs-12 col-sm-5">
                <select name="categoryCode" class="form-control">
                <#list categories as category>
                    <option value="${category.code}"
                            <#if article.id?? && article.categoryCode=='${category.code}'>selected</#if>>${category.name}</option>
                </#list>
                </select>
            </div>
        </div>

        <div class="form-group">
            <label for="content" class="col-sm-1 control-label no-padding-right required">内容</label>
            <div class="col-xs-12 col-sm-9">
            <@s.formTextarea "article.content" 'style="width:100%;height:400px;"' />
            </div>
        </div>

            <div class="form-group">
                <div class="col-xs-12">
                    <label class="col-sm-3 control-label no-padding-right">附件</label>
                    <div class="col-xs-12 col-sm-5">
                        <input multiple="" type="file" id="files" name="files" />
                    </div>
                </div>
            </div>

        <div class="clearfix form-actions">
            <div class="col-xs-10 align-center">
                <button class="btn btn-success" id="submit" data-toggle="form-submit"
                        data-loading-text="正在<@s.message "app.button.save"/>...">
                    <i class="ace-icon fa fa-check bigger-110"></i>
                <@s.message "app.button.save"/>
                </button>
            </div>
        </div>
    </form>
</div>

<script type="text/javascript" src="${ctx}/static/libs/bootstrap/js/marked.min.js"></script>
<script type="text/javascript" src="${ctx}/static/libs/bootstrap/js/bootstrap-markdown.min.js"></script>
<script src="${ctx}/static/app/js/dashboard/manage/article/form.js"></script>