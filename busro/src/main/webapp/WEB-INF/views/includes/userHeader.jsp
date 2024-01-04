<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="icon" href="/resources/img/favicon.ico" type="image/x-icon">
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/css/userHeader.css">
</head>
<body>
	<div id="headerWrap">
        <div id="header">
            <div id="logo">
                <a href="/main">버스로</a>
            </div>
            <div id="gnb">
                <ul>
                    <li><a class="navTop" href="/introduce">이용 가이드</a></li>
					<li><a class="navTop"  href="/ticket/bookinglist">예매 조회/취소</a></li>
					<li><a class="navTop" href="/jobAds/wishListShow">공지사항</a></li>
					<li>
						<div class="dropdown">
							<span class="navTop" class="dropbtn">고객센터</span>
							<div class="dropdown-pointing"></div>
							<div class="dropdown-content">
								<a id="navDrop" href="/daetaFooter/oftenFAQ">자주 묻는 질문</a><br>
								<a id="navDrop" href="/personalAsk/myPageInquiryList">1:1 문의</a>
							</div>
						</div>
					</li>
					
					<!-- 로그인 하지 않은 상태 -->
					<c:if test = "${member == null }">
						<li><a class="navTop" href="/member/login">로그인</a></li>
						<li><a class="navTop" href="/member/beforeJoin">회원가입</a></li>                
					</c:if>
					
					<!-- 로그인한 상태 -->
					<c:if test="${ member != null }">
						<!-- <div class="login_success_area"> -->
							<c:if test="${member.auth eq 'ADMIN'}">            		                        		
								<li><a class="navTop" href="/member/list">관리자기능</a></li>
								<li><a class="navTop">${member.name}님</a></li>								
							</c:if>
					
							<c:if test="${member.auth eq 'USER'}">                    
								<li><a class="navTop">${member.name}님</a></li>
							</c:if>    
							<li style="color: black;"><a class="navTop" href="/member/myPage.do">마이페이지</a></li>
							<li style="color: black;"><a class="navTop" href="/member/logout.do">로그아웃</a></li>                  	          
					<!-- 	</div> -->
					</c:if>					
                </ul>
            </div>
        </div>
    </div>
	
		
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.min.js"></script>
</body>
</html>