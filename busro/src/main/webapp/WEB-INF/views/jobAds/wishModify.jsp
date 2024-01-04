<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@include file="../includes/adminHeader.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
</head>

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
	margin-top: 5px;

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

.fileName{

	margin-right: 5px;
}

.material-symbols-outlined {
  font-variation-settings:
  'FILL' 0,
  'wght' 400,
  'GRAD' 0,
  'opsz' 24
  
}

.material-symbols-outlined {
 	background-color: #808080;
}



.btn{
	text-align: center;
}

.btnb{
	background-color: #808080;
	border: none;
	height: 24px;

}




</style>



<body>
<div id="contentWrap">

			<div class="adTitle"><span>공지사항 수정</span> </div>
			
				<form role="form" action="/jobAds/wishModify" method="post">
				
				<input type="hidden" name="pageNum" value="<c:out value='${cri.pageNum }'/>" >
				<input type="hidden"  name="amount" value="<c:out value='${cri.amount}'/>" >
				<input type="hidden"  name="type" value="<c:out value='${cri.type}'/>" >
				<input type="hidden"  name="keyword" value="<c:out value='${cri.keyword}'/>" >
				<div class="Wform">
				<div class="Wform-group2">
					<div><span class="star">*</span><label>제목</label></div><div> <input class="form-control" name="title" value='<c:out value="${notice.title }"/>'></div>
				</div>
				
				
				<div class="Wform-group3">
					<div><label>관리자</label></div>
					<div><label><c:out value="${notice.writer}"/></label></div>
					<div><label>등록일</label></div><div> <label>  <fmt:formatDate pattern="yyyy-MM-dd" value="${notice.regdate}"/></label></div>
					<div><label>중요</label></div> 
					<c:if test="${notice.top eq 'y' }">
						<div><label><input name="top" type="checkbox"  value="y" checked="checked"></label></div>
					</c:if>
					
					<c:if test="${notice.top eq 'n' }">
						<div><label><input name="top" type="checkbox" value="y"></label></div>
					</c:if>
				</div>	
				
				
				<div class="bigPictureWrapper">
					<div class="bigPicture"></div>
				</div>
				
			
						
						<div class="panel-heading">파일첨부</div>
						
							<div class="form-group uploadDiv">
							<input type="file" name="uploadFile" multiple="multiple">
							</div>						
						
						
							<div class="uploadResult">
								 <ul></ul>
					   		</div>
							<div class="form-group">
								<textarea id="Wcontent" class="form-control" name='content'><c:out value="${notice.content}" /></textarea>
							</div>
						
			
					</div>
				<div class="noBtn">
					<button type="submit" data-oper='modify' class="btn btn-default btnBtn" >수정</button>
					<button type="submit" data-oper='remove' class="btn btn-danger btnBtn">삭제</button>
					<button type="submit" data-oper='list' class="btn btn-info btnBtn" >목록</button>
				</div>
								
			</form>
			
			
</div>


<script>


$(document).ready(function(){
	
	(function() {
		
		if($('#Wcontent').text() == "Imagine there's no heaven" ){
			$('#Wcontent').text("");
			
		}
		
		var nno = '<c:out value="${notice.nno}"/>';
	
	$.getJSON("/jobAds/getAttachList", {nno: nno}, function(arr) {
		
		console.log(arr);
		
		var str = "";
		var str1 = "파일첨부 &nbsp;&nbsp;";	
		
		$(arr).each(function(i, attach) {
			
			
			//image type
			
			if(attach.fileType){
				
				var fileCallPath = encodeURIComponent( attach.uploadPath+ "/s_"+attach.uuid +"_"+attach.fileName);
				
				str1 += attach.fileName;
				str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' "
				str +=" data-filename= '"+attach.fileName+"' data-type='"+attach.fileType+"' ><div>";
				str += "<span class='fileName'> " + attach.fileName+"</span>";
				str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='image' "
				str += " class='btn btn-warning btn-circle btnb'><span class='material-symbols-outlined'>close</span></button><br><br>";  
				str += "<img src='/display?fileName="+fileCallPath+"'>";
				str += "</div>";
				str += "</li>";
				
			}else{
				
				str1 += attach.fileName;
				str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' "
				str += "data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"' ><div>";
				str += "<span class='fileName'> "+ attach.fileName+"</span><br/>";
				str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='file' "
				str += " class='btn btn-warning btn-circle btnb'><span class='material-symbols-outlined'>close</span></button><br>"; 
				str += "<img src='/resources/img/attach.png'></a>";
				str += "</div>";
				str += "</li>";
				
			}

		});
		
		$(".panel-heading").html(str1);
		$(".uploadResult ul").html(str);
		
	});	//end getjson
   })();//end function

	
   $(".uploadResult").on("click", "button", function(e) {
	   
	   console.log("delete file");
	   
	   if(confirm("삭제하시겠습니까? ")){
		   
		   var targetLi = $(this).closest("li");
		   targetLi.remove();
		   
	   }
	
});
   
		var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
			var maxSize = 5242880;	//5MB
			
			function checkExtension(fileName, fileSize) {
				
				if(fileSize >= maxSize){
					alert("파일 사이즈 초과");
					return false;
				}
			
		if(regex.test(fileName)){
			alert("해당 종류의 파일은 업로드할 수 없습니다.")
			
			return false;
		}
		return true;
		
		}
			
		$("input[type='file']").change(function(e) {
			
			var formData = new FormData();
			
			var inputFile = $("input[name='uploadFile']");
			
			var files = inputFile[0].files;
			
			for(var i = 0; i < files.length; i++){
				console.log('옴??');	
				
				if(!checkExtension(files[i].name, files[i].size) ){
					return false;
				}
			
			formData.append("uploadFile", files[i]);
				
			}
			
			$.ajax({
				
				url: '/uploadAjaxAction',
				processData: false,
				contentType: false, data:
				formData,type: 'POST',
				dataType: 'json',
					success: function(result) {
						console.log(result);
				showUploadResult(result);	//업로드 결과 처리 함수			
						
					}
			}); //$.ajax
			
			
		});
		
		function showUploadResult(uploadResultArr){
			
			if(!uploadResultArr || uploadResultArr.length == 0){ return; }
			
			var uploadUL = $(".uploadResult ul");
			
			var str ="";
			
			$(uploadResultArr).each(function(i, obj) {
				
				//image type
				if(obj.image){
					
					var fileCallPath = encodeURIComponent( obj.uploadPath+ "/s_"+obj.uuid +"_"+obj.fileName);
					
					str += "<li data-path='"+obj.uploadPath+"'";
					str +=" data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"'data-type='"+obj.image+"'"
					str +=" ><div>";
					str += "<span class='fileName'>" + obj.fileName+"</span>";
					str += "<button type='button' data-file=\'"+fileCallPath+"\' "
					str += "data-type='image' class='btn btn-warning btn-circle btnb'><span class='material-symbols-outlined'>close</span></button><br>";
					str += "<img src='/display?fileName="+fileCallPath+"'>";
					str += "</div>";
					str += "</li>";
					
				}else{
				
					var fileCallPath = encodeURIComponent(obj.uploadPath+"/"+obj.uuid +"_"+obj.fileName);
					var fileLink = fileCallPath.replace(new RegExp(/\\/g),"/");
					
					str += "<li "
					str += "data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"' ><div>";
					str += "<span class='fileName'>" + obj.fileName+"</span>";
					str += "<button type='button' data-file=\'"+fileCallPath+"\' "
					str += "data-type='image' class='btn btn-warning btn-circle btnb'><span class='material-symbols-outlined'>close</span></button><br>";
					str += "<img src='/resources/img/attach.png'></a>";
					str += "</div>";
					str += "</li>";
					
				}
				
				$(".uploadResult").on("click", "button", function(e) {
					
					console.log("delete file");
					
					var targetFile = $(this).data("file");
					var type = $(this).data("type");
					
					var targetLi = $(this).closest("li");
					
					
					$.ajax({
						
						url: '/deleteFile',
						data: {fileName: targetFile, type:type},
						dataType: 'text',
						type: 'POST',
							success: function(result) {
								alert(result);
								targetLi.remove();	
								
							}
					}); //$.ajax
				});
				
			});
			
			uploadUL.append(str);
			
		}

   
   
	
		var formObj = $("form");
		console.log("진입");
			
	/* 	var str = '<input type="text"  name="nno" value="<c:out value='${notice.nno }'/>" >'; */
		$('button').on("click", function(e) {
			
			e.preventDefault();
			
			var operation = $(this).data("oper");
			
			console.log(operation);
			
			
			if(operation === 'remove') {
				formObj.attr("action", "/jobAds/wishRemove");
				
				
				
				
					if(confirm("삭제하시겠습니까?")){
						var aa = "<c:out value='${notice.nno}' />";
						var bb = "<input name='nno' value='" + aa + "'>";					
						formObj.append(bb).submit();
					
					
				
					}else{
						return false;
				
					}
			}else if(operation === 'list'){
				
				
				
				//move to list
				//self.location= "/jobAds/wishList";
				//return;
				
				formObj.attr("action", "/jobAds/wishList").attr("method", "get");
				var pageNumTag = $("input[name='pageNum']").clone();
				var amountTag = $("input[name='amount']").clone();
				var keywordTag = $("input[name='keyword']").clone();
				var typeTag = $("input[name='type']").clone();
				
				
				formObj.empty();
				
				formObj.append(pageNumTag);
				formObj.append(amountTag);
				formObj.append(keywordTag);
				formObj.append(typeTag);
				
				
			}
			else if(operation === 'modify'){
				
				console.log("submit clicked");
				console.log($('#Wcontent').text());
				if($('#Wcontent').text() == "" ){
					$('#Wcontent').text("Imagine there's no heaven");
						
				}
				
				
				var str = "";
				
				var aa = "<c:out value='${notice.nno}' />";
				var bb = "<input type='hidden' name='nno' value='" + aa + "'>";					
				formObj.append(bb);
				
				$(".uploadResult ul li").each(function(i, obj) {
					
					var jobj = $(obj);
					
					console.dir(jobj);
					
					str += "<input type='hidden' name='attachList["+i+"].fileName'value='"+jobj.data("filename")+"'>";
					str += "<input type='hidden' name='attachList["+i+"].uuid'value='"+jobj.data("uuid")+"'>";
					str += "<input type='hidden' name='attachList["+i+"].uploadPath'value='"+jobj.data("path")+"'>";
					str += "<input type='hidden' name='attachList["+i+"].fileType'value='"+jobj.data("type")+"'>";
					
				});
				
				
				
				formObj.append(str).submit();
				
				}
			
		
			formObj.submit();	
			 	
		
			});
			
		
			
			
		
		});
	

</script>


</body>
</html>