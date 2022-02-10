<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>주문 / 배송상태 관리</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
  <script>
  	//배송지 새창 띄우기
		function nWin(orderIdx) {
  		var url ="${ctp}/alcohol/deliverConfirm?orderIdx="+orderIdx;
  		window.open(url, "deliverConfirm", "width=400px, height=400px");
  	}
  	
		// 주문일자 조회
	  $(document).ready(function() {
	  	$("#myOrderDuration").click(function() {
		    	var startDates = document.getElementById("startDates").value;
		    	var endDates = document.getElementById("endDates").value;
		    	location.href="${ctp}/alcohol/adminOrderProcess?orderSW=DD&startDates="+startDates+"&endDates="+endDates;
	  	});
	  	
    	// 주문상태조회
    	$("#dvStatus").change(function() {
	    	var dvStatus = $(this).val();
	    	location.href="${ctp}/alcohol/adminOrderProcess?orderSW=SS&dvStatus="+dvStatus;
    	});
	  });
  	
		
  	//주문상태 변경
  	function orderProcess(orderIdx,dvStatus) {
    	var ans = confirm("주문상태("+dvStatus+")를 변경하시겠습니까?");
    	if(!ans) return false;
  		var query = {
  				dvStatus : dvStatus,
  				orderIdx : orderIdx
  		};
  		$.ajax({
  			type  : "post",
  			url   : "${ctp}/alcohol/dvStatusUpdate",
  			data  : query,
  			success : function(data) {
  				location.reload();
  			}
    	});
  	}
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<jsp:include page="/WEB-INF/views/admin/adnav.jsp" />
<c:set var="dvStatus" value="${dvStatus}"/>
<p><br/></p>
<div class="container">
	<div class="confirmtitle" style="background-color: black; height: 130px; padding: 20px;">
		<div style="font-size: 30px; color: white;">주문 / 배송관리 | </div><br/> 
		<div style="font-size: 15px; color: white;">주문 된 기간/상태별 관리가 가능합니다.</div>
	</div>
  <table class="table table-borderless">
	  <tr>
	    <td style="text-align:left;">기간 :
	      <c:if test="${startDates == null}">
	        <c:set var="startDates" value="<%=new java.util.Date() %>"/>
	        <c:set var="startDates"><fmt:formatDate value="${startDates}" pattern="yyyy-MM-dd"/></c:set>
	      </c:if>
	      <c:if test="${startDates != null }">
	        <c:set var="startDates" value="${startDates }"/>
	      </c:if>
	      <c:if test="${endDates == null}">
	        <c:set var="endDates" value="<%=new java.util.Date() %>"/>
	        <c:set var="endDates"><fmt:formatDate value="${endDates}" pattern="yyyy-MM-dd"/></c:set>
	      </c:if>
	      <c:if test="${endDates != null }">
	        <c:set var="endDates" value="${endDates }"/>
	      </c:if>
	      <input type="date" name="startDates" id="startDates" value="${startDates}"/>~<input type="date" name="endDates" id="endDates" value="${endDates}"/>
	      <input type="button" value="조회하기" id="myOrderDuration"/>  <!-- onclick="myOrderDuration()" -->
	    </td>
	    <td align="right">주문상태조회 :
	        <select name="dvStatus" id="dvStatus">
	          <option value="전체"    ${dvStatus == '전체'    ? 'selected' : ''}>전체</option>
	          <option value="결제완료" ${dvStatus == '결제완료' ? 'selected' : ''}>결제완료</option>
	          <option value="배송중"  ${dvStatus == '배송중'   ? 'selected' : ''}>배송중</option>
	          <option value="배송완료" ${dvStatus == '배송완료' ? 'selected' : ''}>배송완료</option>
	          <option value="구매완료" ${dvStatus == '구매완료' ? 'selected' : ''}>구매완료</option>
	          <option value="반품처리" ${dvStatus == '반품처리' ? 'selected' : ''}>반품처리</option>
	        </select>
	    </td>
	  </tr>
	</table>
	<table class="table table-hover">
		<tr class="table table-hover text-center align-middle">
      <th>번호</th>
      <th>주문정보</th>
      <th>상품</th>
      <th>주문내역</th>
      <th>주문일시</th>
    </tr>
    <c:forEach var="vo" items="${orderVos}">
    	<c:set var="pdImages" value="${fn:split(vo.pdImage,',')}"/>
		  <c:set var="itemNames" value="${fn:split(vo.itemName,',')}"/>
		  <c:set var="itemPrices" value="${fn:split(vo.itemPrice,',')}"/>
		  <c:set var="quanTitySums" value="${fn:split(vo.quanTitySum,',')}"/>
		  <c:if test="${fn:length(itemNames) < 2}">
			  <c:forEach var="i" begin="0" end="${fn:length(itemNames)-1}" varStatus="st">
		    	<c:set var="stMainCnt" value="${stMainCnt + 1 }"/>
		      <tr class="table table-hover text-center">
		        <td class="pt-4 pb-0 col-1">${curScrStrarNo}</td>
		        <td class="pt-4 pb-0">
		        	<p>주문번호 : ${vo.orderIdx}</p>
		          <p>총 주문액 : <fmt:formatNumber value="${itemPrices[i] * quanTitySums[i]}"/>원</p>
		          <p><input type="button" value="배송지정보" onclick="nWin('${vo.orderIdx}')"></p>
		        </td>
		        <td style="text-align:center;">
		         	<img src="${ctp}/data/shop/${pdImages[i]}" height="120px"/>
		        </td>
		        <td class="pt-4 pb-0">
			        모델명 : <span style="color:black;font-weight:bold;">${itemNames[i]}</span><br/><br/> &nbsp; &nbsp;
			        			  <fmt:formatNumber value="${itemPrices[i]}"/>원
			        			  x ${quanTitySums[i]} Bottles
			      </td>
		        <td class="pt-4 pb-0" style="text-align:center;"><br/>
		          ${fn:substring(vo.orderDate,0,10)}<br/><br/>
		          <button type="button" onclick="orderProcess('${vo.orderIdx}','${vo.dvStatus}')" class="btn btn-outline-dark btn-sm">${vo.dvStatus}</button>
		        </td>
		      </tr>
	      </c:forEach>
      </c:if>
      <c:if test="${fn:length(itemNames) >= 2}"> <!-- 가짓수가 여러가지일경우의 주문 -->
        <tr>
          <td colspan="5" class="p-0">
       		  <table class="table m-0 p-0 border-less" style="background-color:#255255255;">
       		    <c:set var="orderSw" value="0"/>
			        <c:forEach var="i" begin="0" end="${fn:length(itemNames)-1}" varStatus="st">
					    	<c:set var="stMainCnt" value="${stMainCnt + 1 }"/>
					      <tr class="table text-center">
					        <c:if test="${orderSw == 0}">
						        <td class="pt-4 pb-0 col-1" style="text-align:center;vertical-align: middle; " rowspan="${fn:length(itemNames)}">${curScrStrarNo}</td>
					        </c:if>
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
						      <td class="pt-4 p-0" style="text-align:center;vertical-align: middle;" rowspan="${fn:length(itemNames)}"><br/>
					          <c:if test="${orderSw == 0}">
						          ${fn:substring(vo.orderDate,0,10)}<br/><br/>
						          <button type="button" onclick="orderProcess('${vo.orderIdx}','${vo.dvStatus}')" class="btn btn-outline-dark btn-sm">${vo.dvStatus}</button><br/><br/>
						          <p><input type="button" class="btn btn-outline-dark btn-sm" value="배송지정보" onclick="nWin('${vo.orderIdx}')"></p>
						          <c:set var="orderSw" value="1"/>
					          </c:if>
					        </td>
					      </tr>
				      </c:forEach>
	          </table>
	        </td>
	      </tr>
      </c:if>
      <c:set var="curScrStrarNo" value="${curScrStrarNo - 1 }"/>
    </c:forEach>
	</table>
	<br/>
<p><br/></p>
  <!-- 블록 페이징처리 시작(BS4 스타일적용) -->
	<div class="container">
		<ul class="pagination justify-content-center">
			<c:if test="${totPage == 0}"><p style="text-align:center"><b>자료가 없습니다.</b></p></c:if>
			<c:if test="${totPage != 0}">
			  <c:if test="${pag != 1}"> dvStatus startDates endDates orderSW
			    <li class="page-item"><a href="${ctp}/alcohol/alcoholOrderManager?pag=1&orderSW=${orderSW}&dvStatus=${dvStatus}&startDates=${startDates}&endDates=${endDates}" title="첫페이지" class="page-link text-secondary">◁◁</a></li>
			  </c:if>
			  <c:if test="${curBlock > 0}">
			    <li class="page-item"><a href="${ctp}/alcohol/alcoholOrderManager?pag=${(curBlock-1)*blockSize + 1}&orderSW=${orderSW}&dvStatus=${dvStatus}&startDates=${startDates}&endDates=${endDates}" title="이전블록" class="page-link text-secondary">◀</a></li>
			  </c:if>
			  <c:forEach var="i" begin="${(curBlock*blockSize)+1}" end="${(curBlock*blockSize)+blockSize}">
			    <c:if test="${i == pag && i <= totPage}">
			      <li class="page-item active"><a href='${ctp}/alcohol/alcoholOrderManager?pag=${i}&orderSW=${orderSW}&dvStatus=${dvStatus}&startDates=${startDates}&endDates=${endDates}' class="page-link text-light bg-secondary border-secondary">${i}</a></li>
			    </c:if>
			    <c:if test="${i != pag && i <= totPage}">
			      <li class="page-item"><a href='${ctp}/alcohol/alcoholOrderManager?pag=${i}&orderSW=${orderSW}&dvStatus=${dvStatus}&startDates=${startDates}&endDates=${endDates}' class="page-link text-secondary">${i}</a></li>
			    </c:if>
			  </c:forEach>
			  <c:if test="${curBlock < lastBlock}">
			    <li class="page-item"><a href="${ctp}/alcohol/alcoholOrderManager?pag=${(curBlock+1)*blockSize + 1}&orderSW=${orderSW}&dvStatus=${dvStatus}&startDates=${startDates}&endDates=${endDates}" title="다음블록" class="page-link text-secondary">▶</a>
			  </c:if>
			  <c:if test="${pag != totPage}">
			    <li class="page-item"><a href="${ctp}/alcohol/alcoholOrderManager?pag=${totPage}&orderSW=${orderSW}&dvStatus=${dvStatus}&startDates=${startDates}&endDates=${endDates}" title="마지막페이지" class="page-link" style="color:#555">▷▷</a>
			  </c:if>
			</c:if>
		</ul>
	</div>
	<!-- 블록 페이징처리 끝 -->
</div>
<br/>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>