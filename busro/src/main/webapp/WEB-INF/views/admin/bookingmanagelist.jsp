<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="../includes/adminHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">

	
	#totalModal{
		position: absolute;
		z-index: 3;
	}
	
	
	
</style>


<meta charset="UTF-8">
<title>버스 예약건 관리</title>
<link rel="stylesheet" href="/resources/css/routeAndbooking.css">
</head>
<body>
<div id="contentWrap">

	<!-- 검색 -->
	
		<div class="adTitle"><span>예매 관리</span> </div>
		<div class="middleSw">
		<div class="searchArea wrap" >
			<select id="searchKeyword">
				<option value="rno" selected>--예매번호--</option>
				<option value="id">--아이디--</option>
				<option value="name">--회원이름--</option>
				<option value="tdate">--예매일--</option>
				<option value="ddate">--출발지--</option>
			</select>	
			<input placeholder="예)왕복 예매건을 검색하려면 'R' 입력" name="keywordClone" style="width:300px;"/>
			<button id="goSearch" class="btnBtn">검색</button>
		</div>
	
	<div style="margin-right: 100px; width: 97%; background-color: white; border-radius: 4px;">
		<table id="sortList" >
			<thead>
				<tr>
					<th style="width: 60px;">관리번호</th>
					<th>예매번호</th>
					<th>아이디</th>
					<th>예매일</th>
					<th>출발일</th>
					<th>출발지</th>
					<th>도착지</th>
					<th>출발시간</th>
					<th>좌석번호</th>
					<th>결제구분</th>
				</tr>
			</thead>
	        <tbody>
	        	<c:forEach items="${ticketList}" var="ticket">
	        		<tr>
	        			<td>
		        			<div  class="numf"> <c:out value="${ticket.mnum}"/> </div>
		        			<div class="tri">
		        				<a id="tri2" type="button" onclick="openGetInfoModal(${ticket.mnum})" class="modal" data-oper="modalshow" data-toggle="modal" data-target="#getInfo"></a>
		        			</div>	
	        				<!-- 예약상세정보 모달창 -->
	        				<div id="totalModal">
								<div class="getInfo2" id="modal${ticket.mnum}">
									<div class="modal-content" role="document">
									<button data-oper="close" id="initX" class="modalCloseBtn">X</button>
											<div class="modal-header">
												예매정보 상세
											</div>
											<hr class="hrLine">
											<div class="m_body">
											
												<div class="row4">
							                        <div>
							                            <label>예매번호</label>
							                            <input class="input_box" type="text" value="${ticket.rno}" readonly="readonly"/>
							                        </div>
							                        <div>
							                            <label style="padding-right: 174px;">이름</label>
							                            <input class="input_box" type="text" value="${ticket.name}" readonly="readonly"/>
							                        </div>
							                        <div>
							                            <label style="padding-right: 162px;">출발지</label>
							                            <input class="input_box" type="text" value="${ticket.departure}" readonly="readonly"/>
							                        </div>
							                        <div>
							                            <label>좌석번호</label>
							                            <input class="input_box" type="text" value="${ticket.seatnum}" readonly="readonly"/>
							                        </div>
							                        <div>
							                            <label>출발시간</label>
							                            <input class="input_box" type="text" value="${fn:substring(ticket.st,0,2)}시 ${fn:substring(ticket.st,3,5)}분" readonly="readonly"/>
							                        </div>
							                        <div>
							                            <label>결제금액</label>
							                            <input class="input_box" type="text" value="${ticket.realprice}" readonly="readonly"/>
							                        </div>
							                    </div> <!-- row4 -->
							                    
							                    <div class="row5">
							                        <div>
							                            <label style="padding-right: 162px;">아이디</label>
							                            <input class="input_box" type="text" value="${ticket.id}" readonly="readonly"/>
							                        </div>
							                        
							                        <div>
							                            <label>전화번호</label>
							                            <input class="input_box" type="text" value="${ticket.tel}" readonly="readonly"/>
							                        </div>
							                        <div>
							                            <label style="padding-right: 162px;">도착지</label>
							                            <input class="input_box" type="text" value="${ticket.arrival}" readonly="readonly"/>
							                        </div>
							
							                        <div>
							                            <label >결제구분</label>
							                            <input type="text" class="input_box" value="결제완료" readonly="readonly" />
							                        </div>
							
							                        <div>
							                            <label style="padding-right: 162px;">출발일</label>
							                            <input class="input_box" type="text" value="${fn:substring(ticket.ddate,0,4)}년 ${fn:substring(ticket.ddate,5,7)}월 ${fn:substring(ticket.ddate,8,10)}일" readonly="readonly"/>
							                        </div>
							
							                        <div>
							                            <label >결제일시</label>
							                            <input class="input_box" type="text" value="${fn:substring(ticket.tdate,0,4)}년 ${fn:substring(ticket.tdate,5,7)}월 ${fn:substring(ticket.tdate,8,10)}일 ${fn:substring(ticket.tdate,11,19)}" readonly="readonly"/>
							                        </div>
							
							                    </div><!-- row5 -->
                    
                    
											</div> <!-- m_body -->
											<!-- 모달 풋터 -->
											
										<hr class="hrUnderLine2">
										
										<div class="modal-footer">
											<button data-oper="close" class="modalCloseBtn hanX2">닫기</button>
										</div>		
									</div>
								</div>
							</div>
	        			</td>
	        			<td><c:out value="${ticket.rno}"/></td>
	        			<td><c:out value="${ticket.id}"/> </td>
	        			<td><c:out value="${fn:substring(ticket.tdate,0,10)}"/> </td>
	        			<td><c:out value="${fn:substring(ticket.ddate,0,10)}"/></td>
	        			<td><c:out value="${ticket.departure}"/></td>
	        			<td><c:out value="${ticket.arrival}"/></td>
	        			<td><c:out value="${ticket.st}"/> </td>
	        			<td><c:out value="${ticket.seatnum}"/> </td>
	        			<td>결제완료</td>
	        		</tr>
	        		
	        	</c:forEach>
	        </tbody>                     
	                              
		</table>
	
	</div>
	
	
	
	<!-- 페이징  -->
	
	<div class="paging_region">
		
			<c:if test="${pages.prev }">
				<span class="pageInfo"> 
						<a href="${pages.startPage -1 }">&lt;Prev</a> 
				</span>
			 </c:if>
			 
			 <c:forEach begin="${pages.startPage}" end="${pages.endPage}" var="num">
			 	<span class="pageInfo nu">
				 	<c:if test="${num eq pages.cri.pageNum }">
				 		<a style="color: #ff3366;" href="${num}">${num}</a>
				 	</c:if>	
				 	<c:if test="${num ne pages.cri.pageNum }">
				 		<a href="${num}">${num}</a>
				 	</c:if>	
			 	</span>
			 </c:forEach>
			 <c:if test="${pages.next }">
				<span class="pageInfo">
					<a href="${pages.endPage +1 }">Next&gt;</a> 
				</span>
			 </c:if>
			 
		
	</div>
	<form method="get" id="pageMove" action="/ticket/bookingmanagelist">
		<input type="hidden" name="pageNum" value="${pages.cri.pageNum }">
		<input type="hidden" name="amount" value="${pages.cri.amount }">
		<input type="hidden" name="type" value='<c:out value="${pages.cri.type }" />'>
		<input type="hidden" name="keyword" value='<c:out value="${pages.cri.keyword }" />'>
	</form>
	
	
	<!-- 페이징 끝 -->
	</div><!-- middleSw -->

</div>	

	<script type="text/javascript">
	
		$(document).ready(function () {
			
			$(".getInfo2").hide(); 
			
			
			$(".modalCloseBtn").on("click", function (e) {
				$(".getInfo2").hide();
			});
			
			var pageMove = $("#pageMove");
			
			$(".pageInfo a").on("click", function (e) {
				
				e.preventDefault();
				
				pageMove.find("input[name='pageNum']").val($(this).attr("href"));
				
				pageMove.submit();
				
				
			}); //pageInfo  클래스 안의 a태그를 누르면 작동하는 함수
			
			
			
		}); // document ready 함수
		
		
		function openGetInfoModal(a) {
			console.log("진입");
			console.log(a);
			
			var snum = a;
			
			
			//document.getElementById("sno").value = snum;
			$(".getInfo2").hide(); 
			$("#modal"+a).show();
			
		
			/* $(".modal-content").load("/busro/routescheduleget?snum=" + a); */
			
		} //모달 오픈
		
		$("#searchKeyword").on("change",function(){
			var condition = $("#searchKeyword option:selected").val();
			switch(condition){
			case "rno":
				$("input[name='keywordClone']").attr('placeholder','예)왕복 예매건을 검색하려면 \'R\' 입력');
				break;
			case "id":
				$("input[name='keywordClone']").attr('placeholder','아이디로 예매건 검색');
				break;
			case "name":
				$("input[name='keywordClone']").attr('placeholder','계정 이름으로 예매건 검색');
				break;
			case "tdate":
				$("input[name='keywordClone']").attr('placeholder','예) 24일 예매건 검색하려면 \'24일\' 입력');
				break;
			case "ddate":
				$("input[name='keywordClone']").attr('placeholder','출발지로 예매건 검색');
				break;
			default:
				$("input[name='keywordClone']").attr('placeholder','예)왕복 예매건을 검색하려면 R 입력');
				break;
		}
		});
		$("#goSearch").on("click",function(){
			var formObj = $("form");
			var keyword = $("input[name='keywordClone']").val();
			if(keyword != ""){
				var condition = $("#searchKeyword option:selected").val();
				switch(condition){
					case "rno":
						$("input[name='type']").attr('value','R');
						break;
					case "id":
						$("input[name='type']").attr('value','I');
						break;
					case "name":
						$("input[name='type']").attr('value','N');
						break;
					case "tdate":
						$("input[name='type']").attr('value','T');
						break;
					case "ddate":
						$("input[name='type']").attr('value','D');
						break;
					default:
						$("input[name='type']").attr('value','R');
						break;
				}
				$("input[name='keyword']").attr('value',keyword);
				formObj.submit();
			}else{
				alert("키워드를 입력 후 검색해주세요");
			}
		});
	</script>
</body>
</html>