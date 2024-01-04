<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>버스 예약건 확인</title>
<%@include file="../includes/userHeader.jsp"%>
<link rel="stylesheet" href="/resources/css/common.css">
<link rel="stylesheet" href="/resources/css/bookinglist.css">
</head>
<body>
	<div id="contentWrap">
	<div class="ticketTitle underscore40"><span>예매내역</span></div>
		<div class="tableWrap">
			<table>
		        <tbody>
		        	<c:forEach items="${userTicketList}" var="ticket" varStatus="i">
		        		<tr>
			        		<td rowspan="4" class="lastTd bigTd" data-oper="${i.index}">
			        			<div>
			        				<c:out value="${ticket.departure}→${ticket.arrival} (${ticket.headcount}매)"/>
			        			</div>
			        		</td>
			        		<td>
			        			<div>예매번호</div>
			        			<!-- 예약상세정보 모달창 -->
		        				<div class="modal" id="modal${i.index}">
									<div class="getInfo" id="getInfo${i.index}">
										<div class="modal-header underscore120">
											<h3>예매정보 상세</h3>
										</div>
										<div class="modal-body">
											<p>출발일 : <c:out value="${fn:substring(ticket.ddate,0,4)}년 ${fn:substring(ticket.ddate,5,7)}월 ${fn:substring(ticket.ddate,8,10)}일"/>
											<p>출발시간 : <c:out value="${fn:substring(ticket.st,0,2)}시 ${fn:substring(ticket.st,3,5)}분"/>
											<p>좌석번호 : <c:out value="${ticket.seatnum}"/></p>
											<p>반려동물 동승여부 : <c:out value="${ticket.pet}"/></p>							
											<p>총할인금액 : <fmt:formatNumber value="${ticket.discount}" pattern="#,###"/></p>
											<p>최종금액 : <fmt:formatNumber value="${ticket.realprice}" pattern="#,###"/></p>
											<p>결제일시 : <c:out value="${fn:substring(ticket.tdate,0,4)}년 ${fn:substring(ticket.tdate,5,7)}월 ${fn:substring(ticket.tdate,8,10)}일 ${fn:substring(ticket.tdate,11,19)}"/>
											<p>상태: <c:out value="${ticket.status}"/></p></p>
										</div>
										<div class="modal-footer">
											<button data-oper="${i.index}" class="modalCloseBtn" style="float:left;">닫기</button>
											<button data-oper="${i.index}" data-status="${ticket.status}" class="ticketCancelBtn ticketCancelPre" style="float:right;">예매취소</button>
										</div>
									</div>
								</div>
								<div class="modal" id="secondModal${i.index}">
									<div class="cancelConfirm" id="cancelConfirm${i.index}">
										<div class="modal-header underscore60">
											<h3>예약 취소</h3>
										</div>
										<div class="modal-body">
											<div>결제일시 : <c:out value="${fn:substring(ticket.tdate,0,4)}년 ${fn:substring(ticket.tdate,5,7)}월 ${fn:substring(ticket.tdate,8,10)}일 ${fn:substring(ticket.tdate,11,16)}"/></div>
											<div>출발일자 : <c:out value="${fn:substring(ticket.ddate,0,4)}년 ${fn:substring(ticket.ddate,5,7)}월 ${fn:substring(ticket.ddate,8,10)}일 ${fn:substring(ticket.ddate,11,16)}"/></div>
											<div>최종금액 :<fmt:formatNumber value="${ticket.realprice}" pattern="#,###"/></p></div>
											<p style="color:red;">해당 예약건을 취소하겠습니까?</p>
										</div>
										<div class="modal-footer">
											<button data-oper="${i.index}" class="modalCloseBtn" style="float:left;">아니오</button>
											<button data-oper="${i.index}" class="ticketCancelBtn ticketCancelFinal" style="float:right;">취소합니다</button>
										</div>
									</div>
								</div>
			        		</td>
			        		<td id="rno${i.index}" data-oper="${ticket.snum}">
			        			<c:out value="${ticket.rno}"/>
			        		</td>
			        	</tr>
			        	<tr>
			        		<td>예매일</td>
			        		<td><c:out value="${fn:substring(ticket.tdate,0,10)}"/></td>
			        	</tr>
			        	<tr>
			        		<td>출발일</td>
			        		<td><c:out value="${fn:substring(ticket.ddate,0,10)}"/></td>
			        	</tr>
			        	<tr>
			        		<td class="lastTd">상태</td>
			        		<td class="lastTd"><c:out value="${ticket.status}"/></td>
			        	</tr>
		        	</c:forEach>
		        </tbody>               
			</table>
		</div>
	</div>
	<!-- 페이징  -->
	<div class="paging_region">
		<c:if test="${pages.prev }">
			<span class="pageInfo"> 
				<a href="${pages.startPage -1 }">&lt;Prev</a> 
			</span>
		 </c:if>
		 <c:forEach begin="${pages.startPage}" end="${pages.endPage}" var="num">
		 	<span class="pageInfo">
		 		<a href="${num}">${num}</a>
		 	</span>
		 </c:forEach>
		 <c:if test="${pages.next }">
			<span class="pageInfo">
				<a href="${pages.endPage +1 }">Next&gt;</a> 
			</span>
		 </c:if>
	</div>
	<form method="get" id="pageMove" action="/ticket/bookinglist">
		<input type="hidden" name="pageNum" value="${pages.cri.pageNum }">
		<input type="hidden" name="amount" value="${pages.cri.amount }">
		<input type="hidden" name="type" value='<c:out value="${pages.cri.type }" />'>
		<input type="hidden" name="keyword" value='<c:out value="${pages.cri.keyword }" />'>
	</form>
    <%@include file="../includes/footer.jsp" %>
</body>
<script type="text/javascript">
	$(document).ready(function () {
		
		$(".modalCloseBtn").on("click", function(e) {
			$(".modal").css("display","none");
		});
		$(".ticketCancelPre").on("click", function(e) {
			var idx = e.currentTarget.getAttribute("data-oper");
			var status = e.currentTarget.getAttribute("data-status");
			$(".modal").css("display","none");
			if(status == '취소가능'){
				$("#secondModal"+idx).css("display","flex");
			}
			else{
				alert("출발일이 오늘이거나 과거인 경우 취소가 불가능합니다.");
			}
			
		});
		var pageMove = $("#pageMove");
		
		$(".pageInfo a").on("click", function (e) {
			e.preventDefault();
			pageMove.find("input[name='pageNum']").val($(this).attr("href"));
			pageMove.submit();
		}); //pageInfo  클래스 안의 a태그를 누르면 작동하는 함수

		$("td[data-oper]").on("click",function(e){
			var idx = e.currentTarget.getAttribute("data-oper");
			$("#modal"+idx).css("display","flex");
		});
		
		$(".ticketCancelFinal").on("click",function(e){
			var idx = e.currentTarget.getAttribute("data-oper");
			var rno = $("#rno"+idx).text();
			var snum =$("#rno"+idx).attr("data-oper");
			$.ajax({
				method: 'DELETE',
				url : '/ticket/cancelTicket/'+rno+'/'+snum,
				success: function(data){
					alert("예매가 취소되었습니다.");
					self.location = '/ticket/bookinglist';
				}
			});
			$(".modal").css("display","none");
		});
	});
</script>
</html>