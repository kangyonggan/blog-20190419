<#assign ctx="${(rca.contextPath)!''}">

<link rel="stylesheet" href="${ctx}/static/ace/dist/css/prettify.min.css"/>

<div class="page-header">
    <h1>
        留言详情
        <small class="pull-right">
        <#if guest.status=="WAITING">
            <!--待审核-->
            <a href="javascript:" data-role="guest-detail" title="审核通过"
               data-url="${ctx}/dashboard/manage/guest/${guest.id}/COMPLETE" class="btn btn-sm btn-success">审核通过</a>
            <a href="javascript:" data-role="guest-detail" title="审核不通过"
               data-url="${ctx}/dashboard/manage/guest/${guest.id}/REJECT" class="btn btn-sm btn-danger">拒绝</a>
        <#elseif guest.status=="REJECT">
            <!--拒绝-->
            <a href="javascript:" data-role="guest-detail" title="撤销审核"
               data-url="${ctx}/dashboard/manage/guest/${guest.id}/WAITING" class="btn btn-sm btn-inverse">撤销审核</a>
        <#elseif guest.status=="COMPLETE">
            <a href="javascript:" data-role="guest-detail" title="撤销审核"
               data-url="${ctx}/dashboard/manage/guest/${guest.id}/WAITING" class="btn btn-sm btn-danger">撤销审核</a>
            <#if guest.replyUsername == ''>
                <a href="${ctx}/dashboard/manage/guest/${guest.id}/reply" data-target="#myModal" data-toggle="modal"
                   class="btn btn-sm btn-success">回复</a>
            </#if>
        </#if>
        </small>
    </h1>
</div>

<div class="row">
    <div class="col-sm-10 col-sm-offset-1">
        <div class="widget-box transparent">
            <div class="widget-header widget-header-large">
                <h5 class="widget-title grey lighter">
                    <i class="ace-icon fa fa-leaf pink"></i>
                ${guest.content}
                </h5>

                <div class="widget-toolbar no-border invoice-info">
                    <span class="invoice-info-label">昵称:</span>
                    <span class="red">${guest.realname}</span>

                    <br/>
                    <span class="invoice-info-label">邮箱:</span>
                    <span class="blue">${guest.email}</span>
                </div>

                <div class="widget-toolbar hidden-480">
                    <a href="#"></a>
                </div>
            </div>

            <div class="widget-body">
                <div class="widget-main padding-24">

                    <div class="space-10"></div>

                    <h5><i class="ace-icon fa fa-comments-o icon-only pink"></i>站长回复</h5>

                    <div class="markdown">
                    <#if guest.replyMessage == ''>
                        <div class="align-center">
                            <h5 class="red">未回复</h5>
                        </div>
                    <#else>
                    ${guest.replyMessage}
                    </#if>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="${ctx}/static/ace/dist/js/prettify.min.js"></script>
<script src="${ctx}/static/app/js/dashboard/manage/guest/detail.js"></script>