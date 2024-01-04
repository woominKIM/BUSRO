<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../includes/adminHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>버스 노선</title>
<link rel="stylesheet" href="/resources/css/admin/adminMain.css">
<link rel="stylesheet" href="/resources/css/routeAndbooking.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
</head>
<body>
<div id="contentWrap">
	<div class="adTitle"><span>버스 노선</span> </div>
	<div class="middleSw">	
	
	<!-- 검색 -->
	<div class="searchArea" >
		<form action="/admin/routeschedulelist" method="get" id="searchForm">
			<!-- <div class="sc"><span>검색 조건</span></div> -->
			
			<div class="c" >
				<select id="depart" name="departure">	
				</select>
			</div>
			<div class="o">
				<select id="destination" name="arrival"><option disabled selected>--도착지--</option></select>
			</div>
			
			<div class="n">
				<select id="startTime" name="st" >
					<c:forEach var="i" begin="0" end="23">
				<c:choose>
					<c:when test="${i<10}">
					<option value="<fmt:formatNumber value='${i}' pattern ='00' />"<c:if test="${route.lastTimeHour == i}">selected</c:if>> <fmt:formatNumber value='${i}' pattern ='00' /></option>
					</c:when>
					<c:otherwise>
					<option> <fmt:formatNumber value='${i}' pattern ='##' /></option>
					</c:otherwise>
				</c:choose>
				</c:forEach>
				</select> 
					<span>시 이후</span>
			</div>
		
			
			<div class="d">
				<select id="level" name="grade">
					<option disabled selected>--등급--</option>
					<option>우등</option>
					<option>일반</option>
				</select>
			</div>
			
			<div class="i">
				<button class="btnBtn">검색</button>
			</div>
		</form> <!-- 검색 처리 폼 -->
	
	</div> <!-- 검색 전체 div -->

	<div class="routeBtn" style="overflow: hidden;">
		<button id="modBtn" class="btmt" type="button" >수정</button>
	<button id="addBtn" class="btat" type="button">등록</button>

	</div>
	
	<div style="margin-right: 100px; width: 97%; background-color: white; border-radius: 4px;">
		<table id="sortList" >
			<thead >
				<tr>
					<th><input type="checkbox" onclick="return false;"> </th>
					<th>번호</th>
					<th>버스회사</th>
					<th>등급</th>
					<th data-sort="departure" style="cursor: pointer;">출발지<span class="material-symbols-outlined">arrow_drop_down</span></th>
					<th data-sort="arrival" style="cursor: pointer;">도착지<span class="material-symbols-outlined">arrow_drop_down</span></th>
					<th>운영요일</th>
					<th data-sort="st">출발시간</th>
					<th>기본요금(원)</th>
				</tr>
				
			</thead>
	        <tbody>
	        	<c:forEach items="${list}" var="route">
	        		<tr>
	        			<td><input type="checkbox" class="move" name="snum" onclick="oneCheckbox(this)" value="${route.snum}"></td>
	        			<td>
	        			
		        			<div class="numf"> <c:out value="${route.snum}"/> 
			        			<div class="tri">
			        				<a id="tri" type="button" onclick="openGetInfoModal(${route.snum})" class="modal" data-oper="modalshow" data-toggle="modal" data-target="#getInfo"></a>
			        			</div>	
		        			</div>
		        			
	        				<!-- 노선상세정보 모달창 -->
	        				<div id="totalModal">
			
								<div id='${route.snum}' class="getInfo">
									<div class="modal-content" role="document">
											<button data-oper="close" id="initX" class="modalCloseBtn">X</button>
											<div class="modal-header">
												노선정보 상세
											</div><!-- 모달 헤더 -->
											<hr class="hrLine">
											<div class="modal-body">
							
												<input type="hidden" value="${route.snum}">	 <br>
												
												<!-- 고민 -->
												
												<div class="row1">
									                <div>
									                    <label style="padding-right: 53px;">출발지</label>
									                    <input class="roin" type="text" value="${route.departure}" readonly="readonly">
									                </div>
									                <div>
									                    <label>출발시간</label>
									                    <input class="roin" type="text" value="${route.st}" readonly="readonly">
									                </div>
									                <div>
									                    <label>운영요일</label>
									                    <input class="roin" type="text" value="${route.workday}" readonly="readonly">
									                </div>
									            </div>
									            
									            <div class="row2">
									                <div>
									                    <label style="padding-right: 53px;">도착지</label>
									                    <input class="roin" type="text" value="${route.arrival}" readonly="readonly">
									                </div>
									                
									                <div>
									                    <label>소요시간</label>
									                    <input class="roin" type="text" value="${route.eta}" readonly="readonly">
									                </div>
									                <div>
									                    <label style="padding-right: 66px;">등급</label>
									                    <input class="roin" type="text" value="${route.grade}" readonly="readonly">
									                </div>
									            </div>
									            
									            <div class="row3">
									                <div>
									                    <label style="padding-right: 48px;">총 좌석</label>
									                    <input class="roin" type="text" value="28석" readonly="readonly">
									                </div>
									            </div>
												
										    
											</div> <!-- 모달 바디 -->
											<!-- 모달 풋터 -->
											
											<hr class="hrUnderLine">
											
											<div class="modal-footer">
												<button data-oper="close"  class="modalCloseBtn hanX">닫기</button>
											</div>		
									</div><!-- 모달 전체 내용 -->
				
								</div> <!-- class getinfo -->
							
							</div><!-- 노선상세정보 모달창 끝-->
	        				
	        			</td>
	        			<td>땡땡고속</td>
	        			<td><c:out value="${route.grade}"/> </td>
	        			<td><c:out value="${route.departure}"/> </td>
	        			<td><c:out value="${route.arrival}"/> </td>
	        			<td><c:out value="${route.workday}"/> </td>
	        			<td class="numf" id="stN"><c:out value="${route.st}"/> </td>
	        			<td class="numf"><fmt:formatNumber value="${route.price}" type="number" maxFractionDigits="3"/> </td>
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
			 		<%-- <c:if test="${num eq pages.cri.pageNum}">
			 			
			 			<a style="color: #ff3366;" href="${num}">${num}</a>
			 		</c:if>
			 		<c:if test="${num ne pages.cri.pageNum}"> --%>
			 			
			 			<a href="${num}">${num}</a>
			 		<%-- </c:if> --%>
			 			
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
			</div><!-- 페이징 끝 -->
	
	<form method="get" id="pageMove" action="/admin/routeschedulelist">
		<input type="hidden" name="pageNum" value="${pages.cri.pageNum }">
		<input type="hidden" name="amount" value="${pages.cri.amount }">
		<input type="hidden" name="grade" value="${pages.cri.grade }">
		<input type="hidden" name="departure" value="${pages.cri.departure }">
		<input type="hidden" name="arrival" value="${pages.cri.arrival }">
		<input type="hidden" name="st" value="${pages.cri.st }">
	</form>
	
	
	
	

	</div><!-- middleSw -->
	
</div>
	<script type="text/javascript">
	
	/* 정렬해보기 */
	
	
/* 	function sortTable(n) {
		var table, rows, switching, o, x, y, shouldSwitch, dir, switchcount = 0;
			table = document.getElementById("sortList");
			switching = true;
	}  */
	
	
	
	
	 window.addEventListener('click', e => {
		if(e.target.dataset.sort) {table_sort(e.target);}
	});
	
	function table_sort(target) {
		
		console.log(target.cellIndex);
		
		const $tbody = target.parentElement.parentElement.nextElementSibling;
		            for(let i=0; i<$tbody.children.length; i++){
							//tbody.children : td가 아니라 tr이다
		                sort_func(target);
		
		
		            }
	} 
	
 	function sort_func(target) {
		            const cidx = target.cellIndex; //thead의 th 순서 0부터~
		            const $tbody = target.parentElement.parentElement.nextElementSibling;
		
		            for (let i = 0; i < $tbody.children.length - 1; i++) {
		                const $curr = $tbody.children[i].children[cidx];
		                const $next = $tbody.children[i + 1].children[cidx];
		                let val_curr = $curr.innerText;
		                let val_next = $next.innerText;
						let arr = document.getElementById("stN").innerText;
						
						console.log("확인 : " + arr);
						
		                let predi;
		
		                switch(target.dataset.sort){
		                    case "departure" :
			                        val_curr = val_curr[0].toLowerCase();
			                        val_next = val_next[0].toLowerCase();
			                        break;
			
							    case "departure" :
				                     val_curr = parseInt(val_curr);
				                     val_next = parseInt(val_next);
				                     break;
			                        
			                    case "arrival" :
			                        val_curr = val_curr[0].toLowerCase();
			                        val_next = val_next[0].toLowerCase();
			                        break;
			
							    case "arrival" :
				                       val_curr = parseInt(val_curr);
				                       val_next = parseInt(val_next);
				                        break;
				
								case "st" :
									
			                        val_curr = val_curr[0].toLowerCase();
			                        val_next = val_next[0].toLowerCase();
			                        break;
									
							    case "st" :
				                     val_curr = parseInt(val_curr);
				                     val_next = parseInt(val_next);
				                     break;
			                }
		
						
		
		                 if (val_curr > val_next) {
			                    $tbody.insertBefore($curr.parentElement, $next.parentElement.nextElementSibling);
			                }
		            }
	} //sort_func 
	
	
		//체크박스 선택하면 snum 값이 담김
	function oneCheckbox(c) {
		
		console.log(c);
		
		var obj = document.getElementsByName("snum");
		
		for(var i = 0; i < obj.length; i ++){
			
			
			if(obj[i] != c){
				obj[i].checked = false;
				
			}
		}
	} //체크박스 중복 방지
	
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
			
			
			
			
			 $(".getInfo").hide(); 
			
			 var arr1 = []; //출발지
			 var ddd = [];
			 
			 $.getJSON("/admin/searchA.json", function (arrivalResult) {
				 console.log("도착지 : " + arrivalResult);
					console.log(arrivalResult);
					
					for(var j =0; j < arrivalResult.length; j++){
						
						
						const dstr = arrivalResult[j].arrival;
						
						//console.log(arrivalResult[j].arrival);
						ddd[j] = dstr;
						
						
					}
					
					for(var j = 0; j < ddd.length; j++){
						
						//console.log(ddd[j]);
						$("#destination").append("<option value=" + ddd[j]+ ">" + ddd[j] + "</option>");
						
					}
			 }).fail(function(xhr, status, err){
			 		console.log(xhr);
			 	});
			 
			 
			 
			 $.getJSON("/admin/searchD.json", function (departResult) {
			
				// console.log("진입 : " + departResult);
				// console.log(departResult);
				 

				 for(var i=0; i <  departResult.length; i++){
					 
					 const str = departResult[i].departure;
					 
					// console.log(departResult[i].departure);
					 arr1[i] = str;
					 
				 }
				 
				 for(var i = 0; i < arr1.length; i++){
					//	console.log(arr1[i]);
						$("#depart").append("<option value=" + arr1[i]+ ">" + arr1[i] + "</option>");
				
				} 
				 
			
			}).fail(function(xhr, status, err){
		 		console.log(xhr);
		 	});
			 console.log("외부");
			 console.log(arr1);
			 
			
				$("#depart").append("<option disabled selected>--출발지--</option>");
				
				//$("#departure").empty(); //재선택할 시 arrival의 값들을 제거
				/* for(var i = 0; i < arr1.length; i++){
						console.log(arr1[i]);
						$("#depart").append("<option value=" + arr1[i]+ ">" + arr1[i] + "</option>");
				
				} */
			
			$("#addBtn").on("click", function () {
				self.location = "/admin/routescheduleadd";
			}); //등록 버튼 함수
		
			$("#modBtn").on("click", function (e) {
				
					
				e.preventDefault();
				
				var aa = document.getElementsByClassName('move');
				
				var snum = 0;
				
				for(var i = 0; i < aa.length; i ++){
					
					if(aa[i].checked === true){
						
						snum = aa[i].value;
						
						self.location = "/admin/routeschedulemodify?snum="+ snum;
						
						return true;
					}
				}
				alert("노선을 선택해주세요."); 
				
				return false;
				
			}); // 수정 버튼 함수
			
			$(".move").on("checked", function () {
				
				e.preventDefault();
				console.log("체크됨");
				
			});
			
			$(".modalCloseBtn").on("click", function (e) {
				$(".getInfo").hide();
			});
			
			
			
			
			var pageMove = $("#pageMove");
			
			$(".pageInfo a").on("click", function (e) {
				
				e.preventDefault();
				
				console.log("클릭되었다.");
				
				pageMove.find("input[name='pageNum']").val($(this).attr("href"));								
				
				pageMove.submit(); 
				
			
			}); //pageInfo  클래스 안의 a태그를 누르면 작동하는 함수
			
			
			
			
		}); // document ready 함수
		
/* 		var coloring = document.querySelectorAll('.coloring');
		for(var k = 0; k < coloring.length; k++){
			coloring[k].addEventListener("click", getColor);
			function getColor(){
				for(var l = 0; l < coloring.length; l++){
					coloring[l].removeAttribute("class", "active");
					console.log("컬러 확인");
				}
				this.setAttribute("class", "active");
				console.log("컬러 들어왔나");
			}
		} */
		
	
		
		function openGetInfoModal(a) {
			console.log("진입");
			console.log(a);
			
			var snum = a;
			
			
			//document.getElementById("sno").value = snum;
			$(".getInfo").hide(); 
			$('#' + snum).show();
			
		
			/* $(".modal-content").load("/routescheduleget?snum=" + a); */
			
		} //모달 오픈
		
		
		
		
		$(document).on("change", "#depart", function () {
			
			console.log("출발지");
			
			var depart = $("#depart option:selected").val();
			
			console.log("선택된 출발지 : " + depart);
			
				
			
			//출발지를 임의의 배열에 담는다
			//선택된 값을 함수로 가지고 온다(돔제어 = js)
			//for문을 돌린다(if , continue로 위로 올린다)
		});
		
	
		
		
		
		
	</script>
	
	
	
</body>
</html>