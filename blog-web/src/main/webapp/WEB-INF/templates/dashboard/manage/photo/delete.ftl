<#if photo.isDeleted == 1>
<a href="javascript:" data-category="photo-delete" title="恢复相册"
   data-url="${ctx}/dashboard/manage/photo/${photo.id}/undelete">
    <span class="label label-danger arrowed-in">已删除</span>
</a>
<#else>
<a href="javascript:" data-category="photo-delete" title="删除相册"
   data-url="${ctx}/dashboard/manage/photo/${photo.id}/delete">
    <span class="label label-success arrowed-in">未删除</span>
</a>
</#if>