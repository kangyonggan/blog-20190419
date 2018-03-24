<#assign title="留言板"/>
<#assign active_guest="active"/>

<@override name="style">
<link rel="stylesheet" href="${ctx}/static/ace/dist/css/prettify.min.css"/>
<link rel="stylesheet" href="${ctx}/static/ace/dist/css/jquery.gritter.min.css"/>
<link rel="stylesheet" href="${ctx}/static/ace/dist/css/bootstrap.min.css"/>
<link rel="stylesheet" href="${ctx}/static/ace/dist/css/font-awesome.min.css"/>
<link rel="stylesheet" href="${ctx}/static/ace/dist/css/ace.min.css" class="ace-main-stylesheet"
      id="main-ace-style"/>
</@override>

<@override name="breadcrumbs">
<a href="${ctx}/">首页</a>
&gt;
<a href="javascript:" class="active">${title}</a>
</@override>

<@override name="main">
<div id="main">
    <div style="width: 900px; margin: 0 auto;">
        <form action="${ctx}/guest/save" method="post" id="guest-form">
            <div class="space-10"></div>
            <div class="space-10"></div>
            <div class="form-group">
                <div class="form-input">
                    <textarea class="form-control" name="content" rows="5" placeholder="相遇便是缘分，留句话吧..."></textarea>
                </div>
            </div>
            <div class="form-inline">
                <div class="form-group">
                    <input name="realname" class="form-control" placeholder="昵称"/>
                </div>
                <div class="form-group">
                    <input name="email" class="form-control" style="min-width: 240px;" placeholder="邮箱 (审核后会发邮件通知您)"/>
                </div>
                <div class="form-group" style="margin-left: 20px;">
                    <button id="submit" class="btn btn-sm btn-danger"
                            data-loading-text="正在<@s.message "app.button.save"/>...">
                        提 交
                    </button>
                </div>
            </div>
        </form>

        <div class="space-32"></div>

        <div class="guest-line">
            <h3>留言板
                <small class="red">（${page.list?size}）</small>
            </h3>
        </div>

        <ul class="guest-list">
            <#list page.list as guest>
                <li class="item">
                    <div class="l pull-left">
                        <img class="avatar" src="${ctx}/static/app/images/default_avatar.png" width="36" height="36"/>
                        <p class="ip-info">${guest.ipInfo}</p>
                    </div>
                    <div class="r pull-right">
                        <div class="t">
                            <div class="pull-left name">${guest.realname}</div>
                            <div class="pull-right"><@c.relative_date datetime=guest.createdTime/></div>
                        </div>

                        <div class="space-4"></div>

                        <div class="clearboth">
                        ${guest.content}
                        </div>

                        <#if guest.replyMessage != ''>
                            <div class="space-4"></div>

                            <div class="reply-user">站长回复:</div>
                            <div class="clearboth reply">
                                <div class="markdown">
                                ${guest.replyMessage}
                                </div>
                            </div>
                        </#if>
                    </div>
                </li>
                <div class="line"></div>
            </#list>
        </ul>

        <!--分页-->
        <#if (page.list)?? && page.pages gt 1>
            <div class="page-div">
                <ul class="pagination">
                    <#if page.hasPreviousPage>
                        <li>
                            <a href="${url}?p=${page.prePage}">&lt;</a>
                        </li>
                    </#if>

                    <#list page.navigatepageNums as nav>
                        <#if nav == page.pageNum>
                            <li class="active">
                                <a href="javascript:">${nav}</a>
                            </li>
                        <#else>
                            <li>
                                <a href="${url}?p=${nav}">${nav}</a>
                            </li>
                        </#if>
                    </#list>

                    <#if page.hasNextPage>
                        <li>
                            <a href="${url}?p=${page.nextPage}">&gt;</a>
                        </li>
                    </#if>
                </ul>
            </div>
        </#if>

        <div class="space-20"></div>
    </div>
</div>
</@override>

<@override name="script">
<script src="${ctx}/static/ace/dist/js/bootstrap.min.js"></script>
<script src="${ctx}/static/ace/dist/js/ace-extra.min.js"></script>
<script src="${ctx}/static/ace/dist/js/ace-elements.min.js"></script>
<script src="${ctx}/static/ace/dist/js/jquery.gritter.min.js"></script>
<script src="${ctx}/static/ace/dist/js/ace.min.js"></script>
<script src="${ctx}/static/libs/jquery/jquery.form.min.js"></script>
<script src="${ctx}/static/libs/jquery/jquery.validate.min.js"></script>
<script src="${ctx}/static/libs/jquery/jquery.validate.extends.js"></script>
<script src="${ctx}/static/ace/dist/js/prettify.min.js"></script>
<script src="${ctx}/static/app/js/web/guest/index.js"></script>
</@override>

<@extends name="../layout.ftl"/>