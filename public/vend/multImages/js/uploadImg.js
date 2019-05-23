var imgSrc = []; //图片路径
var imgFile = []; //文件流
var imgName = []; //图片名字
//选择图片
function imgUpload(obj) {
	var oInput = '#' + obj.inputId;
	var imgBox = '#' + obj.imgBox;
	var btn = '#' + obj.buttonId;
	var serverId = obj.serverId;
	var upLastUrl=obj.upLastUrl;
    if (typeof(serverId) == "undefined" || serverId == '') {
            serverId = '';
    }
	if(serverId!=''){
		$.getJSON(upLastUrl, {id: serverId},function(result) {			
				  $(".lastimage").html(result.html);
				  for(var vo in result.data){
				  	$("#hiddenInput").append("<input type='hidden' name='"+result.data[vo].image+"[]' value='"+result.data[vo].image+"'>");
				  }
		});		
	}
	
	$(oInput).on("change", function() {
		var fileImg = $(oInput)[0];
		var fileList = fileImg.files;
		for(var i = 0; i < fileList.length; i++) {
			var imgSrcI = getObjectURL(fileList[i]);
			imgName.push(fileList[i].name);
			imgSrc.push(imgSrcI);
			imgFile.push(fileList[i]);
		}
		addNewContent(imgBox);
	})
	$(btn).on('click', function() {
		if(!limitNum(obj.num)){
		  	alert("超过限制");
		  	return false;
		}
		//用formDate对象上传
		var fd = new FormData($('#upBox')[0]);
		for(var i=0;i<imgFile.length;i++){
			fd.append(obj.data+"[]",imgFile[i]);
		}
		submitPicture(obj.upUrl, fd);
	})
}
//图片展示
function addNewContent(obj) {
	$(imgBox).html("");
	for(var a = 0; a < imgSrc.length; a++) {
		var oldBox = $(obj).html();
		$(obj).html(oldBox + '<div class="imgContainer"><img title=' + imgName[a] + ' alt=' + imgName[a] + ' src=' + imgSrc[a] + ' onclick="imgDisplay(this)"><p onclick="removeImg(this,' + a + ')" class="imgDelete">删除</p></div>');
	}
}
//删除
function removeImg(obj, index) {
	imgSrc.splice(index, 1);
	imgFile.splice(index, 1);
	imgName.splice(index, 1);
	var boxId = "#" + $(obj).parent('.imgContainer').parent().attr("id");
	addNewContent(boxId);
}

//删除
function removeImgLast(obj) {
	$(obj).parent('.imgContainer').remove();
}

//限制图片个数
function limitNum(num){
	if(!num){
		return true;
	}else if(imgFile.length>num){
		return false;
	}else{
		return true;
	}
}

//上传(将文件流数组传到后台)
function submitPicture(url,data) {
    for (var p of data) {
	  	//console.log(p);
	}
	if(url&&data){
		$.ajax({
			type: "post",
			url: url,
			async: true,
			data: data,
			processData: false,
			contentType: false,
			success: function(result) {
				
				try {
					var rs = $.parseJSON(result);
					for(var vo in rs){
							if (result.error != 1) {
								$("#hiddenInput").append("<input type='hidden' name='"+data.data+"[]' value='"+rs[vo].url+"'>");
							}
					}
				} catch(e) {
					alert(e);
				}
			}
		});
	}else{
	  alert('请打开控制台查看传递参数！');
	}
}
//图片灯箱
function imgDisplay(obj) {
	var src = $(obj).attr("src");
	var imgHtml = '<div style="width: 100%;height: 100vh;overflow: auto;background: rgba(0,0,0,0.5);text-align: center;position: fixed;top: 0;left: 0;z-index: 1000;"><img src=' + src + ' style="margin-top: 100px;width: 70%;margin-bottom: 100px;"/><p style="font-size: 50px;position: fixed;top: 30px;right: 30px;color: white;cursor: pointer;" onclick="closePicture(this)">×</p></div>'
	$('body').append(imgHtml);
}
//关闭
function closePicture(obj) {
	$(obj).parent("div").remove();
}

//图片预览路径
function getObjectURL(file) {
	var url = null;
	if(window.createObjectURL != undefined) { // basic
		url = window.createObjectURL(file);
	} else if(window.URL != undefined) { // mozilla(firefox)
		url = window.URL.createObjectURL(file);
	} else if(window.webkitURL != undefined) { // webkit or chrome
		url = window.webkitURL.createObjectURL(file);
	}
	return url;
}