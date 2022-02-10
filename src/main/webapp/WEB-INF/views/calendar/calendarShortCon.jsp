<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>예약 상세 내역</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
</head>
<body>
<p><br/></p>
<div class="container">
	<h3>예약상세조회</h3>
  <br/><hr/>
  <div>날짜/시간 : ${vo.CDate}</div>
  <hr/>
  <div>방문목적 : ${vo.part}</div>
  <div>제품명 : ${vo.reItemName}</div>
  <hr/>
  <div>내 용 : ${vo.content}</div>
  <hr/>
  <p><input type="button" value="창닫기" onclick="window.close()"/></p>
</div>
<br/>
</body>
</html>