<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Lato">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<html>
<style>
.logo > ul {
	margin-right : 10px;
	margin-bottom : 0px;
	padding : 0;
	width: 14%;
}
.logo li {
    list-style: none;
    float: right;
    font-size: 15px;
    margin-right: 15px;
    margin-top: 5px;
    color: white;
}

</style>
<script>
	// 검색버튼 클릭시 수행할 내용.
	function searchCheck() {
		var searchString = searchForm.searchString.value;
		if(searchString == "") {
			alert("검색어를 입력하세요");
			searchForm.searchString.focus();
		}
		else {
			searchForm.submit();
		}
	}
</script>
<head>
    <meta charset="UTF-8">
    <title>header_home</title>
</head>
<body>
	<div class="logo row" id = "logo" style="background-color: black" >
		<div class="col" style="text-align: center"><a href="${ctp}/"><img src="${ctp}/images/logo.png" width="180px" style="margin-left:30px; margin-right:170px;"></a></div>
		<div class="container col-6 p-1" >
			<form name="searchForm" method="post" action="${ctp}/alcohol/itemSearch">
			  <div class="d-flex align-items-center" style="margin-top: 30px;">
			    <input class="form-control mt-3" type="search" placeholder="상품명을 입력하세요" name="searchString" aria-label="Search"> &nbsp;&nbsp;
			    <input class="btn btn-light mt-3"  type="button" value="검색" onclick="searchCheck()"/>
			    <!-- <button id="searchBtn" class="btn btn-outline-success flex-shrink-0 mt-3" type="button" >검색</button> -->
			  </div>
		  </form>
		</div>
		<div class="col-3" >
		  <c:set var="startDates" value="<%=new java.util.Date() %>"/>
      <c:set var="startDates"><fmt:formatDate value="${startDates}" pattern="yyyy-MM-dd"/></c:set>
      <c:set var="endDates" value="<%=new java.util.Date() %>"/>
      <c:set var="endDates"><fmt:formatDate value="${endDates}" pattern="yyyy-MM-dd"/></c:set>
			<ul style="float: right;">
	      <li><a href="${ctp}/alcohol/myOrderDuration?startDates=${startDates}&endDates=${endDates}" style="cursor:pointer;">MyOrder🚛</a></li>
	      <li><a href="${ctp}/alcohol/cartList" style="cursor:pointer;">WishList🧳</a></li>
	      <li>
	      	<c:if test="${empty sLevel || sLevel == 99}"><a style="cursor:pointer;" href="${ctp}/user/userInput"><font> Join</font></a></c:if>
	      	<c:if test="${!empty sLevel && sLevel != 99}">
		      	<c:if test="${sLevel == 0}"><a style="cursor:pointer;" href="${ctp}/admin/adminMain"><font>Admin</font></a></c:if>
		      	<c:if test="${sLevel != 0}"><a style="cursor:pointer;" href="${ctp}/user/userMain"><font> My page</font></a></c:if>
	      	</c:if>
	      </li>
	      <li>
	        <c:if test="${sLevel == 99 || empty sLevel}"><a style="cursor:pointer;" href="${ctp}/user/userLogin"><font> Login</font></a></c:if>
	        <c:if test="${sLevel != 99 && !empty sLevel}"><a style="cursor:pointer;" href="${ctp}/user/userLogout"><font> LogOut</font></a></c:if>
	      </li>
	     </ul>
     </div>
  </div>
</body>
</html>