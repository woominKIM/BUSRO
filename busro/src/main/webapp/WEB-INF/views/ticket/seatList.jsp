<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html>
<head>
	<meta charset="UTF-8">
	<title>좌석 선택</title>
	<link rel="stylesheet" href="/resources/css/common.css">
	<link rel="stylesheet" href="/resources/css/seatList.css">
</head>
<script type="text/javascript">
	window.history.forward();
	function noBack(){window.history.forward();}
</script>
<body onload="noBack();" onpageshow="if(event.persisted) noBack();" onunload="">
	<%@include file="../includes/userHeader.jsp" %>
	<div class="wrapper">
		<div class="seatTitle underscore260"><span>일정 조회 > <b class="smallFont24">좌석 선택</b> > 예매 최종확인</span></div>
		<section>
				<table>
					<thead>
						<tr>
							<td class="driverSeat" colspan="3"><div>운전석</div></td>
							<td colspan="4"></td>
						</tr>
						<tr>
							<td colspan="3"><div class="underscore30">A열</div></td>
							<td colspan="3"></td>
							<td><div class="underscore30">B열</div></td>
						</tr>
					</thead>
					<tbody>
						<c:forEach begin="0" end="8" step="1" varStatus="status">
							<c:choose>
								<c:when test="${status.last}">
									<tr class="seatIconTr">
										<td><img class="seatIcon seatIconA" src="../resources/img/emptySeat.png"></td><td class="tdSpace"></td>
										<td><img class="seatIcon seatIconA" src="../resources/img/emptySeat.png"></td><td class="tdSpace"></td>
										<td><img class="seatIcon seatIconB" src="../resources/img/emptySeat.png"></td><td class="tdSpace"></td>
										<td><img class="seatIcon seatIconB" src="../resources/img/emptySeat.png"></td>
									</tr>
									<tr class="seatInfoTr">
										<td class="seatInfo seatInfoA"></td><td class="tdSpace"></td>
										<td class="seatInfo seatInfoA"></td><td class="tdSpace"></td>
										<td class="seatInfo seatInfoB"></td><td class="tdSpace"></td>
										<td class="seatInfo seatInfoB"></td>
									</tr>
								</c:when>
								<c:when test="${status.first}">
									<tr class="seatIconTr">
										<td><img class="seatIcon seatIconA" src="../resources/img/emptySeat.png"></td><td class="tdSpace"></td>
										<td><img class="seatIcon seatIconA" src="../resources/img/emptySeat.png"></td><td class="tdSpace"></td>
										<td id="corridor" rowspan="${(status.end)*3}"></td><td class="tdSpace"></td>
										<td><img class="seatIcon seatIconB" src="../resources/img/emptySeat.png"></td>
									</tr>
									<tr class="seatInfoTr">
										<td class="seatInfo seatInfoA"></td><td class="tdSpace"></td>
										<td class="seatInfo seatInfoA"></td><td class="tdSpace"></td>
										<td class="tdSpace"></td><td class="seatInfo seatInfoB"></td>
									</tr>
									<tr>
										<td colspan="7"></td>
									</tr>
								</c:when>
								<c:otherwise>
									<tr class="seatIconTr">
										<td><img class="seatIcon seatIconA" src="../resources/img/emptySeat.png"></td><td class="tdSpace"></td>
										<td><img class="seatIcon seatIconA" src="../resources/img/emptySeat.png"></td><td class="tdSpace"></td>
										<td class="tdSpace"></td><td><img class="seatIcon seatIconB" src="../resources/img/emptySeat.png"></td>
									</tr>
									<tr class="seatInfoTr">
										<td class="seatInfo seatInfoA"></td><td class="tdSpace"></td>
										<td class="seatInfo seatInfoA"></td><td class="tdSpace"></td>
										<td class="tdSpace"></td><td class="seatInfo seatInfoB"></td>
									</tr>
									<tr>
										<td colspan="7"></td>
									</tr>
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</tbody>
				</table>
		</section>
		<aside>
			<div class="asideWrap">
				<table>
					<thead>
						<tr>
							<td class="headCountText" rowspan="2">성인</td>
							<td class="headCount" data-oper="A" rowspan="2">0</td>
							<td class="headCountPlus" data-oper="A">▲</td>
						</tr>
						<tr>
							<td class="headCountMinus" data-oper="A">▼</td>
						</tr>
						<tr>
							<td class="headCountText" rowspan="2">청소년</td>
							<td class="headCount" data-oper="T" rowspan="2">0</td>
							<td class="headCountPlus" data-oper="T">▲</td>
						</tr>
						<tr>
							<td class="headCountMinus" data-oper="T">▼</td>
						</tr>
						<tr>
							<td class="headCountText" rowspan="2">아동</td>
							<td class="headCount" data-oper="K" rowspan="2">0</td>
							<td class="headCountPlus" data-oper="K">▲</td>
						</tr>
						<tr>
							<td class="headCountMinus" data-oper="K">▼</td>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td colspan="4">
								<form role="form" action="/ticket/ticketConfirm" method="post">
									<input type='hidden' name='chkRoundTrip' value='<c:out value="${searchDTO.chkRoundTrip}"/>'>
							        <input type='hidden' name='departure' value='<c:out value="${searchDTO.departure}"/>'>
									<input type='hidden' name='arrival' value='<c:out value="${searchDTO.arrival}"/>'>
									<input type='hidden' name='leaveDay' value='<c:out value="${searchDTO.leaveDay}"/>'>
									<input type='hidden' name='comebackDay' value='<c:out value="${searchDTO.comebackDay}"/>'>
									<div hidden='hidden' id="preSeatInfo">
										<c:forEach items="${tDTOList}" var="tDTO" varStatus="idx">
											<input type="hidden" name="tDTOList[${idx.index}].snum" value="${tDTO.snum}">
											<input type="hidden" name="tDTOList[${idx.index}].order" value="${tDTO.order}">
											<input type="hidden" name="tDTOList[${idx.index}].dDate" value="${tDTO.DDate}">
											<input type="hidden" name="tDTOList[${idx.index}].seatNum" value="${tDTO.seatNum}">
											<input type="hidden" name="tDTOList[${idx.index}].pType" value="${tDTO.PType}">
											<input type="hidden" name="tDTOList[${idx.index}].pet" value="${tDTO.pet}">
										</c:forEach>
									</div>
				           			<button id="redo">이전</button>
				           			<button id="next" style="float:right;" type="submit">다음</button>
				           		</form>
			           		</td>
						</tr>
					</tbody>
				</table>
				<fieldset id="remarkSelect" hidden="hidden">
					<legend>특이사항 체크</legend>
					<div>
						<input type="checkbox" id="petYN" name="petYN"/>
						<label>반려동물 동승(Y/N)</label>
					</div>
				</fieldset>
			</div>
		</aside>
	</div>
    <%@include file="../includes/footer.jsp" %>
</body>
<script type="text/javascript">
$(document).ready(function(){
	
	//전역변수
	const NumberOfBusSeats = 28;
	var seatCount = 0;
	var seatOrder = 0;
	var currPType = 'none';
	var roundTripPTypeList = [];
	var roundTripPTypeCount = 0;
	var tempSeat = '';
	
	//초기설정
	$(function(){
		//A열, B열 각각에 A01, A02.. 식으로 식별번호 부여
		$(".seatIconA").each(function(index){
			$(this).attr("data-oper","A"+(index+1).toString().padStart(2,'0'));
		});
		$(".seatInfoA").each(function(index){
			$(this).attr("data-oper","A"+(index+1).toString().padStart(2,'0'));
			$(this).text("A"+(index+1).toString().padStart(2,'0'));	
		});
		$(".seatIconB").each(function(index){
			$(this).attr("data-oper","B"+(index+1).toString().padStart(2,'0'));
		});
		$(".seatInfoB").each(function(index){
			$(this).attr("data-oper","B"+(index+1).toString().padStart(2,'0'));
			$(this).text("B"+(index+1).toString().padStart(2,'0'));	
		});
		
		//왕복의 복귀편일 경우의 변수 및 화면단 초기화
		if("${searchDTO.chkRoundTrip}" === "1"){
			var aCount = 0;
			var tCount = 0;
			var kCount = 0;
			currPType = 'fixed';
			<c:forEach var="tDTO" items="${tDTOList}" varStatus="idx">
				roundTripPTypeList.push("${tDTO.PType}");
				if("${tDTO.PType}" === "A") aCount++;
				if("${tDTO.PType}" === "T") tCount++;
				if("${tDTO.PType}" === "K") kCount++;
				roundTripPTypeCount++;
			</c:forEach>
			$(".headCount[data-oper='A']").text(aCount);
			$(".headCount[data-oper='T']").text(tCount);
			$(".headCount[data-oper='K']").text(kCount);

			seatCount = roundTripPTypeCount;
			$(".headCountPlus").hide();
			$(".headCountMinus").hide();
		}
		
		//좌석 클릭시 이벤트 설정
		$(".seatIcon").on("click",function(e){
			
			//인원수를 선택하였을 경우
			if(seatCount>0 && currPType !== 'none'){
				
				//이미 지정한 좌석 선택시
				if($(this).attr("data-ptype")){
					alert("이미 지정되어있는 좌석입니다.");
				}
				//빈좌석 선택시 해당좌석 지정
				else{
					
					//지정한 좌석에 대한 css처리
					$(this).parent().css("background-color","cornsilk");
					$(".seatInfo[data-oper='"+$(this).attr("data-oper")+"']").css("background-color","cornsilk");
					$(".headCountPlus[data-oper='"+currPType+"']").css("background-color","");
					
					//지정한 좌석에 대한 데이터 처리
					if("${searchDTO.chkRoundTrip}" !== "1"){
						$(this).attr("data-ptype",currPType);
						$(".seatInfo[data-oper='"+$(this).attr("data-oper")+"']").attr("data-ptype",currPType);
					}
					//왕복에서 이전에 정한 인원데이터가 있는경우 해당정보를 가져와 인원정보가 자동 기입됨.
					else{
						var ptypeIdx = roundTripPTypeCount - seatCount;
						$(this).attr("data-ptype",roundTripPTypeList[ptypeIdx]);
						$(".seatInfo[data-oper='"+$(this).attr("data-oper")+"']").attr("data-ptype",roundTripPTypeList[ptypeIdx]);
					}
					$(this).attr("data-order",seatOrder);
					$(this).attr("data-pet","N");
					seatOrder++;
					seatCount--;
					
					//인원수 선택토큰 초기화
					if("${searchDTO.chkRoundTrip}" !== "1"){
						currPType='none';
					}
					
					//특이사항 설정을 위한 초기화 설정
					tempSeat=$(this).attr("data-oper");
					$("input[name='petYN']").prop('checked',false);
					$("#remarkSelect").show();
				}
			} 
			//인원수를 선택하지 않았을 경우(혹은 인원선택과 좌석지정을 모두 마쳤을 경우)
			else{
				
				//인원 증감이 가능한 경우(왕복의 출발편 및 편도)
				if("${searchDTO.chkRoundTrip}" !== "1"){
					//이미 지정한 좌석 선택시 좌석지정 취소
					if($(this).attr("data-ptype")){
						
						//인원수 1만큼 삭감
						var preCount = parseInt($(".headCount[data-oper='"+$(this).attr("data-ptype")+"']").text());
						$(".headCount[data-oper='"+$(this).attr("data-ptype")+"']").text(preCount - 1);
						seatOrder--;
						
						//취소한 좌석의 데이터 삭제
						$(this).removeAttr("data-ptype");
						$(this).removeAttr("data-order");
						$(this).removeAttr("data-pet");
						$(".seatInfo[data-oper='"+$(this).attr("data-oper")+"']").removeAttr("data-ptype");
						
						//지정좌석 취소에 따른 css처리
						$(this).parent().css("background-color","");
						$(".seatInfo[data-oper='"+$(this).attr("data-oper")+"']").css("background-color","");
						$(this).attr("src","../resources/img/emptySeat.png");
						$("input[name='petYN']").prop('checked',false);
						$("#remarkSelect").hide();
					}
					//빈좌석 선택시
					else{
						alert("예약할 인원수를 추가해주십시오.");
					}
				}
				
				//인원 증감이 불가한 경우(왕복의 복귀편)
				else{
					//이미 지정한 좌석 선택시 좌석지정 전체 취소
					if($(this).attr("data-ptype")){
						var cancelYN = confirm("지정한 좌석을 전체 취소한 후 재지정하시겠습니까?");					
						if(cancelYN == true){

							//지정좌석 전체취소에 따른 css처리
							$(".seatIcon[data-ptype]").parent().css("background-color","");
							$(".seatInfo[data-ptype]").css("background-color","");
							$(".seatIcon[data-ptype]").attr("src","../resources/img/emptySeat.png");
							
							//전체취소한 좌석의 데이터 삭제
							$(".seatIcon").removeAttr("data-ptype");
							$(".seatIcon").removeAttr("data-order");
							$(".seatIcon").removeAttr("data-pet");
							
							//지정좌석 전체취소에 따른 변수 초기화
							seatOrder=0;
							seatCount = roundTripPTypeCount;
							$("input[name='petYN']").prop('checked',false);
							$("#remarkSelect").hide();
						}
					}
					//빈좌석 선택시
					else{
						alert("복귀편의 인원이 출발편의 인원을 초과할 수 없습니다.");
					}
				}
			}
		});
		
		//이미 예약된 좌석에 대한 설정
		var tList = ${ticketList};
		$.each(tList,function(index,ticket){
			
			//반려동물 유무에 따라 특수석임을 표기
			if(ticket.pet === 'Y'){
				$(".seatIcon[data-oper='"+ticket.seatnum+"']").attr("src","../resources/img/reservedPetSeat.png");
				$(".seatInfo[data-oper='"+ticket.seatnum+"']").html("예약석<br>(반려동반)");	
			}else {
				$(".seatIcon[data-oper='"+ticket.seatnum+"']").attr("src","../resources/img/reservedSeat.png");
				$(".seatInfo[data-oper='"+ticket.seatnum+"']").html("예약석");	
			}
			
			//예약석은 좌석지정기능 차단
			$(".seatIcon[data-oper='"+ticket.seatnum+"']").off("click");
			$(".seatIcon[data-oper='"+ticket.seatnum+"']").on("click",function(e){
				e.preventDefault();
				alert("이미 예약된 좌석입니다.");
			});
			
			//예약석의 css 지정
			$(".seatIcon[data-oper='"+ticket.seatnum+"']").parent().css("background-color","#ccc");
			$(".seatInfo[data-oper='"+ticket.seatnum+"']").css("background-color","#ccc");
		});
	});
	
	//반려동물 동승여부 체크 승인/해제시 동작
	$("input[name='petYN']").on("change",function(){
		
		//체크했을 시
		if($("input[name='petYN']").is(':checked')){
			$(".seatIcon[data-oper='"+tempSeat+"']").attr("src","../resources/img/petSeat.png");
			$(".seatIcon[data-oper='"+tempSeat+"']").attr("data-pet","Y");
		}
		
		//체크 해제했을 시
		else{
			$(".seatIcon[data-oper='"+tempSeat+"']").attr("src","../resources/img/emptySeat.png");
			$(".seatIcon[data-oper='"+tempSeat+"']").attr("data-pet","N");
		}
	});
	
	//(+) 클릭 시 좌석 선택 횟수 부여
	if("${searchDTO.chkRoundTrip}" !== "1"){
		$(".headCountPlus").on("click",function(e){
			e.preventDefault();
			if(seatCount>0 && currPType!=='none') {
				alert("먼저 선택한 인원에 대한 좌석을 선택해주세요.");
			}
			else{
				
				seatCount++;
				switch($(this).attr("data-oper")){
					case 'A':
						currPType = 'A';
						break;
					case 'T':
						currPType = 'T';
						break;
					case 'K':
						currPType = 'K';
						break;
					default:
						currPType = 'none';
						break;
				}
				
				//인원수 1만큼 증가
				var preCount = parseInt($(".headCount[data-oper='"+$(this).attr("data-oper")+"']").text());
				$(".headCount[data-oper='"+$(this).attr("data-oper")+"']").text((preCount+1));
				$(this).css("background-color","#EF3340");
				
	
				//특이사항 체크창 숨김
				tempSeat='';
				$("input[name='petYN']").prop('checked',false);
				$("#remarkSelect").hide();
			}
		});
	}
	
	//(-) 클릭 시 좌석 선택 횟수 차감
	if("${searchDTO.chkRoundTrip}" !== "1"){
		$(".headCountMinus").on("click",function(e){
			if(seatCount<1){
				alert("해당 탑승 유형에 대하여 더이상 차감할 인원수가 없습니다.\n이미 지정한 좌석을 취소하시려면 해당 좌석을 클릭하십시오.");
			}else{
				if(currPType && currPType === $(this).attr("data-oper")){
					seatCount--;
					var preCount = parseInt($(".headCount[data-oper='"+$(this).attr("data-oper")+"']").text());
					$(".headCount[data-oper='"+$(this).attr("data-oper")+"']").text((preCount-1));
					$(".headCountPlus[data-oper='"+$(this).attr("data-oper")+"']").css("background-color","");
				}else{
					alert("해당 탑승 유형에 대하여 더이상 차감할 인원수가 없습니다.\n 다른 유형에 대한 좌석 선택을 먼저 마치십시오.");
				}
			}
		});
	}
	
	//이전버튼 동작
	$("#redo").on("click",function(e){
		e.preventDefault();
		var formObj = $("form[role='form']");
		formObj.attr("method","get");
		formObj.attr("action","/schedule/scheduleList");
		formObj.submit();
	});
	
	//다음버튼 동작
	$("#next").on("click",function(e){
		e.preventDefault();
		var formObj = $("form[role='form']");

		//로그인 확인
		if('${member.id}' == ''){
			alert('세션이 만료되었습니다. 재로그인하세요.');
			return false;
		}
		//왕복의 출발편일 경우 인원수를 전부 체크했는지 확인
		if("${searchDTO.chkRoundTrip}" === "2"){
			if(seatCount > 0){
				alert("먼저 인원수에 대한 좌석을 모두 선택해주십시오.");
				return false;
			}
		}
		//왕복의 복귀편일 경우 인원수를 전부 체크했는지 확인
		if("${searchDTO.chkRoundTrip}" === "1"){
			if(seatCount > 0){
				alert("먼저 인원수에 대한 좌석을 모두 선택해주십시오.");
				return false;
			}
		}
		//폼 태그 값 초기화
		var chkRoundTripTag = $("input[name='chkRoundTrip']").clone();
		var departureTag = $("input[name='departure']").clone();
		var arrivalTag = $("input[name='arrival']").clone();
		var leaveDayTag = $("input[name='leaveDay']").clone();
		var comebackDayTag = $("input[name='comebackDay']").clone();
		var preSeatInfoTag = $("div[id='preSeatInfo']").clone();
		var redoTag = $("button[id='redo']").clone();
		var nextTag = $("button[id='next']").clone();
		formObj.empty();
		formObj.append(chkRoundTripTag);
		formObj.append(departureTag);
		formObj.append(arrivalTag);
		formObj.append(leaveDayTag);
		formObj.append(comebackDayTag);
		formObj.append(preSeatInfoTag);
		formObj.append(redoTag);
		formObj.append(nextTag);
		//폼 태그에 지정좌석정보 추가
		$(".seatIcon[data-ptype]").each(function(index,item){
			var idx = index + ${fn:length(tDTOList)};
			var snumTag = "<input type='hidden' name='tDTOList["+idx+"].snum' value='"+${snum}+"'/>";
			var orderTag = "<input type='hidden' name='tDTOList["+idx+"].order' value='"+$(item).attr("data-order")+"'/>";
			var ddateTag = "<input type='hidden' name='tDTOList["+idx+"].dDate' value='"+"${searchDTO.leaveDay}"+"'/>";
			var seatnumTag = "<input type='hidden' name='tDTOList["+idx+"].seatNum' value='"+$(item).attr("data-oper")+"'/>";
			var ptypeTag = "<input type='hidden' name='tDTOList["+idx+"].pType' value='"+$(item).attr("data-ptype")+"'/>";
			var petTag = "<input type='hidden' name='tDTOList["+idx+"].pet' value='"+$(item).attr("data-pet")+"'/>";
			formObj.append(snumTag);
			formObj.append(orderTag);
			formObj.append(ddateTag);
			formObj.append(seatnumTag);
			formObj.append(ptypeTag);
			formObj.append(petTag);
		});
		
		formObj.submit();
	});
});
</script>
</html>