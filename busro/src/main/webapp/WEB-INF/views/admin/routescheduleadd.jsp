<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../includes/adminHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<script type="text/javascript">

	

	$(document).ready(function(){
		
		$(".workday").change(function () {
			if($("#weekend").is(":checked")){
				$("#weekday").removeAttr("required");
			}
		});
		
		
/* 	$("#addBtn").click(function (e) {
			
			e.preventDefault();
			
			const errMsg = {
					departure: {"출발지를 선택해주세요";}, 
					price: {"요금을 입력해주세요."}, 
					
			}
			
			var departure = $('.departure').val();
			
			if(departure == ""){
				alert("출발지를 선택해주세요.");
				return false;
				
			}
		}); */
		
		
		var msg = "<c:out value='${result}'/>";

		console.log(msg);
		
		if(msg == "실패"){
			alert("이미 노선이 존재합니다.");
		}
		
		var arr = ['강릉','경주','고양','광주','군산','김포공항','대전','동대구','동서울','부산','부천','수원','안동','울산','익산','전주','춘천','통영','포항'];
			
		$("#departure").append("<option value=''>--선택--</option>");
		

		
		//$("#departure").empty(); //재선택할 시 arrival의 값들을 제거
		for(var i = 0; i < arr.length; i++){
			
			
				console.log(arr[i]);
				$("#departure").append("<option value=" + arr[i]+ ">" + arr[i] + "</option>");
		
		}
		
		
	}); //document ready 끝
	
	$(document).on("change", "#departure", function () {
		var arr = ['강릉','경주','고양','광주','군산','김포공항','대전','동대구','동서울','부산','부천','수원','안동','울산','익산','전주','춘천','통영','포항'];
			
		console.log("진입");
		
		var a = $("#departure").val();
		
		console.log(a);
		
		$("#arrival").empty(); //재선택할 시 arrival의 값들을 제거
		$("#arrival").append("<option value='' disabled selected>--선택--</option>");
		for(var i = 0; i < arr.length; i++){
			
			if(arr[i] === a){
				continue;
			}else{
				console.log(arr[i]);
				$("#arrival").append("<option value=" + arr[i]+ ">" + arr[i] + "</option>");
				
			}
			
			
		}
		//출발지를 임의의 배열에 담는다
		//선택된 값을 함수로 가지고 온다(돔제어 = js)
		//for문을 돌린다(if , continue로 위로 올린다)
	});
	
	
</script>

<title>노선 등록</title>
</head>
<body>
<div id="contentWrap">
	<div class="wrapping">
		<div class="adTitle"><span>버스 노선 등록</span> </div>
		<form action="/admin/routescheduleadd" name="addRoute" onsubmit="return validate_check(this);" method="post" role="form">
		
		<div class="routeAddForm">
			
			<div class="labels" style="width: 150px; float: left; margin-left: 300px;">
				<div><span class="star">*</span>출발지</div>
				<div><span class="star">*</span>도착지</div>
				<div><span class="star">*</span>기본요금</div>
				<div><span class="star">*</span>운영요일</div>
				<div><span class="star">*</span>출발시간</div>
				<div><span class="star">*</span>소요시간</div>
				<div><span class="star">*</span>총 좌석</div>
				<div><span class="star">*</span>등급</div>
			</div>
				<div class="enterPoint" style="float: left;">
					<div><select class="routeControl" id="departure" name="departure" required>
						</select>
					</div>
					<div style="padding-bottom: 1rem;"><select class="routeControl" id="arrival" name="arrival" required>	
							<option value="" disabled selected>--선택--</option>
						</select>
					</div>
					<div style="padding-bottom: 1rem;"><input class="routeControl" type="number" min="0" name="price" required> <label class="inLabel" style="margin-left: 10px;"> 원 </label></div>
					<div style="padding-bottom: 0.5rem;">
						<div class="routeControl" >
							<input class="workday" id="weekday" type="checkbox" value="평일" name="workday" required="required" style="margin-right: 10px;"><label class="inLabel" for="weekday" style="margin-right: 15px;">평일</label>
							<input class="workday" id="weekend" type="checkbox" value="주말" name="workday" style="margin-right: 10px;"><label class="inLabel" for='weekend' style="margin-right: 15px;">주말</label>
						</div>
					</div>
					<div style="padding-bottom: 1rem;">
						<select class="routeControl" id="hour" name="sth" required>
							<option value="">선택</option>
							<c:forEach var="i" begin="0" end="23">
							<c:choose>
								<c:when test="${i<10}">
								<option value="<fmt:formatNumber value='${i}' pattern ='00' />"<c:if test="${list.lastTimeHour == i}">selected</c:if>> <fmt:formatNumber value='${i}' pattern ='00' /></option>
								</c:when>
								<c:otherwise>
								<option> <fmt:formatNumber value='${i}' pattern ='##' /></option>
								</c:otherwise>
							</c:choose>
							</c:forEach>
							
						</select><label style="margin-left: 10px;">시 </label> 
						<!-- <c:if test="${i<10}">0${i}</c:if> 작동 X -->
						<%-- <option value="<fmt:formatNumber value='${i}' pattern ='00' />" --%>
							<%--<c:if test="${list.lastTimeHour == i}">selected</c:if>> <fmt:formatNumber value='${i}' pattern ='00' /></option> --%>
						
						
						<select class="routeControl" id="minutes" name="stm" style="margin-left: 15px;">
						
						<c:forEach var="j" begin="0" end="55" step="5">
						
							<c:choose>
								<c:when test="${j<10}">
									<option value="<fmt:formatNumber value='${j}' pattern ='00' />"> <fmt:formatNumber value='${j}' pattern ='00' /></option>
								</c:when>
								<c:otherwise>
									<option> <fmt:formatNumber value='${j}' type="number"/></option>
								</c:otherwise>
							</c:choose>
							
						</c:forEach>
							
						</select> <label style="margin-left: 10px;"> 분 </label>
					</div>
					<div style="padding-bottom: 1rem;"> <input class="routeControl" type="number" name="eta" required="required" min="0"><label class="inLabel" style="margin-left: 10px;"> 분 </label></div>
					<div style="padding-bottom: 1.8rem;"> <label> 28석 </label></div>
						<div style="padding-bottom: 1rem;">
							<input type="radio" name="grade" value="우등" id="superior" required="required" style="margin-right: 10px;"> <label for="superior" style="margin-right: 15px;">우등</label> 
							<input type="radio" name="grade" value="일반" id="general" style="margin-right: 10px;"> <label for="general">일반</label>
						</div>
				</div>
			
		</div>
		
				<div class="regiBtn noBtn">
					<button type="submit" class="btnBtn" id="addBtn">등록</button> 
					<button type="button" class="btnBtn" onclick="location.href='/admin/routeschedulelist'">취소</button>
				</div>

	</form>
	</div>
</div>	
	
</body>
</html>