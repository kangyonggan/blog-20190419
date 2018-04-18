<#assign ctx="${(rca.contextPath)!''}">
<#assign key = RequestParameters.key!'' />
<#assign type = RequestParameters.type!'' />

<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
    <meta charset="utf-8"/>
    <title>${title!''}</title>
    <meta name="description" content="${description!'康永敢的博客'}"/>
    <meta name="keywords" content="${keywords!'康永敢,康永敢的博客'}">
    <link rel="shortcut icon" href="${ctx}/static/app/images/favicon.ico" type="image/x-icon">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0"/>
    <link rel="stylesheet" href="${ctx}/static/app/css/wap.css"/>
    <script src="${ctx}/static/ace/dist/js/jquery.min.js"></script>
<@block name="style"/>
</head>
<body>
<div class="search-panel">
    <form action="${ctx}/wap/search" method="get">
        <input type="text" name="key" placeholder="搜一搜..." value="${key}" required/>
        <select name="type">
            <option value="ARTICLE">文&nbsp;章</option>
            <option value="NOVEL" <#if type=="NOVEL">selected</#if>>小&nbsp;说</option>
            <option value="MUSIC" <#if type=="MUSIC">selected</#if>>音&nbsp;乐</option>
        </select>
    </form>
</div>

<div class="main-panel">
<@block name="main"/>
</div>

</body>
</html>