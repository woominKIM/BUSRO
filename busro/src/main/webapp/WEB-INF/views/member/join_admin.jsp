<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="../includes/adminHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>계정추가(관리자용)</title>
<link rel="stylesheet" href="/resources/css/admin/adminMain.css">
<script src="https://code.jquery.com/jquery-3.4.1.js"
	integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
	crossorigin="anonymous"></script>
</head>
<body>
<div id="contentWrap">
	<div class="wrapper">
	<div class="adTitle"><span>계정 추가</span> </div>
		<form action="/member/join" method="post" id="join_form">
				<div id="content">			
				
					<div class="id_wrap">
						<div class="id_name"><span class="star">*</span>아이디</div>
						<div class="id_input_box">
							<input type="text" class="id_input" name="id" id="id" placeholder="아이디를 입력해주세요" maxlength="12">
						</div>
						<span class="id_input_re_1">사용 가능한 아이디입니다.</span>
						<span class="id_input_re_2">아이디가 이미 존재합니다.</span>
						<span class="final_id_ck">아이디를 입력해주세요.</span>
						
						
					</div>
	
					<div class="pw_wrap">
						<div class="pw_name"><span class="star">*</span>비밀번호</div>
						<div class="pw_input_box">
							<input class="pw_input" name="pass" id="password" placeholder="비밀번호를 입력해주세요" maxlength="12">						
						</div>
						<span class="final_pw_ck">비밀번호를 입력해주세요.</span>
						<span class="final_pw_ak">비밀번호는 영문+숫자조합으로 8~12자리까지 입력해주세요 ※특수문자 사용불가</span>
					</div>				
	
					<div class="user_wrap">
						<div class="user_name"><span class="star">*</span>이름</div>
						<div class="user_input_box">
							<input class="user_input" name="name" placeholder="이름을 입력해주세요" maxlength="9">
						</div>
						<span class="final_name_ck">이름을 입력해주세요.</span>
					</div>
	
					<div class="birth_wrap">
						<div class="birth_name" id="info__birth"><span class="star">*</span>생년월일</div>
							<select class="form-select-sm" id="birth-year" name="year">
								<option selected>2023</option> 
							</select> 
							<label>년</label>
							<select class="form-select-sm" id="birth-month" name="month">
								<option selected>1</option>
							</select>
							<label>월</label>
							<select class="form-select-sm" id="birth-day" name="day">
								<option selected>1</option>
							</select>
							<label>일</label>									
					</div>
	
					<div class="tel_wrap">
						<div class="tel_name"><span class="star">*</span>핸드폰 번호</div>
							<input class="tel1_input" type="text" name="tel1" id="tel1" value="010" readonly="readonly">
							 
							- <input class="tel_input" type="text" name="tel2" id="tel2" maxlength="4" pattern="[0-9]{3,4}" placeholder="중간번호 4자리"> 
							- <input class="tel_input" type="text" name="tel3" id="tel3" maxlength="4" pattern="[0-9]{3,4}" placeholder="끝번호 4자리">
							<span class="final_tel_ck">핸드폰번호를 입력해주세요.</span>
							
							<!-- - <input class="tel_input" type="number" name="tel2" id="tel2" 
							maxlength="4" oninput="numberMaxLength(this);" placeholder="중간번호 4자리"> 
							- <input class="tel_input" type="number" name="tel3" id="tel3" 
							maxlength="4" oninput="numberMaxLength(this);" placeholder="끝번호 4자리">
							<span class="final_tel_ck">핸드폰번호를 입력해주세요.</span> -->
							
							<div class="clearfix"></div>																
							<!-- <script>
							function numberMaxLength(e) {
								if(e.value.length > e.maxLength) { //입력받은 값의 길이가 설정한 최대길이보다 길 경우
									e.value = e.value.slice(0, e.maxLength); //지정해놓은 최대길이로 줄임
								}
							}
							</script> -->
					</div>
	
					<div class="gender_wrap">
						<div class="gender_name"><span class="star">*</span>성별</div>
						<span id="gender_m">남자</span>
							<input class="checkboxx" type="radio" name="gender" value="M">
						<span id="gender_w">여자</span>
							<input class="checkboxx" type="radio" name="gender" value="F">
						<div class="clearfix"></div>
					</div>
	
					<div class="auth_wrap">				
						<div class="auth_name"><span class="star">*</span>권한</div>
					
							<span id="auth_a">ADMIN</span>
							<input class="checkboxx" type="radio" name="auth" value="ADMIN">
							
							<span id="auth_u">USER</span>
							<input class="checkboxx" type="radio" name="auth" value="USER" checked="checked">
							
						<div class="clearfix"></div>				
					</div>
	
					<div class="noBtn">
						<input type="submit" class="join_button btnBtn" value="계정추가">
					</div>
			</div>
		</form>
	</div>
</div>	
<%@include file="../includes/footer.jsp" %>
</body>

<script type="text/javascript">	

	//'출생 연도' 셀렉트 박스 option 목록 동적 생성
	const birthYear = document.querySelector('#birth-year')
	const birthMonth = document.querySelector('#birth-month')
	const birthDay = document.querySelector('#birth-day')
	
	// option 목록 생성 여부 확인	
	isYearOptionExisted = false;
	isMonthOptionExisted = false;
	isDayOptionExisted = false;
	
	birthYear.addEventListener('focus', function() {
		// year 목록 생성되지 않았을 때 (최초 클릭 시)
		if (!isYearOptionExisted) {
			isYearOptionExisted = true
			for (var i = 2022; i >= 1940; i--) {
				// option element 생성
				const YearOption = document.createElement('option')
				YearOption.setAttribute('value', i)
				YearOption.innerText = i
				// birthYearEl의 자식 요소로 추가
				this.appendChild(YearOption);
			}
		}
	});
	
	birthMonth.addEventListener('focus', function() {
		// year 목록 생성되지 않았을 때 (최초 클릭 시)
		if (!isMonthOptionExisted) {
			isMonthOptionExisted = true
			for (var i = 2; i <= 12; i++) {
				// option element 생성
				const MonthOption = document.createElement('option')
				MonthOption.setAttribute('value', i)
				MonthOption.innerText = i
				// birthYearEl의 자식 요소로 추가
				this.appendChild(MonthOption);
			}
		}
	});
	
	birthDay.addEventListener('focus', function() {
		// year 목록 생성되지 않았을 때 (최초 클릭 시)
		if (!isDayOptionExisted) {
			isDayOptionExisted = true
			for (var i = 2; i <= 31; i++) {
				// option element 생성
				const DayOption = document.createElement('option')
				DayOption.setAttribute('value', i)
				DayOption.innerText = i
				// birthYearEl의 자식 요소로 추가
				this.appendChild(DayOption);
			}
		}
	});	
</script>

<script>

/* 유효성 검사 통과유무 변수 */
var idCheck = false;            // 아이디
var idckCheck = false;            // 아이디 중복 검사
var pwCheck = false;            // 비번
var nameCheck = false;            // 이름
var telCheck = false;            // 전화번호
var birthCheck = false;

$(document).ready(function() {
	
	//회원가입 버튼(회원가입 기능 작동)
	$(".join_button").click(function(e) {
		
		e.preventDefault();
		
		 /* 입력값 변수 */
        var id = $('.id_input').val();                 // id 입력란
        var pw = $('.pw_input').val();                // 비밀번호 입력란        
        var name = $('.user_input').val();            // 이름 입력란
        var tel = $('.tel_input').val();			 //전화번호 입력란
        var birth = $('.form-select-sm').val();               
        
        /* 아이디 유효성검사 */
        if(id == ""){
            $('.final_id_ck').css('display','block');
            idCheck = false;
       
        }else{
            $('.final_id_ck').css('display', 'none');            
            idCheck = true;
        }        
      
      //여기 확인해야함//여기 확인해야함//여기 확인해야함//여기 확인해야함//여기 확인해야함//여기 확인해야함//여기 확인해야함
      //여기 확인해야함//여기 확인해야함//여기 확인해야함//여기 확인해야함//여기 확인해야함//여기 확인해야함//여기 확인해야함
        /* 비밀번호 유효성 검사 */
        if(pw == "") {
            $('.final_pw_ck').css('display','block');
            pwCheck = false;       	
        }else{
            $('.final_pw_ck').css('display', 'none');
            pwCheck = true;
        } //여기 확인해야함//여기 확인해야함//여기 확인해야함//여기 확인해야함//여기 확인해야함//여기 확인해야함//여기 확인해야함
      //여기 확인해야함//여기 확인해야함//여기 확인해야함//여기 확인해야함//여기 확인해야함//여기 확인해야함//여기 확인해야함//여기 확인해야함
        
       	var patt2 = new RegExp("[0-9]{3,4}");
		var res2 = patt2.test($("#tel2").val());
		
		var patt3 = new RegExp("[0-9]{4}");
		var res3 = patt3.test($("#tel3").val());
		
		if (!patt2.test($("#tel2").val())) {
			alert("중간번호를 정확히 입력하여 주십시오.(3~4자리 입력)");
			return false;
		}
		
		if (!patt3.test($("#tel3").val())) {
			alert("끝번호를 정확히 입력하여 주십시오.(4자리 입력)");
			return false;
		}
       
        
        /* 이름 유효성 검사 */
        if(name == ""){
            $('.final_name_ck').css('display','block');
            nameCheck = false;
        }else{
            $('.final_name_ck').css('display', 'none');
            nameCheck = true;
        }
        
        /* 생년월일 유효성 검사 */
        if(birth == ""){
            $('.final_birth_ck').css('display','block');
            birthCheck = false;
        }else{
            $('.final_birth_ck').css('display', 'none');
            birthCheck = true;
        }
        
        /* 핸드폰번호 유효성 검사 */
        if(tel == ""){
            $('.final_tel_ck').css('display','block');
            telCheck = false;
        }else{
            $('.final_tel_ck').css('display', 'none');
            telCheck = true;
        }
        
        /* 최종 유효성 검사 */
        if(idCheck && idckCheck && pwCheck && nameCheck && telCheck && birthCheck){
        	$("#join_form").attr("action", "/member/join_admin");
        	console.log("전송.................");
            $("#join_form").submit();
            alert("계정추가 완료");
            
        }else {
        	alert("계정추가 실패 내용확인필요");			
		}
       
        
        return false;  
        
        
        
		/* $("#join_form").attr("action", "/member/join");
		$("#join_form").submit(); */
		
		
	}); //click
	
}); //ready
	
	//아이디 중복 체크
	$(".id_input").on("propertychange change keyup paste input", function() {
		var memberId = $('.id_input').val();	//.id_input에 입력되는 값
		var data = {memberId : memberId}		//'컨트롤에 넘길 데이터 이름': '데이터(.id.input에 입력되는 값)'		
				
		$.ajax({
				type: "post",
				url: "/member/memberIdChk",
				data: data,
				success: function(result) {
					
					if(result != 'fail') {
			       		$('.id_input_re_1').css("display", "block");
						$('.id_input_re_2').css("display", "none");
						idckCheck = true;   						       					
						
					}else {						
						$('.id_input_re_2').css("display", "block");
						$('.id_input_re_1').css("display", "none");
						idckCheck = false;
						
					}//if-else
					
				}//success
		}); //ajax
		
	}); //function

</script>

</html>