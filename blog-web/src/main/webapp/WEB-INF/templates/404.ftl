<#assign title="404"/>

<@override name="main">
<div id="main">
    <div class="err">
        您请求的页面不存在！(404)
    </div>
</div>

<div class="warn-mobile hidden wap-adj">
    <script>
        var disp = $(".wap-adj").css("display");
        if (disp != "none") {
            window.location.href = '${ctx}/wap/404';
        }
    </script>
</div>
</@override>

<@extends name="web/layout.ftl"/>