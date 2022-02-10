<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>회원로그인</title>
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
	 			<h4><font style="color: white">회원 로그인</font></h4><br/>
		    <form name="myform" method="post" class="was-validated">
		    	<div class="container">
		        <label for="mid" class="visually-hidden">아이디</label>
		        <input type="text" id="mid" name="mid" value="${mid}" class="form-control " placeholder="아이디를 입력하세요" required autofocus><br/>
		        <label for="password" class="visually-hidden">패스워드</label>
		        <input type="password" id="pwd" name="pwd" class="form-control " placeholder="패스워드" required><br/>
		        <button class="btn btn-light" type="submit">로그인하기</button>&nbsp;
		        <button class="btn btn-light" type="button" onclick="location.href='${ctp}/';" >돌아가기</button>&nbsp;
					  <button class="btn btn-light" type="button" onclick="location.href='${ctp}/user/userInput';" >회원가입</button><br/>
					  <div class="row" style="font-size:12px;">
					    <span class="col mt-3"><input type="checkbox" name="idCheck" checked/> 아이디 저장</span>
					    <span class="col mt-3">[<a href="${ctp}/user/userIdSearch">아이디찾기</a>] / [<a href="${ctp}/user/userPwdSearch">비밀번호찾기</a>]</span>
		      	</div>
		      </div>
	    	</form>
		</main>
	</div>
</div>
<br/>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>