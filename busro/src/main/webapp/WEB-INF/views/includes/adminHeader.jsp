<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
.dropdown {
	position: relative;
	display: block;
	
}

.dropdown-content a {
	/* font-size: 17px; */
	color: #050540;
	font-weight: bold;
	display: inline-block;
	white-space: nowrap;
	margin: 5px 0;

}

.dropdown-content {
	display: none;
	position: absolute;
	z-index: 1; /*다른 요소들보다 앞에 배치*/
	font-weight: 400;
	background-color: #f9f9f9;
	min-width: 120px;
	

}

.dropdown:hover .dropdown-content {
	display: block;
}

</style>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/resources/css/admin/adminMain.css">
</head>
<body>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>	

<div id="headerWrap">
	<div id="header">
	     <div id="logo">
	          <a href="/main">버스로</a>
	      </div>
	      <div id="gnb">
		      <ul>
		      	<li><a class="navTop"  href="/member/list">회원 관리</a></li>
				<li><a class="navTop" href="/admin/routeschedulelist">버스 노선 관리</a></li>
				<li><a class="navTop" href="/ticket/bookingmanagelist">예매 관리</a></li>
				<li>
					<div class="dropdown">
						<span class="navTop" class="dropbtn">게시판 관리</span>
						<div class="dropdown-pointing"></div>
						<div class="dropdown-content">
							<a id="navDrop" href="/jobAds/wishList">공지사항</a><br>
							<a id="navDrop" href="/daetaFooter/adminFAQ">자주 묻는 질문</a>
						</div>
					</div>
				</li>
				<li><a class="navTop" href="/admin/adminInquirylist">1:1 답변</a></li>
				
				
				<!-- 로그인한 상태 -->
				<c:if test="${ member != null }">
					<!-- <div class="login_success_area"> -->
						<c:if test="${member.auth eq 'ADMIN'}">            		                        		
							<li><a class="navTop">관리자 ${member.name}님</a></li>								
						</c:if>
						<li style="color: black;"><a class="navTop" href="/member/myPage.do">마이페이지</a></li>
						<li style="color: black;"><a class="navTop" href="/member/logout.do">로그아웃</a></li>                  	          
				<!-- 	</div> -->
				</c:if>	
		      </ul>          
		</div>
	</div>
</div>
 	
</body>
</html>