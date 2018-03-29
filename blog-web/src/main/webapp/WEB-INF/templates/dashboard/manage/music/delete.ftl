<#if music.isDeleted == 1>
<a href="javascript:" data-category="music-delete" title="恢复音乐"
   data-url="${ctx}/dashboard/manage/music/${music.id}/undelete">
    <span class="label label-danger arrowed-in">已删除</span>
</a>
<#else>
<a href="javascript:" data-category="music-delete" title="删除音乐"
   data-url="${ctx}/dashboard/manage/music/${music.id}/delete">
    <span class="label label-success arrowed-in">未删除</span>
</a>
</#if>