$(function () {
    $(".filter-form .sort").click(function () {
        $.get(ctx + "/wap/article/page?categoryCode=" + categoryCode + "&sort=" + sort, function (data, status) {
            if (status == "success") {
                data = eval('(' + data + ')');
                reRender(data.page.list);
                if (sort == "desc") {
                    sort = "asc"
                } else {
                    sort = "desc";
                }
            } else {
                alert("网络错误，请稍后再试！");
            }
        });
    });

    /**
     * 重新渲染
     *
     * @param list
     */
    function reRender(list) {
        $(".article-list").empty();
        if (!list || list.length == 0) {
            $(".article-list").append("<div class='empty'>暂无查询记录</div>");
        } else {
            for (var i = 0; i < list.length; i++) {
                var article = list[i];
                var content = "";
                content += '<div class="item">';
                if (article.picture) {
                    content += '<div class="left"><img src="' + article.picture + '"></div>';
                }
                content += '<div class="right"><a href="' + ctx + '/wap/article/' + article.id + '">';
                content += '<div class="title nowrap" title="' + article.title + '">' + article.title + '</div>';
                content += '<div class="summary">' + article.summary + '</div></a></div></div>';

                $(".article-list").append(content);
            }
        }
    }
});