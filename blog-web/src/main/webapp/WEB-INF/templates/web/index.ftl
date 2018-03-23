<#assign title="首页"/>
<#assign active_index="active"/>

<@override name="style">
<link rel="stylesheet" href="${ctx}/static/app/css/unslider.css"/>
</@override>

<@override name="breadcrumbs">
<a href="javascript:" class="active">首页</a>
</@override>

<@override name="main">
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
            <a href="javascript:void(0);" class="unslider-arrow04 prev">
                <img class="arrow" id="al" src="${ctx}/static/app/images/arrowl.png" alt="prev" width="20" height="35">
            </a>
            <a href="javascript:void(0);" class="unslider-arrow04 next">
                <img class="arrow" id="ar" src="${ctx}/static/app/images/arrowr.png" alt="next" width="20" height="37">
            </a>
        </div>
        <div id="life-thing">
            <div class="head-name">
                <div>生活动态</div>
                <a href="#">+ 更多</a>
            </div>
            <div class="space-10"></div>
            <div class="title">今天上班路上看到两个电瓶车追尾了</div>
            <div class="desc">2018年11月5-10日，首届中国国际进口博览会将在上海国家会展中心举行。闵行区毗邻国家会展中心，城市保障任务艰巨，为抓好各项组织筹备和服务保障工作...</div>

            <div class="list">
                <ul>
                    <li><a href="#">今天上班路上看到两个电瓶车追尾了<span>[2018-03-12]</span></a></li>
                    <li><a href="#">今天上班路上看到两个电瓶车追尾了<span>[2018-03-12]</span></a></li>
                    <li><a href="#">今天上班路上看到两个电瓶车追尾了<span>[2018-03-12]</span></a></li>
                    <li><a href="#">今天上班路上看到两个电瓶车追尾了<span>[2018-03-12]</span></a></li>
                </ul>
            </div>
        </div>
    </div>

    <div class="panel">
        <div class="toolbar">
            <div class="title">文章</div>
            <a href="${ctx}/article" class="more"><span class="icon">+</span>更多</a>
        </div>

        <div class="list">
            <ul>
                <#if articles?size gt 0>
                    <#list articles as article>
                        <li>
                            <a href="${ctx}/article/${article.id}">
                                <span class="nowrap">${article.title}</span>
                                <div>[${article.createdTime?date}]</div>
                            </a>
                        </li>
                    </#list>
                <#else>
                    <div class="empty">
                        没有文章
                    </div>
                </#if>
            </ul>
        </div>
    </div>

    <div class="panel">
        <div class="toolbar">
            <div class="title">常用工具</div>
            <a href="${ctx}/tool" class="more"><span class="icon">+</span>更多</a>
        </div>

        <div class="list">
            <ul>
                <#if tools?size gt 0>
                    <#list tools as tool>
                        <li>
                            <a href="${ctx}/tool/${tool.code}">${tool.name}<span>[${tool.createdTime?date}]</span></a>
                        </li>
                    </#list>
                <#else>
                    <div class="empty">
                        没有工具
                    </div>
                </#if>
            </ul>
        </div>
    </div>

    <div class="space-20"></div>

    <div class="novel">
        <div class="head">
            热门小说
        </div>
        <div class="category">
            <ul>
                <li class="first"><a href="#">小说分类</a></li>
                <li class="active"><a href="#">玄幻</a></li>
                <li><a href="#">都市</a></li>
                <li><a href="#">修真</a></li>
                <li><a href="#">历史</a></li>
                <li><a href="#">言情</a></li>
                <li><a href="#">网游</a></li>
                <li><a href="#">科幻</a></li>
                <li><a href="#">其他</a></li>
            </ul>
            <a href="#" class="more"><span class="icon">+</span>更多</a>
        </div>
        <div class="book-list">
            <a href="#">
                <dl>
                    <dd>
                        <img src="${ctx}/static/app/images/111s.jpg">
                    </dd>
                    <dt>武炼巅峰</dt>
                </dl>
            </a>
            <a href="#">
                <dl>
                    <dd>
                        <img src="${ctx}/static/app/images/111s.jpg">
                    </dd>
                    <dt>武炼巅峰</dt>
                </dl>
            </a>
            <a href="#">
                <dl>
                    <dd>
                        <img src="${ctx}/static/app/images/111s.jpg">
                    </dd>
                    <dt>武炼巅峰</dt>
                </dl>
            </a>
            <a href="#">
                <dl>
                    <dd>
                        <img src="${ctx}/static/app/images/111s.jpg">
                    </dd>
                    <dt>武炼巅峰</dt>
                </dl>
            </a>
            <a href="#">
                <dl>
                    <dd>
                        <img src="${ctx}/static/app/images/111s.jpg">
                    </dd>
                    <dt>武炼巅峰</dt>
                </dl>
            </a>
            <a href="#">
                <dl>
                    <dd>
                        <img src="${ctx}/static/app/images/111s.jpg">
                    </dd>
                    <dt>武炼巅峰</dt>
                </dl>
            </a>
        </div>
    </div>
</div>

<div id="link">
    友情链接： <a href="#" target="_blank">相关重要链接</a> | <a href="#" target="_blank">其他链接</a> | <a href="#" target="_blank">使用手册</a>
</div>
</@override>

<@override name="script">
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
</@override>

<@extends name="layout.ftl"/>