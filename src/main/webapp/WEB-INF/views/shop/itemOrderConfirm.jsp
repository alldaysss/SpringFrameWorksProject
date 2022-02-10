<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>주문이 완료 되었습니다.</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
  <script>
  	function nWin(orderIdx) {
  		var url ="${ctp}/alcohol/deliverConfirm?orderIdx="+orderIdx;
  		window.open(url, "deliverConfirm", "width=400px, height=400px");
  	}
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<p><br/></p>
<div class="container">
	<div class="confirmtitle" style="background-color: black; height: 130px; padding: 20px;">
		<div style="font-size: 30px; color: white;">주문완료 | </div> 
		<div style="font-size: 15px; color: white;"><b>${sMid}</b>님의 상품주문이 완료 되었습니다. <br/> 상품을 다시한번 확인해주세요.</div>
	</div>
	<div>
	  <c:set var="pdImages" value="${fn:split(vo.pdImage,',')}"/>
	  <c:set var="itemNames" value="${fn:split(vo.itemName,',')}"/>
	  <c:set var="itemPrices" value="${fn:split(vo.itemPrice,',')}"/>
	  <c:set var="quanTitySums" value="${fn:split(vo.quanTitySum,',')}"/>
		<table class="table table-bordered">
			<tr class="table table-hover text-center align-middle">
	      <th>번호</th>
	      <th>주문정보</th>
	      <th>상품</th>
	      <th>주문내역</th>
	      <th>주문일시</th>
	    </tr>
	    <c:forEach var="i" begin="0" end="${fn:length(itemNames)-1}" varStatus="st">
	      <tr class="table table-hover text-center">
	        <td class="pt-4 pb-0">${st.count}</td>
	        <td class="pt-4 pb-0">
	        	<p>주문번호 : ${vo.orderIdx}</p>
	          <p>총 주문액 : <fmt:formatNumber value="${itemPrices[i] * quanTitySums[i]}"/>원</p>
	        </td>
	        <td style="text-align:center;">
	         	<img src="${ctp}/data/shop/${pdImages[i]}" height="120px"/>
	        </td>
	        <td class="pt-4 pb-0">
		        모델명 : <span style="color:black;font-weight:bold;">${itemNames[i]}</span><br/><br/> &nbsp; &nbsp;
		        			  <fmt:formatNumber value="${itemPrices[i]}"/>원
		        			  x ${quanTitySums[i]} Bottles
		      </td>
	        <td class="pt-4 pb-0">
	          ${vo.orderDate}<br/><br/>결제완료
	        </td>
	      </tr>
      </c:forEach>
		</table>
		<br/>
	  <p class="text-center"><a href="${ctp}/" class="btn btn-dark">메인으로 돌아가기</a> &nbsp;
			<c:set var="startDates" value="<%=new java.util.Date() %>"/>
			<c:set var="startDates"><fmt:formatDate value="${startDates}" pattern="yyyy-MM-dd"/></c:set>
			<c:set var="endDates" value="<%=new java.util.Date() %>"/>
			<c:set var="endDates"><fmt:formatDate value="${endDates}" pattern="yyyy-MM-dd"/></c:set>
    <a href="${ctp}/alcohol/myOrderDuration?startDates=${startDates}&endDates=${endDates}" class="btn btn-dark">구매내역보기</a> <!-- 페이징 처리 -->
  </p>
	</div>
</div>
<br/>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>