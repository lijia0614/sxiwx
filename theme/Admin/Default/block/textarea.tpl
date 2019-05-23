<if condition="$v.fields_type eq 'textarea'">
<tr> 
         <td>{$v.title}：</td> 
         <td> 
         <textarea style="width:500px; height:50px;" name="{$v.fields}" {:htmlvlidate($v)} id="{$v.fields}">{:isset($data[$v.fields])?$data[$v.fields]:''}</textarea> <span id="messageBox" for="title" generated="true" class="onShow Validform_checktip">{$v.info}</span></td> 
</tr>
</if>
