<#assign ctx="${(rca.contextPath)!''}">

<div class="space-30"></div>

<div class="text-center">
    <h3>服务器内部错误（500），请联系<a href="${ctx}/about">管理员</a>！</h3>
</div>

<script>
    $('.breadcrumb li').eq(1).remove();
</script>