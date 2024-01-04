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
<%@ include file="../includes/adminHeader.jsp" %>

	<style type="text/css">
		
		.show{
			display:'';
		}
		.hide{
			display:none !important;
		}
		 

		
	</style>


<link href="/resources/css/admin/adminMain.css" rel="stylesheet">

</head>

<body>
<div class="wrap">

<div id="contentWrap">
	<div class="adTitle"><span>FAQ</span> </div>
	<div class="middleSw">
<div>
	<!-- <form name="search-form" autocomplete="off">
		<select name="type">
			<option selected value="">검색 내용 선택</option>
			<option value="title">질문</option>
			<option value="content">내용</option>
			<option value="writer">작성자</option>
		</select>
		<input type="text" name="keyword" value="" style="width: 500px;height: 20px;">
		<input type="button" onclick="getSearchList()" class="btn btn-outline-primary mr-2"  value="검색" >
		<a href="oftenFAQ"></a>
	</form> -->
</div> 

<div class="searchArea" >
		<form id="searchForm" action="adminFAQ" method="get">
						<!-- select부분의 name는 criteria부분의 type에 해당됨으로 name를 type로 한다  -->
						<!-- select로 감싸진 option의 value부분이 select의 name에 type에 해당하는 값으로 전송된다  -->
						<div class="row  pull-right">
						<div class="f">
							<select class="form-control" name="type">
								<!-- option value="T" 한칸띄고 selected를 붙여주고 싶은거다 삼항연산자를 통해서 -->
								<option value="" <c:out value="${pageMaker.cri.type == null ? 'selected' : '' }"/> >검색조건</option>
								<option value="q" <c:out value="${pageMaker.cri.type eq  'q' ? 'selected' : '' }"/>>질문</option>
								<option value="a" <c:out value="${pageMaker.cri.type eq  'a' ? 'selected' : '' }"/>>답변</option>
								<option value="c" <c:out value="${pageMaker.cri.type eq  'c' ? 'selected' : '' }"/>>종류</option>
								<option value="qa" <c:out value="${pageMaker.cri.type eq  'qa' ? 'selected' : '' }"/>>질문 or 답변</option>
								<option value="qc" <c:out value="${pageMaker.cri.type eq  'qc' ? 'selected' : '' }"/>>질문 or 종류</option>
								<option value="qac" <c:out value="${pageMaker.cri.type eq  'qac' ? 'selected' : '' }"/>>질문 or 답변 or 종류</option>
							</select>
						</div>
						<!-- 검색 키워드부분 criteria클래스의 변수명 keyword부분에 해당함으로 naem="keyword" -->
						
							<!--이부분도 action="/board/list"로 보냈을때 다시 받는 부분이 필요하다 그래서
							페이징처리나 기타 작업을 수행할때도 기본적으로 value값이 입력이 되어있도록 만든다  -->
							<!-- 이부분까지 수행시 ?type=T&keyword=2&pageNum=1&amount=10 처럼 파라미터값으로 잘받고 처리도 잘된다  -->
						  <div class="a">
						<input class="form-control"  type="text" name="keyword" value='<c:out value="${pageMaker.cri.keyword}"/>'>
						<!--검색을 했어도 페이징 처리는 필요함으로 pageNum과 amount를 넘겨준다  -->
						<!--criteria에서 파라미터 수집시 같이 수집되어서 값이 컨트롤러로 넘어감  -->
						</div>
						<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
		                <input type="hidden" name="amount" value="${pageMaker.cri.amount }">
		               
		                <div class="q"> 
							<button class="form-control btnBtn" id="allSearch">검색</button> 
						</div>
						<!--여기까지가 리스트에서 다시 리스트로 보내는 부분이며  -->
						<!--추가로 다시 받는부분이 필요하다 이유 !! cri부분을 전부 받기위해서 기존 pageNum등은  잘 받는 부분이 있으나  
							keyword와 type는 받는 부분이 없다 그래서 select부분과 input부분에 value로 받는다
							어디처럼?? pageMaker.cri.amount처럼 받는다
						-->
						
						</div>
					</form>
</div>
<!--이부분은 페이징 처리부분으로 키워드와 검색타입을 숨겨서 보내준다 현재의 값 -> 넘어가는 페이지로 보내준다  -->
		                    	<!--?pageNum=1&amount=10&type=T&keyword=2&bno=580 요렇게 잘 넘어감  -->

		                    	
<div style="margin-right: 100px; width: 97%; background-color: white; border-radius: 4px;">
<table class="table">
	<thead>

		<tr >
			<td colspan="5" style="text-align: right">
			<span><button class="add btnBtn">추가</button></span>
				<span><button class="modify btnBtn">수정</button></span>
				<span><button class="save btnBtn hide ">저장</button></span>
				<span><button class="close btnBtn hide ">취소</button></span>
				<span ><button class="remove btnBtn" >삭제</button></span>
			
			<div class="addbody hide" style="margin: 15px 0 10px 0;">
				<form class ="form" action="aa" method="get">
					<select name="category">
						<option value="예매">예매</option>
						<option value="결제">결제</option>
						<option value="취소/환불">취소/환불</option>
						<option value="시스템">시스템</option>
						<option value="기타">기타</option>
					</select>
					
					<div>
						<div class="aq">
							<label>질문</label>
							<input class="aq_input" name="question">
						</div>
						<span class="aq_null_ck">질문을 작성해주세요.</span>
					</div>
					
					<div>
						<div class="aa">
							<label>답변</label>
							<input class="aa_input"  name="answer">
						</div>
						<span class="aa_null_ck">답변을 작성해주세요.</span>
					</div>
					
					<label>작성자</label>
					<input type="hidden" name="writer" value="${member.id}"> 
					<!-- disabled 속성을 쓰면 입력은 막을 수 있으나 값을 못 읽어 property null때문에 쓸 수가 없음. -->
					<!-- 입력 막기 위해 input을 hidden으로 가리고 value값만 넘겨줌 -->
					<span>${member.id }</span>
					
					
					<button class="register btnBtn">저장</button>
					<button class="boom btnBtn">취소</button>
				</form>
		</div>
				
			</td>	 
		</tr>	
	
		<tr>
			<td style="width: 10%"></td>
			<th style="width: 10%">구분</th>
			<th style="width: 15%">분류</th>
			<th style="width: 40%">질문</th>
			<th style="width: 10%"></th>
		</tr>
		
		
	</thead>
	
	<tbody>
		<c:forEach items="${list }" var="a">
			<tr>
				<td>
					<input type="radio"  class="radio" name="fno" value="${a.fno }" >
				</td>
				<td >
					<div class="initQ">
						<span>Q</span> 
					</div>
				</td>
				<td>${a.category }</td>				
				<td class="title" style="text-align: left;"><div class="aq">${a.question }</div></td>
				<td>
					<button class="down" data-oper="${a.fno}" data-down="${a.fno}">∨</button>
				</td>
				
			</tr>
			<!-- 질문 클릭시 답변 노출  -->
			
			<tr class="answer hide">
				<td></td>
				<td>
					<div class="initA">
						<span>A</span> 
					</div>
				</td>
				<td></td>	
				<td style="text-align: left;">
						<div class="aa">${a.answer }</div>
				</td>
				<td>
					<button class="up" data-oper="${a.fno}">∧</button>
				</td>
			</tr>
		</c:forEach>
		
	</tbody>

</table>
</div>
			<div class="paging_region">
				<div class="pagePrev"> 
					<c:if test="${pageMaker.prev }">
	                	<span class="pageInfo">
	                  		<a href="adminFAQ?pageNum=${pageMaker.startPage - 1 }&amount=${pageMaker.cri.amount }&type=${pageMaker.cri.type }&keyword=${pageMaker.cri.keyword }">&lt;Prev</a>
	                  	</span>
	                 </c:if>
                 </div>	
                 <div class="pageNum">
                 
	                 <c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="num">
	                  	<span class="pageInfo nu" >
	                  		<a href="adminFAQ?pageNum=${num }&amount=${pageMaker.cri.amount }&type=${pageMaker.cri.type }&keyword=${pageMaker.cri.keyword }">${num }</a>
	                  	</span>
	                 </c:forEach>
                  </div>	
                  <div class="pageNext"> 
	                 <c:if test="${pageMaker.next }">
	                  	<span class="pageInfo">
	                  		<a href="adminFAQ?pageNum=${pageMaker.endPage + 1 }&amount=${pageMaker.cri.amount }&type=${pageMaker.cri.type }&keyword=${pageMaker.cri.keyword }">Next&gt;</a>
	                  	</span>
	                  </c:if>
	             </div>
			</div> <!-- 페이징 -->
	</div>


</div>
</div>
		<script type="text/javascript">
		
		var table = document.querySelector('.table');
		var result = "";
		//아래로 버튼을 클릭
		//답변이 열리도록
		
		var aqCheck = false;
		var aaCheck = false;
		var aq = $(".aq_input").val();
		var aa = $(".aa_input").val();
		
		var questionVal = $(".question").val();
		var answerupdateVal = $(".answerupdate").val();
		var quCk = false;
		var auCk = false;
		
		
		var radiobtn = document.querySelectorAll('.radio');
		for(var i = 0; i < radiobtn.length; i++){
			radiobtn[i].addEventListener('change', function(e) {
				//console.log(e.target.value);
				result = e.target.value;
			});
		}
		
		function getSearchList(){
			$.ajax({
				type : 'GET',
				url : $("form[name=search-form]").serialize(),
				success : function(result){
					$('#FaQtable > tbody').empty();
					if(result.length>=1){
						result.forEach(function(item){
							str='<tr>'
							str += "<td>"+item.idx+"</td>";
							str+="<td>"+item.writer+"</td>";
							str+="<td><a href = 'detail?idx=" + item.idx + "'>" +item.title + "</a></td>";
							str+="<td>"+item.hit+"</td>";
							str+="</tr>"
							$('#FaQtable').append(str);
						})
					}
				}
							
				
			})
		}

		var allSearch = document.querySelector('#allSearch');
		
		allSearch.addEventListener('click', function() {
			console.log('allSearch');
			var form = document.querySelector('#searchForm');
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
			if(target.classList.contains('add')){
				e.preventDefault();
				console.log("추가버튼을 클릭함");
				add(target);
			}
			if(target.classList.contains('modify')){

				e.preventDefault();				
				if(result !== '' && result!==null){
					console.log("수정버튼을 클릭함");

					var radio =  document.querySelectorAll('.radio');
					for(var i=0;i<radio.length;i++){
						radio[i].onclick = function() {
							return false;
						}
					}
					document.querySelector('.save').classList.remove('hide');
					document.querySelector('.close').classList.remove('hide');
					document.querySelector('.modify').classList.add('hide');
					document.querySelector('.remove').classList.add('hide');
					var ra = document.querySelectorAll('.radio');
					console.log(ra);
					
					/* document.querySelector('.down').classList.add('hide');
					document.querySelector('.up').classList.add('hide'); */
					console.log(result);
					modify(result);
				}else {
					console.log('result 없음:' + result);
					alert("질문을 선택해주세요.");
				}
				
				
			}
			if(target.classList.contains('remove')){
				e.preventDefault();			
				console.log("삭제버튼을 클릭함");
				console.log(result);
				if(result !== '' && result!==null){
					remove();	
				}else{
					alert('삭제할 번호를 지정해주세요');
				}
				
			}
			/* if(target.classList.contains('radio')){
				var target = e.target;
				result = target.value;
				console.log("라디오버튼을 클릭함");
				console.log(result);
			} */
			if(target.classList.contains('save')){
				console.log ("저장함");
				e.preventDefault();
				
				questionVal = $(".question").val();
				answerupdateVal = $(".answerupdate").val();
				quCk = false;
				auCk = false;
				
				
				if(questionVal != "" && answerupdateVal != ""){
					console.log("aaaaaa");
					quCk = true;
					auCk = true;
					console.log("저장");
					save();
					
				}
				if(questionVal == ""){
					/* document.getElementsByClassName('question').innerHTML=('<span style="color : red; font-weight= bold;">질문을 작성해주세요.</span>'); */
					
					console.log("bbbbbb");
					alert("질문을 작성해주세요.");
					$(".question").after('<span style="color : red; font-weight: bold;">질문을 작성해주세요.</span>');
					console.log("질문 확인 : " + aq);
					console.log("답변 확인 : " + aa);
					
					quCk = false;
					auCk = true;
					
				}
				if(answerupdateVal == ""){
					console.log("cccccc");
					alert("답변을 작성해주세요.");
					$(".answerupdate").after('<span style="color : red; font-weight: bold;">답변을 작성해주세요.</span>');
					
					console.log("질문 확인 : " + aq);
					console.log("답변 확인 : " + aa);
					quCk = true;
					auCk = false;
				}
			}
			if(target.classList.contains('close')){
				e.preventDefault();
				console.log("취소함");
				close();
			}
		});
		var addbody = document.querySelector('.addbody');
		console.log(addbody);
		addbody.addEventListener('click', function(e) {
			console.log('addbody 진입');
			var target = e.target;
			console.log(target);
			if(target.classList.contains('register')){
				e.preventDefault();	
				
				aq = $(".aq_input").val();
				aa = $(".aa_input").val();
				
				 if(aa != "" && aq != ""){
					console.log("aaaaaa");
					aqCheck = true;
					aaCheck = true;
					console.log("저장");
					register();
					
				}
				if(aq == ""){
					$(".aq_null_ck").css('display', 'block');
					console.log("bbbbbb");
					
					console.log("질문 확인 : " + aq);
					console.log("답변 확인 : " + aa);
					
					aqCheck = false;
					aaCheck = true;
				}
				if(aa == ""){
					console.log("cccccc");
					
					$(".aa_null_ck").css('display', 'block');
					
					console.log("질문 확인 : " + aq);
					console.log("답변 확인 : " + aa);
					aqCheck = true;
					aaCheck = false;
				} 
				
			}
			if(target.classList.contains('boom')){
				e.preventDefault();
				console.log("취소");
				boom();
			}
		});
		function remove(){
			var inputFno = document.createElement('input');
			inputFno.setAttribute('value', result);
			inputFno.setAttribute('name', "fno");
		
			var form = document.querySelector('.form');
			form.method = 'post';
			form.action ="delete";
			form.innerHTML = "";
			
			form.appendChild(inputFno);
			console.log(form);
			form.submit();
			
		}
		
		
		function modify(result) {
			console.log('수정함수');
			var radio = document.querySelectorAll('.radio');
			console.log(radio);
			for(var i = 0; i < radio.length; i++){
				if(radio[i].value === result){
					console.log("같아" + radio[i]);
					var nextE = radio[i].parentElement.parentElement; //tr
					nextE.nextElementSibling.classList.remove('hide');
					nextE.nextElementSibling.children[3];
					console.log(nextE.children[3]);
					console.log(nextE.nextElementSibling.children[3]);
					var str = nextE.children[2].textContent;
					console.log("str 확인 : " + str);
					nextE.children[2].innerHTML = '<select name="category" class="category"><option value="예매">예매</option><option value="결제">결제</option><option value="취소/환불">취소/환불</option><option value="시스템">시스템</option><option value="기타">기타</option></select>';
					let sel3 = document.querySelector("select[name=category]").options;
					for (let i=0; i<sel3.length; i++) {
					    console.log(sel3[i].text);
					    console.log(nextE.children[2]);
						if (sel3[i].text == str) sel3[i].selected = true;
					}
					console.log(nextE.children[3].textContent);
					
					nextE.children[3].innerHTML = '<input style="width: 100%;height: 40px; text-align: left;" name="question" class="question" value="'+nextE.children[3].innerText+'">';
					nextE.nextElementSibling.children[3].innerHTML = '<input style="width: 100%;height: 40px; background-color: #f7f7f7;" class="answerupdate" name="answer" value="'+nextE.nextElementSibling.children[3].innerText+'">';
					//저장버튼 만들기 취소도
					// !!.textContent 사용하면 왠지 모르게 공백과 동시에 가운데 정렬이 되어버린다... 해결 못함. innerText로 텍스트값만 불러오는건 ok
				}
			}
		}
		function save() {
			console.log("저장되었습니다");
			var inputFno = document.createElement('input');
			inputFno.setAttribute('value', result);
			inputFno.setAttribute('name', "fno");
			
			console.log(inputFno);
			var form = document.querySelector('.form');
			form.innerHTML = "";
						
			let question = document.querySelector('.question');
			let category = document.querySelector('.category');
			let answer = document.querySelector('.answerupdate'); 
			form.method = 'post';
			form.action ="update";
			form.appendChild(inputFno);
			form.appendChild(question);			
			form.appendChild(category);			
			form.appendChild(answer);			
			console.log(form);
			form.submit();
		
		}
		
		
		function close() {
			console.log("취소되었습니다");
			//input 창 비우기
			var radio = document.querySelectorAll('.radio');
			console.log(radio);
			for(var i = 0; i < radio.length; i++){
				if(radio[i].value === result){
					console.log("같아" + radio[i]);
					var nextE = radio[i].parentElement.parentElement
					nextE.nextElementSibling.classList.remove('hide');
					nextE.nextElementSibling.children[3];
					console.log(nextE.children[3].firstChild.value);
					console.log(nextE.nextElementSibling.children[3]);
					nextE.children[3].textContent = nextE.children[3].firstChild.value;
					nextE.nextElementSibling.children[3].textContent = nextE.nextElementSibling.children[3].firstChild.value;
					//저장버튼 만들기 취소도
					document.querySelector('.save').classList.add('hide');
					document.querySelector('.close').classList.add('hide');
					document.querySelector('.modify').classList.remove('hide');
					document.querySelector('.remove').classList.remove('hide');
					
					
					location.reload();
					location.replace(location.href);
					location.href = location.href;

					
					history.go(0); 
				}
			}
		}
		function boom() {
			console.log("취소함");
			//input 창 비우기
			addbody.classList.add('hide');		
		}
		//등록시 유효성 검사
		function register() {
			var form = document.querySelector('.form');
			form.action = 'registerFAQ';
			form.method = 'post';
			console.log(form);
			form.submit(); 
		}
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
		function add(target) {
			console.log("추가창이 뜸");
			var target = target;
			var str = '';	
			
			var a = document.querySelector('.addbody');
			console.log(a);
			a.classList.remove('hide');
			
		}
		

	$(document).ready(function () {
		var query = window.location.search; //전체 url 가져옴
		
		var param = new URLSearchParams(query); //전체 url의 파라미터 가져오기
		
		var pageNumber = param.get('pageNum'); //현재 페이지 넘버만 추출
		
		console.log(pageNumber);
		
		var readypage = document.querySelectorAll("span a"); 
		
		for(var m = 0; m < readypage.length; m++){
			console.log(readypage[m].innerText);
			if(pageNumber == readypage[m].innerText){
				console.log(readypage[m]); //태그 자체가 찍힘
				readypage[m].classList.add("coloring"); //클래스 추가해주기
				console.log(readypage[m]);
			}else{
				readypage[m].classList.remove("coloring"); //클래스 제거해주기
			}
		}
	});
		
		
		
		</script>
</body>
</html>