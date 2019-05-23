// JavaScript Document	// 删除 
$(function(){
	// 禁止<--后退操作
	/*
	var counter = 0;
	if (window.history && window.history.pushState) {
		$(window).on('popstate', function(){
			window.history.pushState('forward', null, '#');
			window.history.forward(1); 
		});
	}
	window.history.pushState('forward', null, '#'); //在IE中必须得有这两行
	window.history.forward(1);
	*/
	 
	// 选择操作
	$(document).on('click','.change a',function(){
		$this = $(this);
		id = $this.attr('data-act');
		if(id == '1'){
			$this.attr('data-act','2').removeClass('img1').addClass('img2');  
			$("#product_barcode").show();
			$("#product_sch").hide();
		}else{
			$this.attr('data-act','1').removeClass('img2').addClass('img1');
			$("#product_sch").show();
			$("#product_barcode").hide();
		}
	});
	
	//$("#barcode").focus().val('');	// 默认焦点不做 
	// 条码操作
	$(document).on('keypress',"input#barcode",function(e){ 
		var $this = $(this);
		var key = window.event ? e.keyCode : e.which;
		if(key.toString() == "13"){ 
			//$("#barcode").blur();
			var barcode = $("#barcode").val();
			if(barcode != ''){
				store_id = $("#store_id").val();
				seller_type = $("#seller_type").val();
				$.ajax({
					type:'POST',
					url:'?m=stock&a=get_product',
					data:{barcode:barcode, store_id:store_id, seller_type:seller_type},
					success:function(result){
						product_insert_html(result);
						$("#barcode").focus().val('');
					},error:function(){
						alert('错误');
					}
				}); 
				return false;	
			}
		}
	});	 
	
	// 标题
	$(document).on('keypress',"input#title",function(e){ 
		$this = $(this); 
		if(event.keyCode == "13"){
			title = $('input#title').val(); 
			if(title != ''){
				product_box();
				product_list(title, function(data){
					if(data.error == '0'){
						html = '';
						$.each(data.list, function(k,v){
							html += '<tr>'+
									'<td><input type="checkbox" name="pid" class="pid" value="'+v.id+'"/></td>'+
									'<td>'+v.title+'<input type="hidden" name="title" class="title" value="'+v.title+'"/></td>'+
									'<td>'+v.stock_num+'<input type="hidden" name="stock_num" class="stock_num" value="'+v.stock_num+'"/></td>'+
									'<td>'+v.unit+'</td>'+
									'<td>'+v.sku+'</td>'+
									'<td>'+v.price+'<input type="hidden" name="price" class="price" value="'+v.price+'"/></td>'+
									'</tr>';			 
						});
						$(".pdbox table tbody").html(html);	
					}else{
						$(".pdbox table tbody").html('<tr><td colspan="6">'+data.msg+'</td></tr>');	
					}
					$(".pdcon table tbody tr:first").addClass("selected","selected").find("input[name=pid]").attr("checked","checked");	//默认第一条选中
				}); 
				$("input#pd_title").val(title).focus(); 
				$("input#title").blur(); 
			}
        }
	}); 
	// 数量
	$(document).on('keypress',"input#buy_num",function(e){
		$this = $(this);
		if(event.keyCode == "13"){ 
			$('input#buy_price').focus().select(); 
        }
	}); 
	// 价格
	$(document).on('keypress',"input#buy_price",function(e){ 
		$this = $(this);
		if(e.keyCode == "13"){
			pid = $('input#buy_id').val();
			num = $('input#buy_num').val(); 
			price = $('input#buy_price').val(); 
			action_id = $("input#action_id").val(); 
			if(!action_id){	// 出库的操作
				buy_stock_num = $('input#buy_stock_num').val(); 
				if(num > buy_stock_num){
					$("input#buy_id").val('');
					$("input#buy_num").val('');
					$("input#buy_stock_num").val('');
					$("input#buy_price").val('');
					$("input#title").val('').focus().select();
					return;
				}
			}
			// 入库操作为空
			$.ajax({
				type:'POST',
				url:'?m=stock&a=get_product',
				data:{id:pid},
				success:function(result){
					product_insert_html(result, num, price);
					// 目标跳转 
					$("input#buy_id").val('');
					$("input#buy_num").val('');
					$("input#buy_stock_num").val('');
					$("input#buy_price").val('');
					$("input#title").val('').focus().select(); 
				},error:function(){
					alert('错误');
				}
			});	 
			
        }
	}); 
	// 弹窗的操作，只对弹出的窗口进行操作
	$(document).on('keydown',function(e){
		if($("div").is('.pd')){
			var $div  = $(".pd");
			if(e.keyCode == '40'){			// 下键
				if($('tr').is(".pdcon table tbody tr.selected")){
					$(".pdcon table tbody tr.selected").next().addClass("selected","selected").siblings().removeClass("selected"); 
				}else{
					$(".pdcon table tbody tr:first").addClass("selected","selected");
				} 
			}else if(e.keyCode == '38'){	// 上键
				$(".pdcon table tbody tr.selected").prev().addClass("selected","selected").siblings().removeClass("selected"); 
			}else if(e.keyCode == '13'){	// 执行回车的操作
				if($("tr").is(".pdcon table tbody tr.selected")){
					pid =   $(".pdcon table tbody tr.selected input.pid").val();
					news_title = $(".pdcon table tbody tr.selected input.title").val(); 
					price = $(".pdcon table tbody tr.selected input.price").val(); 
					stock_num = $(".pdcon table tbody tr.selected input.stock_num").val(); 
					if(pid !=  undefined ){
						$("input#buy_id").val(pid);
						$("input#title").val(news_title);
						$("input#buy_num").val('1');	// 默认1
						$("input#buy_stock_num").val(stock_num);	//当前库存
						$("input#buy_price").val(price); 
						product_box_close();
						// 目标跳转
						setTimeout(function(){
							$("#buy_num").focus().select();
						},10); 	
					}
				}
			}else if(e.keyCode == '27'){	// ESC
				product_box_close();
			} 
			if(e.keyCode == '40' || e.keyCode == '38'){
				$(".pdcon table tbody tr.selected input").attr("checked","checked")
				.parents('tr').siblings().find('input').attr("checked",false); 
			}
		}
	});
	
	function product_box(){
		html = '<div class="pd_bg"></div>'+
				'<div class="pd">'+
					'<div class="pdname"><span>产品查找</span><a href="javascript:;" class="pd_close">x</a></div>'+
					'<div class="pdcon">'+
						'<!--div class="pdsch">'+
							'<span>产品：</span><input type="text" id="pd_title" value="" size="30"/>'+
						'</div-->'+
						'<div class="pdbox">'+
							'<table class="ltable" width="100%">'+
								'<thead>'+
									'<tr>'+
										'<th width="30"></th>'+
										'<th>产品名</th>'+
										'<th width="80">库存</th>'+
										'<th width="80">单位</th>'+
										'<th width="120">规格</th>'+
										'<th width="80">价格</th>'+
									'</tr>'+
								'</thead>'+
								'<tbody></tbody>'+
							'</table>'+
						'</div>'+
					'</div>'+
				'</div>'; 
		if(!$('div').is(".dg")){
			$(".filter").after(html);
		}
	}
	$(document).on('click', '.pd_close',function(e){ 
		product_box_close();
	});
	function product_box_close(){
		$(".pd_bg").remove();	
		$(".pd").remove(); 
	}
	// 获取产品信息 
	function product_list(key, callback){ 
		store_id = $("#store_id").val();
		seller_type = $("#seller_type").val();
		$.ajax({
			type:'POST',
			url:'?m=stock&a=get_product_list',
			data:{key:key, store_id:store_id, seller_type:seller_type},
			success:function(result){ 
				var data = jQuery.parseJSON(result); 
				callback(data);
			},error:function(){
				alert('错误');
			}
		}); 
	}
	// 向产品中增加内容
	function product_insert_html(result, buy_num, buy_price){
		var data = jQuery.parseJSON(result); 
		buy_num = buy_num?buy_num:'1';
		buy_price = buy_price?buy_price:data.price;
		if(data.error == '0'){ 
			if($(".main table tr").hasClass("pro_"+data.id)){
				var pro_num = $(".pro_"+data.id+" input.pro_num").val();
				var pro_num = parseInt(pro_num)+parseInt(buy_num);
				$(".pro_"+data.id+" input.pro_num").val(pro_num);
			}else{
				html = '<tr class="pro_'+data.id+'"><input name="pro_id[]" type="hidden" value="'+data.id+'">'+ 
						'<td><a href="javascript:;" class="pro_del" data-id="'+data.id+'">删除</a></td>'+
						'<td>'+data.title+'</td>'+
						'<td>'+data.procode+'</td>'+
						'<td>'+data.unit+'</td>'+
						'<td><input name="pro_num[]" type="text" class="pro_num enter_act" size="5" value="'+buy_num+'" data-id="'+data.id+'"/></td>'+ 
						'<td><input name="pro_price[]" type="text" class="pro_price enter_act" size="8" value="'+buy_price+'"></td>'+ 
						'<td><span class="pro_total_price_html"></span><input name="pro_total_price[]" type="hidden" class="pro_total_price" size="8" value="0.00" data-id="'+data.id+'"/></td>'+  
						'<td>'+data.remark+'</td>'+
					'</tr>';
				if($("#pro_body tr").length == 0){
					$("#pro_body").html(html);
				}else{
					$("#pro_body tr:last").after(html);
				} 	
			}
			// 计算当前价格
			set_pro_price(data.id); 
			// 重置总价格
			set_total_price();
		}else{ 
			//alert(data.msg); 
			// 错误提示
		}
	}
	 
	// 计算单个产品的价格
	function set_pro_price(data_id){
		pro_price = $(".pro_"+data_id+" input.pro_price").val();
		pro_num = $(".pro_"+data_id+" input.pro_num").val();  
		pro_total_price = (parseFloat(pro_price)*parseInt(pro_num)).toFixed(2); 
		$(".pro_"+data_id+" input.pro_total_price").val(pro_total_price);
		$(".pro_"+data_id+" span.pro_total_price_html").html(pro_total_price);
	}
	// 计算全部价格
	function set_total_price(){
		var total_price = 0; 
		$("table tbody tr").each(function(){ 
			pro_price = $("input.pro_total_price",this).val();
			total_price += parseFloat(pro_price);  
		}); 
		$("#total_price").html((total_price).toFixed(2));
		$(".total_price").val((total_price).toFixed(2));
		promote_price = $("#promote_price").val();
		other_price = $("#other_price").val();
		pay_price = (parseFloat(total_price)-parseFloat(promote_price)+parseFloat(other_price)).toFixed(2);;
		$("#pay_price").html(pay_price);
		$(".pay_price").val(pay_price);
	}
	
	$(document).on('click', ".pro_del",function(){
		var id = $(this).attr('data-id');
		$("tr.pro_"+id).remove();
		set_total_price();
	});
	
	// 操作对总价格的重计
	$(document).on('change', "input.pro_num",function(){
		data_id = $(this).attr('data-id');
		set_pro_price(data_id);
		set_total_price();
	});
	$(document).on('change', "input.pro_total_price",function(){
		data_id = $(this).attr('data-id'); 
		set_total_price();
	});
	$(document).on('change', "input#promote_price,#other_price",function(){
		data_id = $(this).attr('data-id'); 
		set_total_price();
	});
	
	
	
	
	
}); 