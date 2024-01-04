<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@include file="../includes/adminHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<title>Insert title here</title>
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
<style type="text/css">

/*  .noticenum{
	text-align: center;
}
a{
	text-decoration-line: none;
	color: black;
}
a:hover{
	font-weight: bold;
}

table {

	
	width:90%;
}
.thead1{
	width: 15%;
}

input{
	border-radius: 4px;
	border-width: 1px; 
}

body {
	min-width:530px;
	max-width: 1730px;
}
 */
#searchForm {

	text-align: center;
	padding-top: 80px;
	padding-bottom: 40px;

} 

.material-symbols-outlined {

	color: #EF3340;
  
}

ul {
    list-style:none;
    }

li {   
    float: left;
	} 
	
.noticeTit{

text-align: left;
}


.pagination{

	padding: 0px 0 5px 10px;
	display: table;
  	margin-left: auto;
 	margin-right: auto;
  	text-align: center;

}

</style>
</head>
<body>
<div id="contentWrap">
	<div class="wrap">
		<div class="adTitle"><span>공지사항</span> </div>
		<div class="middleSw">	
		<!-- <h1 class="page-header">관리자 페이지</h1> -->

		<div class="searchArea" >
			<form id="searchForm" action="/jobAds/wishList" method="get">
				<select name='type'>
					<option value="T" <c:out value="${pageMaker.cri.type eq 'T'?'selected':''}"/>>제목</option> 
					<option value="C" <c:out value="${pageMaker.cri.type eq 'C'?'selected':''}"/>>내용</option>  
					<option value="TC" <c:out value="${pageMaker.cri.type eq 'TC'?'selected':''}"/>>제목 or 내용</option>  
				</select>
				
				<input type="text" name="keyword" value='<c:out value="${pageMaker.cri.keyword}"/>'/>
				<input type="hidden" name="pageNum" value='<c:out value="${pageMaker.cri.pageNum}"/>'/> 
				<input type="hidden" name="amount" value='<c:out value="${pageMaker.cri.amount}"/>'/>			
				<button class="btnBtn">검색</button>
			</form>
		</div>
	
		<div>
			<button id="regBtn" onclick="location.href='/jobAds/wishRegister'" type="button">등록</button>
		</div>		
		
<div style="margin-right: 100px; width: 97%; background-color: white; border-radius: 4px;">		
<table>
	<thead>
		
		<tr>
			
			<th>번호</th>
			<th>제목</th>
			<th>등록일</th>
		</tr>
	</thead>
	
	
	<c:forEach items="${toplist}" var="toplist">
	
	<tr>
		<th><span class="material-symbols-outlined">notifications</span></th>
		<td class="noticeTit"> 
				<a class="move" href='<c:out value="${toplist.nno}"/>'>
					<c:out value="${toplist.title}"/>
				</a>
		</td>
		<td class="noticereg">
			<fmt:formatDate pattern="yyyy-MM-dd" value="${toplist.regdate}"/>
		</td>
	</tr>
	
	
	</c:forEach>
	
	
	
	<c:forEach items="${list}" var="notice">
		<tr>
			<td class="noticenum">
				<c:out value="${notice.nno}" />
			</td>
			<td style="text-align: left;">
				<a class="move" href='<c:out value="${notice.nno}"/>'>
					<c:out value="${notice.title}"/>
				</a>
			</td>
			<td><fmt:formatDate pattern="yyyy-MM-dd" value="${notice.regdate}"/></td>
		</tr>
	</c:forEach>
	
</table> <!-- table태그의 끝 -->
</div>		

<div class="paging_region">
		
		<ul class="pagination">
		
			<c:if test="${pageMaker.prev}">
				<li class="paginate_button previous">
					<a class="pagePrev2" href="${pageMaker.startPage -1}">&lt;Prev</a>
				</li>
			</c:if>
			
			<c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
			<li class="paginate_button pageInfo ${pageMaker.cri.pageNum == num ? 'active':''}">
				<span class="pageInfo ">
					<a  href="${num}" style=" text-decoration-line: none;"> &nbsp;&nbsp; ${num} &nbsp;&nbsp; </a>
				</span>
			</li>
			</c:forEach>
			
			<c:if test="${pageMaker.next}">
				<li class="paginate_button next">
					<a  class="pageNext2" href="${pageMaker.endPage +1 }">Next&gt;</a>
				</li>
			</c:if>
		</ul>
	
	<!-- end Pagination -->
	
	
	<form id="actionForm" action="/jobAds/wishList" method="get">
		<input type="hidden" name="pageNum" value= '${pageMaker.cri.pageNum}'>
		<input type="hidden" name="amount" value= '${pageMaker.cri.amount}'>
	</form>
</div> <!-- 페이징 -->
</div><!-- middleSw -->
</div>
</div>
	
	<script type="text/javascript">
		$(document).ready(function() {
			
		
			var actionForm = $("#actionForm");
			
			$(".paginate_button a").on("click", function(e) {
				
				var formData1 = $("input[name='pageNum']");
				var formData2 = $("input[name = 'amount']");
				
				e.preventDefault();
				actionForm.empty();
				
				console.log('click');
				
				actionForm.attr("action", "/jobAds/wishList");
				actionForm.append(formData1);
				actionForm.append(formData2);
				actionForm.find("input[name='pageNum']").val($(this).attr("href"));
				actionForm.submit();
				
			});
			
			$(".move").on("click", function(e){
				
				e.preventDefault();
				actionForm.empty();
				actionForm.append("<input type='hidden' name='nno' value='"+$(this).attr("href")+"'>");
				actionForm.attr("action", "/jobAds/wishGet");
				actionForm.submit();
				
			});
			
			
			var searchForm = $("#searchForm");
			
			$("#searchForm button").on("click", function(e) {
				
			
				
				if(!searchForm.find("input[name='keyword']").val()){
					alert("키워드를 입력하세요");
					return false;
				}
				
				searchForm.find("input[name='pageNum']").val("1");
				e.preventDefault();
				
				searchForm.submit();
				
			});
			
		});
	</script>


</body>
</html>