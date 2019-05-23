<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
 <head> 
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" /> 
  <title>编缉</title> 
  <link href="/public/admin/default/css/edit.css" rel="stylesheet" type="text/css" /> 
   <script src="/public/admin/default/js/jquery-1.9.1.js"></script> 
    <script src="/public/vend/Validform/Validform_v5.3.2_min.js"></script>
    <script src="/public/admin/default/js/common.js"></script>  
    <script src="/public/vend/kindeditor/kindeditor-min.js" type="text/javascript"></script>    
    <script language="javascript" src="/public/admin/default/js/ajaxfileupload.js"></script>  
    <script src="/public/vend/laydate/laydate.js"></script>

<script language="javascript">
			var editor;
			KindEditor.ready(function(K) {
				editor = K.create('.editor', {
					resizeType : 1,
					allowPreviewEmoticons : false,
					allowImageUpload : false,
					afterBlur: function(){this.sync();}
				});	
				var editor = K.editor({
					allowFileManager : true
				});
				K('.select_img').click(function() {
					var imgid=$(this).attr("upkey");
						editor.loadPlugin('image', function() {
							editor.plugin.imageDialog({
								showRemote : false,
								imageUrl : K('#'+imgid).val(),
								clickFn : function(url, title, width, height, border, align) {
									K('#'+imgid).val(url);
									editor.hideDialog();
								}
							});
						});
					});		
			});
</script>

 </head> 
 <body> 
  <input type="hidden" name="current_load_url" id="current_load_url" value="" /> 
  <div class="pad-10">
<div class="fixed-bar">
        <div class="item-title">
          <div class="subject">
            <h3>单页管理</h3>
            <h5>编缉单页内容</h5>
          </div>
          <ul class="tab-base nc-row">
          <li><a  href="javascript:void(0);" class="tab current"><span>基本设置</span></a></li>
          <li><a href="javascript:void(0);" class="tab"><span>SEO设置</span></a></li>
          </ul>
         </div>
      </div>  
   <div class="common-form"> 
   <if condition="isset($id)">
    <form action="{:url(SYS_PATH."/".CONTROLLER."/edit",array('id'=>$id))}" method="post" class="formvalidate" id="DataFromSubmit" isajax="true"> 
    <input type="hidden" name="id" value="{$id}" />
   <else />
   	<form action="{:url(SYS_PATH."/".CONTROLLER."/add")}" method="post" class="formvalidate" id="DataFromSubmit" isajax="true">
   </if>
     
     <fieldset> 
      <!--<legend>填写信息</legend>-->
      <table width="100%" class="table_form"> 
       <tbody class="maincont">
        <tr> 
         <td width="150">父级分类：</td> 
         <td>
         {$category|raw}<span id="messageBox" for="title" generated="true" class="onShow ">请选择内容分类</span> 
         </td> 
        </tr>       
        <tr> 
         <td width="12%">内容标题：</td> 
         <td><input type="text" id="title"  style="width:300px;" class="input-text" datatype="*" value="{$data['title']}" name="title" placeholder="请输入内容标题" /> <span id="messageBox" for="title" generated="true" class="Validform_checktip onShow ">内容标题</span> </td> 
        </tr>    
        
		<tr>
			<td>上传图片：</td>
			<td>
				<div class="upload_button">
					<input type="text" style="float:left;"  id="image" name="image" class="vtip" data-img="{$data.image}" value="{$data.image}" />
					<a class="file" href="javascript:;">选择文件<input type="file" name="imgFile[]" class="img_file upimg" upkey="image"  id="imgFile"/></a>
                    <span id="messageBox" for="title" generated="true" class=" Validform_checktip onShow " style="margin-top:5px;">图片上传</span>
				</div>
			</td>
	  	</tr>                            
        
        
 
        
        <tr> 
         <td>内容详情：</td> 
         <td> 
         <textarea style="width:670px; height:350px;"  datatype="*" class="editor" name="content" id="content">{$data['content']}</textarea> <span id="messageBox" for="title" generated="true" class="Validform_checktip onShow ">内容详情</span></td> 
        </tr>    
        
        <include file="common:block" />     
        
        <tr> 
         <td width="12%">排序</td> 
         <td><input type="text" id="sort" class="input-text" style="width:80px;" value="{:isset($data['sort'])&&$data['sort']?$data['sort']:'10'}" name="sort" placeholder="排序" /> <span id="messageBox" for="title" generated="true" class="onShow ">数字越小，排名越前</span> </td> 
        </tr>        
        

 

       </tbody>
          <tbody class="maincont none">
          <include file="block::is_seo" />
          </tbody>
      </table> 
     </fieldset> 
     <input type="hidden" name="dialogid" id="dialogid" value="" /> 
     <input type="submit" style="display:none;" name="dosubmit" id="dosubmit" value=" 提交 " /> 
    </form> 
   </div> 
  </div>
  <style>
      .none{
          display: none;
      }
  </style>
 </body>
 <script>
     $(".tab-base a").click(function () {
         var index =$(this).parent().index();
         var indexs =$(this).parent().parent();
         indexs.find('a').removeClass("current");
         $(this).addClass("current");
         $(".maincont").addClass("none").eq(index).removeClass("none");
     })
 </script>
</html>