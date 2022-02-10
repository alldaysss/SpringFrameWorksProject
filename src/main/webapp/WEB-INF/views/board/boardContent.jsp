<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css" rel="stylesheet">
<meta name='viewport' content='width=device-width, initial-scale=1'>
<script src='https://kit.fontawesome.com/a076d05399.js' crossorigin='anonymous'></script>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>게 시 물 보기</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
  <style>
  	.clicked{color:red;}
  	
  	.ReplyRemove {
  		visibility:hidden;
  	}
  	th:hover > .ReplyRemove {
  		visibility:visible;
  	}
  </style>
  <script>
  	// 게시글 삭제 처리
  	function delCheck() {
  		var ans = confirm("게시글을 삭제 하시겠습니까?");
  		if(ans) location.href="${ctp}/board/boardDelete?idx=${vo.idx}&pag=${pag}&pageSize=${pageSize}&lately=${lately}";
  	}
  	
  	// 좋아요 처리
  	function goodCheck() {
  		var query = {
  				idx : ${vo.idx}
  		}
  		$.ajax({
  			type : "post",
  			url  : "${ctp}/board/boardGood",
  			data : query,
  			success: function() {
  					location.reload();
  			}
  		});
  	}
  	
  	// 댓글 좋아요 처리 !
  	function replyGoodCheck(idx) {
  		var query = {
  				idx : idx
  		}
  		$.ajax({
  			type : "post",
  			url  : "${ctp}/board/replyBoardGood",
  			data : query,
  			success:function() {
  				location.reload();
  			}
  		});
  	}
    
  	// 댓글 입력처리
    function replyCheck() {
    	var boardIdx = "${vo.idx}";
    	var mid = "${sMid}";
    	var nickName = "${sNickName}";
    	var content = replyForm.content.value;
    	if(content == "") {
    		alert("댓글을 입력하세요");
    		replyForm.content.focus();
    		return false;
    	}
    	var query = {
    			boardIdx : boardIdx,
    			mid : mid,
    			nickName : nickName,
    			content  : content,
    	}
    	
    	$.ajax({
    		type : "post",
    		url  : "${ctp}/board/boardReplyInsert",
    		data : query,
    		success:function() {
    			location.reload();
    		}
    	});
    }
    // 전체 댓글 보이기/가리기
    $(document).ready(function(){
    	$("#reply").show();
    	$("#replyViewBtn").hide();
    	
    	$("#replyViewBtn").click(function(){
    		$("#reply").slideDown(500);
    		$("#replyViewBtn").hide();
    		$("#replyHiddenBtn").show();
    	});
    	$("#replyHiddenBtn").click(function(){
    		$("#reply").slideUp(500);
    		$("#replyViewBtn").show();
    		$("#replyHiddenBtn").hide();
    	});
    });
    
    function replyDelCheck(replyIdx) {
    	var ans = confirm("댓글을 삭제 하시겠습니까?");
    	if(!ans) return false;
    	
    	$.ajax({
    		type : "post",
    		url  : "${ctp}/board/boardReplyDelete",
    		data : {replyIdx : replyIdx},
    		success:function() {
    			location.reload();
    		},
    		error : function() {
    			alert("전송오류");
    		}
    	});
    }
    // 답변글 쓰기 (부모 댓글의 댓글)
    function insertReReply(idx, level, levelOrder, nickName) {
    	var insReply = "";
    	insReply += "<table style='margin: 0px;'>";
    	insReply += "<tr>";
    	insReply += "<th style='padding: 0px; padding-left: 20px;'><p>＃ ${sNickName}</p></th>";
    	insReply += "</tr>";
    	insReply += "<tr>";
    	insReply += "<td style='padding: 0px; padding-left: 20px; width:1000px;'><textarea rows='3' name='content' id='content"+idx+"' class='form-control'>@"+nickName+"</textarea></td>";
    	insReply += "</tr>";
    	insReply += "<tr>";
    	insReply += "<td align='right'><p><input class='btn btn-outline-dark btn-sm' type='button' value='댓글달기' onclick='reReplyCheck("+idx+","+level+","+levelOrder+")'/></p>";
    	insReply += "</td>";
    	insReply += "</tr>";
    	insReply += "</table>";
    	insReply += "<hr/>";
    	
    	$("#replyBoxOpenBtn"+idx).hide();
    	$("#replyBoxCloseBtn"+idx).show();
    	$("#replyBox"+idx).slideDown(50);
    	$("#replyBox"+idx).html(insReply);
    }
    // 댓글 입력 폼 닫기
    function closeReReply(idx) {
    	$("#replyBoxOpenBtn"+idx).show();
    	$("#replyBoxCloseBtn"+idx).hide();
    	$("#replyBox"+idx).slideUp(50);
    }
    // 부모댓글의 댓글 저장하기
		function reReplyCheck(idx, level, levelOrder) {
    	var boardIdx = "${vo.idx}";
    	var mid = "${sMid}";
    	var nickName = "${sNickName}";
    	var content = "content"+idx;
    	var contents = $("#"+content).val();
    	
    	if(content == "") {
    		alert("답변글의 내용을 입력하세요");
    		$("#"+content).focus();
    		return false;
    	}
    	var query = {
    			boardIdx : boardIdx,
    			mid : mid,
    			nickName : nickName,
    			content : contents,
    			level : level,
    			levelOrder:levelOrder
    	}
    	$.ajax({
    		type : "post",
    		url  : "${ctp}/board/boardReReplyInsert",
    		data : query,
    		success:function() {
    			location.reload();
    		}
    	});
    }

  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<p><br/></p><font style="color: blue;"></font>
<div class="container">
  <c:if test="${sw != 'search'}">
  <!-- 이전글/다음글 처리 -->
  <div class="row">
  	<c:if test="${sw != 'search'}">
	    <div class="col col-4">
	    	<button class="btn btn-dark" onclick="location.href='${ctp}/board/boardList?pag=${pag}&pageSize=${pageSize}&lately=${lately}';">목록으로</button>
	      <c:if test="${!empty pnVos[1]}">
	      	<button class="btn btn-dark" onclick="location.href='${ctp}/board/boardContent?idx=${pnVos[1].idx}&pag=${pag}&pageSize=${pageSize}&lately=${lately}';">다음글</button>
	      </c:if> 
	      <c:if test="${!empty pnVos[0]}">
	      	<button class="btn btn-dark" onclick="location.href='${ctp}/board/boardContent?idx=${pnVos[0].idx}&pag=${pag}&pageSize=${pageSize}&lately=${lately}';">이전글</button>
	      </c:if>
	    </div>
	    <div class="col col-5"></div>
	    <div class="col text-right">
        <c:if test="${sMid == vo.mid}">
        	<button class="btn btn-dark" onclick="location.href='${ctp}/board/boardUpdate?idx=${vo.idx}&pag=${pag}&pageSize=${pageSize}&lately=${lately}';">수정하기</button>
      		<button class="btn btn-dark" onclick="delCheck()">삭제하기</button>
        </c:if>
	    </div>
    </c:if>
  </div>
  <br/>
  <hr style="margin: 0;"/>
  </c:if>
  <table class="table">
  	<tr class="table table-borderless">
  		<th class="p-1" colspan="5"><font style="font-size: x-large;">${vo.title}</font></th>
  	</tr>
    <tr class="table table-borderless">
      <th class="p-1" width="80px;"><font style="font-size: medium;">${vo.nickName}</font></th> <!-- 글쓴이 -->
      <td class="p-1" width="70px;"><font style="font-size: small;">조회 ${vo.readNum}</font></td> <!-- 조회 -->
      <td class="p-1" width="160px;"><font style="font-size: small;"> ${fn:substring(vo.WDate,0,19)} </font> </td>
      <td class="p-1" width="70px;"><font style="font-size: small;">추천 ${vo.good}</font></td> <!-- 글쓴날짜 -->
      <td class="p-1" width="*"></td>
    </tr>
    <tr class="table table-borderless">
      <td class="p-4 m-0" colspan="5" style="height:200px">${fn:replace(vo.content, newLine, '<br/>')}</td>
    </tr>
  </table>
  <hr/>
	<button class="btn btn-dark" id="replyViewBtn" >댓글달기</button>
	<button class="btn btn-dark" id="replyHiddenBtn" >댓글접기</button>
	<button class="btn btn-dark" onclick="goodCheck()">추천 ${vo.good}
		<c:if test="${good == 0 }"> ♡</c:if>
		<c:if test="${good == 1 }"> ♥  </c:if>
	</button>

<!-- 댓글 출력/입력 처리부분 -->
 <!-- 댓글 출력 --> <!-- foreach로 돌면서 댓글을 VO로 가지고 온다. -->
  <div id="reply">
	  <table class="table table-borderless">
	  	<c:forEach var="rVo" items="${rVos}">
	    	<c:if test="${rVo.level <= 0 }"> <!-- 부모댓글부분은 들여쓰기 하지 않음 -->
		    <tr>
		      <th class="p-1" width="80px;"><font style="font-size: small;">${rVo.nickName}</font>
	      		<c:if test="${rVo.mid == sMid}">
		      		&nbsp;<a class="ReplyRemove" href="javascript:replyDelCheck(${rVo.idx});"><i class='fas fa-times' style='color:orange'></i></a>
		      	</c:if>
		      </th> <!-- 글쓴이 -->
		    </tr>
		    <tr>
		      <td class="p-1 m-0" colspan="3" style="height:50px;">${fn:replace(rVo.content, newLine, '<br/>')}</td> <!-- 댓글 내용 -->
		    </tr>
		    <tr>
	      	<td class="p-1" width="100px;"><font style="font-size: x-small;">${fn:substring(rVo.WDate,0,19)}</font></td> <!-- 글쓴날짜 -->
		    </tr>
		    <tr style="border-bottom: 1px solid; color: #eee;">
		      <th class="col col-2">
					  <input class="btn btn-outline-dark btn-sm" type="button" value="답글" onclick="insertReReply('${rVo.idx}','${rVo.level}','${rVo.levelOrder}','${rVo.nickName}')" id="replyBoxOpenBtn${rVo.idx}"/>
	          <input class="btn btn-outline-dark btn-sm" type="button" value="접기" onclick="closeReReply(${rVo.idx})" id="replyBoxCloseBtn${rVo.idx}" class="replyBoxClose" style="display:none"/>
		      </th>
		      <th class="col col-8"></th>
		      <th class="col col-2 text-right">
					  <button class="btn btn-outline-dark btn-sm" onclick="replyGoodCheck(${rVo.idx})">추천 ${rVo.replyGood} 
						  <i class="fas fa-wine-glass-alt" 
						  	<c:forEach var="good" items="${replyGoods}">
							  	<c:if test="${good== rVo.idx}">style="color:red"</c:if>
							  </c:forEach>
						  ></i>
					  </button>
					</th>
		    </tr>
		    </c:if>
		    <c:if test="${rVo.level > 0 }">	<!-- 하위 댓글은 들여쓰기 한다. -->
				<tr>
		      <th class="p-1" width="80px;">
		      	<c:forEach var="i" begin="1" end="${rVo.level}">&nbsp;&nbsp;</c:forEach>
      			<font style="font-size: small;">└─${rVo.nickName}</font>
	      		<c:if test="${rVo.mid == sMid}">
		      		&nbsp;<a class="ReplyRemove" href="javascript:replyDelCheck(${rVo.idx});"><i class='fas fa-times' style='color:orange'></i></a>
		      	</c:if>
		      </th> <!-- 글쓴이 -->
		    </tr>
		    <tr>
		      <td class="p-1 m-0" colspan="3" style="height:50px; ">${fn:replace(rVo.content, newLine, '<br/>')}</td> <!-- 댓글 내용 -->
		    </tr>
		    <tr>
	      	<td class="p-1" width="100px;"><font style="font-size: x-small;">${fn:substring(rVo.WDate,0,19)}</font></td> <!-- 글쓴날짜 -->
		    </tr>
		    <tr style="border-bottom: 1px solid; color: #eee;">
		      <th class="col col-2">
	          <input class="btn btn-outline-dark btn-sm" type="button" value="답글" onclick="insertReReply('${rVo.idx}','${rVo.level}','${rVo.levelOrder}','${rVo.nickName}')" id="replyBoxOpenBtn${rVo.idx}" />
	          <input class="btn btn-outline-dark btn-sm" type="button" value="접기" onclick="closeReReply(${rVo.idx})" id="replyBoxCloseBtn${rVo.idx}" class="replyBoxClose" style="display:none"/>
		      </th>
		      <th class="col col-8"></th>
		      <th class="col col-2 text-right">
					  <button class="btn btn-outline-dark btn-sm" onclick="replyGoodCheck(${rVo.idx})">추천 ${rVo.replyGood} 
						  <i class="fas fa-wine-glass-alt" 
						  	<c:forEach var="good" items="${replyGoods}">
							  	<c:if test="${good== rVo.idx}">style="color:red"</c:if>
							  </c:forEach>
						  ></i>
					  </button>
					</th>
		    </tr>
	    	</c:if>
	      <tr>
	      	<td colspan="5"><div id="replyBox${rVo.idx}"></div></td>
	      </tr>
	    </c:forEach>
	  </table>
	</div>
  <form name="replyForm" method="post">
	  <table class="table table-borderless">
	  	<tr>
	  	  <td style="width:90%">
	  	    글내용 :<br/><br/>
	  	    <textarea rows="4" name="content" id="content" class="form-control"></textarea>
	  	  </td>
	  	  <td style="width:10%">
	  	    <br/><p>작성자 :<br/>${sNickName}</p>
	  	    <p>
	  	      <input class="btn btn-outline-dark btn-sm" type="button" value="댓글달기" onclick="replyCheck()"/>
	  	    </p>
	  	  </td>
	  	</tr>
	  </table>
	  <input type="hidden" name="boardIdx" value="${vo.idx}"/>
	  <input type="hidden" name="mid" value="${sMid}"/>
	  <input type="hidden" name="nickName" value="${sNickName}"/>
	  <input type="hidden" name="pag" value="${pag}"/>
	  <input type="hidden" name="pageSize" value="${pageSize}"/>
	  <input type="hidden" name="lately" value="${lately}"/>
  </form>
</div>
<br/>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>