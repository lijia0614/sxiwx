/**
 * 后台全局控制
 * @author 成都艾威尔网络科技有限公司(四川挚梦科技有限公司)
 * @date 2018-03-29
 * @QQ 905873908
 * @url http://www.ivears.com/
 */
$(document).ready(function () {
    vtip();// 预览图片及文字
    setDateStyle();//设置日期样式
    $(".formvalidate").Validform({
        datatype: {//验证规则
            "empty": /^\s*$/
        },
        tiptype: 3,
        ignoreHidden: true,
        label: "#messageBox",
        showAllError: true,
        beforeSubmit: function (curform) {
            //在验证成功后，表单提交前执行的函数，curform参数是当前表单对象。
            var actionUrl = $(".formvalidate").attr('action');
            var isajax = $(".formvalidate").attr('isajax');
            var dialogid = $("#dialogid").val();
            if (isajax == 'true' || isajax == 'undefined') {
                ajaxSubmitPost(actionUrl, dialogid, '', 'no'); //ajax提交	
                return false;
            }
            return false;
            //这里明确return false的话表单将不会提交;	
        },
        callback: function (form) {
            return false;
        }
    });


    $(document).off("click", ".frmrightClass");
    $(document).on("click", ".frmrightClass", function () {
        var url = $(this).attr('data-url');
        $("#current_load_url").val(url);
        loding();
        $(".right").load(url, '', function (response) {
            try {
                var response = $.parseJSON(response);
                if (response.status != 1) {
                    window.top.layer.msg(response.msg, {icon: 2, shade: [0.8, '#393D49'], time: 1000});
                    lodingok();
                    $(".right").html(response.msg);
                    return;
                }
            } catch (e) {
                lodingok();
            }
        });

    });
    $(document).off("click", ".dialog");
    $(document).on("click", ".dialog", function () {
        var dataurl = $(this).attr("data-url");
        var width = $(this).attr("data-width");
        var height = $(this).attr("data-height");
        var title = $(this).attr("title");
        var buttonYes = $(this).attr("data-button");

        if (typeof (buttonYes) == "undefined" || buttonYes == '') {
            buttonYes = 1;
        }
        if (typeof (height) == 'undefined') {
            height = "400px";
        }
        if (typeof (width) == 'undefined') {
            width = "750px"
        }
        var dialogid = "dialogid" + Math.random();
        if (buttonYes == 1) {
            try {

                $.dialog({
                    id: dialogid,
                    title: title,
                    width: width,
                    height: height,
                    lock: true,
                    background: '#000',
                    opacity: 0.5,
                    content: 'url:' + dataurl,
                    init: function () {
                        var iframe1 = this.iframe.contentWindow;
                        try {
                            var body = iframe1.document.body;
                            var str = body.innerHTML;
                            str = $.parseJSON(str);
                            if (str.status == 0) {
                                window.top.layer.msg(str.msg, {icon: 2, shade: [0.8, '#393D49'], time: 1000});
                                $.dialog({
                                    id: dialogid
                                }).close();
                            }
                        } catch (e) {
                        }
                    },
                    icon: 'error.gif',
                    ok: function () {
                        iframe = this.iframe.contentWindow;
                        var url = iframe.document.getElementById('DataFromSubmit').action;
                        iframe.document.getElementById("dialogid").value = dialogid;
                        iframe.document.getElementById("dosubmit").click();
                        return false;
                    },
                    cancel: true
                });
            } catch (e) {
                $.getScript("/public/vend/lhgDialog/lhgdialog.min.js?skin=iblue",
                        function () {
                            $.dialog({
                                id: dialogid,
                                title: title,
                                width: width,
                                height: height,
                                lock: true,
                                background: '#000',
                                opacity: 0.5,
                                content: 'url:' + dataurl,
                                init: function () {
                                    var iframe1 = this.iframe.contentWindow;
                                    try {

                                        var body = iframe1.document.body;
                                        var str = body.innerHTML;
                                        str = $.parseJSON(str);
                                        if (str.status == 0) {
                                            window.top.layer.msg(str.msg, {icon: 2, shade: [0.8, '#393D49'], time: 1000});
                                            $.dialog({
                                                id: dialogid
                                            }).close();
                                        }
                                    } catch (e) {
                                        //alert(e);		
                                    }
                                },
                                icon: 'error.gif',
                                ok: function () {
                                    iframe = this.iframe.contentWindow;
                                    var url = iframe.document.getElementById('DataFromSubmit').action;
                                    iframe.document.getElementById("dialogid").value = dialogid;
                                    iframe.document.getElementById("dosubmit").click();
                                    return false;
                                },
                                cancel: true
                            });
                        });
            }
        } else {

            try {
                $.dialog({

                    id: dialogid,
                    title: title,
                    width: width,
                    height: height,
                    lock: true,
                    background: '#000',
                    opacity: 0.5,
                    content: 'url:' + dataurl,
                    init: function () {

                        var iframe1 = this.iframe.contentWindow;
                        try {
                            var body = iframe1.document.body;
                            var str = body.innerHTML;
                            str = $.parseJSON(str);
                            if (str.status == 0) {
                                window.top.layer.msg(str.msg, {icon: 2, shade: [0.8, '#393D49'], time: 1000});
                                $.dialog({
                                    id: dialogid
                                }).close();
                            }
                        } catch (e) {
                            alert(e);
                        }
                    }
                });
            } catch (e) {

                $.getScript("/public/vend/lhgDialog/lhgdialog.min.js?skin=iblue",
                        function () {
                            $.dialog({

                                id: dialogid,
                                title: title,
                                width: width,
                                height: height,
                                lock: true,
                                background: '#000',
                                opacity: 0.5,
                                content: 'url:' + dataurl,
                                init: function () {

                                    var iframe1 = this.iframe.contentWindow;
                                    try {
                                        var body = iframe1.document.body;
                                        var str = body.innerHTML;
                                        str = $.parseJSON(str);
                                        if (str.status == 0) {
                                            window.top.layer.msg(str.msg, {icon: 2, shade: [0.8, '#393D49'], time: 1000});
                                            $.dialog({
                                                id: dialogid
                                            }).close();
                                        }
                                    } catch (e) {
                                        alert(e);
                                    }
                                }
                            });
                        });
            }
        }
    });

    /**全选**/
    $(document).off("click", ".checkboxall");
    $(document).on("click", ".checkboxall", function () {
        try {
            var isChecked = $(this).prop("checked");
            $(".checkSon").prop("checked", isChecked);
        } catch (e) {
            var isChecked = true;
            $(".checkSon").prop("checked", isChecked);
        }
    });

    /** office文件上传 **/
    $(document).off("click", ".upOffice");
    $(document).on('change', '.upOffice', function () {
        var loadingDiv = window.top.layer.load();
        var $this = $(this);
        var id = $this.attr("id");//获取当前上传域名称
        var upkey = $this.attr("upkey");//获取需要赋值数据据字段框
        var moduleName = $this.attr("module-name");//当前上传的控制器名
        var fieldsName = $this.attr("fields-name");//当前上传的方法
        if (typeof (upkey) == "undefined") {
            upkey = "image";//如果没有upkey,默认为image
        }
        $("#upload_msg").ajaxStart(function () {
            $(this).show();
        });
        var numArr = [];
        var txt = $this.parent().find("input:file"); //获取所有上传附件框
        for (var i = 0; i < txt.length; i++) {
            numArr.push(txt.eq(i).attr('id'));       //将附件框的ID添加到数组中
        }
        $.ajaxFileUpload({
            url: '../uploads/officeUpload.html?id=' + id + '&moduleName=' + moduleName + '&fieldsName=' + fieldsName + '&jq_time=' + new Date().getTime(),
            secureuri: false,
            fileElementId: numArr,
            dataType: 'text', //text json
            success: function (result) {
                var data = jQuery.parseJSON(result);
                if (data.error == '0') {
                    $("#" + upkey).val(data.url);
                } else {
                    window.top.layer.msg(data.msg, {icon: 2, shade: [0.8, '#393D49'], time: 1000});
                }
                window.top.layer.close(loadingDiv);
            }
        });
    });


    /** 文件上传 **/
    $(document).off("click", ".upfiles");
    $(document).on('change', '.upfiles', function () {
        var loadingDiv = window.top.layer.load();
        var $this = $(this);
        var id = $this.attr("id");//获取当前上传域名称
        var upkey = $this.attr("upkey");//获取需要赋值数据据字段框
        var moduleName = $this.attr("module-name");//当前上传的控制器名
        var fieldsName = $this.attr("fields-name");//当前上传的方法
        if (typeof (upkey) == "undefined") {
            upkey = "image";//如果没有upkey,默认为image
        }
        $("#upload_msg").ajaxStart(function () {
            $(this).show();
        });
        var numArr = [];
        var txt = $this.parent().find("input:file"); //获取所有上传附件框
        for (var i = 0; i < txt.length; i++) {
            numArr.push(txt.eq(i).attr('id'));       //将附件框的ID添加到数组中
        }
        $.ajaxFileUpload({
            url: '../uploads/fileupload.html?id=' + id + '&moduleName=' + moduleName + '&fieldsName=' + fieldsName + '&jq_time=' + new Date().getTime(),
            secureuri: false,
            fileElementId: numArr,
            dataType: 'text', //text json
            success: function (result) {
                var data = jQuery.parseJSON(result);
                if (data.error == '0') {
                    $("#" + upkey).val(data.url);
                } else {
                    window.top.layer.msg(data.msg, {icon: 2, shade: [0.8, '#393D49'], time: 1000});
                }
                window.top.layer.close(loadingDiv);
            }
        });
    });


    /** 单个图片上传**/
    $(document).off("click", ".upimg");
    $(document).on('change', '.upimg', function () {
        var $this = $(this);
        var loadingDiv = window.top.layer.load();
        var id = $this.attr("id");//获取当前上传域名称
        var upkey = $this.attr("upkey");//获取需要赋值数据据字段框
        var moduleName = $this.attr("module-name");//当前上传的控制器名
        var fieldsName = $this.attr("fields-name");//当前上传的方法
        if (typeof (upkey) == "undefined") {
            upkey = "image";//如果没有upkey,默认为image
        }
        $("#upload_msg").ajaxStart(function () {
            $(this).show();
        });
        var numArr = [];
        var txt = $this.parent().find("input:file"); //获取所有上传附件框
        for (var i = 0; i < txt.length; i++) {
            numArr.push(txt.eq(i).attr('id'));       //将附件框的ID添加到数组中
        }
        $.ajaxFileUpload({
            url: '../uploads/uploadfile.html?id=' + id + '&moduleName=' + moduleName + '&fieldsName=' + fieldsName + '&jq_time=' + new Date().getTime(),
            secureuri: false,
            fileElementId: numArr,
            dataType: 'text', //text json
            success: function (result) {
                var data = jQuery.parseJSON(result);
                if (data.error == '0') {
                    $("#" + upkey).attr('data-img', data.url);
                    $("#" + upkey).val(data.url);
                } else {
                    window.top.layer.msg(data.msg, {icon: 2, shade: [0.8, '#393D49'], time: 1000});
                }
                window.top.layer.close(loadingDiv);
            }
        });
    });

    /** 多图片上传**/
    $(document).off("click", ".mult_upimg");
    $(document).on('change', '.mult_upimg', function () {
        var loadingDiv = window.top.layer.load();
        var $this = $(this);
        var id = $this.attr("id");//获取当前上传域名称
        var upkey = $this.attr("upkey");//获取需要赋值数据字段框
        if (typeof (upkey) == "undefined") {
            upkey = "image";//如果没有upkey,默认为image
        }
        $("#upload_msg").ajaxStart(function () {
            $(this).show();
        });
        var numArr = [];
        var txt = $this.parent().find("input:file"); //获取所有上传附件框
        for (var i = 0; i < txt.length; i++) {
            numArr.push(txt.eq(i).attr('id'));       //将附件框的ID添加到数组中
        }
        $.ajaxFileUpload({
            url: '../uploads/multupload.html?id=' + id + '&jq_time=' + new Date().getTime(),
            secureuri: false,
            fileElementId: numArr,
            dataType: 'text', //text json
            success: function (result) {
                var data = jQuery.parseJSON(result);
                for (var o in data) {
                    if (data[o].error == 0) {
                        var obj = upkey + "_lastHtml";
                        $("#" + obj).append('<div class="imgContainer"><input type="hidden" name="' + upkey + '[]" value="' + data[o].url + '"> <img title="' + data[o].url + '" alt="' + data[o].url + '" src="' + data[o].url + '" onclick="imgDisplay(this)"><p class="imgDelete">删除</p></div>');
                    }
                }
                window.top.layer.close(loadingDiv);
            }
        });
    });

    $(document).off("click", ".imgDelete");
    $(document).on('click', '.imgDelete', function () {
        $(this).parent().remove();
    });


    /**分页点击**/
    $(document).off("click", ".pageList a");
    $(document).on("click", ".pageList a", function () {
        var url = $(this).attr('href');
        if (typeof (url) == "undefined") {
            return false;
        }
        $("#current_load_url").val(url);
        loding();
        $(".right").load(url, '',
                function (response) {
                    try {
                        var response = $.parseJSON(response);
                        if (response.status == 1) {
                        } else {
                            window.top.layer.msg(response.msg, {icon: 2, shade: [0.8, '#393D49'], time: 1000});
                            return;
                        }
                    } catch (e) {
                        lodingok();
                    }
                });
        return false;
    })

    /** 列表页搜索**/
    $(document).off("click", ".searchButton");
    $(document).on("click", ".searchButton",
            function () {
                var url = $(this).attr("data-url");
                url = url + "?" + $('.ajaxSearchFrom').serialize();
                $("#current_load_url").val(url);
                loding();
                $(".right").load(url, '', function (response) {
                    try {
                        var response = $.parseJSON(response);
                        if (response.status == 1) {

                        } else {
                            window.top.layer.msg(response.msg, {icon: 2, shade: [0.8, '#393D49'], time: 1000});
                            return;
                        }
                    } catch (e) {
                        lodingok();
                    }
                });
            });

    /**删除按钮**/
    $(document).off("click", ".remove");
    $(document).on("click", ".remove", function () {
        var dataurl = $(this).attr("data-url");
        zmCmsConfirm(dataurl, "确认要删除吗?");
    });

    /**更改状态**/
    $(document).off("click", ".pointer");
    $(document).on("click", ".pointer", function () {
        var dataurl = $(this).attr("data-url");
        var dataid = $(this).attr("data-id");
        var obj = $(this);
        if (dataurl.indexOf("?") < 0) {
            dataurl = dataurl + "?";
        }
        var datavalue = $(this).attr("data-value");
        if (datavalue == 1) {
            var txt = "您确定要禁用吗？";
        } else {
            var txt = "您确定要启用吗？";
        }
        var postData = "id=" + dataid + "&value=" + datavalue;
        zmCmsConfirm(dataurl, txt, postData);
    });
    $(document).off("click", ".webSiteSubmit");
    $(document).on("click", ".webSiteSubmit", function () {
        var dataurl = $("#DataFromSubmit").attr('action');
        if (dataurl.indexOf("?") < 0) {
            dataurl = dataurl + "?";
        }
        var postData = $('.formvalidate').serialize();
        $.ajax({
            cache: true,
            type: "post",
            url: dataurl + "&random=" + Math.random(),
            data: postData,
            async: true,
            error: function (request) {
                $.dialog.tips("系统错误", 2, 'error.gif');
            },
            success: function (data) {
                var data = $.parseJSON(data);
                if (data.status == 1) {
                    layer.msg(data.msg, {icon: 1, shade: [0.8, '#393D49'], time: 1000});
                    $(".right").load(current_load_url);
                } else {
                    layer.msg(data.msg, {icon: 2, shade: [0.8, '#393D49'], time: 1000});
                }



            }
        });
        return false;

    });

    //自定义radio样式
    $(document).off("click", ".cb-enable");
    $(document).on("click", ".cb-enable", function () {
        var parent = $(this).parents('.onoff');
        $('.cb-disable', parent).removeClass('selected');
        $(this).addClass('selected');
        $('.checkbox', parent).attr('checked', true);
    });
    $(document).off("click", ".cb-disable");
    $(document).on("click", ".cb-disable", function () {
        var parent = $(this).parents('.onoff');
        $('.cb-enable', parent).removeClass('selected');
        $(this).addClass('selected');
        $('.checkbox', parent).attr('checked', false);
    });

    //批量删除
    $(document).off("click", ".listDelete");
    $(document).on("click", ".listDelete", function () {
        var dataurl = $("#formsubmit").attr('action');
        var data = $('.formvalidate2').serialize();
        zmCmsConfirm(dataurl, "确定要批量删除吗?",data);
    });

    $(document).off("click", ".category_select_class");
    $(document).on("click", ".category_select_class", function () {
        var url = $(this).attr('data-url');
        $("#current_load_url").val(url);
        loding();
        $(".right").load(url, '', function (response) {
            try {
                var response = $.parseJSON(response);
                if (response.status != 1) {
                    window.top.layer.msg(response.msg, {icon: 2, shade: [0.8, '#393D49'], time: 1000});
                    return;
                }
            } catch (e) {
                lodingok();
            }
        });

    });

    $(document).off("click", "input[name='is_seo']");
    $(document).on("click", "input[name='is_seo']", function () {
        var val = $(this).val();
        if (val == 1) {
            $(".seo_tr").fadeIn();
        } else {
            $(".seo_tr").fadeOut();
        }

    });

    $(document).click(function () {
        $(".select-list").hide();
    })



});

/*
 *  用来给不支持HTML5 placeholder属性的浏览器增加此功能。
 *  @param element {String or Object} 需要添加placeholder提示的输入框选择器或者输入框jquery对象。
 *  @param defualtCss {String} 提示默认的样式class。
 */

function showRemind(element, defualtCss) {
    if (-[1, ]) {
        return false;
    }
    $(element).each(function (el, i) {
        var placeholder = $(this).attr('placeholder');
        if (placeholder) {
            $(this).addClass(defualtCss).val(placeholder);
            $(this).focus(function (e) {
                if ($(this).attr('placeholder') === $(this).val()) {
                    $(this).val('').removeClass(defualtCss);
                }
            });
            $(this).blur(function (e) {
                if ($(this).val() === "") {
                    $(this).addClass(defualtCss).val($(this).attr('placeholder'));
                }
            });
        }
    });
}

function loding() {
    $("#BgDiv1").css({display: "block", height: $(document).height()});
    var yscroll = document.documentElement.scrollTop;
    var screenx = $(window).width();
    var screeny = $(window).height();
    $(".DialogDiv").css("display", "block");
    $(".DialogDiv").css("top", yscroll + "px");
    var DialogDiv_width = $(".DialogDiv").width();
    var DialogDiv_height = $(".DialogDiv").height();
    $(".DialogDiv").css("left", (screenx / 2 - DialogDiv_width / 2) + "px")
    $(".DialogDiv").css("top", (screeny / 2 - DialogDiv_height / 2) + "px")
    $("body").css("overflow", "hidden");
}
function lodingok() {
    $('#BgDiv1').delay(0).hide(0);
    $('.DialogDiv').delay(0).hide(0);
}

function ajaxSubmitPost(url, dialogid, formvalidate, no) {
    if (dialogid == '') {
        dialogid = 'add';
    }
    if (formvalidate == '') {
        var data = $('.formvalidate').serialize();
    } else {
        var data = $('.formvalidate2').serialize();
    }
    $.ajax({
        cache: true,
        type: "POST",
        url: url,
        data: data,
        async: false,
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            window.top.layer.msg("系统错误", {icon: 2, shade: [0.8, '#393D49'], time: 1000});
        },
        success: function (data) {
            var data = $.parseJSON(data);
            var msg = data.msg;
            var status = data.status;
            if (data.status == 1) {
                window.top.layer.msg(msg, {icon: 1, shade: [0.6, '#000'], time: 1000});
                if (data.hidden == "yes") {
                    try {
                        if (dialogid) {
                            window.top.$.dialog({
                                id: dialogid
                            }).time(1);
                        }
                    } catch (e) {
                    }
                } else {
                    window.top.$.dialog({
                        id: dialogid
                    }).reload(dialogid, current_load_url);
                }
                var current_load_url = window.top.$("#current_load_url").val();
                if (current_load_url != "") {
                    window.top.$(".right").load(current_load_url);
                }
                //原版setTimeout(function(){window.top.$.dialog({id:dialogid}).close();},1000);
            } else {
                window.top.layer.msg(msg, {icon: 2, shade: [0.8, '#393D49'], time: 1000});
            }
        }
    });
    return false;

}

function setDateStyle() {
    try {
        /*
         *   @设置日期控件样式
         */
        laydate.skin('blue');
        $(document).off("click", ".datetime");
        $(document).on("click", ".datetime", function () {
            laydate({istime: true, format: 'YYYY-MM-DD hh:mm:ss'});
        });
        $(document).off("click", ".date");
        $(document).on("click", ".date", function () {
            laydate({istime: true, format: 'YYYY-MM-DD'});
        });

        $(document).off("click", ".month");
        $(document).on("click", ".month", function () {
            laydate({istime: true, format: 'YYYY-MM'});
        });
        /*
         *   @结束
         */
    } catch (e) {
        //alert(e);
    }
}

/**
 提示确认框
 **/
function zmCmsConfirm(dataurl, notice, postData) {
    layer.confirm(notice, {
        title: "操作提示",
        btn: ['确定', '取消'], //按钮
        icon: 0,
        shade: [0.8, '#393D49']
    }, function () {
        var loadingDiv = window.top.layer.load();
        $.getJSON(dataurl, postData, function (data) {
            if (data.status == 0) {
                window.top.layer.msg(data.msg, {icon: 2, shade: [0.8, '#393D49'], time: 1000});
            } else {
                var current_load_url = $("#current_load_url").val();
                if (current_load_url != "") {
                    $(".right").load(current_load_url);
                } else {
                    window.location.reload();
                }
                window.top.layer.msg(data.msg, {icon: 1, shade: [0.8, '#393D49'], time: 500});
            }
            window.top.layer.close(loadingDiv);
        });
    }, function () {

    });
}


//图片灯箱
function imgDisplay(obj) {
    var src = $(obj).attr("src");
    var imgHtml = '<div style="width: 100%;height: 100vh;overflow: auto;background: rgba(0,0,0,0.5);text-align: center;position: fixed;top: 0;left: 0;z-index: 9999;"><img src=' + src + ' style="margin-top: 100px; max-width:700px;margin-bottom: 100px;"/><p style="font-size: 50px;position: fixed;top: 30px;right: 30px;color: white;cursor: pointer;" onclick="closePicture(this)">×</p></div>'
    window.top.$('body').append(imgHtml);
}
//关闭
function closePicture(obj) {
    $(obj).parent("div").remove();
}

// 预览图片文字
this.vtip = function () {
    this.xOffset = -10; 		// x distance from mouse
    this.yOffset = 15; 			// y distance from mouse       
    $(".vtip").unbind().hover(
            function (e) {
                data_img = $(this).attr('data-img');
                if (data_img == 'undefined' || data_img == '') {
                    data_ttl = $(this).attr('data-ttl');
                    if (data_ttl == 'undefined' || data_ttl == '') {
                        this.t = data_ttl;
                    } else {
                        this.t = '暂无预览';
                    }
                } else {
                    this.t = '<img src="' + data_img + '" style="max-width:200px;"/>';
                }
                this.title = '';
                this.top = (e.pageY + yOffset);
                this.left = (e.pageX + xOffset);
                $('body').css("cursor", "help");
                $('p#vtip').width() > 200 ? $('p#vtip').width(200) : '';
                $('body').append('<p id="vtip">' + this.t + '</p>');
                $('p#vtip').css("top", this.top + "px").css("left", this.left + "px").fadeIn(0);
            },
            function () {
                this.title = this.t;
                $('body').css("cursor", "");
                $("p#vtip").fadeOut("slow").remove();
            }
    ).mousemove(
            function (e) {
                this.top = (e.pageY + yOffset);
                this.left = (e.pageX + xOffset);
                $("p#vtip").css("top", this.top + "px").css("left", this.left + "px");
            }
    );
};
