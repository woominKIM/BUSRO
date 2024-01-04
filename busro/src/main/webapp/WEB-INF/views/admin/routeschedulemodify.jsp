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
		var arr = ['강릉','경주','고양','광주','군산','김포공항','대전','동대구','동서울','부산','부천','수원'
			,'안동','울산','익산','전주','춘천','통영','포항'];
		$("#departure").append("<option>--선택--</option>");
		
		//$("#departure").empty(); //재선택할 시 arrival의 값들을 제거
		for(var i = 0; i < arr.length; i++){
			
			
				console.log(arr[i]);
				$("#departure").append("<option value=" + arr[i]+ ">" + arr[i] + "</option>");
		
		} // 출발지 도착지 선택관련
		
		
		// 삭제
		
		function modalshow() {
			var modal = document.querySelector(".deletemodal");
			
			modal.style.display="block";
			console.log("모달 열음");
		};
		
		//document.getElementByClassName(".modalCloseBtn")
		
		 function modalclose() {
			var modal = document.querySelector(".deletemodal");
			
			modal.style.display="none";
			
			console.log("모달 닫음");
		};
		
		
		var formObj = $("form");
		
		$('button').on("click", function(e) {
			
			e.preventDefault();
			
			var operation = $(this).data("oper");
			
			console.log(operation);
			
			if(operation === 'remove'){
				
				formObj.attr("action", "/admin/delete");
				alert("삭제 완료");
				formObj.submit();
			}
			
			if(operation === 'modalshow'){
				
				modalshow();
				
			}
			
			if(operation === 'list'){
				
				formObj.attr("action", "/admin/routeschedulelist").attr("method","get");
				formObj.submit();
			}
			
			if(operation === 'modify'){
				
				e.preventDefault();
				
				if(!$("input:checked[Name='workday']").is(":checked")){
					alert("운영요일을 선택해주세요.");
					return false;
				}
				
				formObj.submit();
				
			}
			
			if(operation === 'modalclose'){
				
				modalclose();
				
			}
			
			
			
		}); // 삭제 처리
		
	}); //document ready 끝
	
	$(document).on("change", "#departure", function () {
		var arr = ['강릉','경주','고양','광주','군산','김포공항','대전','동대구','동서울','부산','부천','수원'
			,'안동','울산','익산','전주','춘천','통영','포항'];
		console.log("진입");
		
		var a = $("#departure").val();
		
		console.log(a);
		
		$("#arrival").empty(); //재선택할 시 arrival의 값들을 제거
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

<title>노선 수정페이지</title>
</head>
<body>
<div id="contentWrap">
<div class="wrapping">
	<div class="adTitle"><span>버스 노선 수정</span> </div>
	<form action="/admin/routeschedulemodify" method="post" role="form">
	
	<div class="routeAddForm">
		
		<input type="hidden" name="snum" value="${schedule.snum }">
		
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
			<div style="padding-bottom: 1rem;">
				<select class="routeControl" id="departure" name="departure" required>
					<option><c:out value="${schedule.departure }" /></option>
				</select>
			</div>
			<div style="padding-bottom: 1.4rem;">
				<select class="routeControl" id="arrival" name="arrival">	
					<option><c:out value="${schedule.arrival }" /></option>
				</select>
			</div>
			<div style="padding-bottom: 1rem;">
				<input class="routeControl" type="number" min="0" name="price" value="<c:out value="${schedule.price}" />"><label style="margin-left: 10px;">원</label>
			</div>
			<div style="padding-bottom: 0.7rem;">
				<div class="routeControl">
					<c:if test="${schedule.workday eq '평일'}">
						<input class="workday" id="weekday" type="checkbox" value="평일" name="workday" checked="checked" style="margin-right: 10px;" >
					</c:if>	
					<c:if test="${schedule.workday ne '평일'}">
						<input class="workday" id="weekday" type="checkbox" value="평일" name="workday" style="margin-right: 10px;" >
					</c:if>
					<label for="weekday" style="margin-right: 15px;">평일</label>
					
					<c:if test="${schedule.workday eq '주말'}">	
						<input class="workday" id="weekend" type="checkbox" value="주말" name="workday" checked="checked" style="margin-right: 10px;" >
					</c:if>		
					<c:if test="${schedule.workday ne '주말'}">	
						<input class="workday" id="weekend" type="checkbox" value="주말" name="workday" style="margin-right: 10px;" >
					</c:if>	
					<label for='weekend'>주말</label>
				</div>
			</div>
			
			<div style="padding-bottom: 1rem;">
				<select class="routeControl"  id="hour" name="sth" required>
			
					<option><c:out value="${schedule.sth }" /></option>
					
					<c:forEach var="i" begin="0" end="23">
					<c:choose>
						<c:when test="${i<10}">
							<option value="<fmt:formatNumber value='${i}' pattern ='00' />"<c:if test="${list.lastTimeHour == i}">selected</c:if>> <c:out value="${route.sth }"><fmt:formatNumber value='${i}' pattern ='00' /></c:out></option>
						</c:when>
						<c:otherwise>
						<option> <fmt:formatNumber value='${i}' pattern ='##' /></option>
						</c:otherwise>
					</c:choose>
					</c:forEach>
					
				</select> <label style="margin-left: 10px;">시 </label> 
		<!-- <c:if test="${i<10}">0${i}</c:if> 작동 X -->
		<%-- <option value="<fmt:formatNumber value='${i}' pattern ='00' />" --%>
			<%--<c:if test="${list.lastTimeHour == i}">selected</c:if>> <fmt:formatNumber value='${i}' pattern ='00' /></option> --%>
		
		
			<select class="routeControl" id="minutes" name="stm" style="margin-left: 15px;">
				<option><c:out value="${schedule.stm }" /></option>
				
				<c:forEach var="j" begin="0" end="55" step="5">
					
					<c:choose>
						<c:when test="${j<10}">
							<option value="<fmt:formatNumber value='${j}' pattern ='00' />"> <fmt:formatNumber value='${j}' pattern ='00' /></option>
						</c:when>
						<c:otherwise>
							<option><fmt:formatNumber value='${j}' type="number"/></option>
						</c:otherwise>
					</c:choose>
					
				</c:forEach>
				
			</select> <label style="margin-left: 10px;"> 분 </label>
			</div>
			<div style="padding-bottom: 1rem;">
				<input class="routeControl" min="0" type="number" name="eta" value='<c:out value="${schedule.eta }"/>'><label class="inLabel" style="margin-left: 10px;"> 분 </label>
			</div>
			<div style="padding-bottom: 1.8rem;"><label> 28석 </label> </div>
			<div style="padding-bottom: 1rem;">
				<c:if test="${schedule.grade eq '우등'}">
					<input type="radio" name="grade" value="우등" id="superior" checked="checked" style="margin-right: 10px;"> 
				</c:if>
				<c:if test="${schedule.grade ne '우등'}">
					<input type="radio" name="grade" value="우등" id="superior" style="margin-right: 10px;"> 
				</c:if>
				<label for="superior" style="margin-right: 15px;">우등</label> 
				
				<c:if test="${schedule.grade eq '일반'}">
					<input type="radio" name="grade" value="일반" id="general" checked="checked" style="margin-right: 10px;">
				</c:if>
				<c:if test="${schedule.grade ne '일반'}">
					<input type="radio" name="grade" value="일반" id="general" style="margin-right: 10px;">
				</c:if>
				<label for="general">일반</label>
			</div>
		</div>
	
		
			<!-- 삭제모달창 -->
		
			<div id="deletemodal" class="deletemodal" style="display: none;">
				<div class="delete-content" role="document">
					<div class="delete-body">
						<c:out value="${schedule.departure }"/> → <c:out value="${schedule.arrival }" /> 
						행의 노선을 삭제하시겠습니까? 
					</div> <!-- 모달 창 바디 -->
					<div class="delete-modal-footer">
						<button class="modalRemoveBtn deBtn" data-oper="remove" id="delete">진행</button>
						<button class="modalCloseBtn deBtn" data-oper="modalclose" style="margin-left: 10px;" >아니오</button>
					</div> <!-- 모달 버튼  -->	
				</div> <!-- 모달 전체 내용 -->
			</div> <!-- deletemodal 끝 -->
			
		<!-- 삭제 모달창 끝 -->
		
	</div>
	</form>
		<div class="noBtn">
			<button type="submit" data-oper="modify" class="btnBtn">수정</button> 
			<button data-oper="modalshow" type="button" class="btnBtn yesX"  data-toggle="modal" data-target="#deletemodal">삭제</button>
			<button  data-oper="list" type="button" class="btnBtn" onclick="location.href='/admin/routeschedulelist'">취소</button>
		</div>
</div>
</div>
</body>
</html>