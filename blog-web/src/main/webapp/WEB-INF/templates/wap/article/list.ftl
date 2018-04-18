<#assign title='文章'/>
<#assign categoryCode = RequestParameters.categoryCode!'' />

<@override name="main">
<form class="filter-form" action="${ctx}/wap/article" method="get">
    <input type="hidden" name="categoryCode" value="${categoryCode!''}">
    <div class="down">全部栏目</div>
    <div class="sort">发布时间</div>
</form>
</@override>

<@extends name="../layout.ftl"/>