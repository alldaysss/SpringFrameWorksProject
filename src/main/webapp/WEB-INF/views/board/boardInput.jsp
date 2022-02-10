<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>글쓰기</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
    <script src="${ctp}/ckeditor/ckeditor.js"></script>
    <script>
	    function fCheck() {
	    	var title = myform.title.value;
	    	var content = myform.content.value;
	    	var itemNames = myform.itemNames.value;
	    	
	    	if(title.trim() == "") {
	    		alert("게시글 제목을 입력하세요");
	    		myform.title.focus();
	    	}
	    	else if(itemNames == "") {
	    		alert("주문하신 상품을 선택하세요");
	    	}
	    	else {
	    		myform.submit();
	    	}
	    }
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<p><br/></p>
<div class="container">
	<div style="background-color: black; height: 100px; padding: 20px;">
		<div style="font-size: 25px; color: white;">게시판 글쓰기 |</div>
		<div style="font-size: 15px; color: white;">고객님이 구매하신 상품의 후기를 들려주세요</div>
	</div>
  <form name="myform" method="post">
	  <table class="table">
	    <tr>
	      <th>글쓴이</th>
	      <td>${sNickName}</td>
	    </tr>
	    <tr>
	      <th>구매하신 제품 </th>
	      <td>
      		<select name="itemNames">
					  <option value="">선택해주세요</option>      				
      			<c:forEach var="vo" items="${alVos}">
						  <option value="${vo.orderIdx}/${vo.itemName}/${vo.pdImage}">
						  	[${fn:substring(vo.orderDate, 0, 10)}]
						  	<c:if test="${fn:length(vo.itemName) > 30 }"> ${fn:substring(vo.itemName, 0, 30)}...</c:if>
						  	<c:if test="${fn:length(vo.itemName) <= 30 }"> ${vo.itemName}</c:if>
					  	</option>
      			</c:forEach>
      		</select>
	      </td>
	    </tr>
	    <tr>
	      <th>글제목</th>
	      <td><input type="text" name="title" placeholder="글제목을 입력하세요" class="form-control" autofocus required /></td>
	    </tr>
	    <tr>
	      <th>글내용</th>
	      <td><textarea rows="6" name="content" id="CKEDITOR" class="form-control" required></textarea></td>
				<script>
			    CKEDITOR.replace("content",{
			    	uploadUrl:"${ctp}/alcohol/imageUpload",     /* 그림파일 드래그&드롭 처리 */
			    	filebrowserUploadUrl: "${ctp}/alcohol/imageUpload",  /* 이미지 업로드 */
			    	height:460
			    });
			  </script>
	    </tr>
	    <tr>
	      <td colspan="2" style="text-align:center">
	        <input type="button" value="글올리기" onclick="fCheck()" class="btn btn-dark"/> &nbsp;
	        <input type="reset" value="다시입력" class="btn btn-dark"/> &nbsp;
	        <input type="button" value="돌아가기" onclick="location.href='${ctp}/board/boardList';" class="btn btn-dark"/>
	      </td>
	    </tr>
	  </table>
	  <input type="hidden" name="hostIp" value="${pageContext.request.remoteAddr}"/>
	  <input type="hidden" name="mid" value="${sMid}"/>
	  <input type="hidden" name="nickName" value="${sNickName}"/>
  </form>
</div>
<br/>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>