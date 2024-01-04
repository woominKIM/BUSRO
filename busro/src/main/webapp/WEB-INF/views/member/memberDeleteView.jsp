<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.4.1.js"
	integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
	crossorigin="anonymous"></script>
	
<title>회원탈퇴</title>
<%@include file="../includes/userHeader.jsp"%>
<link rel="stylesheet" href="/resources/css/common.css">
<style type="text/css">
input {
	height: 50px;
	background-color: transparent;
	border: none;
	border-bottom: 1px solid;
	border-radius: 0;
	outline: none;	
	width: 25%;	
	margin: 0 0 15px 0;	
	padding: 0;
	box-shadow: none;
	box-sizing: content-box;
	transition: all 0.3s;
	text-align: center;	
}

input:focus {
	border-bottom: 1px solid #26a69a;
	box-shadow: 0 1px 0 0 #26a69a;
}
</style>
</head>

<script type="text/javascript">
		$(document).ready(function(){
			
			// 취소
			$("#cancel").on("click", function(){
				
				location.href = "/main";
						    
			});
			
			
			$("#submit1").on("click", function(e) {
				
				e.preventDefault();
				
				
				//비번 미입력	
				if($("#userPass").val()=="") {
					alert("비밀번호를 입력해주세요.");
					$("#userPass").focus();
					return false;
				}
				
				$.ajax({
					url : "/member/passChk",
					type : "POST",
					dataType : "json",
					data : $("#delForm").serializeArray(),
					success: function(data){
						
						if(data==0) {
							alert("패스워드가 틀렸습니다.");
							return;
						}else {
							if(confirm("회원탈퇴하시겠습니까?")) {								
								alert("그동안 '버스로'를 이용해주셔서 감사합니다.");
								console.log("탈퇴 참");
								$("#delForm").submit();
							}else {
								alert("회원탈퇴가 취소되었습니다.");
								console.log("탈퇴 거짓");
								return;
							}
							
						}
					}
				}); //$.ajax({				
				 
			}); //$("#submit").on("click", function(){
				
		}); //$(document).ready(function(){
	</script>
<body>
	<div class="wrapper">
		<div class="wrap">			
			<div id="content">
				<section id="main-section">
					<form action="/member/memberDelete" method="post" id="delForm">
						<span style="font-size: 40px;">회원탈퇴 페이지</span>
						<div style="height: 20px;"></div>

						<div style="position: relative; margin-bottom: 30px;">
							<label style="margin-left: 10px; position: absolute; font-size: 20px; font-weight: bold;">아이디</label>
							<input type="text" id="userId" name="id"
								style="position: absolute; margin-left: 260px;"
								value="${member.id}" readonly="readonly"><br>
						</div>

						<div style="position: relative; margin-bottom: 30px;">
							<label style="margin-left: 10px; position: absolute; font-size: 20px; font-weight: bold;">비밀번호</label>
							<input style="position: absolute; margin-left: 260px;"
								type="password" id="userPass" name="pass" placeholder="비밀번호 입력" maxlength="12"><br>
						</div>

						<div style="position: relative; margin-bottom: 30px;">
							<label style="margin-left: 10px; position: absolute; font-size: 20px; font-weight: bold;">이름</label>
							<input style="position: absolute; margin-left: 260px;"
								type="text" id="userName" name="userName" value="${member.name}"
								readonly="readonly"><br>
						</div>

						<p
							style="font-size: 20px !important; font-weight:bold; white-space: nowrap; color: #dc143c">
							★★반드시 읽어주세요!!★★<br>
							<br> 
							※ 탈퇴 시 사이트 이용정보는 삭제, 복구가 불가능하오니 신중히 선택하시기 바랍니다.<br>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(이용정보 = 작성하신 1:1문의 글, 버스예매내역 등)<br>
							<br>
							※ 탈퇴 시 등록하신 모든 개인정보는 삭제, 폐기 처리되며 복구가 불가합니다.
						</p>

						<div style="height: 20px;"></div>
						<div style="position: relative; margin-bottom: 30px;">
							<button type="submit" id="submit1">회원탈퇴</button>
							<button type="button" id="cancel">취소</button>
						</div>						
					</form>
				</section>

				<aside id="main-aside">
					<div class="aside-list">
						<ul>
							<li><a href="/member/myPage.do">개인정보</a></li>
							<li><a href="/ticket/bookinglist">예매내역</a></li>
							<li><a href="/busro/myPageInquiryList">1:1 문의 내역</a></li>
							<li><a href="/member/memberDeleteView" method="post">회원탈퇴</a></li>
						</ul>
					</div>
				</aside>

			</div>
		</div>
	</div>
<%@include file="../includes/footer.jsp" %>
</body>

</html>