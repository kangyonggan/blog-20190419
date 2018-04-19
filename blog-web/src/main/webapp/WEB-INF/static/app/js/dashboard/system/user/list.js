$(function () {
    updateState("system/user");

    var $table = $('#user-table');

    $table.bootstrapTable();

    $table.on('click', 'a[data-role=user-delete]', function () {
        var $trigger = $(this);
        var url = $trigger.data('url');

        var title = $trigger.attr("title");

        $.messager.confirm("提示", "确定" + title + "吗?", function () {
            $.get(url).success(function () {
                Message.success("操作成功");
                var params = $("#user-query-form").serializeForm();
                $table.bootstrapTable("refresh", {query: params});
            }).error(function () {
                Message.error("网络错误，请稍后重试");
            })
        });
    });
});