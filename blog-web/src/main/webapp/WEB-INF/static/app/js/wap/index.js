$(function () {
    $("#search-key").click(function () {
        $(this).animate({
            width: "100%",
            left: "0px"
        });
        $("#search-type").removeClass("hidden");
    });
    $(document).click(function (e) {
        var id = $(e.target).attr("id");
        if (id != "search-key" && id != "search-type") {
            $("#search-key").css("width", "100px").css("right", "5px").css("left", "auto");
            $("#search-type").addClass("hidden");
        }
    });
});