<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="Responsive Bootstrap4 Shop Template, Created by Imran Hossain from https://imransdesign.com/">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title> Allday's liquor shop </title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
</head>
<body>
<div style="width: 100%; ">
<jsp:include page="/WEB-INF/views/include/header.jsp" />
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/video.jsp"/>

<!-- 베스트 3 판매상품 -->
<%--   <div class="w3-container w3-content w3-center w3-padding-64" style="max-width:800px" id="band">
    <h2 class="w3-wide"><b>Best 3</b></h2>
    <p class="w3-opacity"><i>이달의 베스트 셀러</i></p>
    <p class="w3-justify">구매자분들이 이달 가장 많이 구매하신 상품입니다.</p>
    <div class="w3-row w3-padding-32">
      <div class="w3-third">
        <p>Name</p>
        <img src="${ctp}/images/bombay.jpg" class="w3-round w3-margin-bottom" alt="Random Name" style="width:60%">
      </div>
      <div class="w3-third">
        <p>Name</p>
        <img src="${ctp}/images/martini.jpg" class="w3-round w3-margin-bottom" alt="Random Name" style="width:60%">
      </div>
      <div class="w3-third">
        <p>Name</p>
        <img src="${ctp}/images/royal.jpg" class="w3-round" alt="Random Name" style="width:60%">
      </div>
    </div>
  </div> --%>
<!-- 시음 문의 -->
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</div>
</body>
</html>