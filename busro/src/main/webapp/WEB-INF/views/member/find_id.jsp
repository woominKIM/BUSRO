<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../includes/userHeader.jsp" %>    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="/resources/css/common.css">
<script
  src="https://code.jquery.com/jquery-3.4.1.js"
  integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
  crossorigin="anonymous"></script>
<script>
	$(function(){
		$("#loginBtn").click(function(){
			location.href='../member/login.do';
		})
		
		$("#findPwBtn").click(function(){
			location.href='../member/find_idpw_form.do';
		})
		
	})
</script>

<title>아이디 찾기 결과</title>
</head>
<body>

	<div id="content" style="text-align: center;">					
		<span style="font-size: 40px;">아이디 찾기 결과</span>
		<div style="height: 20px;"></div>
		<h5 style="font-size: 20px; font-weight: bold;">${id}입니다!</h5>
		<div style="height: 20px;"></div>
		<button type="button" id="loginBtn">로그인</button>
		<button type="button" id="findPwBtn">비밀번호 찾기</button>				
	</div>
<%@include file="../includes/footer.jsp" %>
</body>
</html>