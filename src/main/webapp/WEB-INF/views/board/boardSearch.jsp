<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>검색어리스트</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
  <script>
	  // 검색콤보상자 선택시 커서를 검색어 입력창으로 이동하기
	  function searchChange() {
	  	searchForm.searchString.focus();
	  }
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<p><br/></p>
<div class="container">
	<div style="background-color: black; height: 100px; padding: 20px;">
		<div style="font-size: 25px; color: white;">검색결과 |</div>
		<div style="font-size: 15px; color: white;">입력하신 검색 결과입니다..</div>
	</div>
	<br/>
	<div class="container text-left">
		<input class="btn btn-dark btn-sm" type="button" value="돌아가기" onclick="location.href='${ctp}/board/boardList';"/>
	</div>
	<br/>
	<!-- 검색기 처리 끝 -->
  <table class="table text-center">
    <tr class="table-dark table-sm">
      <th>번호</th>
      <th>상품</th>
      <th style="width: 50%">글제목</th> <!-- 오른쪽에 댓글과 좋아요 구현 -->
      <th>글쓴이</th>
      <th>글쓴날짜</th>
      <th>조회수</th>
    </tr>
    <c:forEach var="vo" items="${vos}">
	    <tr class="p-0 ">
	      <td class="p-0 pt-5 pb-4">${curScrStrarNo}</td>
	      <td class="p-0 pt-1">
    			<img alt="${fn:split(vo.itemName, ',')[0]}" src="${ctp}/data/shop/${fn:split(vo.pdImage, ',')[0]}" height="90px">
	      </td>
	      <td class="text-left p-4">
	        <a href="${ctp}/board/boardContent?idx=${vo.idx}&pag=${pag}&pageSize=${pageSize}&lately=${lately}">
	        	<font style="font-size: large;">${vo.title}</font>
	        </a>💖${vo.good}
	        <c:if test="${vo.diffTime <= 24}">
	        	<img src="${ctp}/images/new.gif"/> <!-- 댓글작업 해야 함 -->
	        </c:if><br/>
	        <div>
	        	<font style="font-size: small; color: gray;">
						  	<c:if test="${fn:length(vo.itemName) > 40 }"> ${fn:substring(vo.itemName, 0, 40)}...</c:if>
						  	<c:if test="${fn:length(vo.itemName) <= 40 }"> ${vo.itemName}</c:if>
	        	</font> 
	        </div> <!-- 여러개 구매시 최상단에 있는 배열의 데이터만 당겨옴 -->
	      </td>
	      <td class="p-0 pt-5 pb-4">${vo.nickName}</td>
	      <td class="p-0 pt-5 pb-4">
	        <c:if test="${vo.diffTime <= 24}">${fn:substring(vo.WDate,11,19)}</c:if>
	        <c:if test="${vo.diffTime >  24}">${fn:substring(vo.WDate,0,10)}</c:if>
	      </td>
	      <td class="p-0 pt-5 pb-4">${vo.readNum}</td>
	    </tr>
	    <c:set var="curScrStrarNo" value="${curScrStrarNo - 1}"/>
    </c:forEach>
  </table>
<!-- 블록 페이징처리 시작(BS4 스타일적용) -->
	<div class="container">
		<ul class="pagination justify-content-center">
			<c:if test="${totPage == 0}"><p style="text-align:center"><b>자료가 없습니다.</b></p></c:if>
			<c:if test="${totPage != 0}">
			  <c:if test="${pag != 1}">
			    <li class="page-item"><a href="${ctp}/board/boardList?pag=1&pageSize=${pageSize}&lately=${lately}" title="첫페이지" class="page-link text-secondary">◁◁</a></li>
			  </c:if>
			  <c:if test="${curBlock > 0}">
			    <li class="page-item"><a href="${ctp}/board/boardList?pag=${(curBlock-1)*blockSize + 1}&pageSize=${pageSize}&lately=${lately}" title="이전블록" class="page-link text-secondary">◀</a></li>
			  </c:if>
			  <c:forEach var="i" begin="${(curBlock*blockSize)+1}" end="${(curBlock*blockSize)+blockSize}">
			    <c:if test="${i == pag && i <= totPage}">
			      <li class="page-item active"><a href='${ctp}/board/boardList?pag=${i}&pageSize=${pageSize}&lately=${lately}' class="page-link text-light bg-secondary border-secondary">${i}</a></li>
			    </c:if>
			    <c:if test="${i != pag && i <= totPage}">
			      <li class="page-item"><a href='${ctp}/board/boardList?pag=${i}&pageSize=${pageSize}&lately=${lately}' class="page-link text-secondary">${i}</a></li>
			    </c:if>
			  </c:forEach>
			  <c:if test="${curBlock < lastBlock}">
			    <li class="page-item"><a href="${ctp}/board/boardList?pag=${(curBlock+1)*blockSize + 1}&pageSize=${pageSize}&lately=${lately}" title="다음블록" class="page-link text-secondary">▶</a>
			  </c:if>
			  <c:if test="${pag != totPage}">
			    <li class="page-item"><a href="${ctp}/board/boardList?pag=${totPage}&pageSize=${pageSize}&lately=${lately}" title="마지막페이지" class="page-link" style="color:#555">▷▷</a>
			  </c:if>
			</c:if>
		</ul>
	</div>
</div>
<br/>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>