<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>아이디 검색 리스트</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<p><br/></p>
<div class="container">
	<div class="container-sm w-50 p-3 my-3 bg-dark text-white">
		<main class="form-signin">
	      <img src="${ctp}/images/logo.png" alt="" width="150px">
	 			<h4><font style="color: white">검색된 아이디는?</font></h4><br/>
		    <form name="myform" method="post" class="was-validated">
		    	<div class="container">
		        <p>입력하신 이메일주소(<font color="white"><b>${vos[0].email}</b></font>)로 검색된 아이디는 아래와 같습니다.</p>
		        <c:forEach var="vo" items="${vos}" varStatus="st">
				      <c:set var="mid1" value="${fn:substring(vo.mid,0,2)}"/>
				      <c:set var="mid2" value="${fn:substring(vo.mid,4,fn:length(vo.mid))}"/>
				      <p>${st.count}. <font color="blue">${mid1}**${mid2}</font></p>
				    </c:forEach>
		        <br/>
		        <p><input type="button" value="돌아가기" onclick="location.href='${ctp}/user/userLogin';"/></p>
		      </div>
	    	</form>
		</main>
	</div>
</div>
<br/>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>