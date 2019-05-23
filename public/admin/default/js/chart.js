// JavaScript Document
$.fn.statistic = function(opt){
	var def = {
			'color':'red',
			'size':'30px',
			'x_name':'时间',
			'y_name':'数量',
		}
	var set = $.extend(def, opt); 
	this.html("<div id='canvasDiv'></div> ");
	var width = this.width();
	var height = this.height(); 
	if(height == 0){
		height = '300';
	}
	jQuery.getScript("public/js/ichart.1.2.min.js", function() { 
		var data = [{ 
						value:set.data,
						color:'#31A3D7',
						line_width:1
					}
				 ];
		var labels = set.labels; 
		var chart = new iChart.LineBasic2D({
			render : 'canvasDiv',
			data: data, 
			width : width,
			height : height,
			shadow:true,
			shadow_color : '#ffffff',
			shadow_blur :5,
			shadow_offsetx : 0,
			shadow_offsety : 0,
			background_color:'#ffffff',
			tip:{
				enable:true,
				shadow:true,
				listeners:{
					parseText:function(tip,name,value,text,i){
						return "<span style='color:#005268;font-size:12px;'>"+labels[i]+""+ "</span> <span style='color:#005268;font-size:12px;'>"+value+"</span>";
					}
				}
			},
			crosshair:{
				enable:true,
				line_color:'#F59380'
			},
			sub_option : {
				smooth:true,
				label:false,
				hollow:false,
				hollow_inside:false,
				point_size:7
			},
			coordinate:{
				width:width-80,
				height:height-80,
				striped_factor : 0.18,
				grid_color:'#ddd',
				axis:{
					color:'#ddd',
					width:[0,0,1,1]
				},
				scale:[{ 
					 label : {
						color:'#9d987a',
						font : '微软雅黑',
						fontsize:11,
						fontweight:100
					 },
					 scale_color:'#9f9f9f'
					},{
					 position:'bottom',	
					 label : {
						color:'#9d987a',
						font : '微软雅黑',
						fontsize:11,
						fontweight:100
					 }, 
					 labels:labels
				}]
			}
		});
		//利用自定义组件构造左侧说明文本
		chart.plugin(new iChart.Custom({
				drawFn:function(){
					//计算位置
					var coo = chart.getCoordinate(),
						x = coo.get('originx'),
						y = coo.get('originy'),
						w = coo.width,
						h = coo.height;
					//在左上侧的位置，渲染一个单位的文字
					chart.target.textAlign('start')
					.textBaseline('bottom')
					.textFont('100 12px 微软雅黑').fillText(set.y_name, x-20, y-15, false,'#9d987a')
					.textBaseline('top').fillText(set.x_name, x+w+10, y+h-9, false,'#9d987a');
					
				}
		}));
		//开始画图
		chart.draw();
	});
}