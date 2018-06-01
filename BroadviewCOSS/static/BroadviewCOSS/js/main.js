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
        beforeSend:function (xhr,settings) {
            xhr.setRequestHeader("X-CSRFtoken",getCookie("csrftoken"))
        }
    });

    $.extend($.fn.dataTable.defaults, {
        "language": {
            "sProcessing": "处理中...",
            "sLengthMenu": "显示 _MENU_ 项结果",
            "sZeroRecords": "没有匹配结果",
            "sInfo": "显示第 _START_ 至 _END_ 项结果，共 _TOTAL_ 项",
            "sInfoEmpty": "显示第 0 至 0 项结果，共 0 项",
            "sInfoFiltered": "(由 _MAX_ 项结果过滤)",
            "sInfoPostFix": "",
            "sSearch": "搜索:",
            "sUrl": "",
            "sEmptyTable": "表中数据为空",
            "sLoadingRecords": "载入中...",
            "sInfoThousands": ",",
            "oPaginate": {
                "sFirst": "首页",
                "sPrevious": "上页",
                "sNext": "下页",
                "sLast": "末页"
            },
            "oAria": {
                "sSortAscending": ": 以升序排列此列",
                "sSortDescending": ": 以降序排列此列"
            }
        },
        "pagingType": "full"
    });

    $.fn.dataTable.ext.errMode = 'none';

    $('.content-table').DataTable();

    /*$('#user-table').DataTable({
        processing: true,
        serverSide: true,
        ajax: {
            headers: {"X-CSRFToken": getCookie("csrftoken")},
            url: "/user/show",
            type: "POST"
        },
        columnDefs: [
            {
                "targets": 0,
                "searchable": false,
                "visible": false,
            },
            {
                "targets": 4,
                "data": null,
                "render": function (data, type, row) {
                    return "" +
                        "<a href=\"#\">" +
                        "   <button class=\"btn btn-outline-success btn-sm\"><i class=\"fa fa-edit fa-fw\"></i>修改</button>" +
                        "</a> " +
                        "<button class=\"btn btn-outline-danger btn-sm\"><i class=\"fa fa-close fa-fw\"></i>删除</button>";
                }
            }
        ],
    });*/
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

function deleteObject(url, id) {
    swal({
        title: "确定要删除吗",
        text: "操作将无法撤销",
        type: "warning",
        showCancelButton: true,
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        closeOnConfirm: false,
        showLoaderOnConfirm: true,
    }, function (isConfirm) {
        if (isConfirm) {
            $.ajax({
                url: url,
                type: "post",
                data: JSON.stringify({
                    "id": id
                }),
                success: function (data) {
                    let dataObj = JSON.parse(data);
                    swal({
                        title: dataObj.message,
                        type: dataObj.result ? "success" : "error",
                        confirmButtonText: "确认",
                    }, function () {
                        if (this.type === "success") {
                            location.reload()
                        }
                    });
                },
                error: function (data) {
                    console.log(data);
                }
            });
        }
    })
};