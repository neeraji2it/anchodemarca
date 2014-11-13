function select_file_type(val) {
    $.ajax({
        url: '/home/' + val + '/client_categories',
        success: function(data) {
            $("#client-category").html(data);
        }
    });
}

function select_type(val) {
    $.ajax({
        url: '/home/' + val + '/creative_categories',
        success: function(data) {
            $("#creative-category").html(data);
        }
    });
}

function file_type(val) {
    $.ajax({
        url: '/home/' + val + '/tutor_categories',
        success: function(data) {
            $("#tutor-category").html(data);
        }
    });
}

function client_categories(s) {
    if (jQuery(s).val() != '') {
        $.ajax({
            url: '/constants/categories/?categories=' + jQuery(s).val(),
            success: function(data) {
                $('#client_categories').html(data);
                $('#search_all').html(data);
                $('#client_pages').hide();
                $('#client_index').hide();
            }
        });
    }
}

function client_company(s) {
    if (jQuery(s).val() != '') {
        $.ajax({
            url: '/constants/company/?company_name=' + jQuery(s).val(),
            success: function(data) {
                $('#search_all').html(data);
            }
        });
    }
}

function social_categories(s) {
    if (jQuery(s).val() != '') {
        $.ajax({
            url: '/constants/social_categories/?categories=' + jQuery(s).val(),
            success: function(data) {
                $('#client_categories').html(data);
                $('#search_all').html(data);
                $('#client_pages').hide();
                $('#client_index').hide();
            }
        });
    }
}

function client_logos(s) {
    if (jQuery(s).val() != '') {
        $.ajax({
            url: '/constants/client_logos/?image_file_name=' + jQuery(s).val(),
            success: function(data) {
                $('#client_categories').html(data);
                $('#search_all').html(data);
                $('#client_pages').hide();
                $('#client_index').hide();
            }
        });
    }
}

function client_date(s) {
    if (jQuery(s).val() != '') {
        $.ajax({
            url: '/constants/project_date/?categories=' + jQuery(s).val(),
            success: function(data) {
                $('#client_categories').html(data);
                $('#search_all').html(data);
                $('#client_pages').hide();
                $('#client_index').hide();
            }
        });
    }
}

function creative_categories(s) {
    if (jQuery(s).val() != '') {
        $.ajax({
            url: '/constants/categories/?categories=' + jQuery(s).val(),
            success: function(data) {
                $('#creative_categories').html(data);
                $('#search_all').html(data);
                $('#creative_pages').hide();
                $('#creative_index').hide();
            }
        });
    }
}

function tutor_categories(s) {
    if (jQuery(s).val() != '') {
        $.ajax({
            url: '/constants/course_categories/?categories=' + jQuery(s).val(),
            success: function(data) {
                $('#tutor_categories').html(data);
                $('#search_all').html(data);
                $('#tutor_pages').hide();
                $('#tutor_index').hide();
            }
        });
    }
}

function tutor_course(s) {
    if (jQuery(s).val() != '') {
        $.ajax({
            url: '/constants/course_date/?categories=' + jQuery(s).val(),
            success: function(data) {
                $('#tutor_categories').html(data);
                $('#search_all').html(data);
                $('#tutor_pages').hide();
                $('#tutor_index').hide();
            }
        });
    }
}

function tutor_views(s) {
    if (jQuery(s).val() != '') {
        $.ajax({
            url: '/tutors/views/?categories=' + jQuery(s).val(),
            success: function(data) {
                $('#tutor_categories').html(data);
                $('#search_all').html(data);
                $('#tutor_pages').hide();
                $('#tutor_index').hide();
            }
        });
    }
}

function creative_likes(s) {
    if (jQuery(s).val() != '') {
        $.ajax({
            url: '/creatives/likes/?categories=' + jQuery(s).val(),
            success: function(data) {
                $('#creative_categories').html(data);
                $('#search_all').html(data);
            }
        });
    }
}

function creative_reputation(s) {
    if (jQuery(s).val() != '') {
        $.ajax({
            url: '/users/creative_reputation/?categories=' + jQuery(s).val(),
            success: function(data) {
                $('#creative_categories').html(data);
                $('#search_all').html(data);
                $('#creative_pages').hide();
                $('#creative_index').hide();
            }
        });
    }
}

function tutor_reputation(s) {
    if (jQuery(s).val() != '') {
        $.ajax({
            url: '/users/tutor_reputation/?categories=' + jQuery(s).val(),
            success: function(data) {
                $('#tutor_categories').html(data);
                $('#search_all').html(data);
                $('#tutor_pages').hide();
                $('#tutor_index').hide();
            }
        });
    }
}

function client_budget(s) {
    if (jQuery(s).val() != '') {
        $.ajax({
            url: '/constants/budget/?categories=' + jQuery(s).val(),
            success: function(data) {
                $('#client_categories').html(data);
                $('#search_all').html(data);
                $('#client_pages').hide();
                $('#client_index').hide();
            }
        });
    }
}

function creative_views(s) {
    if (jQuery(s).val() != '') {
        $.ajax({
            url: '/constants/project_views/?categories=' + jQuery(s).val(),
            success: function(data) {
                $('#creative_categories').html(data);
                $('#search_all').html(data);
                $('#client_categories').show();
                $('#creative_pages').hide();
            }
        });
    }
}