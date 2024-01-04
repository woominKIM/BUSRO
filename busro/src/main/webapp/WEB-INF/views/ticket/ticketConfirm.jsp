<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<style>
	table{text-align:center;}
	section{width:60%; background-color:#f0f0f0; float:left;}
	aside{width:40%; background-color:lightyellow; float:right;}
</style>
<html>
<head>
	<title>예매 최종확인</title>
	<link rel="stylesheet" href="/resources/css/common.css">
	<link rel="stylesheet" href="/resources/css/ticketConfirm.css">
</head>
<script type="text/javascript">
	window.history.forward();
	function noBack(){window.history.forward();}
</script>
<body onload="noBack();" onpageshow="if(event.persisted) noBack();" onunload="">
	<%@include file="../includes/userHeader.jsp" %>
	<div id="contentWrap">
		<div class="confirmTitle underscore260"><span>일정 조회 > 좌석 선택 > <b class="smallFont24">예매 최종확인</b></span></div>
		<c:choose>
			<c:when test="${fn:length(scheduleList) eq 2}">
				<div class="tableWrap">
					<table>
						<thead>
							<tr>
								<td class="seperateCompletly" colspan="4">${searchDTO.departure}<img class="goImg" src="../resources/img/oneWay.png">${searchDTO.arrival}</td>
								<td colspan="3">결제 요금</td>
							</tr>
						</thead>
						<tbody>
							<tr class="seperateTd40">
								<td>출발지</td>
								<td>도착지</td>
								<td>출발일</td>
								<td class="seperateCompletly">승차구분</td>
								<td>기본요금</td>
								<td>할인</td>
								<td>총 결제금액</td>
							</tr>
							<tr class="seperateTd40">
								<td>${searchDTO.departure}</td>
								<td>${searchDTO.arrival}</td>
								<td>${searchDTO.leaveDay}</td>
								<td id="leaveHeadCount" class="seperateCompletly"></td>
								<td id="leavePriceDefault"></td>
								<td id="leaveDiscount"></td>
								<td id="leavePriceFinal"></td>
							</tr>
					</table>
				</div>
				<div class="tableWrap">
					<table>
						<thead>
							<tr>
								<td class="seperateCompletly" colspan="4">${searchDTO.arrival}<img class="goImg" src="../resources/img/oneWay.png">${searchDTO.departure}</td>
								<td colspan="3">결제 요금</td>
							</tr>
						</thead>
						<tbody>
							<tr class="seperateTd40">
								<td>출발지</td>
								<td>도착지</td>
								<td>출발일</td>
								<td class="seperateCompletly">승차구분</td>
								<td>기본요금</td>
								<td>할인</td>
								<td>총 결제금액</td>
							</tr>
							<tr class="seperateTd40">
								<td>${searchDTO.arrival}</td>
								<td>${searchDTO.departure}</td>
								<td>${searchDTO.comebackDay}</td>
								<td id="comebackHeadCount" class="seperateCompletly"></td>
								<td id="comebackPriceDefault"></td>
								<td id="comebackDiscount"></td>
								<td id="comebackPriceFinal"></td>
							</tr>
			</c:when>
			<c:otherwise>
				<div class="tableWrap">
					<table>
						<thead>
							<tr>
								<td class="seperateCompletly" colspan="4">${searchDTO.departure}<img class="goImg" src="../resources/img/oneWay.png">${searchDTO.arrival}</td>
								<td colspan="3">결제 요금</td>
							</tr>
						</thead>
						<tbody>
							<tr class="seperateTd40">
								<td>출발지</td>
								<td>도착지</td>
								<td>출발일</td>
								<td class="seperateCompletly">승차구분</td>
								<td>기본요금</td>
								<td>할인</td>
								<td>총 결제금액</td>
							</tr>
							<tr class="seperateTd40">
								<td>${searchDTO.departure}</td>
								<td>${searchDTO.arrival}</td>
								<td>${searchDTO.leaveDay}</td>
								<td id="oneWayHeadCount" class="seperateCompletly"></td>
								<td id="oneWayPriceDefault"></td>
								<td id="oneWayDiscount"></td>
								<td id="oneWayPriceFinal"></td>
							</tr>
			</c:otherwise>
		</c:choose>
					<tr>
						<td colspan="7">
							<form role="form" action="/ticket/doTicketing" method="post">
								<input type="hidden" name="chkRoundTrip" value="${searchDTO.chkRoundTrip}">
								<c:forEach items="${tDTOList}" var="tDTO" varStatus="idx">
									<input type="hidden" name="tDTOList[${idx.index}].snum" value="${tDTO.snum}">
									<input type="hidden" name="tDTOList[${idx.index}].order" value="${tDTO.order}">
									<input type="hidden" name="tDTOList[${idx.index}].dDate" value="${tDTO.DDate}">
									<input type="hidden" name="tDTOList[${idx.index}].seatNum" value="${tDTO.seatNum}">
									<input type="hidden" name="tDTOList[${idx.index}].pType" value="${tDTO.PType}">
									<input type="hidden" name="tDTOList[${idx.index}].pet" value="${tDTO.pet}">
								</c:forEach>
								<button id="cancel" style="float:left;">취소(처음으로)</button>
								<button id="next" style="float:right;" type="submit">다음</button>
							</form>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
    <%@include file="../includes/footer.jsp" %>
</body>
<script type="text/javascript">
$(document).ready(function(){
	
	//왕복&편도 구분
	var chkRoundTrip = "${searchDTO.chkRoundTrip}";

	//유형별 할인률
	var adultDisRate = 1;
	var teenDisRate = 0.9;
	var kidDisRate = 0.7;
	
	//왕복인 경우의 데이터 출력
	if(chkRoundTrip>0){
		
		//가는편&오는편 각각의 인원수
		var leaveHeadCount = 0;
		var comebackHeadCount = 0;
		
		//가는편$오는편 최종 금액
		var leavePriceFinal = 0;
		var comebackPriceFinal = 0;
		
		//데이터 출력
		<c:forEach items="${tDTOList}" var="tDTO" varStatus="idx">
			if("${tDTO.snum}" == "${scheduleList[0].snum}"){
				leaveHeadCount++;	
				switch("${tDTO.PType}"){
					case 'A':
						leavePriceFinal += Math.floor("${scheduleList[0].price}"*adultDisRate);
						break;
					case 'T':
						leavePriceFinal += Math.floor("${scheduleList[0].price}"*teenDisRate);
						break;
					case 'K':
						leavePriceFinal += Math.floor("${scheduleList[0].price}"*kidDisRate);
						break;
				}
			}
			if("${tDTO.snum}" == "${scheduleList[1].snum}"){
				comebackHeadCount++;	
				switch("${tDTO.PType}"){
				case 'A':
					comebackPriceFinal += Math.floor("${scheduleList[1].price}"*adultDisRate);
					break;
				case 'T':
					comebackPriceFinal += Math.floor("${scheduleList[1].price}"*teenDisRate);
					break;
				case 'K':
					comebackPriceFinal += Math.floor("${scheduleList[1].price}"*kidDisRate);
					break;
				}
			}
		</c:forEach>
		var leavePriceDefault = "${scheduleList[0].price}"*leaveHeadCount;
		var comebackPriceDefault = "${scheduleList[1].price}"*comebackHeadCount;
		$("#leaveHeadCount").text("${scheduleList[0].grade}("+leaveHeadCount+")");
		$("#comebackHeadCount").text("${scheduleList[1].grade}("+comebackHeadCount+")");
		$("#leavePriceDefault").text(leavePriceDefault.toLocaleString('ko-KR'));
		$("#comebackPriceDefault").text(comebackPriceDefault.toLocaleString('ko-KR'));
		$("#leaveDiscount").text((leavePriceDefault - leavePriceFinal).toLocaleString('ko-KR'));
		$("#comebackDiscount").text((comebackPriceDefault - comebackPriceFinal).toLocaleString('ko-KR'));
		$("#leavePriceFinal").text(leavePriceFinal.toLocaleString('ko-KR'));
		$("#comebackPriceFinal").text(comebackPriceFinal.toLocaleString('ko-KR'));
	}
	
	//편도인 경우의 데이터 출력
	else{
		
		//인원수
		var headCount = 0;
		//최종 금액
		var priceFinal = 0;
		
		//데이터 출력
		<c:forEach items="${tDTOList}" var="tDTO" varStatus="idx">
			headCount++;	
			switch("${tDTO.PType}"){
				case 'A':
					priceFinal += Math.floor("${scheduleList[0].price}"*adultDisRate);
					break;
				case 'T':
					priceFinal += Math.floor("${scheduleList[0].price}"*teenDisRate);
					break;
				case 'K':
					priceFinal += Math.floor("${scheduleList[0].price}"*kidDisRate);
					break;
			}
		</c:forEach>
		var priceDefault = "${scheduleList[0].price}"*headCount;
		$("#oneWayHeadCount").text("${scheduleList[0].grade}("+headCount+")");
		$("#oneWayPriceDefault").text(priceDefault);
		$("#oneWayDiscount").text(priceDefault - priceFinal);
		$("#oneWayPriceFinal").text(priceFinal);
	}
	
	//취소버튼 동작
	$("#cancel").on("click",function(e){
		e.preventDefault();
		var formObj = $("form[role='form']");
		formObj.empty();
		formObj.attr("method","get");
		formObj.attr("action","/main");
		formObj.submit();
	});
	
	//다음버튼 동작
	$("#next").on("click",function(e){
		//로그인 확인
		if('${member.id}' == ''){
			alert('세션이 만료되었습니다. 재로그인하세요.');
			return false;
		}
		alert("예약이 완료되었습니다.");
	});
});
</script>
</html>