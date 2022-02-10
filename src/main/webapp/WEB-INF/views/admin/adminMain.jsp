<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>관 리 자 페 이 지</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<jsp:include page="/WEB-INF/views/admin/adnav.jsp"/>
</head>
<body>
<jsp:include page="/WEB-INF/views/admin/adContent.jsp"/>
<p><br/></p>
<div class="container">

</div>
<br/>
</body>
</html>