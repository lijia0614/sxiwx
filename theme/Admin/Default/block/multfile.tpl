<if condition="$v.fields_type eq 'multfile'">
	<input type="hidden" name="encode_fields[{$v.fields}]" value="{$v.fields}">
	<!--批量上传-->
	<link href="/public/vend/multImages/css/up.css" rel="stylesheet" type="text/css">
	<tr>
		<td>{$v.title}：</td>

		<td>
			<div class="upload_button">
				<a class="file multImages" id="btn" href="javascript:;">多图上传<input type="file" name="up_{$v.fields}[]" id="up_{$v.fields}" class="img_file mult_upimg" upkey="{$v.fields}" multiple="multiple" /></a>
				<span id="messageBox" for="title" generated="true" class=" Validform_checktip onShow " style="margin-top:5px;">{$v.info}</span>
			</div>
			<div id="imgBoxs"><div class="lastimage" id="{$v.fields}_lastHtml"></div><div id="imgBox"></div></div>
		</td>
	</tr>
	<if condition="$id">
		<script language="JavaScript">
            try{
                var uri="{:url(SYS_PATH."/Api/multiImages",array("module"=>CONTROLLER,"module_id"=>$id,"fileds_name"=>$v.fields))}&random="+Math.random();
                $.getJSON(uri, {},function(result) {
						$("#up_{$v.fields}").parent().parent().parent().find("#imgBoxs .lastimage").html(result.html);
                });
            }catch(e){
                //alert(e);
            }
		</script>
	</if>
</if>