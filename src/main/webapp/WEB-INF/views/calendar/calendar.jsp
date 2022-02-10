<%@page import="com.spring.cjs2108_bji.vo.CalendarVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>방문예약/취소</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
  <style>
    #td1,#td8,#td15,#td22,#td29,#td36 {
      color: red;
    }
    #td7,#td14,#td21,#td28,#td35,#td42 {
      color: blue;
    }
    .today {
      font-size: 1.1em;
      background-color: pink;
      color: #fff;
      /* text-align: center; */
    }
    #timetable button {
    	background-color: rgba(80,250,150,0.9);
    	border: 0.1px solid rgba(0,0,0,0.2);
    	border-radius: 3px;
    	padding: 5px 22px;
    	box-shadow: 0 0 3px #fff0;
    	margin: 3px;
    	font-family: 'HY나무B';
    }
    #timetable button:hover {
			background-color: rgba(100,150,0,0.1);
    	box-shadow: 0 0 3px lightgray;
		}
		
		.item{display: none;}
  </style>
</head>
<script>
	$(document).ready(function() {
		$("#CalendarListHidden").hide();
		$("#CalendarInputHidden").hide();
	});
	function clickValue(time) {
		var CalendarInput = "";
		if($("#date").html()==""){
			alert("먼저 날짜를 선택하십시오.");
			return false;
		};
		$("#time").html(time);
  	$("#CalendarInputHidden").show();
  	$("#CalendarView").slideDown(0);
  	setTimeout(function() {
  		window.scroll({top : $("#gothere").position().top-1000 , behavior: 'smooth'});
  	}, 0); 
	}

  // 등록취소
  function reserveCancel() {
  	$("#CalendarView").slideUp(200);
  	/* $('.useSw').attr('disabled', false); */
  	$("#CalendarInputHidden").hide();
  	//$("#CalendarInputView").show();
  	$('#timetable').focus();
  }
  
  function datesPick(ymd) {
	  $("#date").html(ymd);
	  //$("#CalendarView").hide();
	  $("#CalendarView").slideUp(200);
	  $("#time").html("");
	  $.ajax({
		  type : "post",
		  url  : "${ctp}/calendar/calendarPicks",
		  data : {cDate : ymd},
		  success : function(data) {
			  $(".useSw").attr("disabled", false);
			  for(let i=0; i< data.length; i++) {
				  $("#"+data[i].cdate.substring(11,13)+data[i].cdate.substring(14,16)).attr("disabled", true);
				  
			  }
		  }
	  });
  }
  
  function testOption() {
	  let temp = $("#itemC").val();
	  
	  $(".item").css("display","none");
	  $("."+temp).css("display","block");
	  
  }
  // 데이터 넘겨주기
  function reserveOk() {
	  let date = $("#date").html();
	  let time = $("#time").html();
	  myform.cDate.value = date +" "+ time;
	  if($("#time").html() ==""){
			alert("시간을 선택하십시오.");
			return false;
		}
	  else if($("#date").html() ==""){
			alert("날짜를 선택하십시오.");
			return false;
		}
	  else if($("#part").val() ==""){
			alert("방문 목적을 선택하십시오.");
			return false;
		}
	  else if ($("#part").val() !="시음") {
		  myform.submit();
	  }
	  else if($("#itemC") && $("#itemC".trim()).val() ==""){
			alert("상품의 분류를 선택하십시오.");
			return false;
		}
	  else if($("#reItemName") && $("#reItemName".trim()).val() ==""){
			alert("상품명을 선택하십시오.");
			return false;
		}
		else {
		  myform.submit();
		}
  }
  // 탭 변경 시 애니메이션 효과
  function selectpart() {
	  if($("#part").val() != "시음") {
		  $(".showhides1").fadeOut();
		  $("#itemC").val("");
		  $("#reItemName").val("");
	  }
	  else {
		  $(".showhides1").fadeIn(); 
	  }
  }
  // 예약 시간 취소
  function DelCheck(idx) {
	  var ans = confirm("예약을 취소 하시겠습니까?");
	  if(!ans) return false;
	  $.ajax({
		  type : "post",
		  url  : "${ctp}/calendar/delTimes",
		  data : {idx : idx},
		  success:function() {
			  alert("선택한 시각의 예약이 취소 되었습니다.");
			  location.reload();
		  }
	  });
  }
  // 일정 내용 상세 보기
  function newWin(idx) {
	  var url = "${ctp}/calendar/calendarShortCon?idx="+idx;
	  window.open(url, "winOpen", "width=450px, height=400px");
  }

</script>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<p><br/></p>
<div class="container">
	<div style="background-color: black; height: 100px; padding: 20px;">
		<div style="font-size: 25px; color: white;">방문예약 / 취소 |</div>
		<div style="font-size: 15px; color: white;">직접 방문하여 주류시음 / 기타문의가 가능합니다.</div>
	</div><br/>
  <div class="row text-center" style=" font-size:1.4em;">
  	<div class="col text-center" style="width: 50%; font-size:0.9em;">
  		<div class="row m-0" > <!-- 날짜 -->
  			<div class="col" ></div>
		    <button class="btn btn-outline-dark btn-sm col-1" onclick="location.href='${ctp}/calendar/calendarForm?yy=${yy-1}&mm=${mm}'" title="이전년도">◁◁</button>&nbsp;
		    <button class="btn btn-outline-dark btn-sm col-1" onclick="location.href='${ctp}/calendar/calendarForm?yy=${yy}&mm=${mm-1}'" title="이전월">◀</button>&nbsp; 
		    <div    class="col-4" style="cursor: pointer;" onclick="location.href='${ctp}/calendar/calendarForm'"><font size="3">${yy} 년 ${mm+1} 월</font></div>
		    <button class="btn btn-outline-dark btn-sm col-1" onclick="location.href='${ctp}/calendar/calendarForm?yy=${yy}&mm=${mm+1}'" title="다음월">▶</button>&nbsp;
		    <button class="btn btn-outline-dark btn-sm col-1" onclick="location.href='${ctp}/calendar/calendarForm?yy=${yy+1}&mm=${mm}'" title="다음년도">▷▷</button>
  			<div class="col"></div>
  		</div>
  		<br/>
  		<div id="temporary"></div>
			<div class="row m-0">
				<div class="col-sm-12" style="height: 400px;">
					<table class="table" style="height: 100%">
						<tr style="text-align: center; font-size: 0.7em; background-color: #FFFACD;height: 10%;">
							<th style="color: red;width: 13%;vertical-align: middle;">일</th>
							<th style="width: 13%;vertical-align: middle;">월</th>
							<th style="width: 13%;vertical-align: middle;">화</th>
							<th style="width: 13%;vertical-align: middle;">수</th>
							<th style="width: 13%;vertical-align: middle;">목</th>
							<th style="width: 13%;vertical-align: middle;">금</th>
							<th style="color: #4169E1;width: 13%;vertical-align: middle;">토</th>
						</tr>
						<tr>
							<c:set var="cnt" value="1"/>
							<c:forEach var="preDay" begin="${preLastDay - (startWeek-2) }" end="${preLastDay}">
								<td id="td${cnt}" style="color: silver; font-size: 0.2em; padding:3px;">
									${preYear}-${preMonth+1}-${preDay}
								</td>
							<c:set var="cnt" value="${cnt=cnt+1}"/>
							</c:forEach>
							<!-- 해당 월 날짜 반복 출력 -->
							<c:forEach begin="1" end="${lastDay}" varStatus="st">
								<c:set var="todaySw" value="${yy == toYear && mm == toMonth && st.count == toDay ? 1 : 0}"/>
								<td id="td${cnt}" ${todaySw == 1 ? 'class=today' : '' } style="font-size:0.7em; padding:3px;"> <!-- 오늘 날짜가 맞으면 지정한 class로 디자인 -->
									<c:set var="ymd" value="${yy}-${mm+1}-${st.count}"/> <!-- 화면에 보여준 날짜를 링크하기 위하여 ymd변수에 담는다. -->
										<c:if test="${yy < toYear || (yy == toYear && mm < toMonth) || (yy == toYear && mm == toMonth && st.count < toDay)}"><span style="opacity: 0.7;">${st.count}</span></c:if>
										<c:if test="${yy > toYear || (yy == toYear && mm > toMonth) || (yy == toYear && mm == toMonth && st.count >= toDay)}"><a href="javascript:datesPick('${ymd}')">${st.count}</a></c:if>
										<br/>
									<!-- part를 찍는중 - 같은 part면 part의 갯수를 누적처리했다. -->
		              <c:set var="tempPart" value=""/>
		              <c:set var="tempCnt" value="0"/>
		              <c:set var="tempSw" value="0"/>
		              
		              <c:set var="tempCDate" value=""/>
		              <c:forEach var="vo" items="${vos}">
		              	<c:if test="${fn:substring(vo.CDate,8,10) == st.count}">
		                  <c:set var="tempSw" value="1"/>
		                  <c:set var="tempCnt" value="${tempCnt +1 }"/>
		                  <c:set var="tempItem" value="${fn:substring(vo.CDate,11,16)}"/>
		                  <c:set var="tempCDate" value="${tempItem}/${tempCDate}}"/>
		                  <%-- <c:set var="tempCDate" value="${(true) ? (tempCDate += ' ' += tempItem) : ''}"/> --%>
		              	</c:if>
		              </c:forEach>
		              
		              <c:if test="${tempCnt != 0}">${tempPart}(${tempCnt}건)</c:if>
								<c:if test="${cnt%7 == 0}">
									<tr></tr>
								</c:if>
								<c:set var="cnt" value="${cnt=cnt+1}"/>
							</c:forEach>
							<!-- 다음월의 날짜를 출력. -->
							<c:forEach begin="${nextStartWeek}" end="7" varStatus="nextDay">
								<td id="td${cnt}" style="color: silver; font-size: 0.2em; padding:3px;">
									${nextYear}-${nextMonth+1}-${nextDay.count}
								</td>
								<c:set var="cnt" value="${cnt=cnt+1}"/>
							</c:forEach>
						</tr>
					</table>
				</div>
			</div>
  		<div>
  			<div></div>
  		</div>
  	</div>
<%--   	==${tempCDate}==
  	<c:set var="cDateValue" value="${fn:split(tempCDate,'/')}"/> 
  	<c:forEach var="cd" items="${cDateValue}">
  	  ~${cd}~
  	</c:forEach> --%>
	  <div class="col text-center" style="width: 50%; font-size:0.9em;" id="timetable">
  		<div style="margin: 25px; 0;"></div>
  		<div style="margin: 25px; 0; font-size: x-large;large;"><b>오전</b></div>
  			<button name="use_btn" class="useSw" onclick="clickValue('10:00')" id="1000">10:00</button>
  			<button name="use_btn" class="useSw" onclick="clickValue('10:30')" id="1030">10:30</button>
  			<button name="use_btn" class="useSw" onclick="clickValue('11:00')" id="1100">11:00</button>
  			<button name="use_btn" class="useSw" onclick="clickValue('11:30')" id="1130">11:30</button>
  		<div style="margin: 25px; 0; font-size: x-large;large;"><b>오후</b></div>
  			<button name="use_btn" class="useSw" onclick="clickValue('13:00')" id="1300">13:00</button>
  			<button name="use_btn" class="useSw" onclick="clickValue('13:30')" id="1330">13:30</button>
  			<button name="use_btn" class="useSw" onclick="clickValue('14:00')" id="1400">14:00</button>
  			<button name="use_btn" class="useSw" onclick="clickValue('14:30')" id="1430">14:30</button>
  			<div style="margin: 10px;"></div>
  			<button name="use_btn" class="useSw" onclick="clickValue('15:00')" id="1500">15:00</button>
  			<button name="use_btn" class="useSw" onclick="clickValue('15:30')" id="1530">15:30</button>
  			<button name="use_btn" class="useSw" onclick="clickValue('16:00')" id="1600">16:00</button>
  			<button name="use_btn" class="useSw" onclick="clickValue('16:00')" id="1630">16:30</button>
  			<div style="margin: 10px;"></div>
  			<button name="use_btn" class="useSw" onclick="clickValue('17:00')" id="1700">17:00</button>
  			<button name="use_btn" class="useSw" onclick="clickValue('17:30')" id="1730">17:30</button>
  			<button name="use_btn" class="useSw" onclick="clickValue('18:00')" id="1800">18:00</button>
  			<button name="use_btn" class="useSw" onclick="clickValue('18:30')" id="1830">18:30</button>
	  </div>
  </div>
  <div style="display: none;" id="tempPop"></div>
  <br/>
  <div style="margin: 0 auto;">
	  <div style="display: none;" id="CalendarView">
	  	<form name="myform"  action="${ctp}/calendar/calendarForm" method="post">
		  	<table class="table table-borderless p-0 text-center" style="width: 50%; font-size:1.2em;margin:0 auto;">
					<tr>
						<th colspan="2">
							날짜 : <span id="date"></span> 시간 :<span id="time"></span>
							<input type="hidden" name="cDate"/>
						</th>
					</tr>
					<tr><th style="width: 20%">방문목적 :</th>
						<td class="col">
							<div class='form-group'>
							<select name='part' id="part" class='form-control' onchange="selectpart()">
								<option value="" selected>선택해주세요</option>
								<option value="시음">시음</option>
								<option value="기타">기타</option>
								<option value="단순방문">단순방문</option>
					  	</select>
					  	</div>
				  	</td>
				  </tr>
			    <tr class="showhides1">
			    	<th style="width: 20%">제품분류 :</th>
			    	<td class="col"><span id="test12"></span>
							<div class="form-group">
								<select id="itemC" name="itemCode" class="form-control" onchange="testOption()">
									<option value="">선택해주세요</option>
										<c:forEach var="catevo" items="${alCateVos}">
											<c:if test="${catevo.itemCode == 'FW' }"><option value="FW">프랑스와인</option></c:if> 
											<c:if test="${catevo.itemCode == 'Y' }"><option value="Y">중국명주</option></c:if> 
											<c:if test="${catevo.itemCode == 'J' }"><option value="J">사케</option></c:if> 
										</c:forEach>
								</select>
							</div>
				  	</td>
				  </tr>
			    <tr class="showhides1">
			    	<th style="width: 20%">제품명 : </th>
			    	<td class="col">
							<div id="itemName" class='form-group'>
								<select id="reItemName" name="reItemName" class="form-control">
									<option value="">선택해주세요</option>
										<c:forEach var="vo" items="${alVos}">
											<option class="item ${vo.itemCode}" value="${vo.itemName}">${vo.itemName}</option>
										</c:forEach>
								</select>
							</div>
			  		</td>
			  	</tr>
					<tr>
					<tr>
						<th style="width: 20%">방문내용 : </th><td><textarea name='content' rows='3' class='form-control'></textarea></td>
					</tr>
			  	<tr>
			  		<th colspan='2'>
			  		<div style='text-align:center;'>
				  		<input type='button' value='방문예약' id='reserveStart' class='btn btn-dark' onclick='reserveOk()'> &nbsp;
				  		<input type='button' value='취소하기' id='cancelStart' class='btn btn-dark' onclick='reserveCancel()'>
						</div><br/>
						</th>
					</tr>
				</table>
				<input type="hidden" name="mid" value="${sMid}"/>
			</form>
	  </div>
  </div>
	  <c:if test="${scheduleCnt != 0}">
		  <table id="gothere" class="table table-hover">
		    <tr class="table table-warning" style="text-align:center">
		      <th style="width:15%;">번호</th>
		      <th style="width:15%;">날짜/시간</th>
		      <th style="width:15%;">방문목적</th>
		      <th style="width:15%;">제품명</th>
		      <th style="width:35%">내 용</th>
		      <th style="width:5%"> </th>
		    </tr>
		    <c:forEach var="vo" items="${vos}" varStatus="st">
		    <tr class="table" style="text-align:center; font-family: '맑은고딕'">
		      <td>${st.count}</td>
		      <td><b>${vo.CDate}</b></td>
		      <td>${vo.part}</td>
		      <td>${vo.reItemName}</td>
		      <td style="text-align:center;"><b>
		      	<c:if test="${fn:length(vo.content) > 10}"><a href="javascript:newWin(${vo.idx});">${fn:substring(vo.content,0,10)}...</a></c:if>
		      	<c:if test="${fn:length(vo.content) <= 10}"><a href="javascript:newWin(${vo.idx});">${fn:substring(vo.content,0,9)}</a></c:if>
		      	</b>
		      </td>
		      <td>
		      	<input type="button" value="삭제" onclick="DelCheck(${vo.idx})" class="btn btn-outline-dark btn-sm"/>
		    	</td>
		    </tr>
		    </c:forEach>
		  </table>
	  <hr/>
  </c:if>
</div>
<br/>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>