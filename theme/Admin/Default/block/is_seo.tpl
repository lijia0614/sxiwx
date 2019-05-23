     <tr> 
         <td width="12%">自定义SEO：</td>
         <td> 
		 <div class="onoff">
            <label for="is_seo1" class="cb-enable <if condition="$data['is_seo'] eq 1">selected</if>">是</label>
            <label for="is_seo0" class="cb-disable <if condition="($data['is_seo']==0)||empty($data['is_seo'])">selected</if>">否</label>
            <input id="is_seo1" name="is_seo" <if condition="$data['is_seo'] eq 1">checked="checked"</if> value="1" type="radio">
            <input id="is_seo0" name="is_seo" value="0" type="radio" <if condition="($data['is_seo']==0)||empty($data['is_seo'])">checked="checked"</if>>
          </div>
         </td> 
        </tr>         
        
        <tr class="seo_tr" <if condition="$data.is_seo neq 1||empty($data.is_seo)"> style="display:none;"</if>> 
         <td width="12%">SEO标题</td> 
         <td>
         	<input type="text" id="seo_title" style="width:300px;" class="input-text" value="{:isset($data['seo_title'])&&$data['seo_title']?$data['seo_title']:''}" name="seo_title" placeholder="seo标题" /><span id="messageBox" for="title" generated="true" class="onShow">SEO标题</span>
          </td> 
        </tr> 
        
        <tr class="seo_tr"  <if condition="$data.is_seo neq 1||empty($data.is_seo)"> style="display:none;"</if>> 
         <td width="12%">SEO关键词</td> 
         <td>
         	<input type="text" id="seo_keywords" style="width:300px;" class="input-text" value="{:isset($data['seo_keywords'])&&$data['seo_keywords']?$data['seo_keywords']:''}" name="seo_keywords" placeholder="SEO关键词" /><span id="messageBox" for="title" generated="true" class="onShow ">SEO关键词</span>
          </td> 
        </tr>                
        
        <tr class="seo_tr"  <if condition="$data.is_seo neq 1||empty($data.is_seo)"> style="display:none;"</if>> 
         <td width="12%">SEO描述</td> 
         <td>
         	<textarea style="width:350px; height:60px;" placeholder="SEO描述" name="seo_desc" id="seo_desc">{:isset($data['seo_desc'])&&$data['seo_desc']?$data['seo_desc']:''}</textarea>
            <span id="messageBox" for="title" generated="true" class="onShow ">SEO描述</span>
          </td> 
        </tr>   