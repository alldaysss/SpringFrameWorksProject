<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>게시판 관리</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
  
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<jsp:include page="/WEB-INF/views/admin/adnav.jsp" />
<p><br/></p>
<div class="container">
	<div style="background-color: black; height: 130px; padding: 20px;">
		<div style="font-size: 30px; color: white;">게시판 관리 |</div><br/> 
		<div style="font-size: 15px; color: white;">관리자 권한으로 게시글을 관리합니다.</div>
	</div>
	<br/>
	<!-- 검색기 처리 끝 -->
  <table class="table text-center">
    <tr class="table text-right">
      <td colspan="4">
      	<div class="container text-left">
				  <form name="searchForm" method="post" action="${ctp}/admin/adboardSearch">
				    <div class="row">
					    <select name="searchoption" style="height: 22px;" onchange="searchChange()">
					      <option value="title">글제목</option>
					      <option value="nickName">글쓴이</option>
					      <option value="content">글내용</option>
					    </select>
					    <input type="text" style="height: 22px;" id="searchString" name="searchString" />&nbsp;
					    <c:if test="${empty search}">
					    	<input class="btn btn-dark btn-sm"  type="button" value="검색" onclick="searchCheck()"/> &nbsp;
					    </c:if>
					    <c:if test="${!empty search}">
					    	<input class="btn btn-dark btn-sm" type="button" value="돌아가기" onclick="location.href='${ctp}/admin/adBoardList';"/>
					    </c:if>
						</div>
				    <input type="hidden" name="pag" value="${pag}"/>
					  <input type="hidden" name="pageSize" value="${pageSize}"/>
				  </form>
				</div>
      </td>
      <td colspan="3">
        <input type="checkbox" id="checkAll"/>전체선택/해제 &nbsp;
        <input type="checkbox" id="reverseAll"/>선택반전 &nbsp;
        <input type="button" value="선택항목삭제" onclick="selectDelCheck()" class="btn btn-outline-dark btn-sm"/>
      </td>
    </tr>
    <tr class="table-dark table-sm">
    	<th>선택</th>
      <th>번호</th>
      <th>상품</th>
      <th style="width: 50%">글제목</th> <!-- 오른쪽에 댓글과 좋아요 구현 -->
      <th>글쓴이</th>
      <th>글쓴날짜</th>
      <th>조회수</th>
    </tr>
    <c:forEach var="vo" items="${vos}">
	    <tr class="p-0 ">
	    	<td style="display: none;"><input type="hidden" name="chkNums1" value="${vo.idx }"></td>
	      <td style="padding-top: 40px;"><input type="checkbox" name="chkNum" id="chkNum${vo.idx}" class="chkNum" value="${vo.idx}" onchange="checkDel(${vo.idx})"/></td>
	      <td style="padding-top: 40px;">${curScrStrarNo}</td>
	      <td class="p-0 pt-1">
    			<img alt="${fn:split(vo.itemName, ',')[0]}" src="${ctp}/data/shop/${fn:split(vo.pdImage, ',')[0]}" height="90px">
	      </td>
	      <td class="text-left p-4">
	        <a onclick='window.open("${ctp}/admin/adBoardShortList?idx=${vo.idx}", "adboardShortList", "width=700px, height=400px")'>
	        	<font style="font-size: large; cursor: pointer;">${vo.title}</font>
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
	      <td style="padding-top: 40px;">${vo.nickName}</td>
	      <td style="padding-top: 40px;">
	        <c:if test="${vo.diffTime <= 24}">${fn:substring(vo.WDate,11,19)}</c:if>
	        <c:if test="${vo.diffTime >  24}">${fn:substring(vo.WDate,0,10)}</c:if>
	      </td>
	      <td style="padding-top: 40px;">${vo.readNum}</td>
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
			    <li class="page-item"><a href="${ctp}/admin/adBoardList?pag=1&pageSize=${pageSize}&lately=${lately}" title="첫페이지" class="page-link text-secondary">◁◁</a></li>
			  </c:if>
			  <c:if test="${curBlock > 0}">
			    <li class="page-item"><a href="${ctp}/admin/adBoardList?pag=${(curBlock-1)*blockSize + 1}&pageSize=${pageSize}&lately=${lately}" title="이전블록" class="page-link text-secondary">◀</a></li>
			  </c:if>
			  <c:forEach var="i" begin="${(curBlock*blockSize)+1}" end="${(curBlock*blockSize)+blockSize}">
			    <c:if test="${i == pag && i <= totPage}">
			      <li class="page-item active"><a href='${ctp}/admin/adBoardList?pag=${i}&pageSize=${pageSize}&lately=${lately}' class="page-link text-light bg-secondary border-secondary">${i}</a></li>
			    </c:if>
			    <c:if test="${i != pag && i <= totPage}">
			      <li class="page-item"><a href='${ctp}/admin/adBoardList?pag=${i}&pageSize=${pageSize}&lately=${lately}' class="page-link text-secondary">${i}</a></li>
			    </c:if>
			  </c:forEach>
			  <c:if test="${curBlock < lastBlock}">
			    <li class="page-item"><a href="${ctp}/admin/adBoardList?pag=${(curBlock+1)*blockSize + 1}&pageSize=${pageSize}&lately=${lately}" title="다음블록" class="page-link text-secondary">▶</a>
			  </c:if>
			  <c:if test="${pag != totPage}">
			    <li class="page-item"><a href="${ctp}/admin/adBoardList?pag=${totPage}&pageSize=${pageSize}&lately=${lately}" title="마지막페이지" class="page-link" style="color:#555">▷▷</a>
			  </c:if>
			</c:if>
		</ul>
	</div>
</div>
<br/>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
<script>
  
	  // 검색콤보상자 선택시 커서를 검색어 입력창으로 이동하기
	  function searchChange() {
	  	searchForm.searchString.focus();
	  }
	
	  // 검색버튼 클릭시 수행할 내용.
	  function searchCheck() {
	  	var searchString = searchForm.searchString.value;
	  	var searchoption = searchForm.searchoption.value;
	  	if(searchString == "") {
	  		alert("검색어를 입력하세요");
	  		searchForm.searchString.focus();
	  	}
	  	else {
	  		location.href="${ctp}/admin/adBoardList?pag=${pag}&pageSize=${pageSize}&lately=${lately}&search="+searchString+"&searchoption="+searchoption;
	  	}
	  }
	  
	    // 전체선택
	    $(function(){
	    	var idx = idx
	    	$("#checkAll").click(function(){
	    		if($("#checkAll").prop("checked")) {
		    		$(".chkNum").prop("checked", true);
	    		}
	    		else {
		    		$(".chkNum").prop("checked", false);
	    		}
	    	});
	    });
	    
	    // 선택항목 반전
	    $(function(){
	    	$("#reverseAll").click(function(){
	    		$(".chkNum").prop("checked", function(){
	    			return !$(this).prop("checked");
	    		});
	    	});
	    });

	    // 선택항목 삭제하기(ajax처리하기)
	    let array = [];
	    function selectDelCheck() {
	    	var ans = confirm("선택된 모든 게시물을 삭제 하시겠습니까?");
	    	if(!ans) return false;
				
	    	var idxDelete = "";
    		
	    	<c:forEach var="vo" items="${vos}" varStatus="st">
	    		if ($("input:checkbox[name='chkNum']")[${st.index}].checked) {
	    			idxDelete += ${vo.idx} + "/";
	    		}
	    	</c:forEach>
	    	
	    	$.ajax({
	    		type : "post",
	    		data : {idxDelete : idxDelete},
	    		success:function() {
	    			location.reload();
	    		},
	    		error  :function() {
	    			alert("전송오류!!");
	    		}
	    	});
	    }
  </script>
</body>
</html>