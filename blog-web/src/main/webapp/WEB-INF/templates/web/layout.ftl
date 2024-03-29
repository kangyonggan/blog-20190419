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
    <link rel="stylesheet" href="${ctx}/static/app/css/app.css"/>
    <script src="${ctx}/static/ace/dist/js/jquery.min.js"></script>
<@block name="style"/>
</head>
<body>
<div class="mobile-hidden">
    <div id="header">
        <div class="top">
            <a href="${ctx}/dashboard">
                <div class="img">
                    <span>工作台</span>
                </div>
            </a>
            <form action="${ctx}/search" class="form" method="get">
                <input type="text" name="key" placeholder="搜一搜..." value="${key}" required/>
                <select name="type">
                    <option value="ARTICLE">文章</option>
                    <option value="NOVEL" <#if type=="NOVEL">selected</#if>>小说</option>
                    <option value="MUSIC" <#if type=="MUSIC">selected</#if>>音乐</option>
                </select>
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
            <li class="${active_music!''}"><a href="${ctx}/music">音乐</a></li>
            <li class="${active_life!''}"><a href="${ctx}/life">生活</a></li>
            <li class="${active_photo!''}"><a href="${ctx}/photo">相册</a></li>
            <li class="${active_about!''}"><a href="${ctx}/about">关于我</a></li>
            <li class="${active_guest!''}"><a href="${ctx}/guest">留言板</a></li>
        </ul>
        <div class="breadcrumbs">
            您的当前位置：<@block name="breadcrumbs"/>
        </div>
    </div>

<@block name="main"/>
    <div class="warn-mobile hidden wap-adj">
        <h3>小屏幕请使用<a href="${ctx}/wap">手机版</a>网站。</h3>
        <script>
            var disp = $(".wap-adj").css("display");
            if (disp != "none") {
                window.location.href = '${ctx}/wap';
            }
        </script>
    </div>

    <div class="space-20"></div>

    <div id="footer">
        Copyright © 2018 <@s.message "app.name"/> | <@s.message "app.ba.no"/> <a href="${ctx}/rss/blog.xml"
                                                                                 target="_blank">RSS订阅</a>
    </div>

    <div class="ad" style="display: none">
        <div class="content">
            <ul>
                <li>1. 个人博客</li>
                <li>2. 个人门户网站</li>
                <li>3. 企业门户网站</li>
                <li>4. 你的其他想法</li>
            </ul>

            <div class="btm">
                一条龙服务，私我！
            </div>
        </div>
        <div class="ad-btn">
            接私活
        </div>
    </div>

    <a href="javascript:scrollTo(0, 0)" id="to-top">回到顶部<span class="icon"></span></a>


<#--百度分享-->
    <script>
        var pic = "https://kangyonggan.com/static/app/images/600.png";
        if ($("img").length > 2) {
            pic = "https://kangyonggan.com/" + $($("img")[2]).attr("src");
        }

        window._bd_share_config = {
            "common": {
                "bdSnsKey": {},
                "bdText": document.title,
                "bdUrl": window.location.href,
                "bdDesc": $("meta[name='description']").attr("content"),
                "bdMini": "2",
                "bdMiniList": false,
                "bdPic": pic,
                "bdStyle": "0",
                "bdSize": "16"
            }, "slide": {"type": "slide", "bdImg": "0", "bdPos": "left", "bdTop": "154"}
        };
        with (document) 0[(getElementsByTagName('head')[0] || body).appendChild(createElement('script')).src = '${ctx}/static/api/js/share.js?v=89860593.js?cdnversion=' + ~(-new Date() / 36e5)];
    </script>

    <script>
        var adOffset = "-142px";
        $(".ad").mouseenter(function () {
            $(this).css("left", "0");
        })
        $(".ad").mouseleave(function () {
            $(this).css("left", adOffset);
        })
        // 有滚动条时才显示回到顶部按钮
        window.onscroll = function () {
            if (document.documentElement.scrollTop + document.body.scrollTop > 300) {
                document.getElementById("to-top").style.display = "block";
            } else {
                document.getElementById("to-top").style.display = "none";
            }
        };
    </script>
<@block name="script"/>
</div>
</body>
</html>