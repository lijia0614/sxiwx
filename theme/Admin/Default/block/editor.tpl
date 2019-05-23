<if condition="$v.fields_type eq 'editor'">
<tr> 
         <td>{$v.title}</td> 
         <td> 
         <textarea style="width:670px; height:350px;" class="editor" name="{$v.fields}" id="{$v.fields}">{:isset($data[$v.fields])?$data[$v.fields]:''}</textarea> </td> 
</tr>
</if>
