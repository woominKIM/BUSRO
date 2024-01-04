<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<%@include file="../includes/userHeader.jsp" %>
<script
  src="https://code.jquery.com/jquery-3.4.1.js"
  integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
  crossorigin="anonymous"></script>

<script> 
	$(function() {
		$("#find_idpw_btn").click(function() {
			location.href= "../member/find_idpw_form.do";
		});		
	})
</script>
<link rel="stylesheet" href="/resources/css/common.css">
<link rel="stylesheet" href="/resources/css/member/login.css">

<style type="text/css">

input[type=text], input[type=password] {
	height:50px;
	background-color: transparent;
	border: none;
	border-bottom: 1px solid;
	border-radius: 0;
	outline: none;	
	width: 62%;
	/* font-size: 2rem; */
	margin: 0 0 15px 0;	
	padding: 0;
	box-shadow: none;
	box-sizing: content-box;
	transition: all 0.3s;
	text-align: center;
	position: absolute;
	left: 50%;
	margin-left: -31%;
	
}

input[type=text]:focus, input[type=password]:focus {
	border-bottom: 1px solid #26a69a;
	box-shadow: 0 1px 0 0 #26a69a;	
}

.form-control {
	display: block;	
	color: black;
	background-image: none;	
}


</style>
</head>
<body>

<div class="wrapper">	
	<div class="wrap">
		<div id="content">
			<form id="login_form" method="post">
				<div class="logo_wrap">
					<span>로그인</span>
				</div>
				<div class="login_wrap" style="width: 100%">
					 
					<div class="id_wrap">
						<div class="id_input_box">				
							<input type="text" class="form-control" name="id" maxlength="12" placeholder="Your ID...관리자: GILDONG, 일반사용자: USER1">
						</div>
					</div>
					
					<div class="pw_wrap">
						<div class="pw_input_box">						
							<input type="password" class="form-control" name="pass" maxlength="12" placeholder="Your PW...관리자: ABC123, 일반사용자: AAA1">						
						</div>
					</div>				
									
					<div style="position: relative;">
						<div style="text-align: center; left: 50%; margin-left: -31%; margin-top: 30px; height: 50px; width: 62%; position: absolute;">
							<span id="find_idpw_btn" style="cursor: pointer;">아이디 / 비밀번호 찾기</span> &nbsp; / &nbsp;
							<a href="/member/beforeJoin">회원가입</a>
						</div>								
					</div>
					<div style="position: relative; ">
						<div style="height: 100px; width:62%; left:50%; margin-left:-31%; position: absolute; z-index: -1">
							<c:if test="${result == 0}">
								<div class="login_warn">사용자 ID 또는 비밀번호를 잘못 입력하셨습니다.</div>
							</c:if>
						</div>
					</div>
						
						<div class="login_button_wrap">
							<input type="button" class="login_button" value="로그인">
						</div>								
						
				</div>
			</form>	
		</div>	
	</div>
</div>

<script>

	/* 로그인 버튼 클릭 메서드 */
	$(".login_button").click(function() {
		
		$("#login_form").attr("action", "/member/login");
		$("#login_form").submit();
		
	});

</script>

<%@include file="../includes/footer.jsp" %>
</body>
</html>