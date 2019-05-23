<volist name="menus" id="menu"> 
<div class="left_box" id="top_left_{$menu['id']}"> 
     <div class="title"> 
     	<volist name="menu.childMenu" id="childMenu">
      <a class="lname" href="javascript:;" data-id="{$childMenu.id}"> <i class="iconfont {$childMenu.class_name}"></i> <span>{$childMenu.name}</span> </a>
      	</volist>
     </div> 
     <div class="titlecon"> 
     <volist name="menu.childMenu" id="childMenu">
      <ul class="in_{$childMenu.id}">
      	<volist name="childMenu.actionLists" id="actionLists"> 
       	<li><a href="javascript:;"  class="frmrightClass" data-url='{:url(SYS_PATH."/".$actionLists['module']."/".$actionLists['action'])}' menu_id="{$actionLists.id}">{$actionLists.action_name}</a></li> 
        </volist>
      </ul> 
     </volist>
     </div> 
    </div>
</volist>     