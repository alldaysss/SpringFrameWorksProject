<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="EUC-KR">
	<title>판 매 주 류 리 스 트</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<p><br/></p>
<div class="container">
	<div class="page_title">
		<jsp:include page="/WEB-INF/views/include/mainslide.jsp"/>
	</div>
	<hr/>
	<div style="background-color: rgba(0,0,0,0.85); height: 70px; width: 100%; padding: 20px;" >
		<h4 style="margin: auto 10px;"><font color="white">상품 리스트 : <b>${itemCode}</b></font></h4>	
	</div>
	<c:set var="cnt" value="0"/>
	<div class="row mt-3">
		<c:forEach var="vo" items="${alVos}">
			<div class="col-3">
				<div style="text-align: center;">
					<div onclick="location.href='${ctp}/alcohol/shopContent?idx=${vo.idx}&itemCodeJoin=${itemCodeJoin}';" style="cursor: pointer;" class="m-4">
						<img alt="${itemCode}" src="${ctp}/data/shop/${vo.FName}" height="200px"><br/><hr/>
						<font size="2">${vo.itemName}</font><br>
	          <font size="2" color="blue" ><fmt:formatNumber value="${vo.itemPrice}" pattern="#,###"/>원</font><br>
	          <font size="2">${vo.shortCont}</font><br>
					</div>
				</div>
			</div>
			<c:set var="cnt" value="${cnt+1 }"/>
			<c:if test="${cnt%4 == 0}">
				<div class="row mt-5">
				</div>
			</c:if>
		</c:forEach>
    <div class="container">
      <c:if test="${fn:length(alVos) == 0}"><h3>제품 준비 중입니다.</h3></c:if>
    </div>
	</div>
	<hr/>
	<br/>
	<button class="btn btn-dark" onclick="location.href='${ctp}/alcohol/cartList';">WishList보기</button>
</div>
<br/>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>