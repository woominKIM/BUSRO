<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@include file="../includes/userHeader.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="/resources/css/common.css">
<title>아이디/비번 찾기</title>

<style type="text/css">
.section1 {
	float: left;
	width: 50%;
	height: auto;
	text-align: center;
}

.section2 {
	float: right;
	width: 50%;
	height: auto;
	text-align: center;
}

p {
	font-size: 20px;
	font-weight: bold;	
}

input {
	height: 30px;	
	border: none;
	border-bottom: 1px solid;
	border-radius: 0;
	outline: none;	
	width: 50%;	
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
<body>

<div class="wrapper">
	<div class="wrap">
	
		<div id="content">
			<div class="section1">
				<form action="../member/find_id.do" method="post">
			
					<span style="font-size: 40px !important;">아이디 찾기</span>
						
					<p>
						<label style="padding-right: 42%;">이름</label><br>
						<input type="text" id="name" name="name" maxlength="5" placeholder="이름을 입력해주세요" required>
						
						<script type="text/javascript">
						$(function(){
						       $("#name").blur(function (event) {
						            regexp = /[a-z0-9]|[ \[\]{}()<>?|`~!@#$%^&*-_+=,.;:\"'\\]|[ㄱ-ㅎㅏ-ㅣ]/g;
						            v = $(this).val();
						            if (regexp.test(v)) {
						                alert("이름은 한글만 입력가능 합니다. \n※ 자음, 모음만 입력도 불가합니다.");
						                $(this).val(v.replace(regexp, ''));
						                return;
						            }
						        });
						});
						</script>
					</p>
						
					<p>
						<label style="padding-right: 36%;">생년월일</label><br>
						<input type="text" id="birth" name="birth" onKeyup="inputYMDNumber(this);" placeholder="YYYY-MM-DD" maxlength="10" required>						
					</p>
			
					<p>
						<label style="padding-right: 32%;">휴대폰 번호</label><br>
						<input type="text" id="tel" name="tel" placeholder="휴대폰 번호를 입력해주세요" maxlength="13" required>						
					</p>
					<div style="margin-top: 3%;">
						<button type="submit" id="findIdBtn">아이디 찾기</button>				
					</div>
			
				</form>
			</div>
			
			<div class="section2">
				<form method="post" autocomplete="off" action="../member/modifyPass.do">
				
					<span style="font-size: 40px !important;">비밀번호 찾기</span>
			 	
				 	<p>
				 		<label style="padding-right: 39%;">아이디</label><br>
				 		<input type="text" id="id" name="id" maxlength="12" placeholder="아이디를 입력하세요" required/>
				 	</p>
				 	
				 	<p>
				 		<label style="padding-right: 32%;">휴대폰 번호</label><br>
				 		<input type="text" id="tel" name="tel" placeholder="휴대폰 번호를 입력해주세요" maxlength="13" required/>
				 		<script type="text/javascript">
						$(document).on("keyup", "#tel", function() { 
							$(this).val( $(this).val().replace(/[^0-9]/g, "").replace(/(^02|^0505|^1[0-9]{3}|^0[0-9]{2})([0-9]+)?([0-9]{4})$/,"$1-$2-$3").replace("--", "-") );
						});						
						</script>
				 	</p> 	
				 	
				 	<div style="padding-top: 16.8%">
				 		<button type="submit" id="findPwBtn">비밀번호 찾기</button>
				 	</div>
			 	
				</form>
			</div>
		</div>
	</div>	
</div>
	<script type="text/javascript">
		function inputYMDNumber(obj) { //날짜 입력시 '-' 자동입력

			// @see DELETE 키버튼이 눌리지 않은 경우에만 실행

			if (event.keyCode != 8) {

				// @see 숫자와 하이픈(-)기호의 값만 존재하는 경우 실행

				if (obj.value.replace(/[0-9 \-]/g, "").length == 0) {

					// @see 하이픈(-)기호를 제거한다.

					var number = obj.value.replace(/[^0-9]/g, "");

					var ymd = "";

					// @see 문자열의 길이에 따라 Year, Month, Day 앞에 하이픈(-)기호를 삽입한다.

					if (number.length < 4) {

						return number;

					} else if (number.length < 6) {

						ymd += number.substr(0, 4);

						ymd += "-";

						ymd += number.substr(4);

					} else {

						ymd += number.substr(0, 4);

						ymd += "-";

						ymd += number.substr(4, 2);

						ymd += "-";

						ymd += number.substr(6);

					}

					obj.value = ymd;

				} else {

					alert("숫자 이외의 값은 입력하실 수 없습니다.");

					//@see 숫자와 하이픈(-)기호 이외의 모든 값은 삭제한다.

					obj.value = obj.value.replace(/[^0-9 ^\-]/g, "");

					return false;
				}

			} else {

				return false;
			}
		}
		
		$(document).on("keyup", "#tel", function() { //휴대폰 번호 입력시 '-' 자동생성
			$(this).val( $(this).val().replace(/[^0-9]/g, "").replace(/(^02|^0505|^1[0-9]{3}|^0[0-9]{2})([0-9]+)?([0-9]{4})$/,"$1-$2-$3").replace("--", "-") );
		});	
	</script>
	<%@include file="../includes/footer.jsp" %>
</body>
</html>