<if condition="$v.link_table_status eq 1">
	<if condition="$v.deputy_table_status eq 1">
        <tr> 
                 <td>{$v.title}</td> 
                 <td> 
                 <div style="float:left;">
                 {:Fields_link_table_tocheckbox($v,isset($data['id'])?$data['id']:'')}
                 </div>
                 <span id="messageBox" for="title" generated="true" class="onShow ">{$v.info}</span>
                 </td> 
        </tr> 
    <else />
        <tr> 
                 <td>{$v.title}</td> 
                 <td> 
                 <div style="float:left;">
                 {:Fields_link_table_toselect($v,isset($data[$v['fields']])?$data[$v['fields']]:'')}
                 </div>
                 <span id="messageBox" for="title" generated="true" class="onShow ">{$v.info}</span>
                 </td> 
        </tr>  
    </if>               
</if> 