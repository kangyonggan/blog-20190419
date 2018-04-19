$(function () {
    /**
     * 日期时间格式化
     *
     * @param fmt
     * @returns {*}
     */
    Date.prototype.format = function (fmt) {
        var o = {
            "M+": this.getMonth() + 1,                 //月份
            "d+": this.getDate(),                    //日
            "H+": this.getHours(),                   //小时
            "m+": this.getMinutes(),                 //分
            "s+": this.getSeconds(),                 //秒
            "q+": Math.floor((this.getMonth() + 3) / 3), //季度
            "S": this.getMilliseconds()             //毫秒
        };
        if (/(y+)/.test(fmt)) {
            fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
        }
        for (var k in o) {
            if (new RegExp("(" + k + ")").test(fmt)) {
                fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
            }
        }
        return fmt;
    };

    /**
     * art日期时间格式化
     */
    template.helper('datetimeFormat', function (date) {
        var d = new Date();
        d.setTime(date);
        return d.format("yyyy-MM-dd HH:mm:ss");
    });

    /**
     * art日期格式化
     */
    template.helper('dateFormat', function (date) {
        var d = new Date();
        d.setTime(date);
        return d.format("yyyy-MM-dd");
    });

    /**
     * art时间格式化
     */
    template.helper('timeFormat', function (date) {
        var d = new Date();
        d.setTime(date);
        return d.format("HH:mm:ss");
    });

    /**
     * art日期时间自定义格式化
     */
    template.helper('format', function (date, format) {
        var d = new Date();
        d.setTime(date);
        return d.format(format);
    });

    /**
     * 序列化表单
     */
    $.fn.serializeForm = function () {
        var json = {};
        var arr = this.serializeArray();
        $.each(arr, function () {
            if (json[this.name]) {
                if (json[this.name].push) {
                    json[this.name] = [json[this.name]];
                }
                json[this.name].push(this.value || '');
            } else {
                json[this.name] = this.value || '';
            }
        });

        return json;
    };

    // 有滚动条时才显示回到顶部按钮
    window.onscroll = function () {
        if (document.documentElement.scrollTop + document.body.scrollTop > 100) {
            document.getElementById("btn-scroll-up").style.display = "block";
        } else {
            document.getElementById("btn-scroll-up").style.display = "none";
        }
    };

    // 异步加载界面
    var $ajaxContent = $(".page-content-area");
    $ajaxContent.ace_ajax({
        'default_url': '#index',
        'content_url': function (hash) {
            return window.location.protocol + "//" + window.location.hostname + ":" + window.location.port + window.location.pathname + "/" + hash;
        },
        'update_active': updateMenuActive,
        'update_breadcrumbs': updateBreadcrumbs,
        'update_title': updateTitle,
        'loading_text': '<span class="loading">正在加载, 请稍等...</span>'
    });

    // 监听异步加载失败事件
    $ajaxContent.on("ajaxloaderror", function (e, data) {
        window.location.href = ctx + '/404';
    });

    // 提示框
    $.messager.model = {
        cancel: {text: "取消", classed: 'btn-default'},
        ok: {text: "确定", classed: 'btn-success'}
    };

    // 关闭时清除模态框的数据
    $(document).on('hidden.bs.modal', '.modal', function () {
        $(this).find(".modal-header h3").html("正在加载...");
        $(this).find(".modal-body").html("正在加载...");
        $(this).removeData('bs.modal');
    });

    // form modal提交
    $('.modal').on('click', '[data-toggle=form-submit]', function (e) {
        e.preventDefault();
        $($(this).data('target')).submit();
    });

    // 搜索
    $(document).on("click", "[data-toggle='search-submit']", function (e) {
        e.preventDefault();
        var $this = $(this);
        var $table = $("#" + $this.data("table-id"));

        var params = $this.parent("form").serializeForm();
        $table.bootstrapTable("refresh", {query: params});
        return false;
    });

    // 清空
    $(document).on("click", "[data-toggle='form-reset']", function (e) {
        e.preventDefault();
        var $this = $(this);
        var $form = $this.parent("form");

        $form.find("input").val("");
        $form.find("select").val("");
        return false;
    });
});

// 提示信息
var last_gritter;
var showMessage = function (type, message) {
    if (last_gritter) {
        $.gritter.remove(last_gritter);
    }
    last_gritter = $.gritter.add({
        title: '消息',
        text: message,
        time: 1500,
        class_name: type
    });
};

var Message = {
    success: function (message) {
        showMessage('gritter-success', message);
    },

    warning: function (message) {
        showMessage('gritter-warning', message);
    },

    error: function (message) {
        showMessage('gritter-error', message);
    },

    info: function (message) {
        showMessage('gritter-info', message);
    }
};


/**
 * 更新菜单激活状态
 *
 * @param hash
 */
function updateMenuActive(hash) {
    //  当前菜单
    var $menu = $($('a[data-url="' + hash + '"]')[0]).parent("li");

    // 所有菜单
    var $all_menus = $menu.parents("ul.nav-list").find("li");

    // 清除所有菜单状态
    $all_menus.removeClass("open");
    $all_menus.removeClass("active");
    $(".submenu").css("display", "");

    // 父菜单
    var $parent = $menu.parents("li");
    if ($parent.length > 0) {
        $parent.addClass("open");
    }
    $menu.addClass("active");
}

/**
 * 更新面包屑
 *
 * @param hash
 */
function updateBreadcrumbs(hash) {
    var $menu = $('a[data-url="' + hash + '"]');

    // 下面这坨代码摘自ace.ajax-content.js
    var $breadcrumbs = $('.breadcrumb');
    if ($breadcrumbs.length > 0 && $breadcrumbs.is(':visible')) {
        $breadcrumbs.find('> li:not(:first-child)').remove();

        var i = 0;
        $menu.parents('.nav li').each(function () {
            var $link = $(this).find('> a');

            var $link_clone = $link.clone();
            $link_clone.find('i,.fa,.glyphicon,.ace-icon,.menu-icon,.badge,.label').remove();
            var text = $link_clone.text();
            $link_clone.remove();

            var href = $link.attr('href');

            if (i == 0) {
                var li = $('<li class="active"></li>').appendTo($breadcrumbs);
                li.text(text);
            } else {
                var li = $('<li><a /></li>').insertAfter($breadcrumbs.find('> li:first-child'));
                li.find('a').attr('href', href).text(text);
            }
            i++;
        })
    }
}

/**
 * 更新标题
 *
 * @param hash
 */
function updateTitle(hash) {
    var $menu = $($('a[data-url="' + hash + '"]')[0]);
    var title = $.trim($menu.text());

    if (title != '') {
        document.title = title;
    }
}

/**
 * 更新状态
 *
 * @param hash
 */
function updateState(hash) {
    updateBreadcrumbs(hash);
    updateMenuActive(hash);
    updateTitle(hash);
}