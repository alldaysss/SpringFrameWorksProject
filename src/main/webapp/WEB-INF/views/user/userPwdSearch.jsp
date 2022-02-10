<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>비밀번호 찾기</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
</head >
<body class="text-center">
<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<p><br/></p>
<div class="container">
	<div class="container-sm w-50 p-3 my-3 bg-dark text-white">
		<main class="form-signin">
	      <img src="${ctp}/images/logo.png" alt="" width="150px">
	 			<h4><font style="color: white">비밀번호 찾기</font></h4><br/>
		    <form method="post" class="was-validated">
		    	<div class="container">
		        <label for="mid" class="visually-hidden">아이디 : </label>
		        <input type="text" id="mid" name="mid" class="form-control " placeholder="회원 아이디를 입력하십시오" required autofocus><br/>
		        <label for="toMail" class="visually-hidden">이메일</label>
		        <input type="text" id="toMail" name="toMail" class="form-control " placeholder="회원가입시 등록한 이메일을 입력하십시오" required><br/>
		        <button class="btn btn-light" type="submit">임시 비밀번호 발급</button>&nbsp;
		        <button class="btn btn-light" type="button" onclick="location.href='${ctp}/user/userLogin';" >돌아가기</button>&nbsp;
		      </div>
	    	</form>
		</main>
	</div>
</div>
<br/>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>