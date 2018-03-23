$(function () {
    updateState("manage/article");

    /**
     * 初始化markdown编辑器
     */
    $("#content").markdown({resize: 'vertical'});

    $('#file').ace_file_input({
        no_file: '请选择文件 ...',
        btn_choose: '选择',
        btn_change: '重新选择',
        droppable: false,
        before_change: null,
        thumbnail: false
    });

    var $form = $('#article-form');
    var $btn = $("#submit");

    $form.validate({
        rules: {
            title: {
                required: true,
                rangelength: [1, 64]
            },
            summary: {
                required: true,
                rangelength: [1, 64]
            },
            categoryCode: {
                required: true
            },
            content: {
                required: true
            }
        },
        submitHandler: function (form, event) {
            event.preventDefault();
            $btn.button('loading');
            $(form).ajaxSubmit({
                dataType: 'json',
                success: function (response) {
                    if (response.respCo == '0000') {
                        window.location.hash = "manage/article?r=" + Math.random()
                        Message.success(response.respMsg);
                    } else {
                        Message.error(response.respMsg);
                    }
                    $btn.button('reset');
                },
                error: function () {
                    Message.error("服务器内部错误，请稍后再试。");
                    $btn.button('reset');
                }
            });
        },
        errorPlacement: function (error, element) {
            error.appendTo(element.parent());
        },
        errorElement: "div",
        errorClass: "error"
    });
});