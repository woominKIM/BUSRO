<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>	
<%@include file="../includes/userHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>약관동의</title>

<script src="https://code.jquery.com/jquery-3.4.1.js"
	integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
	crossorigin="anonymous"></script>
<link rel="stylesheet" href="/resources/css/common.css">
<style type="text/css">

#contents.cols-d {	
	min-width: 500px;
}

.f {
	position: relative;
	margin: 0;
	padding: 0;
	color: #666;
}

.f p {
	width: 100%;
	margin: 0 0 13px;
	font-size: 16px;
	font-weight: bold;
	text-align: center;
	margin-top: 20px;
}

.f p:after {
	content: "";
	display: block;
	overflow: hidden;
	clear: both;
	height: 0;
}

.f textarea {
	position: relative;
	width: 80%;
	min-width: 80%;
	height: 250px;
	min-height: 250px;
	padding: 3px 3px 3px 6px;
	border: 1px solid #ececec;
	border-top-color: #e1e1e1;
	border-left-color: #e1e1e1;
	background: #ececec;		
	-webkit-border-radius: 4px;
	resize: none;
}

.scheme-g {
	margin: 26px 0 8px;
	padding: 0px;
	font-size: 20px;
	font-weight: bold;
}

.button_big {
	float: right;
	margin-right: 200px;
    background-color: #050540;
    color: white;
    border-radius: 8px;
    border-width: 0;
    padding: 6px 20px 9px 20px;    
    cursor: pointer; 
}


#check_1, #check_2, #check_3{
	zoom: 1;
	width: 4%;
}
</style>

<script type="text/javascript">
        $(document).ready(function(){
    
            $("#nextBtn").click(function(){            	
                if($("#check_1").is(":checked") == false ||
                		$("#check_2").is(":checked") == false ||
                		$("#check_3").is(":checked") == false) {
                	
                    alert("모든 약관에 동의 하셔야 다음 단계로 진행 가능합니다.");
                    
                    return false;
                    
                }else {
                	
                	$("#terms_form").submit();
                	
				}
            });    
        });
</script>

</head>
<body>	
	<div id="content" class="cols-d">
	
		<span style="font-size: 40px; font-weight: 800;">이용약관 페이지</span>
		
		<div style="height: 20px;"></div>		
		
		<form id="terms_form" class="f" action="/member/join" method="get">
		
			<div style="margin-bottom: 20px;">
				<span class="scheme-g">● 이용약관1</span><br>
			</div>
			
			<div>
				<textarea style="font-size: 1em;">내용입니다.</textarea>
			</div>
			
			<div style="margin-right: 200px;">
				<p>
					<input type="checkbox" id="check_1" name="check_1" /> 위의 약관에 동의 합니다.<br />
				</p>
			</div>
		
			<div style="margin-bottom: 20px;">		
				<span class="scheme-g">● 이용약관2</span><br>
			</div>
			
			<div>
				<textarea style="font-size: 1em;">내용입니다.</textarea>
			</div>
			
			<div style="margin-right: 200px;">
				<p>
					<input type="checkbox" id="check_2" name="check_2" /> 위의 약관에 동의 합니다.<br />
				</p>
			</div>
				
			<div style="margin-bottom: 20px;">	
				<span class="scheme-g">● 이용약관3</span><br>
			</div>
			
			<div>
				<textarea style="font-size: 1em;">내용입니다.</textarea>
			</div>
			
			<div style="margin-right: 200px;">
				<p>
					<input type="checkbox" id="check_3" name="check_3" /> 위의 약관에 동의 합니다.<br />
				</p>
			</div>
			
			<div>
				<input type="button" id="nextBtn" class="button_big" value="다음단계로" name="agree" />
			</div>			
								
		</form>
	</div>
	
<%@include file="../includes/footer.jsp" %>			
</body>
</html>