<#assign ctx="${(rca.contextPath)!''}">

<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
    <meta charset="utf-8"/>
    <meta name="description" content=""/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0"/>

    <link rel="shortcut icon" href="${ctx}/static/app/images/favicon.ico" type="image/x-icon">
    <!-- bootstrap & fontawesome -->
    <link rel="stylesheet" href="${ctx}/static/ace/dist/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="${ctx}/static/ace/dist/css/font-awesome.min.css"/>
    <link rel="stylesheet" href="${ctx}/static/ace/dist/css/jquery.gritter.min.css"/>

    <!-- page specific plugin styles -->

    <!-- text fonts -->
    <link rel="stylesheet" href="${ctx}/static/ace/dist/css/ace-fonts.min.css"/>

    <!--skin-->
    <link rel="stylesheet" href="${ctx}/static/ace/dist/css/ace-skins.min.css"/>

    <!-- ace styles -->
    <link rel="stylesheet" href="${ctx}/static/ace/dist/css/ace.min.css" class="ace-main-stylesheet"
          id="main-ace-style"/>

    <!--[if lte IE 9]>
    <link rel="stylesheet" href="${ctx}/static/ace/dist/css/ace-part2.min.css" class="ace-main-stylesheet"/>
    <![endif]-->

    <!--[if lte IE 9]>
    <link rel="stylesheet" href="${ctx}/static/ace/dist/css/ace-ie.min.css"/>
    <![endif]-->

    <link rel="stylesheet" href="${ctx}/static/app/css/app-dashboard.css"/>

    <script src="${ctx}/static/ace/dist/js/jquery.min.js"></script>

    <!--[if lte IE 8]>
    <script src="${ctx}/static/ace/dist/js/html5shiv.js"></script>
    <script src="${ctx}/static/ace/dist/js/respond.min.js"></script>
    <![endif]-->
<@block name="app-style"/>
</head>
<body class="skin-2">
<#include "navbar.ftl"/>

<div class="main-container" id="main-container">

<#include "sidebar.ftl"/>

    <div class="main-content">
        <div class="main-content-inner">
        <#if !noBreadcrumbs??>
            <div class="breadcrumbs" id="breadcrumbs">
                <ul class="breadcrumb">
                    <li>
                        <i class="ace-icon fa fa-tachometer home-icon"></i>
                        <a data-url="index" href="${ctx}/dashboard#index">工作台</a>
                    </li>
                </ul>
            </div>
        </#if>

            <div class="page-content">
                <div class="page-content-area"></div>
            </div>
        </div>
    </div>

<#include "footer.ftl"/>

<#include "modal.ftl"/>

    <a href="javascript:" id="btn-scroll-up" class="btn-scroll-up btn btn-sm btn-inverse">
        <i class="ace-icon fa fa-angle-double-up icon-only bigger-110"></i>
    </a>
</div>


<!-- basic scripts -->

<!--[if !IE]> -->
<script type="text/javascript">
    window.jQuery || document.write("<script src='${ctx}/static/ace/dist/js/jquery.js'>" + "<" + "/script>");
</script>

<!-- <![endif]-->

<!--[if IE]>
<script type="text/javascript">
    window.jQuery || document.write("<script src='/static/ace/dist/js/jquery1x.min.js'>" + "<" + "/script>");
</script>
<![endif]-->
<script type="text/javascript">
    if ('ontouchstart' in document.documentElement) document.write("<script src='${ctx}/static/ace/dist/js/jquery.mobile.custom.min.js'>" + "<" + "/script>");
</script>

<!--[if lte IE 8]>
<script src="${ctx}/static/ace/dist/js/excanvas.min.js"></script>
<![endif]-->

<script>var ctx = '${ctx}';</script>
<script src="${ctx}/static/ace/dist/js/bootstrap.min.js"></script>
<script src="${ctx}/static/libs/jquery/jquery.bootstrap.min.js"></script>
<script src="${ctx}/static/ace/dist/js/jquery.gritter.min.js"></script>
<script src="${ctx}/static/ace/dist/js/ace-extra.min.js"></script>
<script src="${ctx}/static/ace/dist/js/ace-elements.min.js"></script>
<script src="${ctx}/static/ace/dist/js/ace.min.js"></script>
<script src="${ctx}/static/libs/jquery/jquery.form.min.js"></script>
<script src="${ctx}/static/libs/jquery/jquery.validate.min.js"></script>
<script src="${ctx}/static/libs/jquery/jquery.validate.extends.js"></script>
<script src="${ctx}/static/app/js/app.js"></script>
<@block name="app-script"/>
</body>
</html>
