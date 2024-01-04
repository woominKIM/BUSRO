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
<title>관리자 홈</title>
<link rel="stylesheet" href="/resources/css/admin/adminMain.css">

</head>
<body>
<div id="headerWrap">
	<div id="header">
		<div id="logo">
        	<a href="/main">버스로</a>
        </div>
        <div id="gnb">
		<div class="manage">
		<c:if test="${ member != null }">
	    	<div class="login_success_area">
	                                  
	           <c:if test="${member.auth eq 'ADMIN'}">
	              
	              <a class="alinks" href="/main">HOME</a>
	              <a class="alinks" href="/member/myPage.do">마이페이지</a> 
	              <a class="alinks" href="/member/logout.do">로그아웃</a>
	                        		
	            </c:if>          
	         </div>
	    </c:if>
		<p />
		<br>
		</div>
		<div class="totalWrap">
		
		
		<p />
		<br>
		 <c:if test="${ member != null }">
		 
		 	<div class="welcome_area">
		 		<span>관리자</span> <br>
		 		<span>${member.name}님</span> <br><br>
		 		<span>환영합니다.</span>
		 	</div>
		 </c:if>
		            		
	      <div id="alinks">
	      
			<div><a href="/member/list" style="width: 120px;" ><span>회원 관리 </span> </a>  </div>
			<div><a href="/busro/routeschedulelist" style="width: 200px;"><span>버스 노선 관리</span></a></div>
			<div><a href="/ticket/bookingmanagelist" >예매 관리</a></div>
			<div class="dropdown"><span>게시판 관리</span>
				<div class="dropdown-content">
					<div><a href="/jobAds/wishList" >공지사항</a></div>
					<div><a href="/daetaFooter/adminFAQ">자주 묻는 질문</a></div>
				</div>
			</div>
			
			<div><a class="alinks" href="/busro/adminInquirylist" >1:1 답변 </a></div>
			</div>               
	    		<div id="blankWhite" />            
			</div>
		</div>
	</div>
</div>
</body>
</html>