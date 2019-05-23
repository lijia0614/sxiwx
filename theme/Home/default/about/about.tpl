<head>
    <meta charset="utf-8">
    <!-- <meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1,user-scalable=no"> -->
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=no">
    <meta http-equiv="keywords" content="{$site_keywords}">
    <meta http-equiv="description" content="{$site_description}">
    <read table='webpage' id="$id"></read>
    <!-- <title></title> -->
    <title>{$title} </title>
    <link rel="stylesheet" href="css/font_626180_rzkibgk7ogl.css">

    <link rel="preload" href="css/0.2933c71f.css" as="style">

    <link rel="preload" href="css/style.2933c71f.css" as="style">


    <link rel="preload" href="js/vendors.2933c71f.js" as="script">

    <link rel="preload" href="js/client.2933c71f.js" as="script">


    <base href="/">
    <link href="css/0.2933c71f.css" rel="stylesheet">
    <link href="css/style.2933c71f.css" rel="stylesheet">
    <title data-react-helmet="true"></title>

</head>
<body>
<div id="app">
    <div class="wrap">
        <include file="common:header"/>
        <div class="container-wrap public-container-wrap ">
            <div class="m-nav "><i class="iconfont icon-xiangzuo"></i><span>关于我们</span></div>
            <div class="public container">
                <div class="public-page clearfix">
                    <div class="aside-nav">
                        <ul class="clearfix">
                            <zhimeng table="webpage" where="['pid','=',186]" order="sort desc">
                                <a style="color: #333" href="{:url('about/about',['id'=>$r['id']])}">
                                    <li <if condition="$id eq $r['id']"> class="active" </if> >
                                    {$r.title}
                                    </li>
                                </a>
                            </zhimeng>
                        </ul>
                    </div>
                    <div class="content">
                        <div class="abount-content">
                            <h4>{$title}</h4>
                            {$content}
                        </div>
                    </div>
                </div>
            </div>
            <include file="common:footer"/>
        </div>
    </div>
</div>


<div>
    <div class="rc-notification" style="top: 65px; left: 50%;"><span></span></div>
</div>

</body>