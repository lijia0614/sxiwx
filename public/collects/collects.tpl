<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>采集测试</title>
<style type="text/css">
body{font-family:"微软雅黑"; font-size:14px;}
.data_detail{width:1000px; border:1px dotted #CCCCCC; margin:5px auto; padding:10px;}
.key{font-size:16px; clear:both;}
.content{font-size:14px; clear:both;}
</style>
</head>

<body>
<div style="width:1000px; border:1px dotted #CCCCCC; margin:5px auto; padding:10px;"><h2>采集到的内容列表URL:</h2></div>
<div style="width:1000px; border:1px dotted #CCCCCC; margin:5px auto; padding:10px;">
<textarea name="urls" style="width:95%; height:200px; padding:5px;"><volist name="urls" id="vo">{$vo['url']}<?php echo("\r\n"); ?></volist></textarea>
</div>
<div style="width:1000px; border:1px dotted #CCCCCC; margin:5px auto; padding:10px;"><h2>采集到的内容：</h2></div>
<volist name="data" id="vo">
	<div class="data_detail">
       <strong class="key">{$key}:</strong>
       <div class="content">
           {$vo}
       </div>
    </div>
</volist>
</body>
</html>
