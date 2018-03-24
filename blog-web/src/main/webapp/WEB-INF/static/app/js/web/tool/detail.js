$(function () {
    var $form = $('#tool-form');
    var $btn = $form.find("button");

    var file_input = $form.find('input[type=file]');
    file_input.ace_file_input({
        style: 'well',
        btn_choose: '点击这里添加图片',
        btn_change: null,
        no_icon: 'ace-icon fa fa-picture-o',
        droppable: false,
        allowExt: ["jpeg", "jpg", "png", "gif"],
        allowMime: ["image/jpeg", "image/jpg", "image/png", "image/gif"],
        maxSize: 2097152,//bytes
        thumbnail: 'fit'
    });

    file_input.on('file.error.ace', function (event, info) {
        if (info.error_count['size']) Message.warning('超出最大上传限制。');
        if (info.error_count['ext'] || info.error_count['mime']) Message.warning('不合法的文件类型。');
        event.preventDefault();
    });

    $form.validate({
        ignore: '',
        rules: {
            data: {
                required: true
            },
            file: {
                required: true
            }
        },
        submitHandler: function (form, event) {
            $btn.button('loading');
            return true;
        },
        errorPlacement: function (error, element) {
            error.appendTo(element.parent());
        },
        errorElement: "div",
        errorClass: "error"
    });

    $("#reset").click(function () {
        $form.find("input,textarea,select").val("");
        return false;
    });

    $(".tool-result pre").addClass("prettyprint linenums");
    prettyPrint();
});