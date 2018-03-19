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
    <link rel="stylesheet" href="${ctx}/static/app/css/unslider.css"/>
</head>
<body>

<div id="header">
    <div class="top">
        <a href="${ctx}/login">
            <div class="img"></div>
        </a>
        <form action="#" class="form">
            <input type="text" name="key" placeholder="搜索..."/>
        </form>
    </div>
    <img src="${ctx}/static/app/images/2018.jpg" class="bottom"/>
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
    <div id="top1">
        <!-- 把要轮播的地方写上来 -->
        <div class="banner" id="banner">
            <ul>
                <li><img src="${ctx}/static/app/images/01.jpg" alt="" width="519" height="280"></li>
                <li><img src="${ctx}/static/app/images/02.jpg" alt="" width="519" height="280"></li>
                <li><img src="${ctx}/static/app/images/03.jpg" alt="" width="519" height="280"></li>
                <li><img src="${ctx}/static/app/images/04.jpg" alt="" width="519" height="280"></li>
                <li><img src="${ctx}/static/app/images/05.jpg" alt="" width="519" height="280"></li>
            </ul>
            <a href="javascript:void(0);" class="unslider-arrow04 prev"><img class="arrow" id="al"
                                                                             src="${ctx}/static/app/images/arrowl.png"
                                                                             alt="prev" width="20" height="35"></a>
            <a href="javascript:void(0);" class="unslider-arrow04 next"><img class="arrow" id="ar"
                                                                             src="${ctx}/static/app/images/arrowr.png"
                                                                             alt="next" width="20" height="37"></a>
        </div>
        <div id="life-thing">生活动态</div>
    </div>
</div>

<div id="link">
    友情链接： <a href="#" target="_blank">相关重要链接</a> | <a href="#" target="_blank">其他链接</a> | <a href="#" target="_blank">使用手册</a>
</div>

<div id="footer">
    Copyright © 2018 未来 | 皖ICP备16017743号
</div>

<script src="${ctx}/static/ace/dist/js/jquery.min.js"></script>
<script src="${ctx}/static/libs/jquery/unslider.min.js"></script>
<script>
    var unslider04 = $('#banner').unslider({
                dots: true
            }),
            data04 = unslider04.data('unslider');

    $('.unslider-arrow04').click(function () {
        var fn = this.className.split(' ')[1];
        data04[fn]();
    });
</script>
</body>
</html>