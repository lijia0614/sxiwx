<if condition="$v.fields_type eq 'text'">
   <tr><td>{$v.title}：</td>
       <td><input type="text"  name="{$v.fields}"  class="input-text" value="{:isset($data[$v.fields])?$data[$v.fields]:''}" {:htmlvlidate($v)}  style="width:300px;" /><span id="messageBox" for="title" generated="true" class="onShow Validform_checktip">{$v.info}</span></td>
   </tr>
</if>        