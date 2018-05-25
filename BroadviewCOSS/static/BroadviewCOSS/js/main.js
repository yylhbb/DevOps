(function () {
    "use strict";

    let treeviewMenu = $('.app-menu');

    // Toggle Sidebar
    $('[data-toggle="sidebar"]').click(function (event) {
        event.preventDefault();
        $('.app').toggleClass('sidenav-toggled');
    });

    // Activate sidebar treeview toggle
    $("[data-toggle='treeview']").click(function (event) {
        event.preventDefault();
        if (!$(this).parent().hasClass('is-expanded')) {
            treeviewMenu.find("[data-toggle='treeview']").parent().removeClass('is-expanded');
        }
        $(this).parent().toggleClass('is-expanded');
    });

    // Set initial active toggle
    $("[data-toggle='treeview.'].is-expanded").parent().toggleClass('is-expanded');

    //Activate bootstrip tooltips
    $("[data-toggle='tooltip']").tooltip();

    $.ajaxSetup({
        headers: {"X-CSRFToken": getCookie("csrftoken")}
    });

    $.extend($.fn.dataTable.defaults, {
        "language": {
            "url": "/static/BroadviewCOSS/js/plugins/dataTables/zh_CN.json"
        },
        "pagingType": "full_numbers"
    });

    $('.content-table').DataTable();
})();

function getCookie(name) {
    let arr, reg = new RegExp("(^| )" + name + "=([^;]*)(;|$)");

    if (arr = document.cookie.match(reg))

        return unescape(arr[2]);
    else
        return null;
}

$.fn.serializeObject = function () {
    let object = {};
    let array = this.serializeArray();
    $.each(array, function () {
        if (object[this.name]) {
            if (!object[this.name].push) {
                object[this.name] = [object[this.name]];
            }
            object[this.name].push(this.value || '');
        } else {
            object[this.name] = this.value || '';
        }
    });
    return object;
};

function dangerNotify(message){
    $.notify({
        message: message,
        icon: 'fa fa-close'
    }, {
        type: 'danger',
        mouse_over: 'pause'
    })
}

function successNotify(message){
    $.notify({
        message: message,
        icon: "fa fa-check"
    },{
        type: "success",
        mouse_over: "pause"
    })
}