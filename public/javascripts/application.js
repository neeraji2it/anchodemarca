// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults


//show the image before saving to database
function readURL(input) {
    if (input.files && input.files[0]) {
        var reader = new FileReader();

        reader.onload = function(e) {
            $('#img_show').attr('src', e.target.result);
        }

        reader.readAsDataURL(input.files[0]);
        $("#img_preview").show();
    }
    return true;
}

function bid_status(st, bid_id) {
    var sta = $(st).text();
    $.ajax({
        type: 'POST',
        url: '/constants/' + bid_id + '/bid_status',
        data: {
            status: sta
        },
        method: 'POST',
        success: function(data) {
        }
    });
}


// based on country select city
$(document).ready(function() {
    $("#user_country_id").live('change', function() {
        if ($("#user_country_id").val() != "") {
            var country = $("#user_country_id").val();
            $.ajax({
                type: 'GET',
                url: '/users/add_cities',
                data: 'country_id=' + country,
                success: function(data) {
                }
            });
            return false;
        }
    });
});

// ajax loader for form submit via remote part
jQuery(document).ajaxStart(function(settings) {
    jQuery('#ajax_loader_big_div').show();
});
jQuery(document).ajaxStop(function() {
    jQuery('#ajax_loader_big_div').hide();
});

// add more and remove fields
function remove_fields(link) {
    $(link).prev("input[type=hidden]").val("1");
    $(link).closest(".fields").hide();
}

function add_fields(link, association, content) {
    var new_id = new Date().getTime();
    var regexp = new RegExp("new_" + association, "g")
    $(link).parent().before(content.replace(regexp, new_id));
}

// pagination for without page load
$(function() {
    $(".pagination a").live("click", function() {
        $.getScript(this.href);
        return false;
    });
});

$("#account_form").click(function() {
    $("#account").show();
    $("#hi").show();
});
$("#account").mouseleave(function() {
    $("#account").hide();
    $("#hi").hide();
});

$(document).ready(function() {

    //select all the a tag with name equal to modal
    $('a[name=modal]').click(function(e) {
        //Cancel the link behavior
        e.preventDefault();

        //Get the A tag
        var id = $(this).attr('href');

        //Get the screen height and width
        var maskHeight = $(document).height();
        var maskWidth = $(window).width();

        //Set heigth and width zto mask to fill up the whole screen
        $('#mask').css({
            'width': maskWidth,
            'height': maskHeight
        });

        //transition effect
        $('#mask').fadeIn(1000);
        $('#mask').fadeTo("slow", 0.8);

        //Get the window height and width
        var winH = $(window).height();
        var winW = $(window).width();

        //Set the popup window to center
        $(id).css('top', 100);
        $(id).css('left', winW / 2 - $(id).width() / 2);

        //transition effect
        $(id).fadeIn(2000);

    });

    //if close button is clicked
    $('.window .close').click(function(e) {
        //Cancel the link behavior
        e.preventDefault();

        $('#mask').hide();
        $('.window').hide();
        $("#error").hide();
        $('#error1').hide();
        $('#error3').show();
        $("#div-regForm1").hide();
        $('#login_form1').show();
    });

    //if mask is clicked
    $('#mask').click(function() {
        $(this).hide();
        $('.window').hide();
    });

});

function admin_login() {
    $.ajax({
        url: "/home/new",
        success: function(data) {
            $("#popup_body").html(data);
            $('#overlay').show();
            $('#popup_box').show();
        }
    });
}

function comment_path(user_id) {
    $.ajax({
        url: "/users/" + user_id + "/user_comments/new",
        success: function(data) {
            $("#popup_body1").html(data);
            $('#overlay').show();
            $('#popup_box1').show();
        }
    });
}

function show_comment(user_id) {
    $.ajax({
        url: "/users/" + user_id + "/user_comments/user_comments",
        success: function(data) {
            $("#popup_body1").html(data);
            $('#overlay').show();
            $('#popup_box1').show();
        }
    });
}

function hide_popup() {

    if (jQuery('#popup_box')) {
        jQuery('#popup_body').html("");
        jQuery('#popup_box').hide();
    }

    if (jQuery('#popup_box1')) {
        jQuery('#popup_body1').html("");
        jQuery('#popup_box1').hide();
    }

    if (jQuery('#overlay')) {
        jQuery('#overlay').hide();
    }
}
















