<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@include file="../includes/userHeader.jsp"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<title>Insert title here</title>

<style>
#contentWrap{
	width:1080px;
	min-height: 60vh;
	margin: 0 auto;
}

*{	
	
	color: #050540;
	font-family: "roboto","Noto Sans KR",sans-serif;
    font-size: 15px;
}


.page-header{

	font-size: 40px;
	margin-top: 60px;
	margin-bottom: 80px;
	text-align: center;
	
	
}


.Ntitle{

	font-size: 20px;
}

*:focus{
	
	outline: 0;
}

 .panel-body{
	border : 1px solid #050540; 
	display: block;
	min-width: 1080px;
	margin: 0 auto;
	position: relative;
	padding: 20px;
	border-radius: 4px;
	
} 

 #input-letter{
	
	min-width: 1038.3333px;
	min-height: 300px;
	white-space : pre-line;
	padding : 20px;
	display : block;
	margin-top: 30px;
	
	

} 

 .uploadResult {

	width: 100%;
	background-color: gray;
	
}

 .uploadResult ul{
	display: flex;
	flex-flow: row;
	justify-content: center;
	align-items: center;

}

.uploadResult ul li {
	list-style: none;
	padding: 10px;
	align-content: center;
	text-align: center;
}

.uploadResult il li img{
	width: 100px;
}

.uploadResult ul li span{
	color: white;
}

.bigPictureWrapper {
	position: absolute;
	display: none;
	justify-content: center;
	align-items: center;
	top: 0%;
	width: 100%;
	height: 100%;
	background-color: gray;
	z-index: 100;
	background: rgba(255,255,255,0.5);	
}

.bigPicture {
	position: relative;
	display: flex;
	justify-content: center;
	align-items: center;
}

.bigPicture img {
	width: 600px;
}


.btnlist{

	background-color: #050540;
	color: white;
	border-radius: 8px;
	border-width: 0;
	padding: 6px 20px 9px 20px;
	margin: auto;
	margin-top: 60px;
	display: block;
	
}
.form-group {
	
	
	padding: 20px 10px 40px 20px;
	float: left;
	
}

.formIn-group {
	
	
	padding: 20px 20px 40px 10px;
	float: left;
	
}



.panel-heading{
	padding: 10px;
}

.inimg{
	width: 100%;
	margin: 0 auto;
	text-align: center;
}




</style>
</head>



<h1 class="page-header">공지사항</h1>

<body>
<div id="contentWrap">
	<div class="bigPictureWrapper">
	<div class="bigPicture"><ul></ul>
</div>
</div>



			
			<div class="panel-body">
				
					
						<div class="form-group" style="width: 100px;">
							<label class="Ntitle">제목</label><br><br>
							<label>관리자</label>
						</div>
						
							
						
						<div class="formIn-group" style="width: 400px;">
							<label class="Ntitle"><c:out value="${notice.title }"/></label><br><br>
							<%-- <input class="form-control" name='title' value='<c:out value="${notice.title }"/>' readonly="readonly" size="30" style="border: none; font-size: 30px;"><br><br> --%>
							<label>등록일</label>&nbsp&nbsp&nbsp&nbsp<label><fmt:formatDate pattern="yyyy-MM-dd" value="${notice.regdate}" /></label>
						</div>	
					
					
				<div style='clear:both;'></div>
				
					<hr>
					
				<div class="panel-heading"></div>
					
					<div class="inimg">
					</div>
					<div class="input-div">
						<div id="input-letter"><c:out value="${notice.content}" /></div>
					</div>
			<!-- end panel-body -->
		
		</div>
		<button data-oper='list' class="btnlist" onclick="location.href='/jobAds/wishListShow'">목록</button>				
</div>		


<script>

$(document).ready(function(){
	
	(function() {
		
		var nno = '<c:out value="${notice.nno}"/>';
	
	$.getJSON("/jobAds/getAttachList", {nno: nno}, function(arr) {
		
		console.log(arr);
		
		var str = "";
		/* var str1 = "&nbsp;"; */	
		var str2 = "";
		
		$(arr).each(function(i, attach) {
			
			
			//image type
			
			if(attach.fileType){
				
				var fileCallPath = encodeURIComponent( attach.uploadPath+ "/s_"+attach.uuid +"_"+attach.fileName);
				var fileCallPath1 = encodeURIComponent( attach.uploadPath+ "/"+attach.uuid +"_"+attach.fileName);
				/* str1 += attach.fileName; */
				str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"'><div>";
				str += "<img src='/display?fileName="+fileCallPath+"'>";
				str += "</div>";
				str += "</li>";
				str2 += "<img width='80%' src='/display?fileName="+fileCallPath1+"'>";
				
			}else{
				/* str1 += attach.fileName; */
				str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"' ><div>";
				str += "<span> " + attach.fileName+"</span><br/>";
				str += "<img  src='/resources/img/attach.png' >";
				str += "</div>";
				str += "</li>";
				
			}

		});
		$(".inimg").html(str2);
		/* $(".panel-new").html(str1); */
		/* $(".uploadResult ul").html(str);  */
		
		if($("#input-letter").text() == "Imagine there's no heaven"){
			$("#input-letter").hide();
		}
	});	//end getjson
	
	
	$(".uploadResult").on("click", "li", function(e) {
		
		console.log("view image");
		
		var liObj = $(this);
		
		var path = encodeURIComponent(liObj.data("path")+"/" + liObj.data("uuid")+"_" + liObj.data("filename"));
		
		if(liObj.data("type")){
			
			showImage(path.replace(new RegExp(/\\/g),"/"));
			
		}else {
			//download
			self.location ="/download?fileName="+path
		}
		
		
});
	
	
	function showImage(fileCallPath) {
		
		alert(fileCallPath);
		
		$(".bigPictureWrapper").css("display", "flex").show();
		
		$(".bigPicture")
		.html("<img src='/display?fileName="+fileCallPath+"'>")
		.animate({width: '100%', height: '100%'}, 1000);
		
	}
	
	$(".bigPictureWrapper").on("click", function(e) {
		
		$(".bigPicture").animate({width: '0%', height: '0%'}, 1000);
		setTimeout(function() {
			$('.bigPictureWrapper').hide();
			
		}, 1000);
		
		
	});
	
	
	
})();	//end function 
	
});



</script>


</body>
</html>