$(function () {
    /**
     * 排序
     */
    var isSorting = false;
    $(".filter-form .sort").click(function () {
        if (!isSorting) {
            isSorting = true;
            if (sort == "desc") {
                sort = "asc"
            } else {
                sort = "desc";
            }
            $.get(ctx + "/wap/article/page?categoryCode=" + categoryCode + "&sort=" + sort, function (data, status) {
                if (status == "success") {
                    data = eval('(' + data + ')');
                    hasNextPage = data.page.hasNextPage;
                    $(".article-list").empty();
                    appendList(data.page.list);
                } else {
                    alert("网络错误，请稍后再试！");
                }
                isSorting = false;
            });
        }
    });

    /**
     * 追加到list
     *
     * @param list
     */
    function appendList(list) {
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

            if (hasNextPage) {
                $(".article-list").append('<div class="more">上滑加载更多</div>');
            } else {
                $(".article-list").append('<div class="no-more-content">没有更多内容了</div>');
            }
        }
    }

    // 上滑加载下一页
    var isLoadingNextPage = false;
    $(window).scroll(function () {
        if (hasNextPage && !isLoadingNextPage) {
            if ($(document).scrollTop() >= $(document).height() - $(window).height()) {
                isLoadingNextPage = true;
                $.get(ctx + "/wap/article/page?p=" + (pageNum * 1 + 1) + "&categoryCode=" + categoryCode + "&sort=" + sort, function (data, status) {
                    $(".article-list .more").text("正在努力加载...");
                    if (status == "success") {
                        data = eval('(' + data + ')');
                        hasNextPage = data.page.hasNextPage;
                        $(".article-list .more").addClass("hidden");
                        appendList(data.page.list);
                    } else {
                        alert("网络错误，请稍后再试！");
                    }
                    isLoadingNextPage = false;
                });
            }
        }
    });
});