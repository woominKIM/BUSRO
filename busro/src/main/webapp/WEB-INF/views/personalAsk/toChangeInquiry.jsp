<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../includes/userHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style type="text/css">


	 .star{
	 	color: rgb(238, 106, 123);
	 }


</style>
<title>1:1 문의</title>
<link rel="stylesheet" href="/resources/css/userQu.css">
</head>
<body>

<div id="contentWrap">
	<div class="quTitle"><span>질문 있어요</span> </div>
	<form action="/personalAsk/toChangeInquiry" method="post" role="form">
	
	<input type="hidden" name="ino" value="${view.ino}">
	<div class="iq_wrap">
		<div class="choose">
			<label>문의 유형 </label> <span class="star">*</span>
			<select id="category" name="category" required>
			
				<option value="예매" <c:if test="${view.category eq '예매'}">selected</c:if>>예매</option>
				<option value="결제" <c:if test="${view.category eq '결제'}">selected</c:if>>결제</option>
				<option value="취소/환불" <c:if test="${view.category eq '취소/환불'}">selected</c:if>>취소/환불</option>
				<option value="시스템" <c:if test="${view.category eq '시스템'}">selected</c:if>>시스템</option>
				<option value="기타" <c:if test="${view.category eq '기타'}">selected</c:if>>기타</option>
			</select>
		</div>
		<div class="wonder">
			<div class="who">
				<label>제목</label><span class="star">*</span>
				<input class="quty" type="text" placeholder="30자 이내 입력" maxlength="30" name="title" value="${view.title }" required> 
			</div>
			<div class="toCh">
				<label>작성자 : ${member.id}</label>
				<label>등록일 : <fmt:formatDate value="${view.regdate }" pattern="yy.MM.dd"/></label>
			</div>
			
			<hr style="width: 99%; margin-top: 20px; ">
			
			<textarea class="quco" rows="" cols="" name="content" required>${view.content }</textarea>
		</div>
	</div><!-- iq_wrap -->
	<div class="quBtn">
		<button type="button" onclick="location.href='/personalAsk/myPageInquiryDetail?ino=<c:out value="${view.ino}"/>'">취소</button>
		<button type="submit" data-oper="save">저장</button>
		<button type="submit" data-oper="removeBtn">삭제</button>
	</div>
	<!-- 삭제모달창 -->
		
			<div id="deletemodal" class="deletemodal" style="display: none;">
				<div class="modal-content" role="document">
					<div class="modal-header">
					
					</div>
					<div class="modal-body">
						문의글을 삭제하시겠습니까? 
					</div> <!-- 모달 창 바디 -->
					<div class="modal-footer">
						<button class="modalRemoveBtn" data-oper="remove" id="delete">진행</button>
						<button class="modalCloseBtn" data-oper="modalclose" >닫기</button>
					</div> <!-- 모달 버튼  -->	
				</div> <!-- 모달 전체 내용 -->
			</div> <!-- deletemodal 끝 -->
			
	<!-- 삭제 모달창 끝 -->
	

	</form>

</div>

</body>

<script type="text/javascript">

	$(document).ready(function () {
	
		var formObj = $("form");
		var title = $(".qutu").val();
		var content = $(".quco").val();
		
		$('button').on("click", function (e) {
			
			e.preventDefault();
			
			var operation = $(this).data("oper");
			
			if(operation === 'remove'){
				
				formObj.attr("action", "/personalAsk/userInquiryDelete");
				alert("삭제 완료");
				
				console.log("삭제 성공")
				
				formObj.submit();
				
			}
			
			if(operation === 'save'){
				
				if(title != null && content != null){
					console.log(formObj);
					formObj.submit();
				}else if(title == null || title == ""){
					alert("제목을 입력해주세요.");
					location.reload();
					
				}else if(content == null || content == ""){
					alert("내용을 입력해주세요.");
					location.reload();
					
				}
				
			}
			
			if(operation === 'removeBtn'){
				
				$("#deletemodal").show();
				
			}
			
			if(operation === 'modalclose'){
				
				$("#deletemodal").hide();
			}
			
			
		}); //버튼 클릭 시 
		
		
		
		
		
	}); //ready
	
	
	

</script>

</html>