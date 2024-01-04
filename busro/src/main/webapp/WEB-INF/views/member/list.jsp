<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<%@ include file="../includes/adminHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 페이지 - 회원목록</title>
<link rel="stylesheet" href="/resources/css/member/list.css">
<style type="text/css">
	.pagination{
	
		padding: 0 0 5px 10px;
		display: table;
	  	margin-left: auto;
	 	margin-right: auto;
	  	text-align: center;
	
	}
	
	ul {
    list-style:none;
    }

	li {   
    float: left;
	} 
</style>
</head>

<body>

<script type="text/javascript">
$(document).ready(function() {
	
	$("#save_btn").click(function(e) {
		e.preventDefault();
		console.log("회원정보 수정 모달에서 저장 누름");
		var aform = $("#memberModify");
		var vo = {
				id: aform.find("input[name='id']").val(),
				pass: aform.find("input[name='pass']").val(),
				name: aform.find("input[name='name']").val(),
				birth: aform.find("input[name='birth']").val(),
				tel: aform.find("input[name='tel']").val(),				
				gender: aform.find("input[name='gender']").val(),
				auth: aform.find("input[name='auth']:checked").val()
		};		

		$.ajax({
					type: 'post',
					url: '/member/updateMember1.do',
					data: JSON.stringify(vo),
					contentType: "application/json; charset=utf-8",
					success: function(result, status, xhr) {
						alert("회원정보 변경 완료");
						location.href='/member/list';
					},			
					error: function(xhr, status, er) {
						alert("회원정보 변경 실패, 다시 확인하고 입력하세요");					
					}
					
				}); //$.ajax
		
	});
	
	var actionForm = $("#actionForm");	
	$(".paginate_button a").on("click", function(e) {
		e.preventDefault();		
		actionForm.find("input[name='pageNum']").val($(this).attr("href"));
		actionForm.submit();
	});
	
	var searchForm = $("#actionForm");
	
	$("#actionForm button").on("click", function(e) {
		if(!searchForm.find("option:selected").val()) {
			alert("검색종류를 선택하세요");
			return false;
		}
		
		if(!searchForm.find("input[name='keyword']").val()) {
			alert("키워드를 선택하세요");
			return false;
		}		
		
		searchForm.find("input[name='pageNum']").val("1");
		e.preventDefault();
		console.log(searchForm);	
		searchForm.submit();
	});
	
});
</script>
<div id="contentWrap">
	<div class="adTitle"><span>회원 관리</span> </div>
	<div class="middleSw">		
		<div class="searchArea" >		
			<form id="actionForm" action="/member/list" method="get">
				<select name="type">
					<option value="" <c:out value= "${pageMaker.cri.type == null ? 'selected':''}"/>>검색조건</option>
					<option value="n" <c:out value= "${pageMaker.cri.type eq 'n' ? 'selected':''}"/>>이름</option>
					<option value="i" <c:out value= "${pageMaker.cri.type eq 'i' ? 'selected':''}"/>>아이디</option>
					<option value="a" <c:out value= "${pageMaker.cri.type eq 'a' ? 'selected':''}"/>>회원구분</option>
				</select>
				<input id="keyword" type="text" name="keyword" value='<c:out value="${pageMaker.cri.keyword}"/>' />		
				<input type="hidden" name="pageNum" value='<c:out value="${pageMaker.cri.pageNum}"/>' />
				<input type="hidden" name="amount" value='<c:out value="${pageMaker.cri.amount}"/>' />
				<button type="submit" class="btnBtn">검색</button>			
			</form>
		</div>
		<button onclick="location.href='/member/join_admin'" class="btnBtn">등록</button>
	<div style="margin-right: 100px; width: 97%; background-color: white; border-radius: 4px;">
		<table class="table">
			<thead>
				<tr>
					<th>회원구분</th>
					<th>아이디</th>
					<th>이름</th>
					<th>휴대폰 번호</th>
				</tr>
			</thead>
			<!-- MemberController에서 설정한 키워드 -->
			<c:forEach items="${list}" var="a">
				<tr>
					<td><c:out value="${a.auth}" /></td>
					<td><a class="user"><c:out value="${a.id}" /></a></td>
					<td><c:out value="${a.name}" /></td>
					<td><c:out value="${a.tel}" /></td>
				</tr>
			</c:forEach>
		</table>
	</div>
		<!-- 페이징 -->
		<div class="paging_region ">
			<ul class="pagination">
				<c:if test="${pageMaker.prev}">
					<li class="paginate_button previous">
						<a class="pagePrev2" href="${pageMaker.startPage-1}">&#60;Prev</a>
					</li>
				</c:if>

				<c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
					<li class="paginate_button pageInfo ${pageMaker.cri.pageNum == num ? "active":""} ">
						<a class="pageInfo" href="${num}" style=" text-decoration-line: none;">&nbsp;&nbsp; ${num} &nbsp;&nbsp;</a>
					</li>
				</c:forEach>

				<c:if test="${pageMaker.next}">
					<li class="paginate_button next">
						<a class="pageNext2" href="${pageMaker.endPage +1}">Next&#62;</a>
					</li>
				</c:if>
			</ul>
		</div>
		<!-- /.페이징 -->
</div>
		<!-- 회원정보 상세 모달 -->
		<form action="/member/">
			<div class="modal" id="modal">
				<div class="modal_body">
					<div class="m_head">
						<div class="modal_title">회원정보 상세</div>
						<div class="close_btn" id="close_btn">X</div>
					</div>
					<div class="m_body">
						<div class="modal_label">아이디</div>
						<input type="text" class="input_box" id="id_box"
							value="<c:out value='${a.id}' />" readonly="readonly" disabled="disabled" />
						<div class="modal_label">비밀번호</div>
						<input type="text" class="input_box" id="pass_box"
							value="<c:out value='${a.pass}' />" readonly="readonly" disabled="disabled" />
						<div class="modal_label">이름</div>
						<input type="text" class="input_box" id="name_box"
							value="<c:out value='${a.name}' />" readonly="readonly" disabled="disabled" />
						<div class="modal_label">전화번호</div>
						<input type="text" class="input_box" id="tel_box"
							value="<c:out value='${a.tel}' />" readonly="readonly" disabled="disabled" />
						<div class="modal_label">생년월일</div>
						<input type="text" class="input_box" id="birth_box"
							value="<c:out value='${a.birth}' />" readonly="readonly" disabled="disabled"/>
						<div class="modal_label">성별</div>
						<input type="text" class="input_box" id="gender_box"
							value="<c:out value='${a.gender}' />" readonly="readonly" disabled="disabled" />
						<div class="modal_label">회원구분</div>
						<input type="text" class="input_box" id="auth_box"
							value="<c:out value='${a.auth}' />" readonly="readonly" disabled="disabled"/>
					</div>
					<div class="m_footer">
						<div class="modal_btn cancle moB" id="close_btn">닫기</div>
					</div>
				</div>
			</div>
		</form>
		<!-- /.회원정보 상세 모달 -->

		<!-- 회원정보 수정 모달 -->
		<form id="memberModify" action="/member/updateMember1.do" method="post">
			<div class="modal" id="modal1">
				<div class="modal_body">
					<div class="m_head">
						<div class="modal_title">회원정보 수정 <br>
							<h6>비밀번호, 이름, 휴대전화번호, 회원구분 변경 가능</h6>
						</div>							
						<div class="close_btn" id="close_btn">X</div>
					</div>
					
					<div class="m_body">
						<div class="modal_label"><span class="star">*</span>아이디</div>
						<input type="text" class="input_box" name="id" id="id_box1"
							value="<c:out value='${a.id}' />" readonly="readonly" />

						<div class="modal_label"><span class="star">*</span>비밀번호</div>
						<input type="text" class="pass" name="pass"
							placeholder="변경할 비밀번호를 입력해주세요" maxlength="12" />

						<div class="modal_label"><span class="star">*</span>이름</div>
						<input type="text" class="input_box" name="name" id="name_box1"
							value="<c:out value='${a.name}' />" />

						<div class="modal_label"><span class="star">*</span>휴대전화번호</div>
						<input type="text" class="input_box" name="tel" id="tel_box1"
							value="<c:out value='${a.tel}' />" />

						<div class="modal_label"><span class="star">*</span>생년월일</div>
						<input type="text" class="input_box" name="birth" id="birth_box1"
							value="<c:out value='${a.birth}' />" readonly="readonly" />
							
						<div class="modal_label"><span class="star">*</span>성별 (M:남 / F:여)</div>
						<input type="text" class="input_box" name="gender"
							id="gender_box1" value="<c:out value='${a.gender}' />"
							readonly="readonly" />
							
						<div id="authResult">
							
						</div>
					</div>
					<div class="m_footer">
						<!-- <H5>삭제버튼 클릭 시 바로 삭제되니 주의할 것!!</H5> -->
						<div class="modal_btn cancle moB" id="close_btn">닫기</div>
						<button class="modal_btn save moB" id="save_btn" type="submit">저장</button>
						<button class="modal_btn delete moB" type="submit" value="delete"
							onclick="javascript: form.action='/member/memberDelete1.do';">삭제</button>
					</div>
				</div>
			</div>
		</form>
		<!-- /.회원정보 수정 모달 -->

	</div>

<script>
var id ='';
var pass = '';
var name = '';
var birth = '';
var tel = '';
var gender = '';
var auth = '';

var $table = document.querySelector('table');

function makeTooltipElement(id) {
    var $div = document.createElement('div');
    $div.className = 'tooltip show';
//div의 클래스 지정
   $div.innerHTML = "<div class='btn' id='add-btn'>회원정보 상세</div>" +
   					"<div class='btn' id='add-btn1'>회원정보 수정</div>"
   					
   /* console.log("makeTooltipElement() 로 만들어준 div태그 : ");
   console.log($div); */
    return $div;
}

/* 테이블 */
$table.addEventListener('click', function(event) {
	var $target = event.target;
	/* console.log("클릭한 위치 확인 table");
	console.log($target); */   
	var aaa = $target.textContent;
	   
   /* console.log("aaa에 들어온 값" + aaa); */   
   
   <c:forEach items="${list}" var="a">
   	/* console.log("${a.id}"); */
	   if('${a.id}' == aaa){		   
		
			id = '${a.id}';
			pass = '${a.pass}';
			name = '${a.name}';
			birth = '${a.birth}';
			tel = '${a.tel}';
			gender = '${a.gender}';
			auth = '${a.auth}';
	   }      
   </c:forEach>   
   
   /* console.log("클릭한 해당 요소 클래스리스트에 파라미터 클래스가 있는지 확인 " + $target.classList.contains('user')); */ 
   
	if ( $target.classList.contains('user') ) {
		/* console.log("클릭한 요소가 있다면 다음  다음엘리멘트를 가져옴" + $target.nextElementSibling); */		
        if ( $target.nextElementSibling !== null ) {
            $target.nextElementSibling.classList.add('show');
   			//클릭한 다음요소에 클래스 show를 넣어줌
        } else {
   <!--클릭한 요소가 user이고 다음 엘리멘트가 없다면 만듬 makeTooltipElement(타겟의 내용)-->
   		/* console.log("클릭한 요소가 없다면 클릭한 요소의 내용 가져옴  " + $target.textContent); */
            $target.parentNode.appendChild( makeTooltipElement($target.textContent) );
        }
        
    }
})
<!-- 문서 전체 해당 -->
document.addEventListener('click', function(event) {
    var $target = event.target;
    /* console.log("클릭한 위치 확인 docu");
    console.log($target);
    console.log("클릭한 곳에 클래스 리스트에 user클래스가 있는지 T/F : "+ $target.classList.contains('user')); */
    if ( $target.classList.contains('user') ) {
        // 클릭요소중에 .user가 있다면, 해당 클릭 요소를 제외한 나머지 닫기.
        /* console.log("클릭요소중 user가 있다면") */
        // 테이블 밑에 show클래스전체.previousElementSibling 값이 타겟과 같다면 show지움

       /*  $table.querySelectorAll('.show').forEach( elem => (elem.previousElementSibling !== $target) && */
        		/* console.log(elem.previousElementSibling) );           //위콘솔창에 해당하는 내용 */
        		
        $table.querySelectorAll('.show').forEach( elem => (elem.previousElementSibling !== $target) &&
        		elem.classList.remove('show'));
    } else {
       // 클릭 요소중에 .user 클레스가 없다면. 모든 tooltip 닫기.
       // show의 모든 클랙스 선택 -> 반복 -> 클래스의 하나하나의 객체를 elem
       // elem의 클래스 리스트 지움(show라는) .table .tooltip.show { display: block; } style에 지정되어있는값 미적용됨
       /* console.log("elem의 클래스 리스트 지움 "     +  $table.querySelectorAll('.show') );
       console.log($table.querySelectorAll('.show')); */
       $table.querySelectorAll('.show').forEach( elem => elem.classList.remove('show') );
    }
});

</script>

<script type="text/javascript">
//click on 라벨 추가 모달 열기
$(document).on('click', '#add-btn', function (e) {
	$('#id_box').val(id);
	$('#pass_box').val(pass);
	$('#name_box').val(name);
	$('#birth_box').val(birth);
	$('#tel_box').val(tel);
	$('#gender_box').val(gender);
	$('#auth_box').val(auth);
	$('#modal').addClass('show');
});

$(document).on('click', '#add-btn1', function (e) {
	$('#id_box1').val(id);
	$('#name_box1').val(name);
	$('#birth_box1').val(birth);
	$('#tel_box1').val(tel);
	$('#gender_box1').val(gender);
	console.log(auth);
	if(auth == 'ADMIN'){
		$('#authResult').html('<div class="modal_label"><span class="star">*</span>회원구분</div><span class="rightA">ADMIN</span><input class="rightA" type="radio" name="auth" value="ADMIN" checked /><span class="rightG">USER</span><input class="rightG" type="radio" name="auth" value="USER"/>');	
	}else {
		$('#authResult').html('<div class="modal_label"><span class="star">*</span>회원구분</div><span class="rightA">ADMIN</span><input class="rightA" type="radio" name="auth" value="ADMIN"/><span class="rightG">USER</span><input class="rightG" type="radio" name="auth" value="USER" checked/>');	
	}
	
	
	
	$('#modal1').addClass('show');
});

//모달 닫기
$(document).on('click', '#close_btn', function (e) {
	$('#modal').removeClass('show');
	$('#modal1').removeClass('show');
});
</script>

</body>
</html>