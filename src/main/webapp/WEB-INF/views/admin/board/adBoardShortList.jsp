<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>게시글 내용 보기</title>
</head>
<body>
<p><br/></p>
<div class="container">
	<hr/>
	<font style="font-size: x-large;"><b>제목 : </b><br/>${vo.title}</font>
	<hr/>
	<b>게시글 내용 :</b> ${fn:replace(vo.content, newLine, '<br/>')}
  <hr/>
  <p><input type="button" value="창닫기" onclick="window.close()"/></p>
</div>
<br/>
</body>
</html>