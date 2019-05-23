<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>创作平台</title>
    <link href="css/app_1f306cd5.css?" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="css/0_8b3eb11c.css">
</head>
<body><!--[if lt IE 10]>
<![endif]-->
<div id="root">
    <div class="app-wrap">
        <include file="common:users_header"/>
        <div class="main-wrap">
            <include file="common:users_nav"/>
            <section class="main-content">
                <div class="create-book-wrap"><h2 class="title">创建作品</h2>


                    <div class="step-2 text-center"><img width="60" src="//s.weituibao.com/static/8wvkc.png">
                        <div class="create-success">作品创建成功！</div>
                        <div class="create-desc">新建作品后，请尽快上传新章节，章节上传满1500字之后将会进入编辑审核<br>后台，编辑将会在2个工作日内进行审核。</div>
                        <a href="{:url('book/draft',['id'=>$id])}">
                            <button type="button" class="ant-btn ant-btn-primary ant-btn-lg" style="margin-top: 30px;">
                                <span>继续上传章节</span></button>
                        </a>
                        <div class="legal-notice text-left">根据国家相关法律法规要求，请勿上传任何色情、低俗、涉政等 违法违规内容，我们将会根据法规进行审核处理和上报。</div>
                    </div>
                </div>
            </section>
        </div>
        <footer class="text-center">Copyright © 2017-2018 杭州文心网络科技有限公司 All Rights Reserved</footer>
    </div>
</div>


<div>
    <div class="ant-message"><span></span></div>
</div>
</body>