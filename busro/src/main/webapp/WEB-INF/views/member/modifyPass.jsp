<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@include file="../includes/userHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script
  src="https://code.jquery.com/jquery-3.4.1.js"
  integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
  crossorigin="anonymous"></script>

<title>비밀번호 변경</title>
<link rel="stylesheet" href="../resources/css/member/join.css">
<link rel="stylesheet" href="/resources/css/common.css">

<style type="text/css">

input {
	height: 50px;
	background-color: transparent;
	border: none;
	border-bottom: 1px solid;
	border-radius: 0;
	outline: none;	
	width: 50%;
	font-size: 2rem;
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

#actionForm {
	text-align: center;
}

</style>
</head>
<body>

<script>
var pwCheck = false;            // 비번
var pwckCheck = false;            // 비번 확인
var pwckcorCheck = false;        // 비번 확인 일치 확인

$(document).ready(function() {
	
    var pw = $('.pw_input').val();                // 비밀번호 입력란
    var pwck = $('.pwck_input').val();            // 비밀번호 확인 입력란
	var pwNum = pw.search(/[0-9]/g);							//비밀번호 숫자 포함 여부
	var pwEng = pw.search(/[a-z]/ig);							//비밀번호 영문 포함 여부
	var pwSpe = pw.search(/[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi);		//비밀번호 특수문자 포함
	
		$("#modifyPwBtn").click(function(e) {
			
			e.preventDefault();
			
		    console.log("modifyPwBtn 눌렀음");
		    
		    
		    /* 비밀번호 유효성 검사 */		    
		    pw = $('.pw_input').val();
				
	        if(pw == "") {
				alert("비밀번호를 입력하세요");				
				$('.final_pw_ck').css('display','block');				
				pwCheck = false;
				console.log("비밀번호 공백 유효성 검사 실패");
			}else {
				
				$('.final_pw_ck').css('display','none');
				console.log("비밀번호 공백 유효성 검사 성공");
	            pwCheck = true;
			} 	
	        
	        pwNum = pw.search(/[0-9]/g);
	    	pwEng = pw.search(/[a-z]/ig);
	    	pwSpe = pw.search(/[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi);
				
			if($('#password').val().length <= 7 || $('#password').val().length > 12) {
				
				alert("비밀번호는 8~12자리를 입력해주세요");
				$('.final_pw_ak').css('display','block');
				$('.final_pw_ck').css('display','none');
				console.log("비밀번호 길이 유효성 검사 실패");
				pwCheck = false;
				return;
				
			}else {				
				$('.final_pw_ak').css('display','none');
				$('.final_pw_ck').css('display','none');
				console.log("비밀번호 길이 유효성 검사 성공");
	            pwCheck = true;
			} 
			
			if($('#password').val() == $('#id').val()) {
				alert("아이디와 비밀번호는 같을 수 없습니다.");
				pwCheck = false;
				return;			
			}
				
			if(pwNum < 0 || pwEng < 0 || pwSpe > 0 ) {
			
				alert("비밀번호는 영문, 숫자를 혼합하여 입력해주세요.");
				$('.final_pw_ak').css('display','block');
				$('.final_pw_ck').css('display','none');
				console.log("비밀번호 입력방식 유효성 검사 실패");
				pwCheck = false;
				return;
				
			}else {
				
				$('.final_pw_ak').css('display','none');
				$('.final_pw_ck').css('display','none');
				console.log("비밀번호 입력방식 유효성 검사 성공");
	            pwCheck = true;
	        }
			
	        /* 비밀번호 확인 유효성 검사 */
	        pwck = $('.pwck_input').val();
	        
	        if(pwck == "") {
	            $('.final_pwck_ck').css('display','block');
	            $('.pwck_input_re_1').css('display','none');
	            $('.pwck_input_re_2').css('display','none');
	            pwckCheck = false;
	            console.log("비밀번호 이중체크 유효성 검사 실패");
	            return;	            	            
	            
	        }else {
	        	$('.final_pwck_ck').css('display','none');
	        	console.log("비밀번호 이중체크 유효성 검사 성공");
	        	pwckCheck = true;	        	
	        	
	        }
	        
	        if(pw != pwck) {
	            $('.final_pwck_ck').css('display','none');
	            $('.pwck_input_re_1').css('display','none');
	            $('.pwck_input_re_2').css('display','block');
	            pwckCheck = false;
	            console.log("비밀번호 이중체크 유효성 검사 실패");
	            alert("'새 비밀번호'와 '비밀번호 확인'이 일치하지 않습니다.");
	            return;	            
	            
	        }else {
	        	$('.final_pwck_ck').css('display','none');
	        	$('.pwck_input_re_1').css('display','block');
	        	$('.pwck_input_re_2').css('display','none');
	        	console.log("비밀번호 이중체크 유효성 검사 성공");
	        	pwckCheck = true;	        	
	        	
	        }
	        
	        /* 최종 유효성 검사 */
	        if(pwCheck && pwckCheck && pwckcorCheck){
	        	console.log("최종 유효성 검사 성공" + pwCheck +".." + pwckCheck +".." + pwckcorCheck);
	        	$("#actionForm").attr("action", "/member/modifyPass1.do");        	
	            $("#actionForm").submit();
	            alert("비밀번호 변경 성공");
	            
	        }else {
	        	console.log("최종 유효성 검사 실패" + pwCheck +".." + pwckCheck +".." + pwckcorCheck);
	        	alert("비밀번호 변경 실패");	        	
			}    
		    
			return false;
			
		}); //.click
		
		//비밀번호 확인 일치 유효성 검사
		$('.pwck_input').on("propertychange change keyup paste input", function(){

		    var pw = $('.pw_input').val();
		    var pwck = $('.pwck_input').val();
		    $('.final_pwck_ck').css('display', 'none');
		    
		    if(pw == pwck){
		        $('.pwck_input_re_1').css('display','block');
		        $('.pwck_input_re_2').css('display','none');
		        pwckcorCheck = true;
		    }else{
		        $('.pwck_input_re_1').css('display','none');
		        $('.pwck_input_re_2').css('display','block');
		        pwckcorCheck = false;
		    }     
		    
		    

		}); //.on		
});	
</script>

	<div id="content">
		
		<form id="actionForm" method="post" autocomplete="off" action="/member/modifyPass1.do">
			<!-- <div class="id_name">아이디</div> -->
			<input type="hidden" id="id" name="id" value="${vo.id}" readonly />			
	
			<!-- <div class="tel_name">핸드폰 번호</div> -->
			<input type="hidden" id="tel" name="tel" value="${vo.tel}" readonly />
				
			<span style="font-size: 40px;">비밀번호 재설정</span>
			
			<div style="height: 20px;"></div>
				
				<div style="margin-bottom: 30px;">				
					<label class="pw_name">ID: ${vo.id} 의 새 비밀번호</label><br>
					<div style="height: 60px;">
						<input type="password" style="width: 30%;" class="pw_input" name="pass" id="password" placeholder="비밀번호를 입력해주세요" maxlength="12">
					</div>						
					<span class="final_pw_ck">비밀번호를 입력해주세요.</span>
					<span class="final_pw_ak">영문+숫자조합으로 8~12자리까지 입력해주세요 ※특수문자 사용불가</span>						
				</div>
				
				<div style="margin-bottom: 30px;">	
					<label class="pwck_name">비밀번호 확인</label><br>
					<div style="height: 60px;">
						<input type="password" style="width: 30%;" class="pwck_input" name="pass1" id="passChk" placeholder="비밀번호를 확인해주세요" maxlength="12">
					</div>
					<span class="final_pwck_ck">비밀번호 확인을 입력해주세요.</span>
					<span class="pwck_input_re_1">비밀번호가 일치합니다.</span>
					<span class="pwck_input_re_2">비밀번호가 일치하지 않습니다.</span>
				</div>
						
				<div>
					<button type="button" id="modifyPwBtn">변경</button>			
				</div>	
		</form>
	</div>
<%@include file="../includes/footer.jsp" %>
</body>
</html>