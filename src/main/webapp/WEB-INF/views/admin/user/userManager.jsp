<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>회원관리</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
  <script>
  	//회원 등급 관리(변경)
    function levelCheck(obj) {
    	var ans = confirm("회원등급을 변경하시겠습니까?");
    	if(!ans) {
    		location.reload();
    		return false;
    	}
    	var str = $(obj).val();
    	var query = {
    			level : str.substring(0,1),
    			idx : str.substring(1)
    	}
    	$.ajax({
    		type : "post",
    		url  : "${ctp}/admin/adUserLevel",
    		data : query,
    		error:function() {
    			alert("처리 실패!!");
    		}
    	});
    }
  	
  	//회원탈퇴처리(회원정보삭제)
  	function delUsers(idx) {
  		var ans = confirm("회원탈퇴를 진행하시겠습니까?");
  		if(!ans) return false;
  		$.ajax({
  			type : "post",
  			url  : "${ctp}/admin/delUsers",
  			data : {idx, idx},
  			success:function() {
  			  alert("회원 탈퇴 처리 되었습니다.");
			  	location.reload();
  			}
  		});
  	}
    
    // 회원등급별 검색
    function levelSearch() {
    	var level = adminForm.level.value;
    	location.href = "${ctp}/admin/userManager?level="+level;
    }
    
    // 개별회원 검색
    function midSearch() {
    	var mid = adminForm.mid.value;
    	if(mid == "") {
    		alert("아이디를 입력하세요?");
    		adminForm.mid.focus();
    	}
    	else {
    		location.href = "${ctp}/admin/userManager?mid="+mid;
    	}
    }
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<jsp:include page="/WEB-INF/views/admin/adnav.jsp" />
<p><br/></p>
<div class="container">
  <form name="adminForm">      
	  <table class="table table-borderless m-0">
	    <tr>
	      <td colspan="2">
	        <c:choose>
	          <c:when test="${level==99}"><c:set var="title" value="전체"/></c:when>
	          <c:when test="${level==4}"><c:set var="title" value="준"/></c:when>
	          <c:when test="${level==3}"><c:set var="title" value="정"/></c:when>
	          <c:when test="${level==2}"><c:set var="title" value="우수"/></c:when>
	          <c:when test="${level==1}"><c:set var="title" value="특별"/></c:when>
	        </c:choose>
	        <c:if test="${!empty mid}"><c:set var="title" value="${mid}"/></c:if>
	        <h2 style="text-align:center;"><font color="blue">${title} 회원</font> 리스트 (총 : <font color="red">${totRecCnt}</font>건)</h2>
	      </td>
	    </tr>
	    <tr>
	      <td style="text-align:left">
	        <input type="text" name="mid" value="${mid}" placeholder="검색할아이디입력"/>
	        <input type="button" value="개별검색" onclick="midSearch()"/>
	      </td>
	      <td style="text-align:right">회원등급  
	        <select name="level" onchange="levelSearch()">
	          <option value="99" <c:if test="${level==99}">selected</c:if>>전체회원</option>
	          <option value="4" <c:if test="${level==4}">selected</c:if>>준회원</option>
	          <option value="3" <c:if test="${level==3}">selected</c:if>>정회원</option>
	          <option value="2" <c:if test="${level==2}">selected</c:if>>우수회원</option>
	          <option value="1" <c:if test="${level==1}">selected</c:if>>특별회원</option>
	        </select>
	      </td>
	    </tr>
	  </table>
  </form>
  <table class="table table-hover">
    <tr class="table-dark text-dark text-center">
      <th>번호</th>
      <th>아이디</th>
      <th>별명</th>
      <th>성명</th>
      <th>성별</th>
      <th>등급</th>
      <th>상태</th>
    </tr>
    <c:forEach var="vo" items="${vos}">
    	<tr class="text-center">
    	  <td>${curScrStrarNo}</td>
    	  <td>${vo.mid}</td>
    	  <td>${vo.nickName}</td>
    	  <td>
    	    ${vo.name}
    	  </td>
    	  <td>${vo.gender}</td>
    	  <td>
  	      <select name="level" onchange="levelCheck(this)">
  	        <option value="1${vo.idx}" <c:if test="${vo.level==1}">selected</c:if>>특별회원</option>
  	        <option value="2${vo.idx}" <c:if test="${vo.level==2}">selected</c:if>>우수회원</option>
  	        <option value="3${vo.idx}" <c:if test="${vo.level==3}">selected</c:if>>정회원</option>
  	        <option value="4${vo.idx}" <c:if test="${vo.level==4}">selected</c:if>>준회원</option>
  	      </select>
    	  </td>
    	  <td>
    	    <c:if test="${vo.userDel=='OK'}"><a href="javascript:delUsers(${vo.idx})"><font color=red>탈퇴신청</font></a></c:if>
    	    <c:if test="${vo.userDel!='OK'}">활동중</c:if>
    	  </td>
    	</tr>
    	<c:set var="curScrStrarNo" value="${curScrStrarNo - 1}"/>
    </c:forEach>
  </table>
  <br/>
<!-- 페이징처리 시작 -->
<c:if test="${totPage == 0}"><p style="text-align:center"><font color="red"><b>자료가 없습니다.</b></font></p></c:if>
<c:if test="${totPage != 0}">
	<div style="text-align:center">
	  <c:if test="${pag != 1}"><a href="${ctp}/admin/userManager?pag=1&level=${level}">◁◁</a></c:if> &nbsp;&nbsp;
	  <c:if test="${pag > 1}"><a href="${ctp}/admin/userManager?pag=${pag-1}&level=${level}">◀</a></c:if>
	  &nbsp;&nbsp; ${pag}Page / ${totPage}pages &nbsp;&nbsp;
	  <c:if test="${pag < totPage}"><a href="${ctp}/admin/userManager?pag=${pag+1}&level=${level}">▶</a></c:if> &nbsp;&nbsp;
	  <c:if test="${pag != totPage}"><a href="${ctp}/admin/userManager?pag=${totPage}&level=${level}">▷▷</a></c:if>
	</div>
</c:if>
<!-- 페이징처리 끝 -->
</div>
<br/>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>