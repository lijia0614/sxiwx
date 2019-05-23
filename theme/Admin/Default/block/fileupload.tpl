<if condition="$v.fields_type eq 'fileupload'">
		<tr>
			<td>{$v.title}：</td>
			<td>
				<div class="upload_button">
					<input type="text" style="float:left;" {:htmlvlidate($v)} name="{$v.fields}" data-img="{:isset($data[$v['fields']])?$data[$v['fields']]:''}" value="{:isset($data[$v['fields']])?$data[$v['fields']]:''}" id="{$v.fields}" />
					<a class="file" href="javascript:;">选择文件<input type="file" name="up_{$v.fields}[]" id="up_{$v.fields}" module-name="{:CONTROLLER}"  fields-name="{$v.fields}" class="img_file upfiles" upkey="{$v.fields}" /></a>
                    <span id="messageBox" for="title" generated="true" class=" Validform_checktip onShow " style="margin-top:5px;">{$v.info}</span>
				</div>
			</td>
	  	</tr>  
</if>          