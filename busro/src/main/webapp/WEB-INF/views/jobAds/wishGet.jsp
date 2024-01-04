<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@include file="../includes/adminHeader.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<title>Insert title here</title>

<style>
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
	width: 100x;
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

.btn{
	text-align: center;
}


.form-group *{
	vertical-align: middle;
}

.inimg{
	width: 80%;
	margin: 0 auto;
}


</style>
</head>





<body>
<div id="contentWrap">
<!-- 	<div class="bigPictureWrapper">
	<div class="bigPicture">
</div>
</div> -->


<div class="adTitle"><span>공지사항</span> </div>


<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default" >
			<div class="Wform">
				<div class="Wform-group2">
					<div><label>제목</label></div><div>${notice.title}</div>
				</div>
				
				<div class="Wform-group3">
					<div><label>관리자</label></div> 
					<div><label><c:out value="${notice.writer}"/></label></div>
					<div><label>등록일</label></div><div> <label  class="robolabel">  <fmt:formatDate pattern="yyyy-MM-dd" value="${notice.regdate}"/></label></div>
					<div><label>중요</label></div> 
					<c:if test="${notice.top eq 'y' }">
						<div><label><input class="chkTop" name="top" type="checkbox"  value="y" checked="checked" disabled="disabled"></label></div>
					</c:if>
					
					<c:if test="${notice.top eq 'n' }">
						<div><label><input name="top" class="chkTop" type="checkbox" value="y" disabled="disabled" ></label></div>
					</c:if>
				</div>	
				
				<hr style="width: 99%; margin-top: 20px; ">
				
					<div class="uploadResult">
						<ul></ul>
					</div>
				<div class="inimg">
				</div>
				
				<div class="form-group">
					
					<textarea id="noticeContent" class="form-control" name='content' readonly="readonly"><c:out value="${notice.content}" /></textarea>
				</div>
				
			</div>			
				<div class="noBtn">
				<%-- <c:if test="${notice.nno eq 13}"> --%>
					<button data-oper='modify' class="btn btn-default btnBtn" onclick="location.href='/jobAds/wishModify?nno=<c:out value="${notice.nno }"/>'">수정</button>
				<%-- </c:if> --%>
				

				<button data-oper='list' class="btn btn-info btnBtn" onclick="location.href='/jobAds/wishList'">목록</button>				
				</div>
				
				<form id="operForm" action="/jobAds/wishModify" method="get">
					<input type="hidden" id="nno" name="nno" value='<c:out value="${notice.nno}"/>'>
					<input type="hidden" name="pageNum" value='<c:out value="${cri.pageNum}"/>'>
					<input type="hidden" name="amount" value='<c:out value="${cri.amount}"/>'>
					<input type="hidden" name="keyword" value='<c:out value="${cri.keyword}"/>'>
					<input type="hidden" name="type" value='<c:out value="${cri.type}"/>'>
				</form>
				
				
	
		
	</div>
	<!-- end panel -->
</div>
<!-- /.row -->
</div>
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
				str2 += "<img width='100%' src='/display?fileName="+fileCallPath1+"'>";
				
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
		
		if($("#noticeContent").text() == "Imagine there's no heaven"){
			$("#noticeContent").hide();
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