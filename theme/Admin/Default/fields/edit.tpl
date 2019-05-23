<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
 <head> 
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" /> 
  <title></title> 
  <link href="/public/admin/default/css/edit.css" rel="stylesheet" type="text/css" /> 
   <script src="/public/admin/default/js/jquery-1.9.1.js"></script> 
    <script src="/public/vend/Validform/Validform_v5.3.2_min.js"></script>
    <script src="/public/admin/default/js/common.js"></script>        
  <style>
#FrmContent{height:100%; }
</style> 

 </head> 
<body>
<div class="nav"><span>编缉</span><a href="javascript:window.history.go(-1);" class="right">返回</a></div>
  <input type="hidden" name="current_load_url" id="current_load_url" value="" /> 
   
  <div class="pad-10"> 
   <div class="common-form"> 
   <if condition="isset($id)">
    <form action="{:url(SYS_PATH."/".CONTROLLER."/edit",array('id'=>$id))}" method="post" class="formvalidate" id="DataFromSubmit" isajax="true"> 
    <input type="hidden" name="id" value="{$id}" />
    <input type="hidden" name="module_id" value="{$module_id}" />
   <else />
   	<form action="{:url(SYS_PATH."/".CONTROLLER."/add")}" method="post" class="formvalidate" id="DataFromSubmit" isajax="true"> 
    <input type="hidden" name="module_id" value="{$module_id}" />
   </if> 
     <fieldset> 
      <legend>填写信息</legend> 
      <table width="100%" class="table_form"> 
       <tbody> 
        <tr> 
         <td width="12%">模型名称</td> 
         <td><input type="hidden" class="input-text" id="mtag" name="mtag" value="{:isset($data['title'])?$data['title']:''}" /> <input type="text" readonly="true" class="input-text" value="{:isset($module['title'])?$module['title']:''}" /> <span id="messageBox" for="title" generated="true" class="Validform_checktip onShow ">模型名称</span></td> 
        </tr> 
        <tr> 
         <td>标题</td> 
         <td><input type="text" class="input-text" id="title"  datatype="*" value="{:isset($data['title'])?$data['title']:''}" name="title" placeholder="请输入标题" /><span id="messageBox" for="title" generated="true" class="Validform_checktip onShow ">名称标题</span></td> 
        </tr> 
        <tr> 
         <td>数据字段名</td> 
         <td> <input type="text" class="input-text" id="fields" errormsg="字段名只能是英文字母"  datatype="/^[a-zA-Z_]{2,10}$/i" value="{:isset($data['fields'])?$data['fields']:''}" name="fields" placeholder="字段名必须英文" /><span id="messageBox" for="title" generated="true" class="Validform_checktip onShow ">数据库中的字段名，请不要使用特殊字符</span>  </td> 
        </tr> 
        
        <tr> 
         <td>关联表</td> 
         <td>
         	<select name="link_table_status" id="link_table_status">
            	<option value="0" <if condition="isset($data['link_table_status'])&&$data['link_table_status']==0">selected="selected"</if>>否</option>
                <option value="1" <if condition="isset($data['link_table_status'])&&$data['link_table_status']==1">selected="selected"</if>>是</option>
            </select><span id="messageBox" for="title" generated="true" class="Validform_checktip onShow ">关联表,默认字段格式为select</span> 
         </td> 
        </tr>        
        <if condition="empty($data['fields_type'])">
        <tr class="fields_type_tr" style="display:<if condition="isset($data['link_table_status'])&&$data['link_table_status']==1">none;</if>"> 
         <td>字段格式</td> 
         <td> 
         <select name="fields_type" id="fields_type_id" style="width:200px;" <if condition="isset($data)"> disabled="disabled"</if>> 
           <option value="">请选择</option>
           <option value="text" <if condition="isset($data['fields_type'])&&$data['fields_type']=='text'">selected="selected"</if>>text(input)</option> 
           <option value="price" <if condition="isset($data['fields_type'])&&$data['fields_type']=='price'">selected="selected"</if>>price(价格字段)</option> 
           <option value="textarea"  <if condition="isset($data['fields_type'])&&$data['fields_type']=='textarea'">selected="selected"</if>>textarea</option> 
           <option value="editor" <if condition="isset($data['fields_type'])&&$data['fields_type']=='editor'">selected="selected"</if>>editor(文章富文本)</option> 
           <option value="selcet" <if condition="isset($data['fields_type'])&&$data['fields_type']=='selcet'">selected="selected"</if>>select(下拉框)</option>
           <option value="fileupload" <if condition="isset($data['fields_type'])&&$data['fields_type']=='fileupload'">selected="selected"</if>>fileupload(文件上传)</option>  
           
           <option value="office" <if condition="isset($data['fields_type'])&&$data['fields_type']=='office'">selected="selected"</if>>office(文档文件)</option>  
           
           <option value="image" <if condition="isset($data['fields_type'])&&$data['fields_type']=='image'">selected="selected"</if>>image(单图上传)</option> 
           <option value="multfile" <if condition="isset($data['fields_type'])&&$data['fields_type']=='multfile'">selected="selected"</if>>multfile(多图上传)</option> 
           <option value="date" <if condition="isset($data['fields_type'])&&$data['fields_type']=='date'">selected="selected"</if>>date(日期)</option> 
           <option value="datetime" <if condition="isset($data['fields_type'])&&$data['fields_type']=='datetime'">selected="selected"</if>>datetime(日期时间)</option> 
           <option value="checkbox" <if condition="isset($data['fields_type'])&&$data['fields_type']=='checkbox'">selected="selected"</if>>checkbox(多选框)</option> 
           <option value="link_table" <if condition="isset($data['fields_type'])&&$data['fields_type']=='link_table'">selected="selected"</if>>关联表</option> 
           </select> 
           </td> 
        </tr>
         <else />        
        <input type="hidden" name="fields_type" value="{$data['fields_type']}" />
        </if>

        
        <tr class="link_table_status_tr" style="display:<if condition="(isset($data['link_table_status'])&&$data['link_table_status']==0)||empty($data['link_table_status'])">none;</if>"> 
         <td>关联表名称</td> 
         <td>
         	<select name="link_table_name" id="link_table_name">
            <option value="">请选择要关联的表</option>
            <volist name="tables" id="vo">
            	<option value="{$vo}" <if condition="isset($data['link_table_name'])&&$data['link_table_name']==$vo">selected="selected"</if>>{$vo}</option>
            </volist>
            </select><span id="messageBox" for="title" generated="true" class="Validform_checktip onShow ">要关联的表名称</span> 
         </td> 
        </tr>
        
        <tr class="link_table_status_tr" style="display:<if condition="(isset($data['link_table_status'])&&$data['link_table_status']==0)||empty($data['link_table_status'])">none;</if>"> 
         <td>查询表条件</td> 
         <td>
        <input type="text" class="input-text" id="link_table_where" value="{:isset($data['link_table_where'])?$data['link_table_where']:''}" name="link_table_where" placeholder="如：type=1" /> <span id="messageBox" for="title" generated="true" class="Validform_checktip onShow ">如type=1,将查询这个表type=1的数据</span> 
         </td> 
        </tr> 
        
        <tr class="link_table_status_tr" style="display:<if condition="(isset($data['link_table_status'])&&$data['link_table_status']==0)||empty($data['link_table_status'])">none;</if>"> 
         <td style="height:30px;">生成副表：</td> 
         <td> 
         <input type="radio" value="1" name="deputy_table_status" class="deputy_table_status" <if condition="(isset($data['deputy_table_status'])&&$data['deputy_table_status']==1)"> checked="checked" disabled</if> />是
         <input type="radio" value="0" name="deputy_table_status" class="deputy_table_status" <if condition="(isset($data['deputy_table_status'])&&$data['deputy_table_status']==0)||empty($data)"> checked="checked"</if> <if condition="isset($data['deputy_table_status'])">  disabled</if> />不 <span id="messageBox" for="title" generated="true" class="Validform_checktip onShow ">生成副表，字段类型将默认为checkbox多选，否则请不要生成副表</span> </td> 
        </tr>     
        
        <tr class="deputy_table_tr" style="display:<if condition="(isset($data['link_table_status'])&&$data['link_table_status']==0)||empty($data['link_table_status'])">none;</if>"> 
         <td>副表名称</td> 
         <td>
        <input type="text" class="input-text" id="deputy_table"   validate="{ required:true,maxlength:300}" value="{:isset($data['deputy_table'])?$data['deputy_table']:''}" name="deputy_table" placeholder="副表名称,英文" {:isset($data['deputy_table'])?'readonly="readonly"':''} /> <span id="messageBox" for="title" generated="true" class="Validform_checktip onShow ">副表的名称</span> 
         </td> 
        </tr>
        
        <tr class="link_table_status_tr" style="display:<if condition="(isset($data['link_table_status'])&&$data['link_table_status']==0)||empty($data['link_table_status'])">none;</if>"> 
         <td>存储的值</td> 
         <td>
         <div id="link_table_fields_div" style="float:left;">
         	<select name="link_table_fields" id="link_table_fields">
            	<option value="">请选择</option>
            </select></div><span id="messageBox" for="title" generated="true" class="Validform_checktip onShow ">option中的值</span> 
         </td> 
        </tr>
        
        <tr class="link_table_status_tr" style="display:<if condition="(isset($data['link_table_status'])&&$data['link_table_status']==0)||empty($data['link_table_status'])">none;</if>"> 
         <td>显示名</td> 
         <td>
         <div id="link_table_fields_display_name_div" style="float:left;">
         	<select name="link_table_fields_display_name" id="link_table_fields_display_name">
            	<option value="">请选择</option>
            </select>
         </div><span id="messageBox" for="title" generated="true" class="Validform_checktip onShow ">option中的显示名称</span> 
         </td> 
        </tr>
         
        <tr id="fields_value_tr" <if condition="(isset($data['fields_type'])&&$data['fields_type']=='selcet')">style="display:;"<else />style="display:none;"</if>> 
         <td>字段的值</td> 
         <td>
         <textarea style="width:300px; height:60px;" id="fields_value" name="fields_value" placeholder="请输入字段的值">
{:isset($data['fields_value'])?$data['fields_value']:''}</textarea>
<span id="messageBox" for="title" generated="true" class="Validform_checktip onShow ">(选项1|值1 注意，每行一个选项)</span> 
         </td> 
        </tr>  
        
        <tr> 
         <td style="height:30px;">编缉框显示：</td> 
         <td> 
         <input type="radio" value="1" name="is_show" <if condition="(isset($data['is_show'])&&$data['is_show']==1)||empty($data)"> checked="checked"</if> />显示
         <input type="radio" value="0" name="is_show" <if condition="isset($data['is_show'])&&$data['is_show']==0"> checked="checked"</if> />不显示 </td> 
        </tr>    
        <tr> 
         <td style="height:30px;">列表显示：</td> 
         <td> 
         <input type="radio" value="1" name="list_show" <if condition="(isset($data['list_show'])&&$data['list_show']==1)"> checked="checked"</if> />显示
         <input type="radio" value="0" name="list_show" <if condition="(isset($data['list_show'])&&$data['list_show']==0)||empty($data)"> checked="checked"</if> />不显示 </td> 
        </tr> 
        <tr class="list_show_tr" style="display:<if condition="(isset($data['list_show'])&&$data['list_show']==0)||empty($data['list_show'])">none;</if>"> 
         <td>列表宽度：</td> 
         <td> 
<input type="text" class="input-text" id="list_width"   style="width:80px;" datatype="n2-3" errmsg="必须是正整数"  value="{:isset($data['list_width'])?$data['list_width']:'10'}" name="list_width" placeholder="宽度" /><span id="messageBox" for="title" generated="true" class="Validform_checktip onShow ">px 必须是正整数</span> 
         </td> 
        </tr>

        
        <tr> 
         <td>JS验证</td> 
         <td> 
         <select name="verify" id="verify"  style="width:150px;"> 
             <option value="0" <if condition="isset($data['verify'])&&$data['verify']==0">selected="selected"</if>>不验证</option>
             <option value="1" <if condition="isset($data['verify'])&&$data['verify']==1">selected="selected"</if>>验证</option> 
         </select> 
         </td> 
        </tr> 
        <tr id="isverify"> 
         <td>验证规则</td> 
         <td> <select name="verify_type"  style="width:150px;"> 
         	 <option value="">请选择</option> 
             <option value="required" <if condition="isset($data['verify_type'])&&$data['verify_type']=='required'">selected="selected"</if>>不能为空</option>
             <option value="price" <if condition="isset($data['verify_type'])&&$data['verify_type']=='price'">selected="selected"</if>>价格金额</option>
             <option value="email" <if condition="isset($data['verify_type'])&&$data['verify_type']=='email'">selected="selected"</if>>邮箱</option>
             <option value="number" <if condition="isset($data['verify_type'])&&$data['verify_type']=='number'">selected="selected"</if>>仅数字</option>
             <option value="mobile" <if condition="isset($data['verify_type'])&&$data['verify_type']=='mobile'">selected="selected"</if>>手机号码</option>
             <option value="landline" <if condition="isset($data['verify_type'])&&$data['verify_type']=='landline'">selected="selected"</if>>座机号码</option>
             <option value="date" <if condition="isset($data['verify_type'])&&$data['verify_type']=='date'">selected="selected"</if>>日期</option>
             <option value="Echeck" <if condition="isset($data['verify_type'])&&$data['verify_type']=='Echeck'">selected="selected"</if>>仅英文字母</option>
             <option value="IntCheck" <if condition="isset($data['verify_type'])&&$data['verify_type']=='IntCheck'">selected="selected"</if>>仅整数</option>
             <option value="strCheck" <if condition="isset($data['verify_type'])&&$data['verify_type']=='strCheck'">selected="selected"</if>>数字英文下划线</option> 
             <option value="choose" <if condition="isset($data['verify_type'])&&$data['verify_type']=='choose'">selected="selected"</if>>select选择</option> 
         </select> 
         </td> 
        </tr> 
        <tr> 
         <td>描述</td> 
         <td> <input type="text" class="input-text" id="info"  datatype="*" value="{:isset($data['info'])?$data['info']:''}" name="info" placeholder="请输入描述" /> <span id="messageBox" for="title" generated="true" class="Validform_checktip onShow ">请输入描述</span></td> 
        </tr> 
         <tr> 
         <td>排序</td> 
         <td> <input type="text" style="width:50px;" datatype="*" class="input-text" id="sort" value="{:isset($data['sort'])?$data['sort']:''}" name="sort" placeholder="请输入排序" /><span id="messageBox" for="title" generated="true" class="Validform_checktip onShow ">数字越小排名越前</span></td> 
        </tr>
       </tbody>
      </table> 
     </fieldset> 
     <input type="hidden" name="dialogid" id="dialogid" value="" /> 
     <input type="submit" style="display:none;" name="dosubmit" id="dosubmit" value=" 提交 " /> 
     <div class="bk15"></div> 
    </form> 
   </div> 
  </div>  
  
<script language="javascript">
$(document).ready(function() {
    $("#link_table_status").change(function() {
        var val = $(this).val();
        if (val == 0) {
            $(".link_table_status_tr").fadeOut();
            $(".fields_type_tr").fadeIn();
            $("#fields_type_id").attr("disabled",false);
        } else {
			$(".fields_type_tr").fadeOut();
            $(".link_table_status_tr").fadeIn();
			
        }
    });
	
    $(".deputy_table_status").click(function() {
        var val = $(this).val();
        if (val == 1) {
			$("#fields_type_id option[value='checkbox']").attr("selected", "selected");
			$(".deputy_table_tr").fadeIn();
        }else{
			$(".deputy_table_tr").fadeOut();
		}
    });		
	
	
    $("#fields_type_id").change(function() {
        var val = $(this).val();
        if (val == 'selcet') {
            $("#fields_value_tr").fadeIn();
        } else {
			$("#fields_value_tr").fadeOut();
        }
    });	
    $("input[name='list_show']").click(function() {
        var val = $(this).val();
        if (val == 1) {
            $(".list_show_tr").fadeIn();
        } else {
	   $(".list_show_tr").fadeOut();
        }
    });	
    
    
	
	
	
    $("#link_table_name").change(function() {
		 var val = $(this).val();
			try{
				var uri="{:url(SYS_PATH.'/Fields/getFieldsOptions')}?tablename="+val+"&random="+Math.random();
				$.getJSON(uri, {tablename: val},function(result) {
					$("#link_table_fields").html(result.data);
					$("#link_table_fields_display_name").html(result.data);
				});
			}catch(e){
				//alert(e);	
			}	
	});
<if condition="isset($data)">
	try{
		var uri="{:url(SYS_PATH.'/Fields/getFieldsOptions')}?tablename={$data['link_table_name']}&random="+Math.random();
		var val="{$data['link_table_name']}";
		$.getJSON(uri, {tablename: val},function(result) {
			$("#link_table_fields").html(result.data);
			$("#link_table_fields option[value='{$data['link_table_fields']}']").attr("selected", "selected"); 		
			$("#link_table_fields_display_name").html(result.data);
			$("#link_table_fields_display_name option[value='{$data['link_table_fields_display_name']}']").attr("selected", "selected");
		});
	}catch(e){
		alert(e);	
	}
</if>			
	
	
});	
</script>  
  
<script>
$(document).ready(function(){
            verifyHidden();
});
$("#verify").change(function(){
            verifyHidden();
});
function verifyHidden(){
            var type=$("#verify").val();
            if(type=='0'){
                $('#isverify').css('display','none');
            }else if(type=='1'){
               $('#isverify').css('display','');
            }
        }
</script> 
 </body>
</html>