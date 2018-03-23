$(function () {
    var $form = $('#tool-form');
    var $btn = $form.find("button");

    $form.validate({
        rules: {
            data: {
                required: true
            }
        },
        submitHandler: function (form, event) {
            $btn.text($btn.attr("data-loading-text"));
            $btn.attr("disabled", "disabled");
            $btn.css("background", "#ccc");
            return true;
        },
        errorPlacement: function (error, element) {
            error.appendTo(element.parent());
        },
        errorElement: "div",
        errorClass: "error"
    });
});