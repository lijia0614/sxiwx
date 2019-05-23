<if condition="$v.fields_type eq 'date'">               
<tr> 
         <td>{$v.title}</td> 
         <td> 
         
         <input type="text"  name="{$v.fields}"  class="input-text date" value="{:isset($data[$v.fields])?$data[$v.fields]:''}" {:htmlvlidate($v)}  style="width:100px;" /><span id="messageBox" for="title" generated="true" class="Validform_checktip onShow ">{$v.info}</span>
         </td> 
</tr>                
</if>   