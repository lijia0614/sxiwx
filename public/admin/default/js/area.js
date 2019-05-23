// area 
$(function(){ 
	// ----------- 后台地址 ----------  
	$.fn.area = function(options){
		var defaults = {
			'prov':'0',
			'city':'0',
			'dist':'0'
		};
		var settings = $.extend({}, defaults, options);
	  	var prov = [], city = [], dist = [];
		$.ajax({  
			type : "get",  
			url : "?m=area&a=get_all",   
			async : false,  
			dataType : 'json',
			success : function(data){ 
				prov = data.prov;
				city = data.city;
				dist = data.dist;
			}  
		});
		// 系统后台用
		prov_html = '<select name="prov" id="area_prov">';
		prov_html += '<option value="0">--省级--</option>'; 
		$.each(prov, function(k, v){
			if(settings.prov == k){
				prov_html += '<option value="'+k+'" selected="selected">'+v+'</option>';
			}else{
				prov_html += '<option value="'+k+'">'+v+'</option>';
			} 
		});
		prov_html += '</select>';
		prov_html += '<select name="city" id="area_city"><option value="0">--市级--</option></select>'; 
		prov_html += '<select name="dist" id="area_dist"><option value="0">--县级--</option></select>';  
		$(this).html(prov_html);  
		// 有值的时候
		if(settings.city != '0'){
			html = '';
			html += '<option value="0">--市级--</option>'; 
			$.each(city[settings.prov], function(k, v){
				if(settings.city == k){ 
					html += '<option value="'+k+'" selected="selected">'+v+'</option>'; 
				}else{
					html += '<option value="'+k+'">'+v+'</option>'; 	
				} 
			});
			$("#area_city").html(html); 
		}
		if(settings.dist != '0'){
			html = '';
			html += '<option value="0">--市级--</option>'; 
			$.each(dist[settings.city], function(k, v){
				if(settings.dist == k){ 
					html += '<option value="'+k+'" selected="selected">'+v+'</option>'; 
				}else{
					html += '<option value="'+k+'">'+v+'</option>'; 	
				} 
			});
			$("#area_dist").html(html); 
		} 
		// 市级
		$('#area_prov', this).unbind().on('change',function(){
			id = $(this).val(); 
			html = '';
			html += '<option value="0">--市级--</option>'; 
			$.each(city[id], function(k, v){
				html += '<option value="'+k+'">'+v+'</option>'; 
			});
			$("#area_city").html(html);
		}); 
		// 县级
		$(document).on('change',"#area_city",function(){
			id = $(this).val(); 
			html = '';
			html += '<option value="0">--县级--</option>'; 
			$.each(dist[id], function(k, v){
				html += '<option value="'+k+'">'+v+'</option>'; 
			}); 
			$("#area_dist").html(html); 
		});
		 
  
  	
	
	
		
		
	}  	   
});









