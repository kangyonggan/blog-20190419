$(function () {
    $("#navbar ul li.active").css("height", "60px");

    var $form = $('#guest-form');
    var $btn = $form.find("button");

    $form.validate({
        rules: {
            content: {
                required: true,
                maxlength: 2048
            },
            realname: {
                required: true,
                maxlength: 32
            },
            email: {
                required: true,
                maxlength: 64,
                email: true
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
});