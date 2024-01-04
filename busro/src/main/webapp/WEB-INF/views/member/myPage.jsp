<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<%@include file="../includes/userHeader.jsp" %>
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

<body>

<script
  src="https://code.jquery.com/jquery-3.4.1.js"
  integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
  crossorigin="anonymous"></script>
  
		
<div class="wrapper">
	<div class="wrap">	
		<div id="content">
			<section id="main-section">
			<div>	
				<form name="infoModify" action="/member/update.do" method="post">				
					<span style="font-size: 30px; margin-left: 30%; font-weight: bold;">회원 정보 수정</span>
					<div style="height: 60px;"></div>
					
					<div style="position: relative; margin-bottom: 30px;">
						<label style="position: absolute; font-size: 20px; font-weight: bold;">아이디(고정)</label>						
							<input style="position: absolute; margin-left: 260px;" value="${vo.id}" name="id" id="id" readonly="readonly"><br>							
					</div>				
					
					<div style="position: relative; margin-bottom: 30px;">
						<label style="position: absolute; font-size: 20px; font-weight: bold;">비밀번호</label>
						<input type="password" title="영문+숫자 조합 8~12자리 입력" style="position: absolute; margin-left: 260px;" name="pass" id="pass" value="${vo.pass}" placeholder="비밀번호를 입력하세요" maxlength="12"><br>
					</div>					
					
					<div style="position: relative; margin-bottom: 30px;">
						<label style="position: absolute; font-size: 20px; font-weight: bold;">이름</label>
						<input style="position: absolute; margin-left: 260px;" value="${vo.name}" name="name" id="name" placeholder="이름을 입력하세요" maxlength="5"><br>
						
						<script type="text/javascript">
						$(function(){
						       $("#name").blur(function (event) {
						            regexp = /[a-z0-9]|[ \[\]{}()<>?|`~!@#$%^&*-_+=,.;:\"'\\]|[ㄱ-ㅎㅏ-ㅣ]/g;
						            v = $(this).val();
						            if (regexp.test(v)) {
						                alert("이름은 한글만 입력가능 합니다. \n※ 자음, 모음만 입력도 불가합니다.");
						                $(this).val(v.replace(regexp, ''));
						            }
						        });
						});
						</script>
					</div>
					
					<div style="position: relative; margin-bottom: 30px;">
						<label style="position: absolute; font-size: 20px; font-weight: bold;">성별(고정)</label>
						<input style="position: absolute; margin-left: 260px;" value="${vo.gender}" name="gender" id="gender" readonly="readonly"> <br>
					</div>
					
					<div style="position: relative; margin-bottom: 30px;">
						<div class="tel_name" style="font-size: 20px !important; font-weight: bold;">핸드폰 번호</div>
							<input class="tel1_input" type="text" name="tel1" id="tel1" value="${vo.tel1}" readonly="readonly">
							 
							- <input class="tel_input" type="number" name="tel2" id="tel2" value="${vo.tel2}" 
									oninput="numberMaxLength(this);" min="0" max="9999" maxlength="4" placeholder="중간번호 4자리">
									 
							- <input class="tel_input" type="number" name="tel3" id="tel3" value="${vo.tel3}" 
									oninput="numberMaxLength(this);" min="0" max="9999" maxlength="4" placeholder="중간번호 4자리">						
						<br>												
							<script>
							var number2 = document.getElementById('tel2');
							var number3 = document.getElementById('tel3');
							
							// -와 +가 입력되지 않게 하기
							number2.onkeydown = function(e) {
							    if(!((e.keyCode > 95 && e.keyCode < 106) || (e.keyCode > 47 && e.keyCode < 58) || e.keyCode == 8)) {
							        return false;
							    }
							}
							
							number3.onkeydown = function(e) {
							    if(!((e.keyCode > 95 && e.keyCode < 106) || (e.keyCode > 47 && e.keyCode < 58) || e.keyCode == 8)) {
							        return false;
							    }
							}
							//. -와 +가 입력되지 않게 하기
							
							function numberMaxLength(e) {								
								if(e.value.length > e.maxLength) {
									e.value = e.value.slice(0, e.maxLength);
								}
							}
							</script>
					</div>
					
					<div style="position: relative; margin-bottom: 30px;">
						<div class="birth_name" id="info__birth" style="font-size: 20px !important; font-weight: bold;">생년월일</div>
						<input class="tel_input" id="year" name="year" value="${vo.year}" type="number" min="1940" max="2024" maxlength="4" oninput="numberMaxLength(this);">
						<span style="font-size: 20px !important;">년</span>			
						<input class="tel_input" id="month" name="month" value="${vo.month}" type="number" min="1" max="12" maxlength="2" oninput="numberMaxLength(this);">
						<span style="font-size: 20px !important;">월</span>									
						<input class="tel_input" id="day" name="day" value="${vo.day}" type="number" min="1" max="31" maxlength="2" oninput="numberMaxLength(this);">
						<span style="font-size: 20px !important;">일</span>
						<br>
						
						<script>
						var number1 = document.getElementById('year');
						var number2 = document.getElementById('month');
						var number3 = document.getElementById('day');
						
						// -와 +가 입력되지 않게 하기
						number1.onkeydown = function(e) {
						    if(!((e.keyCode > 95 && e.keyCode < 106) || (e.keyCode > 47 && e.keyCode < 58) || e.keyCode == 8)) {
						        return false;
						    }
						}
						
						number2.onkeydown = function(e) {
						    if(!((e.keyCode > 95 && e.keyCode < 106) || (e.keyCode > 47 && e.keyCode < 58) || e.keyCode == 8)) {
						        return false;
						    }
						}
						
						number3.onkeydown = function(e) {
						    if(!((e.keyCode > 95 && e.keyCode < 106) || (e.keyCode > 47 && e.keyCode < 58) || e.keyCode == 8)) {
						        return false;
						    }
						}
						//. -와 +가 입력되지 않게 하기
						
							function numberMaxLength(e) {
								if(e.value.length > e.maxLength) {
									e.value = e.value.slice(0, e.maxLength);
								}					
							}						
							</script>
					</div>					
					
					
						<!-- <label>회원등급</label> -->
						<input type="hidden" value="${vo.auth}" name="auth" id="auth" readonly="readonly">
						 <!-- 일반회원용 마이페이지는 관리자를 선택하면 안되니까 막아두기 -->
						 
					<div style="margin-bottom: 30px; margin-left: 30%; margin-top: 10px;">
						<button class="backBtn" type="button" onclick="history.go(-1);">이전</button>
						<button class="jujangBtn" type="submit" id="modifyMyPageBtn">저장</button>
						
					</div>
			
				</form>
			</div>
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
  <script>
	$("#modifyMyPageBtn").on("click",function(e) {		
		console.log("modifyMyPageBtn 클릭했음");
		e.preventDefault();
		var formObj = $("form[name='infoModify']");
		var pw = $("#pass").val();
		var name = $("#name").val();
		var num = pw.search(/[0-9]/g);
		var eng = pw.search(/[a-z]/ig);
		var spe = pw.search(/[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi);
		
		if($('#pass').val() == "") {
			alert("비밀번호를 입력하세요.");			
			return false;
		}
		
		if($('#pass').val() == $('#id').val()) {
			alert("아이디와 비밀번호는 같을 수 없습니다.");			
			return;			
		}
		
		if($('#pass').val().length <= 7 || $('#pass').val().length > 12) {
			alert("비밀번호는 영문,숫자 조합 8~12자리를 입력해주세요.");			
			return false;
		}
		
		if(num < 0 || eng < 0 || spe > 0 ){
			console.log("num..." + num);
			console.log("eng..." + eng);
			console.log("spe..." + spe);
			alert("영문, 숫자를 혼합하여 입력해주세요.");
			return false;			
		} 
		
		if($('#name').val() == "") {
			alert("이름을 입력하세요.");
			return false;			
		}
		
		if(name.length <= 1 || name.length >= 6) {        	
            alert("이름은 2~5글자를 입력해주세요.");
            return false;        	
        }
		
		if($('#tel2').val() == "" || $('#tel3').val() == "") {
			alert("전화번호를 입력하세요.");			
			return false;
		}
		
		if($('#tel2').val().length <= 3 || $('#tel3').val().length <= 3) {
			alert("전화번호는 각 4자리 숫자를 입력해야 합니다.");
			return false;
		}
		
		if($('#year').val() == "" || $('#month').val() == "" || $('#day').val() == "") {
			alert("생년월일을 입력하세요.");			
			return false;
		}
		
		if($('#year').val() <= 1939 || $('#year').val() >= 2024 ||
			$('#month').val() <=0 || $('#month').val() >=13 ||
			$('#day').val() <=0 || $('#day').val() >=32) {
			
			alert("지정된 생년월일 입력 범위를 벗어날 수 없습니다. \n출생연도: 1940~2023, 월: 1~12, 일: 1~31");
			return false;
		}
		
		alert("회원정보 수정 성공!!");		
		formObj.submit();
	});
</script>
		</div>
	</div>
</div> 

<%@include file="../includes/footer.jsp" %>
</body>
</html>