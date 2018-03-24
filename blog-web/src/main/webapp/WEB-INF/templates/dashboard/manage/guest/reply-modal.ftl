<#assign ctx="${(rca.contextPath)!''}">
<#assign modal_title="回复留言" />

<@override name="modal-body">
<form class="form-horizontal" role="form" id="modal-form" method="post"
      action="${ctx}/dashboard/manage/guest/${id}/reply">
    <div class="row">
        <div class="row form-group">
            <div class="col-md-offset-1 col-md-10 col-md-offset-1">
                <textarea class="form-control limited" id="replyMessage" placeholder="支持markdown语法" name="replyMessage" maxlength="20480" style="height:200px;"></textarea>
            </div>
        </div>
    </div>
</form>
</@override>

<@override name="modal-footer">

    <@c.modal_form_tool/>

<script>
    var guestId = '${id}';
</script>
<script src="${ctx}/static/libs/jquery/jquery.inputlimiter.min.js"></script>
<script src="${ctx}/static/app/js/dashboard/manage/guest/reply-modal.js"></script>
</@override>

<@extends name="../../modal-layout.ftl"/>