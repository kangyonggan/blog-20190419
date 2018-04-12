$(function () {
    $(".markdown a").attr("target", "_blank");
    $(".markdown pre").addClass("prettyprint linenums");
    $(".markdown table").addClass("table table-striped table-bordered table-hover");

    prettyPrint();

    $('.markdown img').zoomify();

    $(".markdown").find("h2, h3, h4, h5, h6").each(function (i, item) {
        var tag = $(item)[0].tagName;
        var id = "toc-" + i;
        $(item).attr("id", id);
        $(".markdown-toc ul").append('<li><a href="#' + id + '" class="nowrap md-' + tag + '">' + $(item).text() + '</a></li>');
    });

    $(".markdown-toc > a").click(function () {
        $(".markdown-toc ul").toggle();
        if ($(".markdown-toc > a > span").text() == "[-]") {
            $(".markdown-toc > a > span").text("[+]");
            $(".markdown-toc").css("top", "350px");
        } else {
            $(".markdown-toc > a > span").text("[-]");
            $(".markdown-toc").css("top", "52px");
        }
    });

    $(".markdown pre.prettyprint").addClass("hidden").after("<div class='code-toggle-btn'><a href='javascript:'>显示代码</a></div>");

    $(".code-toggle-btn a").click(function () {
        if ($(this).text() == "显示代码") {
            $(this).parent("div").prev("pre").removeClass("hidden");
            $(this).text("折叠代码");
        } else {
            $(this).parent("div").prev("pre").addClass("hidden");
            $(this).text("显示代码");
        }
    });

});