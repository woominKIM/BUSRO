<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey={개인 KEY값}"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.min.js"></script>
<head>
<meta charset="UTF-8">
<title>Welcome busro</title>
<%@include file="./includes/userHeader.jsp" %>
<link rel="stylesheet" href="/resources/css/common.css">
<link rel="stylesheet" href="/resources/css/main.css">
</head>
<body>
<div class="gallary_area"></div>
<div class="wrapper">
	<div class="contentWrap">	
		<div class="content_area">
			<div class="top_area">
				<div class="map_area">
					<div id="map" style="width:100%;height:100%;"></div>
				</div>
				<div class="search_area">
					<div id="search_content" style="width:100%;height:100%;">
						<form role="form" action="/schedule/scheduleList" method="get" style="width:100%;height:100%;margin:0px;">
							<div class="rdo_area">
								<div class="rdoBox">
		                			<input id="roundTripRdo" type="radio" name="chkRoundTrip" value="2" checked="checked"><span>왕복</span>
		                		</div>
		                		<div class="rdoBox">
		                			<input id="oneWayRdo" type="radio" value="0" name="chkRoundTrip"><span>편도</span>
		                		</div>
	                		</div>
				    		<table class="search_table">
				    			<thead style="height:20%;">
				    				<tr>
				    					<th colspan="8" style="width:100%;"></th>
				    				</tr>
				    			</thead>
					            <tbody>
					                <tr>
					                    <th style="width:20%;">출발지</th>
					                    <th style="width:10%;"></th>
					                    <th style="width:20%;">도착지</th>
					                    <th style="width:2%;"></th>
					                    <th class="leaveDaySpace" style="width:22%;">가는날</th>
					                    <th style="width:2%;"></th>
					                    <th class="comebackDaySpace" style="width:22%;">오는날</th>
					                    <th style="width:2%;"></th>
					                </tr>
					                <tr>
					                    <td>
					                    	<select id="departureSelect" class="terminalSelect underline" style="width: 100px;" name="departure">
					                    	</select>
					                    </td>
					                    <td>
					                    	<div id="destIcon" style="display: flex; justify-content: center; align-items: center;">
						                    	<div id="destIconDiv" class="perfectCircle">
						                    		<img id="destIconImg" width="26" height="26" src="/resources/img/roundTrip.png">
						                    	</div>
					                    	</div>
					                    </td>
					                    <td>
					                    	<select id="arrivalSelect" class="terminalSelect underline" style="width: 100px;" name="arrival">
					                    	</select>
					                    </td>
					                    <td></td>
					                    <td class="leaveDaySpace">
					                    	<input class="dayInput" id="leaveDayInput" type="text" style="width:96%;" name="leaveDay" autocomplete="off"/>
					                    </td>
					                    <td></td>
					                    <td class="comebackDaySpace">
											<input class="dayInput" id="comebackDayInput" type="text" style="width:96%;" name="comebackDay" autocomplete="off"/>
										</td>
										<td></td>
					                </tr>
					                <tr style="height:40%;">
					                	<td colspan="4"></td>
					                	<td colspan="4">
					                		<button id="next" type="submit" style="float:right;">승차권 조회</button>
					                	</td>
					                </tr>
				            	</tbody>
				        	</table>
				    	</form>
			    	</div>
				</div>
			<div class="clearfix"></div>			
		</div>
		<div class="mid_area">
			<c:if test="${fn:length(nList) > 0}">
				<div class="mid_table_area">
				<div class="mid_table_title"><span>공지사항</span></div>
					<div class="tableWrap">
						<table class="mid_table">
							<tr class="seperateTh26">
								<th class="thead2" style="width: 700px;">제목</th>
								<th class="thead3" style="width: 300px;">등록일</th>
							</tr>
							<c:forEach items="${nList}" var="toplist">
								<tr class="seperateTd26">
									<td>${toplist.title}</td>
									<td class="centerFont"><fmt:formatDate pattern="yyyy-MM-dd" value="${toplist.regdate}"/></td>
								</tr>
							</c:forEach>
						</table>
					</div>
				</div>
				<div class="ads_area">
					<img class="adsImage" src="/resources/img/ads.png">
				</div>
			</c:if>
		</div>
		</div>
	</div>
</div>
<%@include file="./includes/footer.jsp" %>
</body>
<script type="text/javascript">
$(document).ready(function(){
	$(".dayInput").attr("disabled",true);
	$("#arrivalSelect").attr("disabled",true);
	
	//출발지 목록 불러오기
	$.getJSON("schedule/getDepartureList",function(dList){
		var departureSelectInner = ""; 
		departureSelectInner += "<option value=\"none\" hidden></option>";
		$.each(dList,function(index, str){
			departureSelectInner += ("<option value=" + str + ">" + str + "</option>");
		});
		$("#departureSelect").html(departureSelectInner);
	});
	
	//터미널 [지명,위도,경도] 정보
	const terminalInfo = [
		['강릉',37.7545149,128.8796152], //강릉:0
		['경주',35.838677,129.2034999], //경주:1
		['고양',37.6429781,126.7898737], //고양:2
		['광주',35.1601666,126.8793224], //광주:3
		['군산',35.978206,126.7244326], //군산:4
		['김포공항',37.560296,126.802333], //김포공항:5
		['대전',36.3509078,127.4370346], //대전:6
		['동대구',35.87794919,128.62966937], //동대구:7
		['동서울',37.5343935,127.0940622], //동서울:8
		['부산',35.2847572,129.0954463], //부산:9
		['부천',37.5041206,126.7566332], //부천:10
		['수원',37.2513342,127.01996], //수원:11
		['안동',36.5745745,128.6759877], //안동:12
		['울산',35.5374868,129.3391238], //울산:13
		['익산',35.9315245,126.9440075], //익산:14
		['전주',35.8346168,127.1291145], //전주:15
		['춘천',37.8646841,127.7175222], //춘천:16
		['통영',34.8850738,128.4169264], //통영:17
		['포항',36.0280159,129.3675997] //포항:18
	];
	
	//지도 초기설정
	var mapContainer = document.getElementById('map');
	var options = {
		center: new kakao.maps.LatLng(terminalInfo[8][1],terminalInfo[8][2]), //지도의 중심좌표
		level: 7 //지도의 레벨(확대, 축소 정도)
	};
	var map = new kakao.maps.Map(mapContainer, options);

	//마커(지도에 표시되는 아이콘) 설정
	var marker = '';
	var imageSrc = "http://t1.daumcdn.net/localimg/localimages/07/2018/pc/img/marker_spot.png"; 
	var imageSize = new kakao.maps.Size(24, 35); 
	var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize); 
	
	//지도 경로 초기설정
	var REST_API_KEY = '{개인 KEY값 사용}'; //개인용으로 수정하기
	var mapUrl = 'https://apis-navi.kakaomobility.com/v1/directions';
	var polyline = '';
	var mapWindow = '';
	var headers = {
		Authorization: "KakaoAK " +REST_API_KEY,
		'Content-Type': 'appliction/json;charset=utf-8'
	};
	
	//지도 전체 초기화 함수
	function mapInit(){
		if(polyline != ''){
			polyline.setMap(null);
		}
		if(mapWindow != ''){
			mapWindow.setMap(null);
		}
		if(marker != ''){
			marker.setMap(null);
		}
	}
	
	//경로값 요청
	async function getBusDirection(depTerminal,arrTerminal){
		var mapDeparture = terminalInfo[8][2]+","+terminalInfo[8][1];
		var mapArrival = terminalInfo[9][2]+","+terminalInfo[9][1];
		var depLat = 0;
		var depLng = 0;
		var arrLat = 0;
		var arrLng = 0;
		
		//출발지,도착지의 위도,경로 입력
		terminalInfo.forEach((terminal,index) =>{
			if(depTerminal === terminal[0]){
				depLat = terminal[1];
				depLng = terminal[2];
				mapDeparture = terminal[2]+","+terminal[1]; //경도,위도
			}
			if(arrTerminal === terminal[0]){
				arrLat = terminal[1];
				arrLng = terminal[2];
				mapArrival = terminal[2]+","+terminal[1]; //경도,위도
			}
		});
		var mapQueryParams = new URLSearchParams({
			origin: mapDeparture,
			destination: mapArrival
		});
		var mapRequestUrl = mapUrl+"?"+mapQueryParams;
		
		//카카오 api서버에 실제경로 요청 및 거리정보 가져오기
		try {
			
			//서버에 경로정보 요청
			var response = await fetch(mapRequestUrl,{
				method: 'GET',
				headers: headers
			});
			if (!response.ok) {
				throw new Error("HTTP error!");
			}
			var data = await response.json();
			var linePath = [];
			data.routes[0].sections[0].roads.forEach(router => {
			    router.vertexes.forEach((vertex, index) => {
			    	if(index %2 === 0){
			        	linePath.push(new kakao.maps.LatLng(router.vertexes[index + 1], router.vertexes[index]));
			    	}
			    });
			});
			
			
			//지도에 경로 기입 및 거리 측정
			if(polyline != ''){
				polyline.setMap(null);
			}
			polyline = new kakao.maps.Polyline({
				path: linePath,
				strokeWeight: 5,
				strokeColor: '#000000',
				strokeOpacity: 0.8,
				strokeStyle: 'solid'
			}); 
			var distanceKM = Math.floor(polyline.getLength()/1000);
			polyline.setMap(map);
			
			//거리정보 윈도우를 도착지에 띄우기
			if(mapWindow != ''){
				mapWindow.setMap(null);
			}
			mapWindow = new kakao.maps.CustomOverlay({
				position: new kakao.maps.LatLng(arrLat,arrLng),
			    content: '<span class="mapWindow" style="display:block; background:#50627F; font-size:10px; text-align:center; border-radius:4px; color:#fff; padding:2px 10px;">'+distanceKM+'(km)</span>'
			});
			mapWindow.setMap(map); 
			
			//출발지,도착지가 모두 보이도록 지도범위 변경
			var bounds = new kakao.maps.LatLngBounds();
			bounds.extend(new kakao.maps.LatLng(depLat,depLng));
			bounds.extend(new kakao.maps.LatLng(arrLat,arrLng));
			map.setBounds(bounds);
	    } catch (error) {
	      console.error('Error:', error);
		}
	}
	
	
	
	//현재시간을 yyyy-MM-dd 형식으로 변환
	Date.prototype.toDateInputValue = (function() {
	    var local = new Date(this);
	    local.setMinutes(this.getMinutes() - this.getTimezoneOffset());
	    return local.toJSON().slice(0,10);
	});
	
	
	
	//편도 선택시 템플릿 변환
	$("#oneWayRdo").on("change",function(e){
		$(".leaveDaySpace").attr("colspan",2);
		$("#destIconImg").attr("src","/resources/img/oneWay.png");
		$(".comebackDaySpace").hide();

		//출발지에 따른 지도 업데이트
		var depTerminal = $("#departureSelect option:selected").val();
		departureMapInit(depTerminal);
		
		//기존 진행사항 초기화
		$("#arrivalSelect").val("");
		$(".dayInput").val("");
		$(".dayInput").attr("disabled",true);
	});
	
	//왕복 선택시 템플릿 변환
	$("#roundTripRdo").on("change",function(e){
		$(".leaveDaySpace").attr("colspan",1);
		$("#comebackDayInput").val(new Date().toDateInputValue());
		$("#destIconImg").attr("src","/resources/img/roundTrip.png");
		$(".comebackDaySpace").show();


		//출발지에 따른 지도 업데이트
		var depTerminal = $("#departureSelect option:selected").val();
		departureMapInit(depTerminal);
		
		//기존 진행사항 초기화
		$("#arrivalSelect").val("");
		$(".dayInput").val("");
		$(".dayInput").attr("disabled",true);
	});
	
	
	
	//출발지 선택시 동작 구현
	$("#departureSelect").on("change",function(){
		var departure = $("#departureSelect option:selected").val();
		$.getJSON("schedule/getArrivalList/"+departure,function(aList){
			var arrivalSelectInner = ""; 
			arrivalSelectInner += "<option value=\"none\" hidden></option>";
			$.each(aList,function(index, str){
				arrivalSelectInner += ("<option value=" + str + ">" + str + "</option>");
			});
			$("#arrivalSelect").attr("disabled",false);
			$("#arrivalSelect").empty();
			$("#arrivalSelect").html(arrivalSelectInner);
		});
		
		//출발지에 따른 지도 업데이트
		var depTerminal = $("#departureSelect option:selected").val();
		departureMapInit(depTerminal);
		
		//기존 진행사항 초기화
		$(".dayInput").val("");
		$(".dayInput").attr("disabled",true);
	});
	
	//출발지 선택시 맵 갱신
	function departureMapInit(depTerminal){
		var depLat = terminalInfo[8][1];
		var depLng = terminalInfo[8][2];
		
		mapInit();
		terminalInfo.forEach((terminal,index) =>{
			if(depTerminal === terminal[0]){
				depLat = terminal[1];
				depLng = terminal[2];
				map.setLevel(7);
				map.setCenter(new kakao.maps.LatLng(depLat,depLng));
			}
		});

		//출발지 마커 띄우기
		marker = new kakao.maps.Marker({
			position: new kakao.maps.LatLng(depLat,depLng),//마커 찍기
			title: depTerminal,
			image: markerImage
		});
		marker.setMap(map);
	}
	
	//도착지 선택시 동작 구현
	$("#arrivalSelect").on("change",function(){
		
		//지도 경로 추출
		var depTerminal = $("#departureSelect option:selected").val();
		var arrTerminal = $("#arrivalSelect option:selected").val();
		getBusDirection(depTerminal,arrTerminal);
		
		//기존 진행사항 초기화
		$(".dayInput").val("");
		$(".dayInput").attr("disabled",true);
		
		updateDepCalendar();
	});


	
	//가는날 달력 선택시 동작 구현
	$("#leaveDayInput").on("change",function(){
		if(($("input[name=chkRoundTrip]:checked").val()) == 2){
			$("#comebackDayInput").val('');
			updateArrCalendar();
		} else {
			$("#comebackDayInput").attr("disabled",false);
			$("#comebackDayInput").val("2099-12-31");
		}
	});
	
	//오는날 달력 선택시 동작 구현
	/*$("#comebackDayInput").on("change",function(){});*/
	
	
	
	//화살표 버튼 클릭시 출발지와 도착지가 바뀜
	$("#destIcon").on("click",function(){
		if(($("#departureSelect").val() != "none" && $("#arrivalSelect").val() != "none")&&($("#departureSelect").val() != null && $("#arrivalSelect").val() != null)){
			var departure = $("#arrivalSelect option:selected").val();
			$.getJSON("schedule/getArrivalList/"+departure,function(aList){
				if(aList.length == 0){
					alert("출발지:"+$("#arrivalSelect").val()+", 도착지:"+$("#departureSelect").val()+" 에 대한 스케쥴이 없습니다.");
					return false;
				}
				var arrivalSelectInner = ""; 
				arrivalSelectInner += "<option value=\"none\" hidden></option>";
				$.each(aList,function(index, str){
					arrivalSelectInner += ("<option value=" + str + ">" + str + "</option>");
				});
				$("#arrivalSelect").empty();
				$("#arrivalSelect").html(arrivalSelectInner);
				$("#arrivalSelect").val($("#departureSelect").val());
				$("#departureSelect").val(departure);
				
				//지도 업데이트
				var depTerminal = $("#departureSelect option:selected").val();
				var arrTerminal = $("#arrivalSelect option:selected").val();
				departureMapInit(depTerminal);
				getBusDirection(depTerminal,arrTerminal);
				
				
				//기존 진행사항 초기화
				$(".dayInput").val("");
				$(".dayInput").attr("disabled",true);
				
				updateDepCalendar();
				
				$("#destIconDiv").removeClass('bgEffect');
				$("#destIconImg").removeClass('rotate');
				$("#destIconDiv").width();
				$("#destIconDiv").addClass('bgEffect');
				$("#destIconImg").addClass('rotate');
			});
		}else {
			alert("출발지와 도착지를 선택해주세요!");
		}
	});
	
	
	//가는날 달력의 초기화/출력
	function updateDepCalendar() {
		$.getJSON("schedule/getScheduleList",function(sList){
			var leaveSet = new Set();
			var chk='';
			
			$.each(sList,function(index, schedule){
				if(schedule.departure === $("#departureSelect option:selected").val() && schedule.arrival === $("#arrivalSelect option:selected").val()){
					if(schedule.workday === '상시'){
						chk='상시';
						return false;
					}
					leaveSet.add(schedule.workday);
					if(leaveSet.size > 1){
						chk='상시';
						return false;
					}
				}
			});
			if(chk != '상시'){
				if(leaveSet.has('평일')){
					getCalendar("#leaveDayInput","평일");
					$("#leaveDayInput").attr("disabled",false);
				}
				else {
					getCalendar("#leaveDayInput","주말");
					$("#leaveDayInput").attr("disabled",false);
				}
			} else {
				getCalendar("#leaveDayInput","상시");
				$("#leaveDayInput").attr("disabled",false);
			}
		});
	}
	
	//오는날 달력의 초기화/출력
	function updateArrCalendar() {
		$.getJSON("schedule/getScheduleList",function(sList){
			var comebackSet = new Set();
			var chk='';
			$.each(sList,function(index, schedule){
				if(schedule.departure === $("#arrivalSelect option:selected").val() && schedule.arrival === $("#departureSelect option:selected").val()){
					if(schedule.workday === '상시'){
						chk='상시';
						return false;
					}
					comebackSet.add(schedule.workday);
					if(comebackSet.size > 1){
						chk='상시';
						return false;
					}
				}
			});
			if(chk != '상시'){
				if(comebackSet.has('평일')){
					getCalendar("#comebackDayInput","평일");
					$("#comebackDayInput").attr("disabled",false);
				}
				else if(comebackSet.has('주말')){
					getCalendar("#comebackDayInput","주말");
					$("#comebackDayInput").attr("disabled",false);
				} else{
					alert("오는편 버스가 없습니다! 편도로 전환됩니다.");
					$("#comebackDayInput").attr("disabled",false);
					$("#comebackDayInput").val("2099-12-31");
					
					var arrTerminalTemp = $("#arrivalSelect option:selected").val();
					$("input:radio[name='chkRoundTrip']:radio[value='0']").trigger('click');
					$("#arrivalSelect").val(arrTerminalTemp).trigger('change');
				}
			} else {
				getCalendar("#comebackDayInput","상시");
				$("#comebackDayInput").attr("disabled",false);
			}
		});
	}
	
	//달력 초기설정
	function getCalendar(name,wd){
		$(name).datepicker({
			dateFormat: 'yy-mm-dd' //Input Display Format 변경
	        ,showOtherMonths: false //빈 공간에 현재월의 앞뒤월의 날짜를 표시
	        ,showMonthAfterYear:true //년도 먼저 나오고, 뒤에 월 표시
			,changeYear: false //콤보박스에서 년 선택 가능
			,changeMonth: false //콤보박스에서 월 선택 가능                
			,showOn: "focus" //button:버튼을 표시하고,버튼을 눌러야만 달력 표시 ^ both:버튼을 표시하고,버튼을 누르거나 input을 클릭하면 달력 표시  
			/*
			,buttonImage: "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif" //버튼 이미지 경로
			,buttonImageOnly: true //기본 버튼의 회색 부분을 없애고, 이미지만 보이게 함
			*/           
			,yearSuffix: "년" //달력의 년도 부분 뒤에 붙는 텍스트
			,monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'] //달력의 월 부분 텍스트
			,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip 텍스트
			,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 부분 텍스트
			,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 부분 Tooltip 텍스트
			,minDate: new Date().toDateInputValue() //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
			,maxDate: "+1Y" //최대 선택일자(+1D:하루후, -1M:한달후, -1Y:일년후)  
		});
		
		//선택 가능한 요일만 활성화
		if(wd === "평일"){
			$(name).datepicker("option","beforeShowDay",function(date){
				return [(date.getDay() != 0 && date.getDay() != 6)]; 
			});
		}
		if(wd === "주말"){
			$(name).datepicker("option","beforeShowDay",function(date){
				return [(date.getDay() != 1 && date.getDay() != 2 && date.getDay() != 3 && date.getDay() != 4 && date.getDay() != 5)]; 
			});
		}
		if(wd === "상시"){
			$(name).datepicker("option","beforeShowDay",null);
		}
		if(name === "#comebackDayInput"){
			$(name).datepicker("option","minDate",$("#leaveDayInput").val());
		}
	}
	
	//검색값을 전부 입력하지 않고 검색할 시 경고 발생
	$("#next").on("click",function(e){
		e.preventDefault();
		var formObj = $("form[role='form']");
		if('${member.id}' == ''){
			location.href="/member/login";
			return false;
		}
		if($("#comebackDayInput").val() == ""){
			alert("검색조건을 모두 입력해주세요.");
		}else{
			if($("#comebackDayInput").val() == "2099-12-31"){
				$("input:radio[name='chkRoundTrip']:radio[value='0']").prop('checked', true); 
			}
			formObj.submit();	
		}
	});
	
	//공지사항 테이블 클릭시 공지사항 이동
	$(".mid_table").on("click",function(e){
		location.href = '/jobAds/wishListShow';
	})
	
});
</script>
</html>