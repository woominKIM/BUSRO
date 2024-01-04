<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../includes/userHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>나의 문의 내역</title>
<link rel="stylesheet" href="/resources/css/userQu.css">
</head>
<body>
	
	<div id="contentWrap">
		<div class="quTitle"><span>1:1 문의 내역</span> </div>
		
		<div class="quWrap">
			<div class="letsMove"><button type="button" onclick="location.href='/personalAsk/ihaveAQ'">글쓰기</button></div>
			
			<div class="tableWrap">
					<table>
						<thead>
							<tr>
								<td>번호</td>
								<td>제목</td>
								<td>등록일</td>
								<td>상태</td>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${ilist}" var="qu">
								<tr>
									<td><div class="ino">${qu.ino}</div></td>
									<td style="text-align: left;">
										<a class="viewInquiry" href='<c:out value="${qu.ino}" />'>
										[${qu.category}]	${qu.title}
										</a>
										</td>
									<td><fmt:formatDate value="${qu.regdate}" pattern="yy.MM.dd"/></td>
									<td class="status">
									<c:if test="${qu.tf eq 1}">답변완료</c:if>
									<c:if test="${qu.tf eq 0 }">답변 대기중</c:if>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>	
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
		 
			<form method="get" id="pageMove" action="/personalAsk/myPageInquiryList">
				<input type="hidden" name="pageNum" value="${pages.cri.pageNum }">
				<input type="hidden" name="amount" value="${pages.cri.amount }">
				<input type="hidden" name="type" value='<c:out value="${pages.cri.type }" />'>
				<input type="hidden" name="keyword" value='<c:out value="${pages.cri.keyword }" />'>
			</form>
			
			
		<!-- 페이징 끝 -->	
		
		<form action="/personalAsk/myPageInquiryList" id="actionForm" method="get">
			<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
	        <input type="hidden" name="amount" value="${pageMaker.cri.amount }">
	        <input type="hidden" name="type" value='<c:out value="${pageMaker.cri.type }" />'>
	        <input type="hidden" name="keyword" value='<c:out value="${pageMaker.cri.keyword }" />'>
		</form>
<%@ include file="../includes/footer.jsp" %>
</body>


<script type="text/javascript">

	$(document).ready(function () {
		
		var actionForm = $("#actionForm");
		
		//문의 상세뷰 페이지 이동
		$(".viewInquiry").on("click", function (e) {
			
			e.preventDefault();
			console.log("클릭 간다");
			
			actionForm.append("<input type='hidden' name='ino' value='"+$(this).attr("href")+"'>");
			actionForm.attr("action", "/personalAsk/myPageInquiryDetail"); /* 괄호 안의 action: form 태그의 action */
			actionForm.submit();
		});
		
		
		var pageMove = $("#pageMove");
		
		$(".pageInfo a").on("click", function (e) {
			
			e.preventDefault();
			
			console.log("클릭되었다.");
			
			pageMove.find("input[name='pageNum']").val($(this).attr("href"));
			
			pageMove.submit();
			
			
		}); //pageInfo  클래스 안의 a태그를 누르면 작동하는 함수
		
		
		
		
	}); //ready


</script>

</html>