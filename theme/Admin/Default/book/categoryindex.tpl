<div class="nav"><span>分类管理</span></div>
<div class="filter"> 
	<a href="javascript:;"  title='添加分类'  class="add dialog" data-url='{:url(SYS_PATH."/".CONTROLLER."/categoryAdd")}' data-height='400px' data-width='750px'>添加分类</a>
</div>
<div class="main"> 
	<table class="ltable">
       <thead> 
        <tr> 
            <th width="130" class="fl"><input type="checkbox" name="checkboxall" id="checkboxall" value="" class="va_m checkboxall" /></th>
            <th width="200">标识</th>
            <th width="600">分类名称</th>
            <th width="150">排序</th>
            <th width="250">状态</th>
            <th width="250">添加时间</th>
            <th width="230">操作</th>
            <th></th>        
        </tr> 
       </thead> 
       <tbody> 
       <empty name="category">
        <tr> 
         	<td colspan="8" nowrap="nowrap" style="text-align:center;">暂无记录</td> 
        </tr> 
        </empty>
       <volist name="category" id="vo">
           <tr>
               <td width="130" class="fl"><input type="checkbox" name="checkboxall" id="checkboxall" value="" class="va_m checkboxall" /></td>
               <td width="200">{$vo.id}</td>
               <td width="600">{$vo.name}</td>
               <td width="150">{$vo.sort}</td>

               <td width="250">
                <if condition="$vo.status eq 1">
                    <span style="color: #2cbca3">正常</span>
                    <else/>
                    <span style="color: indianred">禁用</span>
                </if>
               </td>
               <td nowrap="nowrap">{$vo.time}</td>
               <td nowrap="nowrap" style="text-align:center;">
                   <a href='javascript:void(0);'  data-url='{:url(SYS_PATH."/".CONTROLLER."/categoryEdit",['id'=>$vo['id']])}'  class='dialog edit' alt='编辑' title='编辑管理员'  data-height='420px' data-width='650px'>编缉</a>
                   <a href='javascript:void(0);' data-url='{:url(SYS_PATH."/".CONTROLLER."/categoryDelete",['id'=>$vo['id']])}' class='remove doDel del' val='{$vo.id}' title='删除'>删除</a>  						</td>
               <td></td>
           </tr>
       </volist>
       </tbody>
	</table> 
</div>