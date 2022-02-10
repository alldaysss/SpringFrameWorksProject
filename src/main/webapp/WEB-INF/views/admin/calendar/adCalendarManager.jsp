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
  
  function datesPick(ymd) {
			location.href="${ctp}/admin/adCalendarManager?cDate="+ymd;
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
<jsp:include page="/WEB-INF/views/admin/adnav.jsp" />
<p><br/></p>
<div class="container">
	<div style="background-color: black; height: 100px; padding: 20px;">
		<div style="font-size: 25px; color: white;">월 별 일정 조회 |</div>
		<div style="font-size: 15px; color: white;">해당 월에 예약 된 일정을 확인/관리합니다.</div>
	</div><br/>
  <div class="row text-center" style=" font-size:1.4em;">
  	<div class="col text-center" style="width: 50%; font-size:0.9em;">
  		<div class="row m-0" > <!-- 날짜 -->
  			<div class="col" ></div>
		    <button class="btn btn-outline-dark btn-sm col-1" onclick="location.href='${ctp}/admin/adCalendarManager?yy=${yy-1}&mm=${mm}'" title="이전년도">◁◁</button>&nbsp;
		    <button class="btn btn-outline-dark btn-sm col-1" onclick="location.href='${ctp}/admin/adCalendarManager?yy=${yy}&mm=${mm-1}'" title="이전월">◀</button>&nbsp; 
		    <div    class="col-4" style="cursor: pointer;" onclick="location.href='${ctp}/admin/adCalendarManager'"><font size="3">${yy} 년 ${mm+1} 월</font></div>
		    <button class="btn btn-outline-dark btn-sm col-1" onclick="location.href='${ctp}/admin/adCalendarManager?yy=${yy}&mm=${mm+1}'" title="다음월">▶</button>&nbsp;
		    <button class="btn btn-outline-dark btn-sm col-1" onclick="location.href='${ctp}/admin/adCalendarManager?yy=${yy+1}&mm=${mm}'" title="다음년도">▷▷</button>
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
										<a href="javascript:datesPick('${ymd}')">${st.count}</a>
										<br/>
									<!-- part를 찍는중 - 같은 part면 part의 갯수를 누적처리했다. -->
		              <c:set var="tempPart" value=""/>
		              <c:set var="tempCnt" value="0"/>
		              <c:set var="tempSw" value="0"/>
		              <c:forEach var="vo" items="${adVos}">
		              	<c:if test="${fn:substring(vo.CDate,8,10) == st.count}">
		                  <c:set var="tempSw" value="1"/>
		                  <c:set var="tempCnt" value="${tempCnt +1 }"/>
		                  <c:set var="tempItem" value="${fn:substring(vo.CDate,11,16)}"/>
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
  </div>
  <br/>
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
	    <c:forEach var="clVo" items="${clVos}" varStatus="st">
	    <tr class="table" style="text-align:center; font-family: '맑은고딕'">
	      <td>${st.count}</td>
	      <td><b>${clVo.CDate}</b></td>
	      <td>${clVo.part}</td>
	      <td>${clVo.reItemName}</td>
	      <td style="text-align:center;"><b>
	      	<c:if test="${fn:length(clVo.content) > 10}"><a href="javascript:newWin(${clVo.idx});">${fn:substring(clVo.content,0,10)}...</a></c:if>
	      	<c:if test="${fn:length(clVo.content) <= 10}"><a href="javascript:newWin(${clVo.idx});">${fn:substring(clVo.content,0,9)}</a></c:if>
	      	</b>
	      </td>
	      <td>
	      	<input type="button" value="삭제" onclick="DelCheck(${clVo.idx})" class="btn btn-outline-dark btn-sm"/>
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