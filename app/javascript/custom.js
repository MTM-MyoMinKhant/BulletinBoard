$(document).ready(function() {
    $("#user_account").click(function() {
        $(".profile-info").toggleClass("none");
    });

    $("#dp-s").click(function() {
        $("#detail-post").addClass("d2p-n");
        $("#delete-post").removeClass("dp-n");
        $("#delete-post").addClass("dp-s");
    });

    $("#dp-n").click(function() {
        $("#delete-post").removeClass("dp-s");
        $("#delete-post").addClass("dp-n");
    });

    $("#d2p-s").click(function() {
        $("#delete-post").addClass("dp-n");
        $("#detail-post").removeClass("d2p-n");
        $("#detail-post").addClass("d2p-s");
    });

    $("#d2p-n").click(function() {
        $("#detail-post").removeClass("d2p-s");
        $("#detail-post").addClass("d2p-n");
    });

    $("#du-s").click(function() {
        $("#detail-user").addClass("d2u-n");
        $("#delete-user").removeClass("du-n");
        $("#delete-user").addClass("du-s");
    });

    $("#du-n").click(function() {
        $("#delete-user").removeClass("du-s");
        $("#delete-user").addClass("du-n");
    });

    $("#d2u-s").click(function() {
        $("#delete-user").addClass("du-n");
        $("#detail-user").removeClass("d2u-n");
        $("#detail-user").addClass("d2u-s");
    });

    $("#d2u-n").click(function() {
        $("#detail-user").removeClass("d2u-s");
        $("#detail-user").addClass("d2u-n");
    });
});
