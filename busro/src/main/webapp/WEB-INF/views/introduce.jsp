<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=71453e83317584fa499664add405c9e3"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.min.js"></script>
<head>
<meta charset="UTF-8">
<title>Welcome busro</title>
<%@include file="./includes/userHeader.jsp" %>
<link rel="stylesheet" href="/resources/css/common.css">
<link rel="stylesheet" href="/resources/css/introduce.css">
</head>
<body>
<div class="gallary_area"></div>
<div class="wrapper">
	<div class="contentWrap">	
		<div class="content_area">
			<div class="top_area">
				<img class="introduceImg" src="/resources/img/guide.png">		
			</div>
		</div>
	</div>
</div>
<%@include file="./includes/footer.jsp" %>
</body>
</html>