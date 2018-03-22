<#if category.isDeleted == 1>
<a href="javascript:" data-category="category-delete" title="恢复栏目"
   data-url="${ctx}/dashboard/system/category/${category.code}/undelete">
    <span class="label label-danger arrowed-in">已删除</span>
</a>
<#else>
<a href="javascript:" data-category="category-delete" title="删除栏目"
   data-url="${ctx}/dashboard/system/category/${category.code}/delete">
    <span class="label label-success arrowed-in">未删除</span>
</a>
</#if>