<#assign ctx="${(rca.contextPath)!''}">

<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
    <meta charset="utf-8"/>
    <meta name="description" content=""/>
    <link rel="shortcut icon" href="${ctx}/static/app/images/favicon.ico" type="image/x-icon">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0"/>
    <link rel="stylesheet" href="${ctx}/static/app/css/app.css"/>
</head>
<body>

<div id="header">
    <div class="top">
        <a href="${ctx}/login"><div class="img"></div></a>
        <form action="#" class="form">
            <input type="text" name="key" placeholder="搜索..."/>
        </form>
    </div>
    <img src="${ctx}/static/app/images/005.png" class="bottom"/>
</div>

<div id="navbar">
    <ul>
        <li class="active"><a href="${ctx}/">首页</a></li>
        <li><a href="#">博文</a></li>
        <li><a href="#">工具</a></li>
        <li><a href="#">小说</a></li>
        <li><a href="#">音乐</a></li>
        <li><a href="#">生活</a></li>
        <li><a href="#">相册</a></li>
        <li><a href="#">关于我</a></li>
        <li><a href="#">留言板</a></li>
    </ul>
    <div class="breadcrumbs">
        您的当前位置：<a href="${ctx}/">首页</a> > <a href="#" class="active">新闻通告</a>
    </div>
</div>

<div id="main">
main
</div>

<div id="link">
    友情链接： <a href="#" target="_blank">相关重要链接</a> | <a href="#" target="_blank">其他链接</a> | <a href="#" target="_blank">使用手册</a>
</div>

<div id="footer">
</div>

</body>
</html>