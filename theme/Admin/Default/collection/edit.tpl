<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
 <head> 
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" /> 
  <title></title> 
  <link href="/public/admin/default/css/edit.css" rel="stylesheet" type="text/css" /> 
   <script src="/public/admin/default/js/jquery-1.9.1.js"></script> 
    <script src="/public/vend/Validform/Validform_v5.3.2_min.js"></script>
    <script src="/public/admin/default/js/common.js"></script>
 </head> 
 <body> 
<div class="nav"><span>编缉</span><a href="javascript:window.history.go(-1);" class="right">返回</a></div>
  <input type="hidden" name="current_load_url" id="current_load_url" value="" /> 

  <div class="pad-10"> 
   <div class="common-form"> 
   <if condition="isset($id)">
    <form action="{:url(SYS_PATH."/collection/edit",array('id'=>$id))}" method="post" class="formvalidate" id="DataFromSubmit" isajax="true"> 
    <input type="hidden" name="id" value="{$id}" />
   <else />
   	<form action="{:url(SYS_PATH."/collection/add")}" method="post" class="formvalidate" id="DataFromSubmit" isajax="true">
   </if>
     <input type="hidden" name="model" value="{$model}" id="model" />
     <fieldset> 
      <legend>填写信息</legend> 
      <table width="100%" class="table_form"> 
       <tbody> 
       
        <tr> 
         <td width="12%">采集名称</td> 
         <td><input type="text" id="info[collect_title]"  style="width:200px;" class="input-text" validate="{ required:true,maxlength:200}" value="{:isset($data['collect_title'])&&$data['collect_title']?$data['collect_title']:''}" name="info[collect_title]" placeholder="请输入采集名称" /> <span id="messageBox" for="title" generated="true" class="onShow ">请输入采集名称</span> </td> 
        </tr>       
       
        <tr> 
         <td width="12%">采集URL</td> 
         <td><input type="text" id="info[collect_url]"  style="width:500px;" class="input-text" validate="{ required:true,maxlength:500}" value="{:isset($data['collect_url'])&&$data['collect_url']?$data['collect_url']:''}" name="info[collect_url]" placeholder="请输入待采集URL" /> <span id="messageBox" for="title" generated="true" class="onShow ">请输入待采集URL</span></td> 
        </tr>
        
        <tr> 
         <td width="12%">目标站编码</td> 
         <td>
         <select name="info[collect_content_type]" id="info[collect_content_type]" style="width:150px;">
         	<option value="UTF-8">默认</option>
         	<option value="UTF-8" <if condition="isset($data['collect_content_type'])&&$data['collect_content_type']=='UTF-8'">selected="selected"</if>>UTF-8</option>
            <option value="GB2312" <if condition="isset($data['collect_content_type'])&&$data['collect_content_type']=='GB2312'">selected="selected"</if>>GB2312</option>
         </select>
        <span id="messageBox" for="title" generated="true" class="onShow ">目标站编码,乱码解决方案</span></td> 
        </tr>        
        
        <tr> 
         <td width="12%">采集列表分页</td> 
         <td><input type="radio" value="1" name="info[collect_page_status]"  <if condition="isset($data['collect_page_status'])&&$data['collect_page_status']==1"> checked="checked"</if> />&nbsp;是&nbsp;&nbsp;<input type="radio" value="0" name="info[collect_page_status]" <if condition="(isset($data['collect_page_status'])&&$data['collect_page_status']==0)||empty($data['collect_page_status'])"> checked="checked"</if> />&nbsp;否&nbsp;</td> 
        </tr>   
              
             
        
        <tr id="collect_page_status_tr" <if condition="(isset($data['collect_page_status'])&&$data['collect_page_status']==0)||empty($data['collect_page_status'])">style="display:none;"</if>> 
         <td width="12%">分页配置</td> 
         <td>开始页：<input type="text" id="collect_page_min"  style="width:50px;" class="input-text" validate="{ required:true}" value="{:isset($data['collect_page_min'])&&$data['collect_page_min']?$data['collect_page_min']:''}" name="info[collect_page_min]" placeholder="开始页" /> 结束页：<input type="text" id="collect_page_max"  style="width:50px;" class="input-text" validate="{ required:true}" value="{:isset($data['collect_page_max'])&&$data['collect_page_max']?$data['collect_page_max']:''}" name="info[collect_page_max]" placeholder="结束页" /> 
         
          <span id="messageBox" for="title" generated="true" class="onShow ">如: 采集URL,"1.html"代表第一页,将数字替换为 "分页.html"</span>
         </td> 
        </tr>        
        
        <tr> 
         <td width="12%">采集URL块</td> 
         <td>
<input type="text" id="info[get_content_urls_box]"  style="width:300px;" class="input-text" value="{:isset($data['get_content_urls_box'])&&$data['get_content_urls_box']?$data['get_content_urls_box']:''}" name="info[get_content_urls_box]" placeholder="格式如：#main" /> <span id="messageBox" for="title" generated="true" class="onShow ">如: .conent li 代表url在li标签中循环取出li为块</span> 
         </td> 
        </tr>
        
        <tr> 
         <td width="12%">采集URL规则</td> 
         <td>
<input type="text" id="info[get_content_collect_urls]"  style="width:300px;" class="input-text" validate="{ required:true,maxlength:300}" value="{:isset($data['get_content_collect_urls'])&&$data['get_content_collect_urls']?$data['get_content_collect_urls']:''}" name="info[get_content_collect_urls]" placeholder="如:.main a,代表class为main的容器下所有链接" /> <span id="messageBox" for="title" generated="true" class="onShow ">内容必须包含A标签</span> 
         </td> 
        </tr>   
               
        
        <tr> 
         <td width="12%">列表中缩略图</td> 
         <td><input type="text" id="info[small_img_url]" style="width:300px;" class="input-text" value="{:isset($data['small_img_url'])&&$data['small_img_url']?$data['small_img_url']:''}" name="info[small_img_url]" placeholder="URL列表缩略图" /><span id="messageBox" for="title" generated="true" class="onShow ">格式如：“#main .t_title img”</span></td> 
        </tr>         
        
        <tr> 
         <td width="12%">去除多余URL</td> 
         <td>
<input type="text" id="info[get_content_collect_urls_remove]"  style="width:300px;" class="input-text" value="{:isset($data['get_content_collect_urls_remove'])&&$data['get_content_collect_urls_remove']?$data['get_content_collect_urls_remove']:''}" name="info[get_content_collect_urls_remove]" placeholder="去掉无效URL规则" /> <span id="messageBox" for="title" generated="true" class="onShow ">泛匹配,格式如："info|list|show"</span> 
         </td> 
        </tr>                

        <tr> 
         <td width="12%">内容所属分类</td> 
         <td>
         {$category|raw}<span id="messageBox" for="title" generated="true" class="onShow ">采集到的内容所属分类</span> 
         </td> 
        </tr>       
        
        <!--<tr> 
         <td width="12%">内容所属容器</td> 
         <td><input type="text" id="info[collect_content_box]"  style="width:300px;" class="input-text" validate="{ required:true,maxlength:300}" value="{:isset($data['collect_content_box'])&&$data['collect_content_box']?$data['collect_content_box']:''}" name="info[collect_content_box]" placeholder="如内容分属不同容器，可填body" /> <span id="messageBox" for="title" generated="true" class="onShow ">如：“.main>div或.main div”,不填写，数据可能不全 </span> </td> 
        </tr>-->          
        
        <tr> 
         <td width="12%">标题</td> 
         <td><input type="text" id="title"  style="width:300px;" class="input-text" validate="{ required:true,maxlength:300}" value="{:isset($data['title'])&&$data['title']?$data['title']:''}" name="title" placeholder="请输入标题采集规则" /> <span id="messageBox" for="title" generated="true" class="onShow ">格式如：“.listurl a###text” </span> </td> 
        </tr> 
        
        <tr> 
         <td width="12%">采集内容分页</td> 
         <td>
<input type="text" id="info[get_content_page]"  style="width:300px;" class="input-text" value="{:isset($data['get_content_page'])&&$data['get_content_page']?$data['get_content_page']:''}" name="info[get_content_page]" placeholder="获取内容中分页的url列表规则" /> <span id="messageBox" for="title" generated="true" class="onShow ">获取内容中分页的url列表规则</span>          
         </td> 
        </tr>    


<tr> 
         <td>获取缩略图</td> 
         <td> <input type="checkbox" name="info[is_get_content_small_image]" value="1"  <if condition="isset($data['is_get_content_small_image'])&&$data['is_get_content_small_image']==1"> checked="checked"</if> />&nbsp;获取内容第一张图片为缩略图
         <span id="messageBox" for="title" generated="true" class="onShow ">勾选将获取内容中的第一张图片为缩略图</span>
         </td> 
        </tr>  

        <tr> 
         <td>内容详情</td> 
         <td> 
         <input type="text" id="content"  style="width:300px;" class="input-text" validate="{ required:true,maxlength:300}" value="{:isset($data['content'])&&$data['content']?$data['content']:''}" name="content" placeholder="请输入内容采集规则" /> <span id="messageBox" for="title" generated="true" class="onShow ">格式如：“.listurl a###html”</span>
         </td> 
        </tr>    
        <include file="public:collection_field" />     
        <tr> 
         <td>过滤标签</td> 
         <td> 
         &nbsp;<input type="checkbox" name="info[is_remove_from]" value="1"  <if condition="isset($data['is_remove_from'])&&$data['is_remove_from']==1"> checked="checked"</if> />&nbsp;FROM&nbsp;<input type="checkbox" name="info[is_remove_a]" <if condition="isset($data['is_remove_a'])&&$data['is_remove_a']==1"> checked="checked"</if> value="1" />&nbsp;A&nbsp;<input type="checkbox" name="info[is_remove_script]" value="1"  <if condition="isset($data['is_remove_script'])&&$data['is_remove_script']==1"> checked="checked"</if> />&nbsp;JS
         &nbsp;<input type="checkbox" name="info[is_remove_div]" value="1"  <if condition="isset($data['is_remove_div'])&&$data['is_remove_div']==1"> checked="checked"</if> />&nbsp;DIV&nbsp;<input type="checkbox" name="info[is_remove_p]" value="1"  <if condition="isset($data['is_remove_p'])&&$data['is_remove_p']==1"> checked="checked"</if> />&nbsp;P&nbsp;<input type="checkbox" name="info[is_remove_input]" value="1"  <if condition="isset($data['is_remove_input'])&&$data['is_remove_input']==1"> checked="checked"</if> />&nbsp;INPUT&nbsp;<input type="checkbox" name="info[is_remove_textarea]" value="1"  <if condition="isset($data['is_remove_textarea'])&&$data['is_remove_textarea']==1"> checked="checked"</if> />&nbsp;TEXTAREA&nbsp;<input type="checkbox" name="info[is_remove_iframe]" value="1"  <if condition="isset($data['is_remove_iframe'])&&$data['is_remove_iframe']==1"> checked="checked"</if> />&nbsp;IFRAME&nbsp;<input type="checkbox" name="info[is_remove_span]" value="1"  <if condition="isset($data['is_remove_span'])&&$data['is_remove_span']==1"> checked="checked"</if> />&nbsp;SPAN&nbsp;<input type="checkbox" name="info[is_remove_li]" value="1"  <if condition="isset($data['is_remove_li'])&&$data['is_remove_li']==1"> checked="checked"</if> />&nbsp;LI
         </td> 
        </tr>
        
        <tr> 
         <td>自定义过滤标签</td> 
         <td>
         	<textarea style="width:500px; height:100px;"  placeholder="如：-.content 则去掉classname为content的标签和内容,不加'-'则只去掉标签" id="is_remove_mark" name="is_remove_mark">{:isset($data['is_remove_mark'])&&$data['is_remove_mark']?$data['is_remove_mark']:''}</textarea>
            <span id="messageBox" for="title" generated="true" class="onShow ">每行一组词,去掉class的标签和内容 "-.className",去掉H1标签内容 "-h1"</span>
         </td> 
        </tr>         
        
        <tr> 
         <td>替换内容</td> 
         <td>
         	<textarea style="width:500px; height:100px;"  placeholder="原站词|替换词" id="info[replace_keyword]" name="info[replace_keyword]">{:isset($data['replace_keyword'])&&$data['replace_keyword']?$data['replace_keyword']:''}</textarea>
            <span id="messageBox" for="title" generated="true" class="onShow ">原站词|替换词,每行一组词</span>
         </td> 
        </tr>             
        
        <tr> 
         <td>过滤内容</td> 
         <td>
         	<textarea style="width:500px; height:100px;"  placeholder="过滤内容,每行一个关键词" id="info[remove_keyword]" name="info[remove_keyword]">{:isset($data['remove_keyword'])&&$data['remove_keyword']?$data['remove_keyword']:''}</textarea>
            <span id="messageBox" for="title" generated="true" class="onShow ">采集到的内容也许还有杂质,可自定义去除</span>
         </td> 
        </tr>     

        <tr> 
         <td width="12%">状态</td> 
         <td><input type="radio" value="1" name="info[status]"  <if condition="isset($data['status'])&&$data['status']==1"> checked="checked"</if> />&nbsp;启用&nbsp;&nbsp;<input type="radio" value="0" name="info[status]" <if condition="(isset($data['status'])&&$data['status']==0)||empty($data['status'])"> checked="checked"</if> />&nbsp;禁用&nbsp;</td> 
        </tr>               
             
       </tbody>
      </table> 
     </fieldset> 
     <input type="hidden" name="dialogid" id="dialogid" value="" /> 
     <input type="submit" style="display:none;" name="dosubmit" id="dosubmit" value=" 提交 " /> 
    </form> 
   </div> 
  </div>  
  
<script language="javascript">
$(document).ready(function() {
    $("input[name='info[collect_page_status]']").click(function() {
        var val = $(this).val();
        if (val == '0') {
            $("#collect_page_status_tr").fadeOut();
        } else {
            $("#collect_page_status_tr").fadeIn();
        }
    });
	
});	
</script>  
 </body>
</html>