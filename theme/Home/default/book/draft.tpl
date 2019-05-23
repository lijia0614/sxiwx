<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>创作平台</title>
    <link rel="stylesheet" type="text/css" href="css/0_8b3eb11c.css">
    <link rel="stylesheet" type="text/css" href="/public/layui/css/layui.css">
    <link href="css/app_1f306cd5.css" rel="stylesheet">
    <script src="/public/vend/laydate/laydate.js"></script>
    <script src="/public/layui/layui.js"></script>
</head>
<body><!--[if lt IE 10]>
<![endif]-->
<div id="root">
    <div class="app-wrap">
        <include file="common:users_header"/>
        <div class="main-wrap">
            <include file="common:users_nav"/>
            <section class="main-content">
                <include file="common:book_nav"/>
                <div class="book-draft-wrap">
                    <div class="chapter-aside">
                        <div class="top">共<span>{$count}</span>章</div>
                        <ul class="ant-menu ant-menu-light ant-menu-root ant-menu-inline" role="menu"
                            aria-activedescendant="" tabindex="0" style="width: 220px;">

                            <li class="ant-menu-submenu ant-menu-submenu-inline ant-menu-submenu-open">
                                <volist name="list" id="vo">
                                    <ul class="ant-menu ant-menu-sub ant-menu-inline" role="menu"
                                        aria-activedescendant=""
                                        id="1033$Menu" style="">
                                        <li class="ant-menu-item" role="menuitem" aria-selected="false"
                                            style="padding-left: 20px; height: 100px">
                                            <a href="{:url('book/draft',['id'=>$vo['b_id'],'d_id'=>$vo['id']])}"
                                               style="text-decoration: none;">
                                                <div class="component-chapter-item-wrap">
                                                    <div class="chapter-name clearfix">
                                                        <span class="name-long fl">{$vo['name']}</span>
                                                    </div>
                                                    <div class="chapter-words">共 {$vo.leng} 字
                                                        <span class="fr">{$vo.time|date='m-d H:i'}</span>
                                                    </div>
                                                </div>
                                            </a>
                                        </li>
                                </volist>
                        </ul>
                        </li>

                        </ul>
                    </div>
                    <div class="component-editor-wrap" style="position: relative">
                        <div class="tool-bar clearfix">
                            <div class="fr action">
                                </button>
                                <button type="button" class="ant-btn site-demo-layedit icon-style-calc"
                                        data-type="content">
                                    <i></i><span> 字数统计</span>
                                </button>
                                <button type="button" class="ant-btn site-demo-layedit icon-style-save"
                                        data-type="content">
                                    <i></i><span> 保存</span>
                                </button>
                                <button type="button" class="ant-btn site-demo-layedit icon-style-publish"
                                        data-type="content">
                                    <i></i><span> 发布</span>
                                </button>
                            </div>
                        </div>
                        <input type="hidden" id="b_id" value="{$b_id}"/>
                        <input type="hidden" id="d_id" value="{$data['id']}"/>

                        <input class="ant-input ant-input-lg article-title" placeholder="此处输入章节号与章节名，示例“第九章 性感姐妹”"
                               type="text" id="name"
                               value="{$data['name']}">
                        <textarea class="ant-input article-textarea" id="content"
                                  placeholder="请开始您的创作吧！">{$data['content']}</textarea>
                        <style>
                            .layui-layedit {
                                position: absolute;
                                top: 120px;
                                width: 100%;
                                bottom: 80px;
                            }
                        </style>
                        <textarea style="height: 80px;width: 718px;margin-left: 0;border: 1px solid #e8e8e8;position: absolute; bottom: 0; left: 0;" class="ant-input article-textarea" id="say" placeholder="我有话说">{$data['author_say']}</textarea>
                    </div>
                </div>
            </section>
        </div>
        <footer class="text-center">Copyright © 2017-2018 {$site_name} All Rights Reserved</footer>
    </div>
</div>

<!--发布弹出式-->
<div role="document" class="ant-modal"
     style="width: 520px; position: fixed;top: 50%;margin-top: -158px;left: 50%;margin-left: -260px;display: none">
    <div class="ant-modal-content">
        <button aria-label="Close" class="ant-modal-close">
            <span class="ant-modal-close-x"></span>
        </button>
        <div class="ant-modal-header">
            <div class="ant-modal-title" id="rcDialogTitle0">章节发布</div>
        </div>
        <div class="ant-modal-body">
            <div class="ant-row ant-form-item" style="margin-bottom: 0px;">
                <div class="ant-col-6 ant-form-item-label"><label class="" title="发布章节">发布章节</label></div>
                <div class="ant-col-18 ant-form-item-control-wrapper">
                    <div class="ant-form-item-control"><span class="ant-form-item-children">
                            <div id="c_name">{$data['name']}</div>
                        </span>
                    </div>
                </div>
            </div>
            <div class="ant-row ant-form-item" style="margin-bottom: 0px;">
                <div class="ant-col-6 ant-form-item-label"><label class="" title="字数统计">字数统计</label></div>
                <div class="ant-col-18 ant-form-item-control-wrapper">
                    <div class="ant-form-item-control">
                        <span class="ant-form-item-children">
                            <div id="c_leng">{$data['leng']}</div>
                        </span>
                    </div>
                </div>
            </div>
            <div class="ant-row ant-form-item" style="margin-bottom: 0px;">
                <div class="ant-col-6 ant-form-item-label">
                    <label class="" title="设置发布时间">设置发布时间</label>
                </div>
                <div class="ant-col-18 ant-form-item-control-wrapper">
                    <div class="ant-form-item-control">
                        <span class="ant-form-item-children">
                            <div class="ant-radio-group">
                                <label name="type" class="ant-radio-wrapper ant-radio-wrapper-checked">
                                    <span class="ant-radio ant-radio-checked">
                                        <input type="radio" class="ant-radio-input" value="1">
                                        <span class="ant-radio-inner"></span>
                                    </span>
                                    <span>立即发布</span>
                                </label>
                                <br>
                                <label name="type" class="ant-radio-wrapper">
                                    <span class="ant-radio">
                                        <input type="radio" class="ant-radio-input" value="2">
                                        <span class="ant-radio-inner"></span>
                                    </span>
                                    <span>定时发布</span>
                                </label>


                                    <span class="ant-calendar-picker">
                                        <div>
                                            <input type="text" id="time" class="form_input"
                                                   onclick="laydate({istime: true, format: 'YYYY-MM-DD hh:mm:ss'});"
                                                   validate="{ required:true,maxlength:300}" value=""
                                                   placeholder="选择时间">
                                            <span class="ant-calendar-picker-icon"></span>
                                        </div>
                                    </span>
                                    <div style="position: absolute; top: 0px; left: 0px; width: 100%;">
                                        <div> </div>
                                    </div>
                            </div>
                        </span>
                    </div>
                </div>
            </div>
        </div>
        <div class="ant-modal-footer">
            <button type="button" class="ant-btn ant-btn-primary1">
                <span>发 布</span>
            </button>
        </div>
    </div>
    <div tabindex="0" style="width: 0px; height: 0px; overflow: hidden;">sentinel</div>
</div>

<script>
    layui.use('layedit', function () {
        var layedit = layui.layedit;

        //构建一个默认的编辑器
        var index = layedit.build('content', {
            tool: ['left', 'center', 'right']
            , height: 530
        });
        //编辑器外部操作
        var active = {
            content: function () {
                var content = layedit.getContent(index); //获取编辑器内容

            }
        };

        $('.icon-style-save').on('click', function () {
            var type = $(this).data('type');
            active[type] ? active[type].call(this) : '';
            var name = $('#name').val();
            var content = layedit.getContent(index);
            var say = $('#say').val();
            var b_id = $('#b_id').val();
            var d_id = $('#d_id').val();
            if (name == '') {
                layer.alert('请填写章节名称');
                return false;
            }
            if (content == '') {
                layer.alert('您还没有写章节内容哦');
                return false;
            }
            $.ajax({
                url: "{:url('book/doSaveDraft')}",
                data:{"name":name,"content":content,"b_id":b_id,"d_id":d_id,"say":say},
                type: "POST",
                success: function (req) {
                    console.log(req);
                    var c = JSON.parse(req);
                    if (c.status == 0) {
                        layer.alert(req.msg);
                        return false;
                    }
                    if (c.status == 1) {
                        setTimeout(function () {
                            window.location.href = "{:url('book/draft')}" + '&id=' + c.data;
                        }, 0);
                    }

                }
            });
        });


        // 发布弹出层
        $('.icon-style-publish').click(function () {
            $('.ant-modal').toggle()
            var name = $('#name').val();
            var content = layedit.getContent(index);
            content = content.replace(/<.*?>/ig, "").replace(/\ +/g,"").replace(/[ ]/g,"").replace(/[\r\n]/g,"");
            var words = content.length;
            $('#c_name').text(name);
            $('#c_leng').text(words + '字');
        });
        $('.ant-modal-close-x').click(function () {
            $('.ant-modal').css('display', 'none')
        })

        $('.icon-style-calc').click(function () {
            var content = layedit.getContent(index);
            var title = content.replace(/<[^>]+>/g, "");
            var words = title.length;
            alert('当前字数为：' + words);
        })


        //去发布
        $('.ant-btn-primary1').click(function () {
            var type = $("input[type='radio']:checked").val();

            var time = $('#time').val();
            if (type == undefined) {
                type = 1;
            }
            if (type == 2) {
                if (time == '') {
                    alert('请选择发布时间');
                    return false;
                }
            }
            var name = $('#name').val();
            var content = layedit.getContent(index);
            var b_id = $('#b_id').val();
            var d_id = $('#d_id').val();
            var say = $('#say').val();

            if (name == '') {
                layer.alert('请填写章节名称');
                return false;
            }
            if (content == '') {
                layer.alert('您还没有写章节内容哦');
                return false;
            }

            $.ajax({
                url: "{:url('book/publish')}",
                data:{"name":name,"content":content,"b_id":b_id,"d_id":d_id,"type":type,"time":time,"say":say},
                type: "POST",
                success: function (req) {
                    console.log(req);
                    var c = JSON.parse(req);
                    if (c.status == 0) {
                        alert(c.msg);
                        return false;
                    }
                    if (c.status == 1) {
                        alert(c.msg);
                        setTimeout(function () {
                            window.location.href = "{:url('book/draft')}" + '&id=' + c.data;
                        }, 1000);
                    }

                }
            });
        })

    });


    $('.ant-radio-group label').on('click', function () {
        $(this).addClass('ant-radio-wrapper-checked').siblings().removeClass('ant-radio-wrapper-checked');
        $(this).find('span.ant-radio').addClass('ant-radio-checked').parents('label').siblings('label').find('span.ant-radio').removeClass('ant-radio-checked');
        $(this).find("input.ant-radio-input").attr("checked", true).parents('label').siblings('label').find("input.ant-radio-input").attr("checked", false)
    })
</script>
</body>











