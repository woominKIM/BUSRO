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
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />

<style type="text/css">

/* input{
	border-radius: 4px;
	border-width: 1px; 
} */


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


.btnb{
	
	border: none;
	height: 24px;

}



</style>
</head>
<body>
<div id="contentWrap">
<div class="wrap">
	<div class="row">
		<div class="adTitle"><p>공지사항 등록</p> </div>
		<!-- /.col-lg-12 -->
	</div>
	<!-- /.row -->


			<form role="form" action="/jobAds/wishRegister" method="post">
				<div class="Wform">
				<div class="Wform-group2">
					<div><span class="star">*</span><label>제목</label></div><div> <input class="form-control" id="title" name="title" maxlength="30" style="margin-left: 5px;"></div>
				</div>
				
				<div class="Wform-group">
					<div><label>관리자</label>(<c:out value="${vo.id}"/>)</div>
					
					<div><label>중요</label><input name="top" type="checkbox" value="y"> </div>
				</div>
				
				

				<div class="form-group uploadDiv">
					<div><input type="file" name="uploadFile" multiple></div>
				</div>
				
				<div class="uploadResult">
				
					<ul></ul>
				</div>
			
		
				
				<div class="form-group">
					<div><!-- <label>내용</label> --></div>
					<textarea class="Wcontent" cols="" rows="" name='content' placeholder="내용을 작성해주세요."></textarea>
				</div>
			</div>
				<div class="noBtn">
					<button type="submit" class="btnBtn">등록</button>
					<button type="button" class="btnBtn" onclick="location.href='/jobAds/wishList'">취소</button>
				</div>	

			</form>
		
</div>
</div>



<script>

$(document).ready(function(e) {
	
	var formObj = $("form[role='form']");
	
	$("button[type='submit']").on("click", function(e) {

		e.preventDefault();
		
		var title = $('#title').val();
	
		if(title==""  || title == null){
			
			alert("제목은 필수로 입력해주세요.");
			return false;
		}else{
			console.log("submit clicked");
			
			var str = "";
			
			$(".uploadResult ul li").each(function(i, obj) {
				
				var jobj = $(obj);
				
				console.dir(jobj);
				
				str += "<input type='hidden' name='attachList["+i+"].fileName'value='"+jobj.data("filename")+"'>";
				str += "<input type='hidden' name='attachList["+i+"].uuid'value='"+jobj.data("uuid")+"'>";
				str += "<input type='hidden' name='attachList["+i+"].uploadPath'value='"+jobj.data("path")+"'>";
				str += "<input type='hidden' name='attachList["+i+"].fileType'value='"+jobj.data("type")+"'>";
				
			});
			
			if($('.Wcontent').text() == "" ){
				$('.Wcontent').text("Imagine there's no heaven");
				
			}
			
			
			formObj.append(str).submit();		
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
	
});


</script>




</body>
</html>