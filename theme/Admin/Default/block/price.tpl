<if condition="$v.fields_type eq 'price'">
   <tr><td  width="12%">{$v.title}：</td>
       <td><input type="text"  name="{$v.fields}"  class="input-text" value="{:isset($data[$v.fields])?$data[$v.fields]:''}" {:htmlvlidate($v)}  style="width:80px;" /><span id="messageBox" for="title" generated="true" class="onShow Validform_checktip">{$v.info}</span></td>
   </tr>
</if>
