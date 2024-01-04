<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../includes/adminHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style type="text/css">
	a {
		text-decoration: none;
	}
.coloring{color: #ff3366 !important;}

</style>

<title>1:1 답변</title>
</head>
<body>
<div id="contentWrap">
	<div class="wrap">
		<div class="adTitle"><span>1:1 문의 내역</span> </div>
		
		<!-- 검색 -->
		<div class="searchArea" >
		<form action="/admin/adminInquirylist" id="actionForm" method="get">
			<span> 
				<select name="type">
					<option>전체</option>
					<option value="C">답변대기중</option>
					<option value="R" >답변완료</option>
				</select>
	
			</span>
			
			<button class="btnBtn" type="submit" id="finding">검색</button>	
			<input type="hidden" name="pageNum" value="${pages.cri.pageNum }">
	        <input type="hidden" name="amount" value="${pages.cri.amount }">
	        <input type="hidden" name="keyword" value="${pages.cri.amount }">
	        
	       
		</form>
	</div> <!-- 검색 전체 div -->
	<div style="margin-right: 100px; width: 97%; background-color: white; border-radius: 4px;">	
		<table>
			<thead>
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>작성자</th>
					<th>이름</th>
					<th>작성일</th>
					<th>상태</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${ilist}" var="qu">
					<tr>
						<td><div class="ino">${qu.ino}</div> </td>
						<td style="text-align: left;">
							<a class="viewInquiry" href='<c:out value="${qu.ino}" />'>
							[${qu.category}]	${qu.title}
							</a>
						</td>
						<td>${qu.writer}</td>
						<td>${qu.name }</td>
						<td><fmt:formatDate value="${qu.regdate}" pattern="yy.MM.dd"/> </td>
						<td class="status">
						<c:if test="${qu.ano ne null}">답변완료</c:if>
						<c:if test="${qu.ano eq null }">답변 대기중</c:if>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>	
		
		
			<!-- 페이징  -->
				
				<div class="paging_region">
					<div class="pagePrev"> 
						<c:if test="${pages.prev }">
							<span class="pageInfo"> 
									<a href="${pages.startPage -1 }">&lt;Prev</a> 
							</span>
						 </c:if>
					</div>
					<div class="pageNum"> 
						 <c:forEach begin="${pages.startPage}" end="${pages.endPage}" var="num">
						 	<span class="pageInfo nu">
						 		<a href="${num}">${num}</a>
						 	</span>
						 </c:forEach>
					</div>
					<div class="pageNext"> 
						 <c:if test="${pages.next }">
							<span class="pageInfo">
								<a href="${pages.endPage +1 }">Next&gt;</a> 
							</span>
						 </c:if>
					</div> 
					
				</div>
				<form method="get" id="pageMove" action="/admin/adminInquirylist">
					<input type="hidden" name="pageNum" value="${pages.cri.pageNum }">
					<input type="hidden" name="amount" value="${pages.cri.amount }">
					<input type="hidden" name="type" value='<c:out value="${pages.cri.type }" />'>
					<input type="hidden" name="keyword" value='<c:out value="${pages.cri.keyword }" />'>
				</form>
				
				
				<!-- 페이징 끝 -->	
		
	</div>
</div>
</body>

<script type="text/javascript">


	
	$(document).ready(function () {
			
		var actionForm = $("#actionForm");
		
		var query = window.location.search; //전체 url 가져옴
		
		var param = new URLSearchParams(query); //전체 url의 파라미터 가져오기
		
		var pageNumber = param.get('pageNum'); //현재 페이지 넘버만 추출
		
		console.log(pageNumber);
		
		var readypage = document.querySelectorAll("span a"); 
		
		for(var m = 0; m < readypage.length; m++){
			console.log(readypage[m].innerText);
			if(pageNumber == readypage[m].innerText){
				console.log(readypage[m]); //태그 자체가 찍힘
				$(".pageInfo a").eq(m).addClass("coloring");
				/* readypage[m].classList.add("coloring"); */ //클래스 추가해주기
				console.log(readypage[m]);
			}else{
				$(".pageInfo a").eq(m).removeClass("coloring"); //클래스 제거해주기
				/* $(".pageInfo a:eq(m)") : for문에서는 불가능한 구문으로 위와 동일하게 사용하기 */
				/* $(".pageInfo a:eq(1)") : 사용 가능 */
			}
		}
		
		
		//문의 상세뷰 페이지 이동
		$(".viewInquiry").on("click", function (e) {
			
			e.preventDefault();
			console.log("클릭 간다");
			
			actionForm.append("<input type='hidden' name='ino' value='"+$(this).attr("href")+"'>");
			actionForm.attr("action", "/admin/adminInquirydetails"); /* 괄호 안의 action: form 태그의 action */
			actionForm.submit();
		});
		
		
		var pageMove = $("#pageMove");
		
		$(".pageInfo a").on("click", function (e) {
			
			e.preventDefault();
			
			console.log("클릭되었다.");
			
			pageMove.find("input[name='pageNum']").val($(this).attr("href"));
			
			pageMove.submit();
			
			
		}); //pageInfo  클래스 안의 a태그를 누르면 작동하는 함수
		
		var ino = [];
		//var []jno;
		
		var aa = document.querySelectorAll('.ino');

		for (var i = 0; i < aa.length; i++) {
			
			ino.push(aa[i].textContent);
			
			//var aa[i].textContent = ino;
			
			//console.log(aa[i].textContent);
			
		}
		
		console.log(ino);
		console.log("로딩");
		
		
		
		/*  $.getJSON("/status/" + ino1 + ".json", 
		 		function(data) {
					console.log(data);
		 		}).fail(function(xhr, status, err){

		 			console.log(err);		 		
		 		});  */
		 	
		
		//console.log(ino);
		
		console.log("시작");
		
			
		
				   
		
			
		
	}); //ready
	
	
	
		
	
	
</script>
</html>