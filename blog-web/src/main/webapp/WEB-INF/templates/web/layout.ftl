<#assign ctx="${(rca.contextPath)!''}">

<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
    <meta charset="utf-8"/>
    <title>${title!''}</title>
    <meta name="description" content=""/>
    <link rel="shortcut icon" href="${ctx}/static/app/images/favicon.ico" type="image/x-icon">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0"/>
    <link rel="stylesheet" href="${ctx}/static/app/css/app.css"/>
<@block name="style"/>
</head>
<body>

<div id="header">
    <div class="top">
        <a href="${ctx}/dashboard">
            <div class="img">
                <span>工作台</span>
            </div>
        </a>
        <form action="#" class="form">
            <input type="text" name="key" placeholder="搜索..."/>
        </form>
    </div>
    <img src="${ctx}/static/app/images/2018.jpg" class="bottom"/>
</div>

<div id="navbar">
    <ul>
        <li class="${active_index!''}"><a href="${ctx}/">首页</a></li>
        <li class="${active_article!''}"><a href="${ctx}/article">文章</a></li>
        <li class="${active_tool!''}"><a href="${ctx}/tool">工具</a></li>
        <li class="${active_novel!''}"><a href="${ctx}/novel">小说</a></li>
        <li class="${active_music!''}"><a href="#">音乐</a></li>
        <li class="${active_life!''}"><a href="#">生活</a></li>
        <li class="${active_photo!''}"><a href="#">相册</a></li>
        <li class="${active_about!''}"><a href="#">关于我</a></li>
        <li class="${active_guest!''}"><a href="${ctx}/guest">留言板</a></li>
    </ul>
    <div class="breadcrumbs">
        您的当前位置：<@block name="breadcrumbs"/>
    </div>
</div>

<@block name="main"/>

<div class="space-20"></div>

<div id="footer">
    Copyright © 2018 未来 | 皖ICP备16017743号
</div>

<script src="${ctx}/static/ace/dist/js/jquery.min.js"></script>
<@block name="script"/>
</body>
</html>