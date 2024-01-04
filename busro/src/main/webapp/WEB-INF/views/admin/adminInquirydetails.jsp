<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../includes/adminHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
	input:disabled{
	
		background: white;
		color: black;
		
	}
	
	input {
		
		border: none;
		
	}
	
	textarea {
		
		width: 100%;
		 
		border: none;
		resize: none;
		background: white;
		color: black; 
		text-align: left;
		
	}
</style>
<meta charset="UTF-8">
<title>문의 상세 내용</title>
</head>
<body>

<div class="whole">
<div class="new_world">
	<p class="pageName">1:1 문의</p>
		<div class="detailMaterial">
			<div class="qtitle">
				<input type="text" name="category" disabled="disabled" value="[${view.category }]">
				<input type="text" name="title" disabled="disabled" value="${view.title }" style="width: 800px;">
			</div>
			
			<hr style="margin-top: 10px;" >
			
			<div class="qmemberInfo">
				<span>작성자 : </span><input type="text" name="writer" disabled="disabled" value="${view.writer }">
				<span>성함 : </span> <input type="text" name="writer" disabled="disabled" value="${view.memberVO.name }">
				
				<input type="text" name="regdate" disabled="disabled" value='작성일 : <fmt:formatDate value="${view.regdate }" pattern="yy.MM.dd"/>'>
				<hr style="margin-top: 20px; margin-bottom: 20px;">
				<textarea rows="" cols="" name="content" disabled="disabled">${view.content}</textarea>
			</div> <!-- 문의 상세 내용 -->
		</div>
</div>	
<div class="aranight">
	<div class="adminAnswerBtn">
				
			<button data-oper='save' class="save btnBtn">저장</button>	
			
			<button data-oper='modify' class="modify btnBtn">수정</button>
			<button class="finalModify btnBtn">수정</button>	
			<button data-oper='delete' class="delete yesX">삭제</button>	
		</div>
<div class="adminRegion">
		
		
		<!-- 답변 구간 -->
			<div class="answerArea">
				<input type="hidden" value="" name="regdate">
				
				<c:if test="${ member != null }">
            		<div class="login_success_area">
                     <span>작성자 : </span>   <input type="text" value="${member.id}" class="addWriter" name="writer" disabled="disabled">
                    </div>
                </c:if>
				
				<hr style="margin-top: 10px; margin-bottom: 20px;">
				
				<textarea rows="" cols="10" placeholder="답변 작성" id="addContent" class="addContent" name="content" wrap="hard" required="required"></textarea>
			</div>
		<!-- 존재하는 답변 구간 -->	
		<div class="admin">
			
			
		</div>	<!-- 존재하는 답변 구간 끝 -->
			
</div>	
</div>
	<div class="noBtn">		
		<button  type="button" class="btnBtn" onclick="location.href='/admin/adminInquirylist'">목록</button>
	</div>
</div> <!-- whole -->		
		
		<!-- 삭제용 모달 구간 -->
		<div class="deletemodal" id="deletemodal" style="display: none;">
			<div class="modal-content">
				<div class="qdelete-body"> 삭제하시겠습니까? </div>
				<div class="delete-modal-footer">
					<button class="modalRemoveBtn yesX">예</button>
					<button class="modalCloseBtn btnBtn">아니오</button>
				</div>
			</div>
		
		</div> <!-- 삭제용 모달 구간 끝 -->
		
		
			
		
		


	<script type="text/javascript">
		var writer;
		//var content = $("#addContent").val();
		var content;
		
		var ino = ${view.ino};
	
		var answerUL = $(".admin");
		
		
		$(document).ready(function () {
			
			
			$(".save").hide();
			
			$(".modify").hide();
			$(".delete").hide();
			
			$(".finalModify").hide();
				
		
			$(".modify").on("click", function () {
				
				$(".finalModify").show();
				$(".modify").hide();
				$(".delete").hide();
				$(".adminWriter").removeAttr("disabled");
				$(".adminContent").removeAttr("disabled");
				
				
			}); //수정버튼 누르면
			
			
			$(".finalModify").on("click", function () {
				
				console.log("수정버튼 클릭");
				
				content = $(".adminContent").val();
				
				writer = $(".adminWriter").text();
				
				ino = ${view.ino};
				
				
				$.ajax({
					type : 'post', 
					url : '/update',
					data : { 
						writer : writer, 
						content : content, 
						ino : ino
					}, success: function (updateResult) {
						
						console.log("수정 성공");
						
						console.log("수정 내용 : " + content);
						console.log("수정 작성자 : " + writer);
						
						
						//location.reload();
						$(".modify").show();
						$(".finalModify").hide();
						$(".delete").show();
						$(".admin").show();
						$(".adminContent").attr("disabled");
						
						
					}, error: function () {
						
						console.log("수정 실패");
						console.log("수정 내용 : " + content);
						console.log("수정 작성자 : " + writer);
					}
				
					
					
				}); //ajax
				
			}); //최종 글 수정 버튼 누르면
				
			
			$(".modalCloseBtn").on("click", function () {
				$(".deletemodal").hide();
			});
			
			
		console.log("당근");
		
		var abc = '${get.writer}';
		var rd = '<fmt:formatDate value="${get.regdate}" pattern="yy.MM.dd" />';
		var act = '${get.content}';
		var ino = ${view.ino};
		
		
		var answerUL = $(".admin");
		
		writer = $(".addWriter").val();
		//var content = $("#addContent").val();
		content = $(".addContent").val();
		//var content = document.getElementById("addContent").innerText.value; 
		
		//답변 존재하면 조회하는 ajax =====================
		$.ajax({
			
			type: 'get', 
			data : {ino : ino}, 
			url: '/admin/check', 
			success: function (result) {
			
				if(result == 0){
					console.log('없다네');
					console.log("? : " + result);
					
					$(".save").show();
					
					
				}else{
					
					
					
					console.log('있다네');
					console.log("? : " + result);
					
					
					$(".modify").show();
					$(".delete").show();
					$(".answerArea").hide();
					
					$(".admin").append("<div class='adminWriter' name='writer'>작성자 : " + abc + "</div><div class='adminDate' name='regdate'>등록일 : " + rd + "</div><hr style='margin-top: 10px; margin-bottom: 20px;'><textarea rows='' cols='' class='adminContent' name='content' disabled>" + act + "</textarea>");
					
					console.log("작성자 : " + abc);
					console.log("등록일 : " + rd);
					console.log("내용 : " + act);
					
					
				}
				   
				
			}
			
		}); // ajax 
		
		console.log("고구마");
		
		
			
		
		
		
		}); //ready
		
		
		
		
		$(".save").on("click", function () { 
			
			content = $(".addContent").val(); //aaa
			ino = ${view.ino};
			console.log("writer : " + content);
			console.log("writer : " + writer);
			$(".save").hide();
			
			$(".addContent").attr('disabled', true);
			$(".modify").show();
			$(".delete").show();
			
			if(content == "" || content == null){
					alert("답변을 작성해주세요.");
					location.reload();
				
			}else {
				$.ajax({
					type: 'post', 
					url : '/admin/add',
					data : { 
						writer : writer, 
						content : content, 
						ino : ino
					}, success : function (enroll) {
						
						if(enroll == "add"){
							console.log("성공?");
							console.log("등록 성공" + enroll);
							
						location.reload();
							
						}
						
						
					}, error: function () {
						console.log("등록 실패");
					}
				});
			}	
			
			
			
			
			
		
	}); //저장 누르면	
	
	
	
	
	
	$(document).on('click', '.delete', function (e) {
			
			
			ino = ${view.ino}
			
			console.log("삭제용 ino : " + ino);
		 
			$(".deletemodal").show();
		
			e.preventDefault();
			
			$(".modalRemoveBtn").on("click", function (e){
				
				$.ajax({
					
					type : 'delete', 
					url : '/admin/' + ino , 
					data : {ino : ino }, 
					success : function (deleteResult) {
						
						const xhr = new XMLHttpRequest();
						
						xhr.open('get', 'http://localhost:8090/admin/adminInquirydetails?pageNum=&amount=&type=&keyword=&&ino=' + ino, true);
						xhr.send();
					}
					
				}); //ajax
				
				$(".deletemodal").hide();
				
				$(".answerArea").show();
				$(".modify").hide();
				$(".delete").hide();
			}); //모달창 삭제
			
			
			
			
		}); // 삭제 누르면
	
	
				
				
			
	</script>

</body>
</html>