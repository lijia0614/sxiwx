<!--批量上传-->
<if condition="$v.fields_type eq 'images'">
<input type="hidden" name="encode_fields[]" value="{$v.fields}">
<style type="text/css">
.imagelist{}
.imagelist .imageitem{
    background: none repeat scroll 0 0 #F0F0F0;
    border: 1px solid #E0E0E0;
    display: inline;
    float: left;
	margin-right:10px;
	margin-top:5px;
    padding: 5px;
    width: 120px;
	height:140px;
	overflow:hidden;
	position: relative;
	text-align:center;
	
}
.imageitem .fileimg{
	width:100%;
	height:110px;
	overflow:hidden;
	
}
.imageitem .fileimg img{
	width:100%;
	
}
.imageitem .text{
	clear:both;	
}


.imagelist li em{
    color: #999999;
    display: block;
    line-height: 18px;
    padding: 8px 0px;
}

.imagelist div span {
	margin-top:20px;
}
.imagelist li span a.actbut{float:left;width:24px; height:24px; margin-top:3px;}
</style>                
<script src="/Public/Uploadify/jquery.uploadify-3.1.min.js"></script>
<link href="/Public/Uploadify/uploadify.css" rel="stylesheet">                 
						<script>
                            $(function(){
                                $("#upload").uploadify({
                                    height        : 30,
                                    swf           : '/Public/Uploadify/uploadify.swf',
                                    uploader      : '{:url(SYS_PATH."/Uploadify/upload")}?random='+Math.random(),
                                    width         : 120,
                                    buttonText	  : '选择文件',
                                    auto		  : true,
                                    removeCompleted: false,
                                    onUploadSuccess: function(file, data, response) {
                                        $('#progress').hide();
										try{
                                        	var result = $.parseJSON(data);
										}catch(e){
											alert("错误："+e);	
										}
                                        //错误处理。。。
                                        if(result.status == 0){
                                            alert(result.message);
                                            return false;
                                        }
                                        //上传成功
                                        var id = Math.random().toString();
                                        id = id.replace('.','_'); //生成唯一标示
                                    var html = '<div class="imageitem" id="'+id+'">';
									html+= '<div class="fileimg">'; 
                                    html+= '<input type="hidden" name="{$v.fields}[path][]" value="'+result.file+'">'; //隐藏域，是为了把图片地址入库。。
                                    html+= '<img onclick=javascript:remove("'+result.file+'","'+id+'");  src="'+result.file+'" />';
                                    html+=  '</div>';
									html+=  '<div class="text"><input name="{$v.fields}[name][]" style="width:110px;" class="input-text" value="'+file.name+'"></div>';
									html+= '</div>'; 
                                        $('#image_result').append(html);
                                    },
                                    onUploadStart: function(){
                                        $('#progress').text('上传中.....');  //用户等待提示。
                                    },
                                    onInit: function (){  
                                        $("#upload-queue").hide(); //隐藏上传队列                
                                    }		
                                });
                            })
                            function remove(file,id){
								if(confirm("提示：确认要删除吗？")){
                                	$('#'+id).remove();
								}
                            }
                            function toremove(file){
                            }
                        </script>
                <tr>
                    <td class="left">
                        <label class="validation">{$v.title}：</label>
                    </td>
                    <td>
                       <p style="float:left;">
		<div class="data_grid" style=" width:95%;float:left;padding:10px 20px 20px">
                <div class="even">
                    <!--<h5 style="float:left">附件上传：</h5>-->
                    <div style="width:150px; float:left; margin-top:15px;"><a style="float:right" id="upload"></a> </div><span style="color:#f00; line-height:60px; float:left;">* {$v.info}</span>
                    <pre id="progress" style="margin-top:20px; float:left;"></pre>
                </div>
                <div style="clear:both"></div>
                <div style=" margin-left:30px;">
                    <p>

                    </p>
                </div>
                <div class="clear"></div>
            </div>
                        </p>      
                    </td>
                </tr>      
                <tr>
                <td colspan="2" id="image_result" class="imagelist">
                    <?php 
                    if(isset($data[$v['fields']])){
                    $list_arr=json_decode($data[$v['fields']], true); 
                    ?>
                        <?php if(is_array($list_arr['path'])){
                        		foreach($list_arr['path'] as $key=>$one){
                         ?>
            <div class="imageitem" id="list_arr_{$key}">
                <div class="fileimg">
                    <input type="hidden" name="{$v.fields}[path][]" value="{$list_arr['path'][$key]}">
                    <img  src="{$list_arr['path'][$key]}" onclick=javascript:remove("{$list_arr['path'][$key]}","list_arr_{$key}");>
                </div>    
                <div class="text">
                <input name="{$v.fields}[name][]"  style="width:110px;" class="input-text" value="{$list_arr['name'][$key]}">
                </div>  
            </div>             
						<?php
								 }
							}
                         }    
                         ?>
                </td>
                </tr>          
</if>  