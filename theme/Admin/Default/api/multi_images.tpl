<volist name="list" id="vo">
    <div class="imgContainer">
    	<input type="hidden" name="{$fileds_name}[]" value="{$vo.image}">
        <img title="{$vo.image}" alt="{$vo.image}" src="{$vo.image}" onclick="imgDisplay(this)">
        <p class="imgDelete">删除</p>
    </div>
</volist>

