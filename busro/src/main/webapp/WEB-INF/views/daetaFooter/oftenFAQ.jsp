<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	 <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<title>버스로 FAQ</title>
	<%@include file="../includes/userHeader.jsp"%>
	<link rel="stylesheet" href="/resources/css/common.css">
	<link rel="stylesheet" href="/resources/css/oftenFAQ.css">
</head>
<body>
	<div id="contentWrap">
		<div class="faqTitle underscore60"><span>자주 묻는 질문</span></div>
		<div class="searchArea">
			<div class="searchBtnArea">
				<button class="btnBtn" id="allSearch">전체</button>
				<button class="btnBtn" id="reserve">예매</button> 
				<button class="btnBtn" id="account">결제/환불</button>
				<button class="btnBtn" id="system">시스템</button>
				<button class="btnBtn" id="guiter">기타</button>
			</div>
			<div class="seekArea">
				<form id="searchForm" action="oftenFAQ" method="get">
					<select class="form-control" name="type">
						<option value="" <c:out value="${pageMaker.cri.type == null ? 'selected' : '' }"/> >검색조건</option>
						<option value="q" <c:out value="${pageMaker.cri.type eq  'q' ? 'selected' : '' }"/>>질문</option>
						<option value="a" <c:out value="${pageMaker.cri.type eq  'a' ? 'selected' : '' }"/>>답변</option>
						<option value="c" <c:out value="${pageMaker.cri.type eq  'c' ? 'selected' : '' }"/>>분류</option>
						<option value="qa" <c:out value="${pageMaker.cri.type eq  'qa' ? 'selected' : '' }"/>>질문 or 답변</option>
						<option value="qc" <c:out value="${pageMaker.cri.type eq  'qc' ? 'selected' : '' }"/>>질문 or 분류</option>
						<option value="qac" <c:out value="${pageMaker.cri.type eq  'qac' ? 'selected' : '' }"/>>질문 or 답변 or 분류</option>
					</select>
					<input class="keyword" type="text" name="keyword" value='<c:out value="${pageMaker.cri.keyword}"/>'>
					<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
		               <input type="hidden" name="amount" value="${pageMaker.cri.amount }">
					<button class="gs">검색</button>
				</form>
			</div>
		</div>
		<table class="faqTable">
			<thead>
				<tr class="seperateTh26">
					<th class="th1">구분</th>
					<th class="th1">분류</th>
					<th>질문</th>
					<th></th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${list}" var="a">
					<tr class="seperateTd26">
						<td><input type="hidden" class="radio" name="fno" value="${a.fno}">
							<div class="initQ">
								<span>Q</span> 
							</div>
						</td>
						<td>${a.category}</td>				
						<td class="textTd" style="text-align: left;">${a.question}</td>
						<td>
							<button class="down btnBtn" data-oper="${a.fno}" data-down="${a.fno}">∨</button>
						</td>
					</tr>
					<!-- 질문 클릭시 답변 노출  -->
					
					<tr class="answer hide">
						<td>
							<div class="initA">
								<span>A</span> 
							</div>
						</td>
						<td></td>	
						<td class="textTd" style="text-align: left;">${a.answer}</td>
						<td>
							<button class="up btnBtn" data-oper="${a.fno}">∧</button>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<div class="paginate_area">
			<c:if test="${pageMaker.prev }">
				<span class="paginate_button">
					<a href="oftenFAQ?pageNum=${pageMaker.startPage - 1 }&amount=${pageMaker.cri.amount }&type=${pageMaker.cri.type }&keyword=${pageMaker.cri.keyword }">&lt;Prev</a>
				</span>
			</c:if>            	
			<c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="num">
				<span class="paginate_button" >
					<a href="oftenFAQ?pageNum=${num }&amount=${pageMaker.cri.amount }&type=${pageMaker.cri.type }&keyword=${pageMaker.cri.keyword }">${num}</a>
				 </span>
			</c:forEach>            	
			<c:if test="${pageMaker.next }">
				<span class="paginate_button">
					<a href="oftenFAQ?pageNum=${pageMaker.endPage + 1 }&amount=${pageMaker.cri.amount }&type=${pageMaker.cri.type }&keyword=${pageMaker.cri.keyword }">Next&gt;</a>
				</span>
			</c:if>
		</div>
	</div>
<%@include file="../includes/footer.jsp" %>
</body>
<script type="text/javascript">
		
		var table = document.querySelector('.faqTable');
		var result = "";
		//아래로 버튼을 클릭
		//답변이 열리도록
		
		var radiobtn = document.querySelectorAll('.radio');
		for(var i = 0; i < radiobtn.length; i++){
			radiobtn[i].addEventListener('change', function(e) {
				//console.log(e.target.value);
				result = e.target.value;
			});
		}

		var allSearch = document.querySelector('#allSearch');
		
		allSearch.addEventListener('click', function() {
			console.log('allSearch');
			var form = document.querySelector('#searchForm');
			form.innerHTML = "";
			var input = document.createElement('input');
			
			form.submit();	
			
			
			
		})
		
		var reserve= document.querySelector('#reserve');
		
		reserve.addEventListener('click', function() {
			console.log('reserve');
			var form = document.querySelector('#searchForm');
			form.innerHTML = "";
			var input = document.createElement('input');
			input.setAttribute('name', 'type');
			input.setAttribute('value', 'c');
			var input1 = document.createElement('input');
			input1.setAttribute('name', 'keyword');
			input1.setAttribute('value', '예매');
			form.appendChild(input);
			form.appendChild(input1);
			console.log(form);
			form.submit();
		})
		var account = document.querySelector('#account');
		
		account.addEventListener('click', function() {
			console.log('account');
			var form = document.querySelector('#searchForm');
			form.innerHTML = "";
			var input = document.createElement('input');
			input.setAttribute('name', 'type');
			input.setAttribute('value', 'c');
			var input1 = document.createElement('input');
			input1.setAttribute('name', 'keyword');
			input1.setAttribute('value', '결제/환불');
			form.appendChild(input);
			form.appendChild(input1);
			console.log(form);
			form.submit();
		})
		var system = document.querySelector('#system');
		
		system.addEventListener('click', function() {
			console.log('system');
			var form = document.querySelector('#searchForm');
			form.innerHTML = "";
			var input = document.createElement('input');
			input.setAttribute('name', 'type');
			input.setAttribute('value', 'c');
			var input1 = document.createElement('input');
			input1.setAttribute('name', 'keyword');
			input1.setAttribute('value', '시스템');
			form.appendChild(input);
			form.appendChild(input1);
			console.log(form);
			form.submit();
		})
		var guiter = document.querySelector('#guiter');
		
		guiter.addEventListener('click', function() {
			console.log('guiter');
			var form = document.querySelector('#searchForm');
			form.innerHTML = "";
			var input = document.createElement('input');
			input.setAttribute('name', 'type');
			input.setAttribute('value', 'c');
			var input1 = document.createElement('input');
			input1.setAttribute('name', 'keyword');
			input1.setAttribute('value', '기타');
			form.appendChild(input);
			form.appendChild(input1);
			console.log(form);
			form.submit();
		})
		
		
		
		table.addEventListener('click', function(e) {
			console.log(e.target);
		
			var target = e.target;
			var data = e.target.getAttribute('data-oper');
			if(target.classList.contains('down')){
				e.preventDefault();
				console.log("버튼클릭");
				answerO(target);	//실행시 현재 클릭한 위치정보를 가져감
				$("button[data-down='"+data+"']").hide();
			}
			if(target.classList.contains('up')){
				e.preventDefault();
				console.log("닫힘");
				answerC(target);
				$("button[data-down='"+data+"']").show();
			}
			
			/* if(target.classList.contains('radio')){
				var target = e.target;
				result = target.value;
				console.log("라디오버튼을 클릭함");
				console.log(result);
			} */
			
		});
		
		function answerO(target) {
			console.log("답변열림");
			var target = target;
			var tr = target.parentElement.parentElement;
			console.log(tr.nextElementSibling);
			tr.nextElementSibling.classList.remove('hide');
		}
		function answerC(target) {
			console.log("답변닫힘");
			var target = target;
			var tr = target.parentElement.parentElement;
			
			tr.classList.add('hide');
		}
</script>
</html>