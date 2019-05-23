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
      </div>  
   <div class="common-form"> 
   <if condition="isset($id)">
    <form action="{:url(SYS_PATH."/".CONTROLLER."/addMusic",array('id'=>$id))}" method="post" class="formvalidate" id="DataFromSubmit" isajax="true">
    <input type="hidden" name="id" value="{$id}" />
   <else />
   	<form action="{:url(SYS_PATH."/".CONTROLLER."/addMusic")}" method="post" class="formvalidate" id="DataFromSubmit" isajax="true">
   </if>
     <fieldset> 
      <!--<legend>填写信息</legend>-->
      <table width="100%" class="table_form"> 
       <tbody class="maincont">

       <tr>
           <td width="12%">语种</td>
           <td>
               <select id="lang" name="lang" datatype="*" nullmsg="请选择" class="Validform_error">
                   <option value="">-- 请选择 --</option>
                   <volist name="lang" id="vo">
                       <option style="font-weight:bold;" value="{$vo.id}">{$vo.title}</option>
                   </volist>
               </select>
               <span id="messageBox" for="title" generated="true" class="Validform_checktip onShow Validform_wrong">
           请选择
          </span>
           </td>
       </tr>

       <tr>
           <td width="12%">风格</td>
           <td>
               <select id="type" name="type" datatype="*" nullmsg="请选择" class="Validform_error">
                   <option value="">-- 请选择 --</option>
                   <volist name="type" id="vo">
                       <option style="font-weight:bold;" value="{$vo.id}">{$vo.title}</option>
                   </volist>
               </select>
               <span id="messageBox" for="title" generated="true" class="Validform_checktip onShow Validform_wrong">
           请选择
          </span>
           </td>
       </tr>

       <tr>
           <td width="12%">情感</td>
           <td>
               <select id="feel" name="feel" datatype="*" nullmsg="请选择" class="Validform_error">
                   <option value="">-- 请选择 --</option>
                   <volist name="feel" id="vo">
                       <option style="font-weight:bold;" value="{$vo.id}">{$vo.title}</option>
                   </volist>
               </select>
               <span id="messageBox" for="title" generated="true" class="Validform_checktip onShow Validform_wrong">
           请选择
          </span>
           </td>
       </tr>


        <tr>
         <td width="12%">歌曲名称：</td>
         <td><input type="text" id="title"  style="width:300px;" class="input-text" datatype="*" value="{$data['title']}" name="title" placeholder="请输入歌曲名称" /> <span id="messageBox" for="title" generated="true" class="Validform_checktip onShow ">歌曲名称</span> </td>
        </tr>
       <tr>
           <td width="12%">歌手：</td>
           <td><input type="text" id="songer"  style="width:300px;" class="input-text" datatype="*" value="{$data['songer']}" name="songer" placeholder="请输入歌手" /> <span id="messageBox" for="title" generated="true" class="Validform_checktip onShow ">歌手</span> </td>
       </tr>
       <tr>
           <td width="12%">专辑：</td>
           <td><input type="text" id="zj"  style="width:300px;" class="input-text" value="{$data['zj']}" name="zj" placeholder="请输入专辑" />
           </td>
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
            <td>上传音乐：</td>
            <td>
                <div class="upload_button">
                    <input type="text" style="float:left;"  id="content" name="content" class="vtip" data-img="{$data.content}" value="{$data.content}" />
                    <a class="file" href="javascript:;">选择音乐
                        <input type="file" name="uplodePhoto" class=" upvideo" upkey="video"  id="video"/>
                    </a>
                    <span id="messageBox" for="title" generated="true" class=" Validform_checktip onShow " style="margin-top:5px;">上传音乐</span>
                </div>
            </td>
        </tr>

        <include file="common:block" />     


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


     $('#video').change(function()
     {
         $.ajaxFileUpload({
             url:'mediaUpload',//用于文件上传的服务器端请求地址
             secureuri:false ,//一般设置为false
             fileElementId:'video',//文件上传控件的id属性  <input type="file" id="upload" name="upload" />
             dataType: 'JSON',//返回值类型 一般设置为json
             success:function(data){
                 var obj = $.parseJSON(data);
                 console.log(obj);
                 var url = obj.url;
                 $('#content').val(url);
                 return false;
             }
         });
     });
 </script>
</html>