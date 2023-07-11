$(document).ready(function() {
    $("#user_account").click(function() {
        $(".profile-info").toggleClass("none");
    });

    $(".dp-s").click(function() {
        $("#detail-post").addClass("d2p-n");
        $("#delete-post").removeClass("dp-n");
        $("#delete-post").addClass("dp-s");
    });

    $("#post-delete-close").click(function() {
        $("#delete-post").removeClass("dp-s");
        $("#delete-post").addClass("dp-n");
    });

    $(".d2p-s").click(function() {
        $("#delete-post").addClass("dp-n");
        $("#detail-post").removeClass("d2p-n");
        $("#detail-post").addClass("d2p-s");
        
    });

    $("#post-detail-close").click(function() {
        $("#detail-post").removeClass("d2p-s");
        $("#detail-post").addClass("d2p-n");
    });

    // -----------------------------------------------------

    $(".du-s").click(function() {
        $("#detail-user").addClass("d2u-n");
        $("#delete-user").removeClass("du-n");
        $("#delete-user").addClass("du-s");
    });

    $("#delete-user-close").click(function() {
        $("#delete-user").removeClass("du-s");
        $("#delete-user").addClass("du-n");
    });

    $(".d2u-s").click(function() {
        $("#delete-user").addClass("du-n");
        $("#detail-user").removeClass("d2u-n");
        $("#detail-user").addClass("d2u-s");
    });

    $("#detail-user-close").click(function() {
        $("#detail-user").removeClass("d2u-s");
        $("#detail-user").addClass("d2u-n");
    });
});

    function showUserDetails(userObject , createName , updatedName) {
        let UserDetails = {};
        console.log(userObject);
        console.log(userObject.avatar.url);
        UserDetails.name = userObject.name;
        UserDetails.email = userObject.email;
        UserDetails.phone = userObject.phone;
        UserDetails.dob = userObject.dob;
        UserDetails.address = userObject.address;
        UserDetails.cd = userObject.created_at.slice(0,10);
        UserDetails.cu = createName;
        UserDetails.ud = userObject.updated_at.slice(0,10);
        UserDetails.uu = updatedName;
        UserDetails.avatar = userObject.avatar.url;
        let role;

        if (userObject.role === 1) {
            role = "Admin";
        } else if (userObject.role === 0) {
            role = "User";
        } else {
            role = "Undefined";
        }
        UserDetails.role = role;
        console.log(UserDetails);
        $('#user_detail_name').html(UserDetails.name);
        $('#user_detail_role').html(UserDetails.role);
        $('#user_detail_email').html(UserDetails.email);
        $('#user_detail_phone').html(UserDetails.phone);
        $('#user_detail_dob').html(UserDetails.dob);
        $('#user_detail_address').html(UserDetails.address);
        $('#user_detail_cd').html(UserDetails.cd);
        $('#user_detail_cu').html(UserDetails.cu);
        $('#user_detail_ud').html(UserDetails.ud);
        $('#user_detail_uu').html(UserDetails.uu);
        $('#profile_img').attr('src', UserDetails.avatar);
    }

function showDeleteUserDetails(userObject) {
    let UserDeleteDetails = {}
    UserDeleteDetails.id = userObject.id
    UserDeleteDetails.name = userObject.name;
    UserDeleteDetails.email = userObject.email;
    UserDeleteDetails.phone = userObject.phone;
    UserDeleteDetails.dob = userObject.dob;
    UserDeleteDetails.address = userObject.address;
    let role;

    if (userObject.role === 1) {
        role = "Admin";
    } else if (userObject.role === 0) {
        role = "User";
    } else {
        role = "Undefined";
    }
    UserDeleteDetails.role = role
    $('#user_delete_id').html(UserDeleteDetails.id);
    $('#user_delete_name').html(UserDeleteDetails.name);
    $('#user_delete_type').html(UserDeleteDetails.role);
    $('#user_delete_email').html(UserDeleteDetails.email);
    $('#user_delete_phone').html(UserDeleteDetails.phone);
    $('#user_delete_dob').html(UserDeleteDetails.dob);
    $('#user_delete_address').html(UserDeleteDetails.address);
    document.getElementById('user_soft_delete').value = UserDeleteDetails.id;
    document.getElementById('delete_user').value = 1;
}

function showPostDetails(postObject) {
    let PostDetails = {}
    PostDetails.id = postObject.id;
    PostDetails.title = postObject.title;
    PostDetails.description = postObject.description;
    let status;

    if (postObject.status === 1) {
        status = "Show";
    } else if (postObject.status === 0) {
        status = "Hide";
    } else {
        status = "Undefined";
    }
    PostDetails.status = status;

    $('#post_detail_id').html(PostDetails.id);
    $('#post_detail_title').html(PostDetails.title);
    $('#post_detail_description').html(PostDetails.description);
    $('#post_detail_status').html(PostDetails.status);
}

function showDeletePostDetails(postObject) {
    let PostDeleteDetails = {}
    PostDeleteDetails.id = postObject.id;
    PostDeleteDetails.title = postObject.title;
    PostDeleteDetails.description = postObject.description;
    let status;

    if (postObject.status === 1) {
        status = "Show";
    } else if (postObject.status === 0) {
        status = "Hide";
    } else {
        status = "Undefined";
    }
    PostDeleteDetails.status = status;

    $('#post_delete_id').html(PostDeleteDetails.id);
    $('#post_delete_title').html(PostDeleteDetails.title);
    $('#post_delete_description').html(PostDeleteDetails.description);
    $('#post_delete_status').html(PostDeleteDetails.status);
    document.getElementById('post_soft_delete').value = PostDeleteDetails.id
    document.getElementById('delete_post').value = 1
}
