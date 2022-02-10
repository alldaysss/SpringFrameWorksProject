<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>마이페이지</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
  <style>
  	#usertap:hover {
  		border: solid 0.3px rgba(255, 0, 0, 0.2);
  	}
  	#usertap2:hover {
  		border: solid 0.3px rgba(255, 0, 0, 0.2);
  	}
  	#usertap3:hover {
  		border: solid 0.3px rgba(255, 0, 0, 0.2);
  	}
  </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<p><br/></p>
	<div class="d-flex justify-content-around ml-5 mr-5"  id="infor">
	  <div class= "col-3 p-0" id="usertap" >
			<div class="container">
				<h2>회원정보</h2>
				<hr/>
				<font color="blue">${sMid}</font>님 로그인 중입니다.<br/>
				<p>현재 <font color="green"> ${sStrLevel}</font>입니다.</p>
				<p></p>
				<p>회원정보 : <br/>
					게시판에 올린글수 : <font color="blue">${boardCnt}</font> 개<br/>
					Point : <font color="green">${vo.point}</font>
				</p>
				<hr/>
				<button type="button" class="btn btn-dark" onclick="location.href='${ctp}/user/userPwdCheck';">회원정보변경</button>
				<hr/>
			</div>
		</div>
		<div class="col-3 p-0" id="usertap2">
			<div class="container">
				<h2>나의 주문 내역</h2>
				<hr/>
				<p>구매하신 상품을 조회할 수 있습니다.</p>
				<br/><br/><br/><br/><br/><br/><hr/>
				<button type="button" class="btn btn-dark" onclick="location.href='${ctp}/alcohol/myOrderDuration?startDates=${startDates}&endDates=${endDates}';">주문내역</button>
				<br/><hr/>
			</div>
		</div>
		<div class="col-3 p-0" id="usertap3">
			<div class="container">
				<h2>방문예약/조회</h2>
				<hr/>
				<p>매장에 직접 방문하여 시음 등의 혜택을 누릴 수 있습니다.</p>
				<hr/>
				<br/><br/><br/><br/><br/><br/>
				<hr/>
				<button type="button" class="btn btn-dark" onclick="location.href='${ctp}/calendar/calendarForm';">예약현황</button>
				<hr/>
			</div>
		</div>
	</div>
<br/>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>