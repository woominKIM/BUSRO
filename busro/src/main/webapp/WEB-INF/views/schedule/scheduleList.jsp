<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html>
<head>
	<meta charset="UTF-8">
	<title>스케줄 선택</title>
	<%@include file="../includes/userHeader.jsp"%>
	<link rel="stylesheet" href="/resources/css/common.css">
	<link rel="stylesheet" href="/resources/css/scheduleList.css">
</head>
<script type="text/javascript">
	window.history.forward();
	function noBack(){window.history.forward();}
</script>
<body onload="noBack();" onpageshow="if(event.persisted) noBack();" onunload="">
	<div id="contentWrap">
		<div class="scheduleTitle underscore260"><span><b class="smallFont24">일정 조회</b> > 좌석 선택 > 예매 최종확인</span></div>
			<div id="formWrap">
				<form role="form" action="/ticket/seatList" method="get">
			    	<table>
			            <thead>
				    		<tr class="seperateTd40">
			    				<td class="bigFont30" align="center" colspan="3">
				    				${scheduleList[0].departure}
				                    <img class="goImg" width="37" src="../resources/img/oneWay.png">
				                    ${scheduleList[0].arrival}
				    			</td>
			    				<c:choose>
			    					<c:when test="${searchDTO.chkRoundTrip eq 2}">
			    						<td class="bigFont30">
			    							<div class="underscore40">왕복</div>
			    						</td> 
			    						<td class="bigFont30">
			    							<div class="underscore120"><b>출발일</b><small>/복귀일</small></div>
			    						</td>
			    					</c:when>
			    					<c:when test="${searchDTO.chkRoundTrip eq 1}">
			    						<td class="bigFont30">
			    							<div class="underscore40">왕복</div>
			    						</td> 
			    						<td class="bigFont30">
			    							<div class="underscore120"><small>출발일/</small><b>복귀일</b></div>
			    						</td>
			    					</c:when>
			    					<c:otherwise>
			    						<td colspan=2 class="bigFont30">
			    							<div>편도</div>
			    						</td>
			    					</c:otherwise>
			    				</c:choose>
				    			<td colspan="2">
				    				<button id="discountInfo" class="smallFont20">할인정보</button>
				    			</td>
				    		</tr>
			            </thead>
			            <tr>
			            	<td colspan="7">
		   						<span id="twoDaysAgoSpan" style="font-size:18px; color:#ccc"></span>
		   						<span id="yesterdaySpan" style="font-size:20px; color:#aaa"></span>
		   						<button id="yesterdayBtn" class="smallFont20" style="border:1px solid;">&lt;</button>
		           				${searchDTO.leaveDay} 
		           				<button id="tomorrowBtn" class="smallFont20" style="border:1px solid;">&gt;</button>
		           				<span id="tomorrowSpan" style="font-size:20px; color:#aaa"></span>
		           				<span id="twoDaysLaterSpan" style="font-size:18px; color:#ccc"></span>
			            	</td>
			            </tr>
		                <tr class="seperateTh30">
		                	<th>▼ 선택</th>
		                    <th>출발시간</th>
		                    <th>소요시간</th>
		                    <th>버스등급</th>
		                    <th>총 좌석</th>
		                    <th>잔여석</th>
		                    <th>기본요금</th>
		                </tr>
			            <tbody>
			            	<c:forEach var="schedule" items="${scheduleList}">
			            		<tr class="schedule" data-oper="${schedule.snum}">
			            			<td data-status="${schedule.snum}"></td>
			            			<td>${schedule.st}</td>
			            			<td><fmt:formatNumber pattern="00" type="number" value="${schedule.eta/60}"/>:<fmt:formatNumber pattern="00" type="number" value="${schedule.eta%60}"/></td>
			            			<td>${schedule.grade}</td>
			            			<td>
			            				<c:choose>
				            				<c:when test="${schedule.grade eq '우등'}">
				            					<c:out value="28"/>
				            				</c:when>
				            				<c:otherwise>
				            					<c:out value="28"/>
			            					</c:otherwise>
			            				</c:choose>
			            			</td>
			            			<td data-oper="${schedule.snum}"></td>
			            			<td><fmt:formatNumber value="${schedule.price}" pattern="#,###" /></td>
			            		</tr>
			            	</c:forEach>
			            	<tr>
			            		<td colspan="7">
			            			<button id="redo" >이전</button>
			            			<button id="next" type="submit">다음</button>
			            		</td>
			            	</tr>
			            </tbody>
			        </table>
			        <input type="hidden" name="snum"/>
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
			    </form>
		</div>
    </div>
    <%@include file="../includes/footer.jsp" %>
</body>
<script type="text/javascript">
$(document).ready(function(){
	$("#yesterdaySpan").text(getFormattingDate(-1));
	$("#tomorrowSpan").text(getFormattingDate(1));
	$("#twoDaysAgoSpan").text(getFormattingDate(-2));
	$("#twoDaysLaterSpan").text(getFormattingDate(2));
	
	//버스 등급별 좌석 수
	var excellentExpressBus = 28;
	var expressBus = 28;
	
	//좌석 잔여석 구하는 코드
	<c:forEach var="schedule" items="${scheduleList}">
	$.getJSON("/ticket/getReservedSeatCount/"+"${schedule.snum}"+"/"+"${searchDTO.leaveDay}",function(seatCount){
		$("input[name='snum']").val($(this).data("oper"));
		<c:choose>
			<c:when test="${schedule.grade eq '우등'}">
				$("td[data-oper='${schedule.snum}']").html(excellentExpressBus-seatCount);
				if(excellentExpressBus-seatCount > 0) {
					$("td[data-status='${schedule.snum}']").html("예약가능");
				}else{
					$("td[data-status='${schedule.snum}']").html("예약불가");
				}
			</c:when>
			<c:otherwise>
				$("td[data-oper='${schedule.snum}']").html(expressBus-seatCount);
				if(expressBus-seatCount > 0) {
					$("td[data-status='${schedule.snum}']").html("예약가능");
				}else{
					$("td[data-status='${schedule.snum}']").html("예약불가");
				}
			</c:otherwise>
		</c:choose>
	});
	</c:forEach>
	
	//특정일을 더하거나 뺀 날짜(yyyy-MM-dd)를 구하는 함수
	function getFormattingDate(days){
		var leaveDay = new Date('${searchDTO.leaveDay}');
		leaveDay.setDate(leaveDay.getDate()+days);
		return leaveDay.getFullYear()+"-"+String(leaveDay.getMonth()+1).padStart(2,'0')+"-"+String(leaveDay.getDate()).padStart(2,'0');
	}

	//어제날짜 버튼 누를시 동작 설정
	$("#yesterdayBtn").on("click",function(e){
		e.preventDefault();
		var formObj = $("form");
		var today = new Date();
		var leaveDay = new Date('${searchDTO.leaveDay}');
		var yesterday = new Date($("#yesterdaySpan").text());
		var comebackDay = new Date('${searchDTO.comebackDay}');
		var yesterdayWeekDay = 0;
		var yCount = -1;
		if("${searchDTO.chkRoundTrip}" === "1"){
			while(yesterday >= comebackDay){
				yesterdayWeekDay = yesterday.getDay();
				if(yesterdayWeekDay == 0 || yesterdayWeekDay == 6){
					<c:forEach var="schedule" items="${scheduleList}">
						if("${schedule.workday}" != "" && "${schedule.workday}" != "평일"){
							$("input[name='leaveDay']").val(getFormattingDate(yCount));
							formObj.attr("action","/schedule/scheduleList");
							formObj.submit();
							return true;
						}
					</c:forEach>
				}else{
					<c:forEach var="schedule" items="${scheduleList}">
						if("${schedule.workday}" != "" && "${schedule.workday}" != "주말"){
							$("input[name='leaveDay']").val(getFormattingDate(yCount));
							formObj.attr("action","/schedule/scheduleList");
							formObj.submit();
							return true;
						}
					</c:forEach>
				}
				--yCount;
				yesterday = new Date(getFormattingDate(yCount));
			}
			alert("해당날짜 이전에 존재하는 스케쥴이 없거나 복귀일이 출발일 이전으로 갈 수 없습니다");
			return false;
		}else {
			while(yesterday >= today){
				yesterdayWeekDay = yesterday.getDay();
				if(yesterdayWeekDay == 0 || yesterdayWeekDay == 6){
					<c:forEach var="schedule" items="${scheduleList}">
						if("${schedule.workday}" != "" && "${schedule.workday}" != "평일"){
							$("input[name='leaveDay']").val(getFormattingDate(yCount));
							formObj.attr("action","/schedule/scheduleList");
							formObj.submit();
							return true;
						}
					</c:forEach>
				}else{
					<c:forEach var="schedule" items="${scheduleList}">
					if("${schedule.workday}" != "" && "${schedule.workday}" != "주말"){
						$("input[name='leaveDay']").val(getFormattingDate(yCount));
						formObj.attr("action","/schedule/scheduleList");
						formObj.submit();
						return true;
					}
					</c:forEach>
				}
				--yCount;
				yesterday = new Date(getFormattingDate(yCount));
			}
			alert("해당날짜 이전에 존재하는 스케쥴이 없거나 오늘보다 과거로 갈 수 없습니다.");
			return false;
		}
	});
	
	//내일날짜 버튼 누를시 동작 설정
	$("#tomorrowBtn").on("click",function(e){
		e.preventDefault();
		var formObj = $("form");
		var today = new Date();
		var leaveDay = new Date('${searchDTO.leaveDay}');
		var tomorrow = new Date($("#tomorrowSpan").text());
		var comebackDay = new Date('${searchDTO.comebackDay}');
		var tomorrowWeekDay = 0;
		var tCount = 1;
		if("${searchDTO.chkRoundTrip}" === "2"){
			while(tomorrow <= comebackDay){
				tomorrowWeekDay = tomorrow.getDay();
				if(tomorrowWeekDay == 0 || tomorrowWeekDay == 6){
					<c:forEach var="schedule" items="${scheduleList}">
						if("${schedule.workday}" != "" && "${schedule.workday}" != "평일"){
							$("input[name='leaveDay']").val(getFormattingDate(tCount));
							formObj.attr("action","/schedule/scheduleList");
							formObj.submit();
							return true;
						}
					</c:forEach>
				}else{
					<c:forEach var="schedule" items="${scheduleList}">
						if("${schedule.workday}" != "" && "${schedule.workday}" != "주말"){
							$("input[name='leaveDay']").val(getFormattingDate(tCount));
							formObj.attr("action","/schedule/scheduleList");
							formObj.submit();
							return true;
						}
					</c:forEach>
				}
				++tCount;
				tomorrow = new Date(getFormattingDate(tCount));
			}
			alert("해당날짜 이후에 존재하는 스케쥴이 없거나 출발일이 복귀일을 넘어갈 수 없습니다.");
			return false;
		}else{
			while(true){
				tomorrowWeekDay = tomorrow.getDay();
				if(tomorrowWeekDay == 0 || tomorrowWeekDay == 6){
					<c:forEach var="schedule" items="${scheduleList}">
						if("${schedule.workday}" != "" && "${schedule.workday}" != "평일"){
							$("input[name='leaveDay']").val(getFormattingDate(tCount));
							formObj.attr("action","/schedule/scheduleList");
							formObj.submit();
							return true;
						}
					</c:forEach>
				}else{
					<c:forEach var="schedule" items="${scheduleList}">
						if("${schedule.workday}" != "" && "${schedule.workday}" != "주말"){
							$("input[name='leaveDay']").val(getFormattingDate(tCount));
							formObj.attr("action","/schedule/scheduleList");
							formObj.submit();
							return true;
						}
					</c:forEach>
				}
				++tCount;
				tomorrow = new Date(getFormattingDate(tCount));
			}
		}
	});
	
	//이전버튼 누를시 메인화면 이동
	$("#redo").on("click",function(e){
		e.preventDefault();
		location.replace('/main');
	});
	
	//할인정보 버튼 누를시 모달창 생성(작성예정)
	$("#discountInfo").on("click",function(e){
		e.preventDefault();
		alert("청소년:10%, 아동:30% 할인");
	})
	
	//특정 스케줄 클릭시 동작 설정
	$(".schedule").on("click",function(e){
		if($("td[data-status='"+ $(this).data("oper") +"']").html() == '예약가능'){
			$("input[name='snum']").val($(this).data("oper"));
			$(".schedule").css("background-color","white");
			$(this).css("background-color","cornsilk");
		}else{
			alert("만석입니다.");
		}
	});

	//다음버튼 클릭시 유효성검사(스케줄을 선택하지 않았을 경우)
	$("#next").on("click",function(e){
		e.preventDefault();
		var formObj = $("form");
		
		//로그인 확인
		if('${member.id}' == ''){
			alert('세션이 만료되었습니다. 재로그인하세요.');
			return false;
		}
		if($("input[name='snum']").val() == ""){
			alert("스케줄을 선택하십시오.");
		}else{
			formObj.submit();
		}
	});
});
</script>
</html>     