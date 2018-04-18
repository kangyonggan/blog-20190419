<#assign title='康永敢的博客'/>
<#assign noBack='true'/>

<@override name="main">
    <div class="item-list">
        <div class="item">
            <a href="${ctx}/wap/article">
                <img src="${ctx}/static/app/images/article.png"/>
                <p>文章</p>
            </a>
        </div>
        <div class="item">
            <a href="${ctx}/wap/tool">
                <img src="${ctx}/static/app/images/tool.png"/>
                <p>工具</p>
            </a>
        </div>
        <div class="item">
            <a href="${ctx}/wap/novel">
                <img src="${ctx}/static/app/images/novel.png"/>
                <p>小说</p>
            </a>
        </div>
        <div class="item">
            <a href="${ctx}/wap/music">
                <img src="${ctx}/static/app/images/music.png"/>
                <p>音乐</p>
            </a>
        </div>
        <div class="item">
            <a href="${ctx}/wap/life">
                <img src="${ctx}/static/app/images/life.png"/>
                <p>生活</p>
            </a>
        </div>
        <div class="item">
            <a href="${ctx}/wap/photo">
                <img src="${ctx}/static/app/images/photo.png"/>
                <p>相册</p>
            </a>
        </div>
        <div class="item">
            <a href="${ctx}/wap/guest">
                <img src="${ctx}/static/app/images/guest.png"/>
                <p>留言板</p>
            </a>
        </div>
        <div class="item">
            <a href="${ctx}/wap/about">
                <img src="${ctx}/static/app/images/about.png"/>
                <p>关于我</p>
            </a>
        </div>
        <div class="item">
            <a href="${ctx}/dashboard">
                <img src="${ctx}/static/app/images/dashboard.png"/>
                <p>工作台</p>
            </a>
        </div>
    </div>
</@override>

<@extends name="layout.ftl"/>