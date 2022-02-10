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
	    	
	    	if(title.trim() == "") {
	    		alert("게시글 제목을 입력하세요");
	    		myform.title.focus();
	    	}
	    	else {
	    		myform.oriContent.value = document.getElementById("oriContent").innerHTML;
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
		<div style="font-size: 25px; color: white;">게시판 글 수정 |</div>
		<div style="font-size: 15px; color: white;">고객님이 구매하신 상품의 후기를 들려주세요</div>
	</div>
  <form name="myform" method="post">
	  <table class="table">
	    <tr>
	      <th>글쓴이</th>
	      <td>${sNickName}</td>
	    </tr>
	    <tr>
	      <th>글제목</th>
	      <td><input type="text" name="title" placeholder="글제목을 입력하세요" class="form-control" autofocus required value="${vo.title}"/></td>
	    </tr>
	    <tr>
	      <th>글내용</th>
	      <td><textarea rows="6" name="content" id="CKEDITOR" class="form-control" required>${vo.content}</textarea></td>
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
	        <input type="button" value="글수정하기" onclick="fCheck()" class="btn btn-dark"/> &nbsp;
	        <input type="reset" value="다시입력" class="btn btn-dark"/> &nbsp;
	        <input type="button" value="돌아가기" onclick="location.href='${ctp}/board/boardList';" class="btn btn-dark"/>
	      </td>
	    </tr>
	  </table>
	  <input type="hidden" name="hostIp" value="${pageContext.request.remoteAddr}"/>
	  <input type="hidden" name="mid" value="${sMid}"/>
	  <input type="hidden" name="nickName" value="${sNickName}"/>
	  <input type="hidden" name="idx" value="${vo.idx}"/>
	  <input type="hidden" name="pag" value="${pag}"/>
	  <input type="hidden" name="pageSize" value="${pageSize}"/>
	  <input type="hidden" name="lately" value="${lately}"/>
	  <input type="hidden" name="oriTitle" value="${vo.title}"/>
	  <input type="hidden" name="oriContent"/>
	  <input type="hidden" name=itemNames value="${vo.itemNames}"/>
	  <div id="oriContent" style="display:none;">${vo.content}</div>
  </form>
</div>
<br/>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>