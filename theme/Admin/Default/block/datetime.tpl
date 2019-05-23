<if condition="$v.fields_type eq 'datetime'">               
<tr> 
         <td>{$v.title}</td> 
         <td> 
         
         <input type="text"  name="{$v.fields}"  class="input-text datetime" value="{:isset($data[$v.fields])?$data[$v.fields]:''}" {:Htmlvlidate($v)}  style="width:180px;" /><span id="messageBox" for="title" generated="true" class="Validform_checktip onShow ">{$v.info}</span>
         </td> 
</tr>                
</if>   