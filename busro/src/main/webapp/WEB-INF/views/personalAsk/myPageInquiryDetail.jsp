<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../includes/userHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원용 상세 보기</title>
<link rel="stylesheet" href="/resources/css/userQu.css">
</head>
<body>
<div id="contentWrap">
	<div class="quTitle"><span>1:1 문의 내역</span> </div>
	<div class="iq_wrap">
		<div class="choose">
				<label>[${view.category }]</label>
				<label>${view.title }</label>
		</div>
		
		
		<div class="memberInfo">
			<div class="who">
				<label>작성자 : ${view.writer }</label>	
				<label>등록일 : <fmt:formatDate value="${view.regdate }" pattern="yy.MM.dd"/></label>
			</div>	
				
			<textarea rows="" cols="" name="content" disabled="disabled">${view.content }</textarea>
				
		</div> <!-- 문의 상세 내용 -->
	</div>
	
	<div class="an_wrap">
		<!-- 존재하는 답변 구간 -->
		
		<div class="answer">
				
		</div>	<!-- 존재하는 답변 구간 끝 -->
	</div>
</div>	
	 <form action="/personalAsk/userInquiryDelete" method="post" role="form">
	 
	 <input type="hidden" name="ino" value="${view.ino}">
	 <div class="quBtn">
		<button type="button" onclick="location.href='/personalAsk/myPageInquiryList'">목록</button>
		<button type="button" id="modBtn" onclick="location.href='/personalAsk/toChangeInquiry?ino=<c:out value="${view.ino}"/>'">수정</button>
		<button type="submit" data-oper="removeBtn" id="removeBtn">삭제</button>
	</div>
	<!-- 삭제모달창 -->
		
			<div id="deletemodal" class="deletemodal" style="display: none;">
				<div class="modal-content" role="document">
					<div class="modal-header">
					
					</div>
					<div class="delete-body">
						문의글을 삭제하시겠습니까? 
					</div> <!-- 모달 창 바디 -->
					<div class="delete-modal-footer">
						<button class="modalRemoveBtn deBtn" data-oper="remove" id="delete">진행</button>
						<button class="modalCloseBtn deBtn" data-oper="modalclose" >닫기</button>
					</div> <!-- 모달 버튼  -->	
				</div> <!-- 모달 전체 내용 -->
			</div> <!-- deletemodal 끝 -->
			
	<!-- 삭제 모달창 끝 -->
	</form>
	<%@ include file="../includes/footer.jsp" %>
</body>

<script type="text/javascript">
	
	$(document).ready(function () {
		$(".an_wrap").hide();
		$("#modBtn").hide();
		$("#removeBtn").hide();
		
		var ino = ${view.ino};
		
		var writer;
		
		var content;
		
		var answerUL = $(".an_wrap");
		
		var rd = '<fmt:formatDate value="${get.regdate}" pattern="yy.MM.dd" />';
		var act = '${get.content}';
		var ino = ${view.ino};

		//답변 존재하면 조회하는 ajax =====================
		$.ajax({
		
			type: 'get', 
			data : {ino : ino}, 
			url: '/admin/check', 
			success: function (result) {
			
				if(result == 0){
					console.log('없다네');
					console.log("? : " + result);
					console.log(result);
					
					
					$("#modBtn").show();
					$("#removeBtn").show();
					
				}else{
					console.log('있다네');
					console.log("? : " + result);
					console.log(result);
					
					$(".an_wrap").show();
					
					$(".answer").append("<div class='adminWriter' name='writer'>작성자 : 관리자</div><div class='adminDate' name='regdate'>등록일 : " + rd + "</div><textarea rows='' cols='' class='adminContent' name='content' disabled>" + act + "</textarea>");
					
				}
				   
				
			}, error: function () {
				
				console.log("실패");
				
			}
			
	}); // ajax 
	
	
	var formObj = $("form");
	
	
	$('button').on("click", function (e) {
		
		e.preventDefault();
		
		var operation = $(this).data("oper");
		
		if(operation === 'remove'){
			
			formObj.attr("action", "/personalAsk/userInquiryDelete");
			alert("삭제 완료");
			
			console.log("삭제 성공")
			
			formObj.submit();
			
		}
		
		if(operation === 'removeBtn'){
			
			$("#deletemodal").show();
			
		}
		
		if(operation === 'modalclose'){
			
			$("#deletemodal").hide();
		}
		
		
	}); //버튼 클릭 시 
	
	});// ready
	
	

</script>

</html>