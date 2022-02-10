<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>주문상세내역</title>
</head>
<body>
<div class="container">
  <c:set var="dvPaymentNumber" value="${fn:split(vo.dvPaymentNumber,',')}"/>
  <c:set var="dvPayer" value="${fn:split(vo.dvPayer,',')}"/>
  <c:set var="dvAddress" value="${fn:split(vo.dvAddress,'/')}"/>
  <h3>배송상세조회</h3>
  <br/>
  <hr/>
  <div>주문번호 : ${vo.orderIdx}</div>
  <hr/>
  <div>주문자명 : ${vo.dvName}</div>
  <div>연락처 : ${vo.dvTel}</div>
  <div>주소 : <br/>
		<c:forEach var="vo" items="${dvAddress}">
			| <c:if test="${!empty vo}">${vo}</c:if>
		</c:forEach>
  </div>
  <hr/>
  <div>배송 시 요청 사항: ${vo.dvRequest}</div>
  <hr/>
  <div>결제방식 : ${vo.dvPayment} </div>
  <div>결제번호 :  
  	<c:forEach var="vo" items="${dvPaymentNumber}">
  		<c:if test="${!empty vo}">${vo}</c:if>
  	</c:forEach>
	</div>
  <div>결제처(입금자) : 
  	<c:forEach var="vo" items="${dvPayer}">
  		<c:if test="${!empty vo}">${vo }</c:if>
  	</c:forEach>
  </div>
  <hr/>
  <p><input type="button" value="창닫기" onclick="window.close()"/></p>
</div>
</body>
</html>