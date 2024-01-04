<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<%@include file="../includes/userHeader.jsp" %>
<link rel="stylesheet" href="/resources/css/member/join.css">
<link rel="stylesheet" href="/resources/css/common.css">
<script src="https://code.jquery.com/jquery-3.4.1.js"
	integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
	crossorigin="anonymous"></script>
<style type="text/css">
input[type="number"], input[type="password"] {
    /* appearance: none; */
    border-left-width: 0;
    border-right-width: 0;
    border-top-width: 0;
    background-color: white;
}

input, .form-select-sm {	
	border-bottom: 1px solid black;
	border-radius: 0;
	outline: none;
	margin: 0 0 15px 0;	
	padding: 0;
	box-shadow: none;
	box-sizing: content-box;
	transition: all 0.3s;		
}

input:focus, select:focus {
	border-bottom: 1px solid #26a69a;
	box-shadow: 0 1px 0 0 #26a69a;	
}
</style>
</head>
<body>

	<div class="wrapper">
		<form action="/member/join" method="post" id="join_form">
			<div class="wrap">
				<div id="content">
				
					<div>				
						<div class="subjecet">
							<span>회원가입</span>
						</div>
					</div>
					
					<div>
						<div class="id_wrap">
							<div class="id_name">아이디</div>
							<div class="id_input_box">
								<input type="text" class="id_input" name="id" id="id" placeholder="아이디를 입력해주세요" maxlength="12">
							</div>									
							<span class="final_id_ak">영문+숫자조합으로 8~12자리까지 입력해주세요.<br> ※특수문자 사용불가</span>
							<span class="id_input_re_1">사용 가능한 아이디입니다.</span>
							<span class="id_input_re_2">아이디가 이미 존재합니다.</span>
							<span class="final_id_ck">아이디를 입력해주세요.</span>
						</div>
					</div>
		
					<div>
						<div class="pw_wrap">
							<div class="pw_name">비밀번호</div>
							<div class="pw_input_box">
								<input type="password" class="pw_input" name="pass" id="password" placeholder="비밀번호를 입력해주세요" maxlength="12">						
							</div>
							<span class="final_pw_ck">비밀번호를 입력해주세요.</span>
							<span class="final_pw_ak">영문+숫자조합으로 8~12자리까지 입력해주세요.<br> ※특수문자 사용불가</span>
							
						</div>
					</div>
					
					<div>
						<div class="pwck_wrap">
							<div class="pwck_name">비밀번호 확인</div>
							<div class="pwck_input_box">
								<input type="password" class="pwck_input" name="pass1" placeholder="비밀번호를 확인해주세요" maxlength="12">
							</div>
							<span class="final_pwck_ck">비밀번호 확인을 입력해주세요.</span>
							<span class="pwck_input_re_1">위에 작성한 비밀번호와 일치합니다.</span>
							<span class="pwck_input_re_2">위에 작성한 비밀번호와 일치하지 않습니다.</span>
						</div>
					</div>
		
					<div>
						<div class="user_wrap">
							<div class="user_name">이름</div>
							<div class="user_input_box">
								<input type="text" class="user_input" name="name" id="name" placeholder="이름을 입력해주세요" maxlength="5">
							</div>
							<span class="final_name_ck">이름을 입력해주세요.</span>
						</div>
												
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
					</div>
		
					<div>
						<div class="birth_wrap">
							<div class="birth_name" id="info__birth" style="font-size: 25px !important; font-weight: bold !important;">생년월일</div>
							<select class="form-select-sm" id="birth-year" name="year">
								<option value="0">출생 연도</option>
								
							</select> 
							<select class="form-select-sm" id="birth-month" name="month">
								<option value="0">월</option>
							</select>
							<select class="form-select-sm" id="birth-day" name="day">
								<option value="0">일</option>
							</select>
							<span class="final_birth_ck">생년월일을 입력해주세요.</span>
							<div class="clearfix"></div>									
						</div>
					</div>
		
					<div>
						<div class="tel_wrap">
							<div class="tel_name">핸드폰 번호</div>
								<input class="tel1_input" type="text" name="tel1" id="tel1" value="010" readonly="readonly">								 
								- <input class="tel_input" type="number" name="tel2" id="tel2" oninput="numberMaxLength(this);"  
									placeholder="중간번호 4자리" maxlength="4">									
								- <input class="tel_input" type="number"  name="tel3" id="tel3" oninput="numberMaxLength(this);" 
									placeholder="끝번호 4자리" maxlength="4">
								<span class="final_tel_ck">핸드폰번호를 입력해주세요.</span>
								
								<!-- 4자리만 입력할 수 있도록 해주는 function -->
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
							<!-- /.4자리만 입력할 수 있도록 해주는 function -->
								<div class="clearfix"></div>
						</div>
					</div>
		
					<div>
						<div class="gender_wrap">
							<div class="gender_name">성별</div>
							
							<span id="gender_mw">남자</span>
							
							<input id="checkboxx" type="radio" name="gender" value="M">&nbsp&nbsp
							 
							<span id="gender_mw">여자</span>
							
							<input id="checkboxx" type="radio" name="gender" value="F">
							
							<span class="final_gender_ck">성별을 선택해주세요.</span>
							<div class="clearfix"></div>
						</div>
					</div>
		
					<div>
						<div class="auth_wrap"> <!-- 관리자 → 회원정보 등록 시 사용 -->				
							<div class="auth_name">권한</div>
						
								<span id="auth_au">ADMIN</span>
								<input id="checkboxx" type="radio" name="auth" value="ADMIN">&nbsp&nbsp
								
								<span id="auth_au">USER</span>
								<input id="checkboxx" type="radio" name="auth" value="USER" checked="checked">
								
							<div class="clearfix"></div>				
						</div>
					</div>
		
					<div>
						<div class="join_button_wrap">
							<input type="submit" class="join_button" value="가입하기">
						</div>						
					</div>
					
				</div>
			</div>
		</form>
		</div>
<%@include file="../includes/footer.jsp" %>
</body>

<script type="text/javascript">

	$(".auth_wrap").hide();

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
			for (var i = 2023; i >= 1940; i--) {
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
			for (var i = 1; i <= 12; i++) {
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
			for (var i = 1; i <= 31; i++) {
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
var pwckCheck = false;            // 비번 확인
var pwckcorCheck = false;        // 비번 확인 일치 확인
var nameCheck = false;            // 이름
var telCheck = false;            // 전화번호
var birthCheck = false;
var genderCheck = false;

$(document).ready(function() {
	
	//회원가입 버튼(회원가입 기능 작동)
	$(".join_button").click(function(e) {
		
		e.preventDefault();
		
		 /* 입력값 변수 */
        var id = $('.id_input').val();                 // id 입력란
        var pw = $('.pw_input').val();                // 비밀번호 입력란
        var pwck = $('.pwck_input').val();            // 비밀번호 확인 입력란
        var name = $('.user_input').val();            // 이름 입력란
        var tel = $('.tel_input').val();		//전화번호 입력란
        var birth = $('.form-select-sm').val();        
        var idNum = id.search(/[0-9]/g);							//아이디 숫자 포함 여부
		var idEng = id.search(/[a-z]/ig);							//아이디 영문 포함 여부
		var idSpe = id.search(/[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi);		//아이디 특수문자 포함
		var pwNum = pw.search(/[0-9]/g);							//비밀번호 숫자 포함 여부
		var pwEng = pw.search(/[a-z]/ig);							//비밀번호 영문 포함 여부
		var pwSpe = pw.search(/[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi);		//비밀번호 특수문자 포함
        
        /* 아이디 유효성검사 */
        
        /* final_id_ck = 아이디를 입력해주세요. */
		/* final_id_ak = 영문과 숫자 조합하여 8~12자만 가능 */
		/* id_input_re_1 = 사용 가능한 아이디입니다. */
		/* id_input_re_2 = 아이디가 이미 존재합니다. */
		
		
		
        if($('#id').val() == ""){
            $('.final_id_ck').css('display','block');
            $('.final_id_ak').css('display','none');
            $('.id_input_re_1').css('display','none');
            $('.id_input_re_2').css('display','none');
            alert("아이디를 입력하세요");
            idCheck = false;
            return;
        }else{
            $('.final_id_ck').css('display', 'none');
            $('.final_id_ak').css('display','none');
            $('.id_input_re_1').css('display','none');
            $('.id_input_re_2').css('display','none');
            idCheck = true;
        }
        
        if($('#id').val().length <= 7 || $('#id').val().length > 12) {
        	$('.final_id_ck').css('display','none');
            $('.final_id_ak').css('display','block');
            $('.id_input_re_1').css('display','none');
            $('.id_input_re_2').css('display','none');
        	alert("아이디는 영문,숫자 조합 8~12자리를 입력해주세요");			
        	idCheck = false;
        	return;
        }else if(idNum < 0 || idEng < 0 || idSpe > 0) {
        	$('.final_id_ck').css('display','none');
            $('.final_id_ak').css('display','block');
            $('.id_input_re_1').css('display','none');
            $('.id_input_re_2').css('display','none');
            alert("아이디는 영문, 숫자를 혼합하여 입력해주세요.");
        	idCheck = false;
        	return;
		} else{
			
			$('.final_id_ck').css('display','none');
            $('.final_id_ak').css('display','none');
            $('.id_input_re_1').css('display','block');
            $('.id_input_re_2').css('display','none');
            idCheck = true;
        }
		
		
		/* 비밀번호 유효성 검사 */
        if($('#password').val() == "") {
			alert("비밀번호를 입력하세요");
			$('.final_pw_ck').css('display','block');
			pwCheck = false;
			return;
		}else{
            $('.final_pw_ck').css('display', 'none');
            pwCheck = true;
        }
		
        if($('#password').val() == $('#id').val()) {
			alert("아이디와 비밀번호는 같을 수 없습니다.");
			pwCheck = false;
			return;			
		}
		
		if($('#password').val().length <= 7 || $('#password').val().length > 12) {
			alert("비밀번호는 영문,숫자 조합 8~12자리를 입력해주세요");
			$('.final_pw_ak').css('display','block');
			$('.final_pw_ck').css('display','none');
			pwCheck = false;
			return;
		}else{
			$('.final_pw_ak').css('display', 'none');
            $('.final_pw_ck').css('display', 'none');            
            pwCheck = true;
        }
		
		if(pwNum < 0 || pwEng < 0 || pwSpe > 0 ){
			
			alert("비밀번호는 영문, 숫자를 혼합하여 입력해주세요.");
			$('.final_pw_ak').css('display','block');
			$('.final_pw_ck').css('display', 'none');
			pwCheck = false;
			return;
		} else{
			$('.final_pw_ak').css('display','none');
			$('.final_pw_ck').css('display', 'none');
            pwCheck = true;
        }
		
        /* 비밀번호 확인 유효성 검사 */
        pw = $('.pw_input').val();
        pwck = $('.pwck_input').val();
        
        if(pwck == ""){
            $('.final_pwck_ck').css('display','block');
            pwckCheck = false;
            alert("비밀번호 확인을 입력해주세요");
            return;
        }else{
            $('.final_pwck_ck').css('display', 'none');
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
        
        /* 이름 유효성 검사 */
        if(name == ""){
            $('.final_name_ck').css('display','block');
            nameCheck = false;
            alert("이름을 입력해주세요");
            return;
        }else{
            $('.final_name_ck').css('display', 'none');
            nameCheck = true;
        }       
        
        if(name.length <= 1) {
        	nameCheck = false;
            alert("이름은 2~5글자를 입력해주세요.");
            return;        	
        }
        
		/* 생년월일 유효성 검사 */        
        if($('#birth-year').val() == "0" || $('#birth-month').val() == "0" || $('#birth-day').val() == "0") {
			alert("생년월일을 입력하세요");
			$('.final_birth_ck').css('display','block');
			birthCheck = false;
			return;
		}else {
			$('.final_birth_ck').css('display','none');
			birthCheck = true;			
		}
        
        /* 핸드폰번호 유효성 검사 */
    	var patt2 = new RegExp("[0-9]{4}");
		var res2 = patt2.test($("#tel2").val());
		
		var patt3 = new RegExp("[0-9]{4}");
		var res3 = patt3.test($("#tel3").val());		
		
        if(tel == ""){
            $('.final_tel_ck').css('display','block');
            telCheck = false;
            alert("전화번호를 입력해주세요");
            return;
        }else{
            $('.final_tel_ck').css('display', 'none');
            telCheck = true;
        }
		
		if (!patt2.test($("#tel2").val())) {
			alert("중간번호를 정확히 입력하여 주십시오.(4자리 입력)");
			$('.final_tel_ck').css('display','block');
			telCheck = false;
			return;
		}else{
            $('.final_tel_ck').css('display', 'none');
            telCheck = true;
        }
		
		if (!patt3.test($("#tel3").val())) {
			alert("끝번호를 정확히 입력하여 주십시오.(4자리 입력)");
			$('.final_tel_ck').css('display','block');
			telCheck = false;
			return;
		}else{
            $('.final_tel_ck').css('display', 'none');
            telCheck = true;
        }
        
        /* 성별 유효성 검사 */
        if($("input[name=gender]:radio:checked").length < 1) {
        	$('.final_gender_ck').css('display','block');
        	alert("성별을 선택하세요");
        	genderCheck = false;
        	return;
        	
        }else {
        	$('.final_gender_ck').css('display','none');
        	genderCheck = true;
        	
        }
        
        /* 최종 유효성 검사 */
        if(idCheck && idckCheck && pwCheck && pwckCheck && pwckcorCheck && nameCheck && telCheck && birthCheck){
        	$("#join_form").attr("action", "/member/join");        	
            $("#join_form").submit(); 
            alert("회원가입 완료");
            
        }else {
        	console.log(idCheck +".." + idckCheck +".." + pwCheck +".." + pwckCheck +".." + pwckcorCheck +".." + nameCheck +".." + telCheck +".." + birthCheck);
        	alert("회원가입 실패 내용확인필요");			
		}
        
        return false;
		
	}); //click
	
}); //ready
	
	//아이디 중복 체크
	$(".id_input").on("propertychange change keyup paste input", function() {
		
		/* final_id_ck = 아이디를 입력해주세요. */
		/* final_id_ak = 영문과 숫자 조합하여 8~12자만 가능 */
		/* id_input_re_1 = 사용 가능한 아이디입니다. */
		/* id_input_re_2 = 아이디가 이미 존재합니다. */
		
		var memberId = $('.id_input').val();	//.id_input에 입력되는 값
		var data = {memberId : memberId}		//'컨트롤에 넘길 데이터 이름': '데이터(.id.input에 입력되는 값)'		
				
		$.ajax({
				type: "post",
				url: "/member/memberIdChk",
				data: data,
				success: function(result) {
					if(result == 'fail') {
						$('.id_input_re_2').css("display", "block");
						$('.id_input_re_1').css("display", "none");
						idckCheck = false;
						
					}else {
						$('.id_input_re_1').css("display", "block");
						$('.id_input_re_2').css("display", "none");
						idckCheck = true;
					}
					
				}//success
		}); //ajax
		
	}); //function	
	
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
    
	});	

</script>

</html>