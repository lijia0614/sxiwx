<if condition="$v.fields_type eq 'selcet'">
<tr> 
         <td>{$v.title}</td> 
         <td> 
         <div style="float:left;">
         {:Fields_to_select($v['fields_value'],$v['fields'],isset($data[$v['fields']])?$data[$v['fields']]:'',3)}
         </div>
         <span id="messageBox" for="title" generated="true" class="onShow ">{$v.info}</span>
         </td> 
</tr>                        
</if> 