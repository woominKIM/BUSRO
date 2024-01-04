<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../includes/userHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>1:1 문의</title>
<link rel="stylesheet" href="/resources/css/userQu.css">
</head>
<body>
<div id="contentWrap">
	<div class="quTitle"><span>질문 있어요</span> </div>
	
	<form action="/personalAsk/ihaveAQ" method="post" role="form">
	<div class="iq_wrap">
		<div class="choose">
			<label>문의 유형</label> <span class="star">*</span>
			<select name="category" required>
				<option value="" selected disabled="disabled" >--선택해주세요--</option>
				<option value="예매">예매</option>
				<option value="결제">결제</option>
				<option value="취소/환불">취소/환불</option>
				<option value="시스템">시스템</option>
				<option value="기타">기타</option>
			</select>
		</div>
		
		<div class="wonder">
			<div class="who">
				<label>제목</label><span class="star">*</span>
				<input class="quty" type="text" placeholder="30자 이내 입력" maxlength="30" name="title" required> 
				
				<label>작성자 : </label> <input type="text" value="${member.id}" name="writer" style="border-bottom-width: 0;">
			</div>
			
			<hr style="width: 99%; margin-top: 20px; ">
			
			<!-- <label>내용</label> <span class="star">*</span> -->
			<textarea rows="" cols="" name="content" required placeholder="내용을 입력하세요."></textarea>
			</div>
	</div><!-- iq_wrap -->
			<div class="quBtn">
				<button type="button" onclick="location.href='/personalAsk/myPageInquiryList'">취소</button>
				<button type="submit" >등록</button>
		</div>

	</form>
</div>

<script type="text/javascript">

	

</script>
<%@ include file="../includes/footer.jsp" %>
</body>



</html>