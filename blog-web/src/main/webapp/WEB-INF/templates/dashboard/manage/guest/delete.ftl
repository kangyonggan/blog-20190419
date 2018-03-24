<#if guest.isDeleted == 1>
<a href="javascript:" data-role="guest-tr" title="恢复留言"
   data-url="${ctx}/dashboard/manage/guest/${guest.id}/undelete">
    <span class="label label-danger arrowed-in">已删除</span>
</a>
<#else>
<a href="javascript:" data-role="guest-tr" title="删除留言"
   data-url="${ctx}/dashboard/manage/guest/${guest.id}/delete">
    <span class="label label-success arrowed-in">未删除</span>
</a>
</#if>