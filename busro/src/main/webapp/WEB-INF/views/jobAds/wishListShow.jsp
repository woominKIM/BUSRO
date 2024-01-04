<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@include file="../includes/userHeader.jsp"%>



<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<title>Insert title here</title>
<link rel="stylesheet" href="/resources/css/common.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
<style type="text/css">

*{
	color: #050540;
	font-family: "roboto","Noto Sans KR",sans-serif;
    font-size: 15px;
    
}


.page-header{

	font-size: 40px;
	
}



a{
	text-decoration-line: none;
	color: #050540;
}
a:hover{
	font-weight: bold;
}

.noticeTable{
	
	margin-left:auto;
	margin-right:auto;
	width: 1080px;
	border-radius: 10px;
	border: 1px solid #050540;
	
}
   



table {
	
  	border-collapse : collapse;
  	width: 100%;
  	border-style: hidden;
  	
  	
	
}

th, td {
  border: 1px solid #050540;
  padding: 10px;
  text-align: center;
}



.thead1{
	width: 15%;
}


.thead2{
	width: 40%;
}




#searchForm {

	text-align: center;
	padding-top: 80px;
	padding-bottom: 40px;



}



input{
	
	margin-right: 20px;
	padding-bottom: 9px;
	width: 340px;
	appearance:none;
	border-left-width:0;
	border-right-width:0;
	border-top-width:0;
	border-bottom: 1px solid #050540;
	
}

input:focus {
	
	writing-mode: horizontal-tb !important;
	border-bottom: 2px solid #050540;
	
	
}

*:focus{
	
	outline: 0;
}

select{

	appearance: auto;

}

.choose{
	
	margin-right: 20px;
	padding-bottom: 9px;
	border-left-width:0;
	border-right-width:0;
	border-top-width:0;
	text-align: center;
	width: 120px;
	border-bottom: 1px solid #050540;
	

}

.choose:focus {
	
	border-bottom: 2px solid #050540;
	
}

.btnsearch{

	background-color: #050540;
	color: white;
	border-radius: 8px;
	border-width: 0;
	padding: 6px 20px 9px 20px;
}

body {
	min-width:1080px;
	
}


.material-symbols-outlined {

	color: #EF3340;
  
}



.pagination{

	padding: 60px 0 5px 10px;
	display: table;
  	margin-left: auto;
 	margin-right: auto;
  	text-align: center;

}

.pagination a.active{
	
	color: #050540;

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



</style>
</head>
<body>

		<h1 class="page-header" style="text-align: center; padding-top: 30px; padding-bottom: 10px;">공지사항</h1>
		
		
		<form id="searchForm" action="/jobAds/wishListShow" method="get">
			<select class="choose" name='type' >
				<option value="T" <c:out value="${pageMaker.cri.type eq 'T'?'selected':''}"/>>제목</option> 
				<option value="C" <c:out value="${pageMaker.cri.type eq 'C'?'selected':''}"/>>내용</option>  
				<option value="TC" <c:out value="${pageMaker.cri.type eq 'TC'?'selected':''}"/>>제목 or 내용</option>  
			</select>
			
			<input type="text" name="keyword" value='<c:out value="${pageMaker.cri.keyword}"/>'/>
			<input type="hidden" name="pageNum" value='<c:out value="${pageMaker.cri.pageNum}"/>'/> 
			<input type="hidden" name="amount" value='<c:out value="${pageMaker.cri.amount}"/>'/>			
			<button class="btnsearch">검색</button>
		</form>

<div class="noticeTable">	
		
	<table>
		<thead>
			
			<tr>
				<th class="thead1" style="width: 150px;">번호</th>
				<th class="thead2" style="width: 700px;">제목</th>
				<th class="thead3" style="width: 300px;">등록일</th>
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
				<td class="noticeTit">
					<a class="move" href='<c:out value="${notice.nno}"/>'>
						<c:out value="${notice.title}"/>
					</a>
				</td>
				<td class="noticereg"><fmt:formatDate pattern="yyyy-MM-dd" value="${notice.regdate}"/></td>
			</tr>
		</c:forEach>
		
	</table>

</div>	
<!-- table태그의 끝 -->	

		<ul class="pagination">
		
			<c:if test="${pageMaker.prev}">
				<li class="paginate_button previous">
					<a href="${pageMaker.startPage -1}">&lt;Prev</a>
				</li>
			</c:if>
		
			
			<c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
			<li class="paginate_button ${pageMaker.cri.pageNum == num ? 'active':''}">
				<a href="${num}" style=" text-decoration-line: none;"> &nbsp;&nbsp; ${num} &nbsp;&nbsp; </a>
			</li>
			</c:forEach>
			
			<c:if test="${pageMaker.next}">
				<li class="paginate_button next">
					<a href="${pageMaker.endPage +1 }">Next&gt;</a>
				</li>
			</c:if>
		</ul>
	<!-- end Pagination -->
	
	
	<form id="actionForm" action="/jobAds/wishListShow" method="get">
		<input type="hidden" name="pageNum" value= '${pageMaker.cri.pageNum}'>
		<input type="hidden" name="amount" value= '${pageMaker.cri.amount}'>
	</form>
	
	<script type="text/javascript">
		$(document).ready(function() {
			
		
			var actionForm = $("#actionForm");
			
			$(".paginate_button a").on("click", function(e) {
				
				var formData1 = $("input[name='pageNum']");
				var formData2 = $("input[name='amount']");
				
				e.preventDefault();
				actionForm.empty();
				
				console.log('click');
				
				actionForm.attr("action", "/jobAds/wishListShow");
				actionForm.append(formData1);
				actionForm.append(formData2);
				actionForm.find("input[name='pageNum']").val($(this).attr("href"));
				actionForm.submit();
				
			});
			
			$(".move").on("click", function(e){
				
				e.preventDefault();
				actionForm.empty();
				actionForm.append("<input type='hidden' name='nno' value='"+$(this).attr("href")+"'>");
				actionForm.attr("action", "/jobAds/wishGetShow");
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