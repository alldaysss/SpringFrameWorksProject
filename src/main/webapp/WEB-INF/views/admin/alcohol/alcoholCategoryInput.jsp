<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>상품분류등록</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
  <script src="${ctp}/ckeditor/ckeditor.js"></script>
  <script>
  //상품분류 등록하기
  function fCheck() {
	  
	  var itemCode = itemcategoryForm.itemCode.value;
	  var itemName = itemcategoryForm.itemName.value;
	  var shortCont = itemcategoryForm.shortCont.value;
	  var itemPrice = itemcategoryForm.itemPrice.value;
	  var file = itemcategoryForm.file.value;
		var ext = file.substring(file.lastIndexOf(".")+1);  // 확장자 구하기
		var uExt = ext.toUpperCase();
		var regExpPrice = /^[0-9|_]*$/;   // 가격은 숫자로만 입력받음
	  
	  if(itemCode == "") {
		  alert("상품코드를 입력하세요");
		  itemcategoryForm.itemCode.focus();
		  return false;
	  }
	  else if(itemName == "") {
		  alert("상품명을 입력하세요");
		  itemcategoryForm.itemName.focus();
		  return false;
	  }
	  else if(shortCont == "") {
		  alert("상품 설명을 입력하세요");
		  itemcategoryForm.shortCont.focus();
		  return false;
	  }
	  else if(itemPrice == "") {
		  alert("가격을 입력하세요");
		  itemcategoryForm.itemPrice.focus();
		  return false;
	  }
	  else  if(file == "") {
		  alert("이미지를 삽입하세요");
		  itemcategoryForm.file.focus();
		  return false;
	  }
	  else if(uExt != "JPG" && uExt != "GIF" && uExt != "PNG" && uExt != "JPEG") {
			alert("업로드 가능한 파일이 아닙니다.");
			return false;
		}
		else if(itemPrice == "" || !regExpPrice.test(itemPrice)) {
			alert("상품금액은 숫자로 입력하세요.");
			return false;
		}
	  else if(document.getElementById("file").value != "") {
			var maxSize = 1024 * 1024 * 10;  // 10MByte까지 허용
			var fileSize = document.getElementById("file").files[0].size;
			if(fileSize > maxSize) {
				alert("첨부파일의 크기는 10MB 이내로 등록하세요");
				return false;
			}
		  else {
		  	itemcategoryForm.submit();		  
		  }
	  }
  }
  
  //상품분류 삭제
 	function delCategory(idx) {
	  var ans = confirm("항목을 삭제하시겠습니까?");
	  if(!ans) return false;
	  $.ajax({
		  type : "post",
		  url  : "${ctp}/alcohol/delCategory",
		  data : {idx : idx},
		  success:function() {
			  alert("선택하신 항목이 삭제 되었습니다.");
			  location.reload();
		  }
	  });
  }
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<jsp:include page="/WEB-INF/views/admin/adnav.jsp" />
<p><br/></p>
<div class="container">
	<div id="item">
		<form name="itemcategoryForm" method="post" action="${ctp}/alcohol/alcoholCategory" enctype="multipart/form-data">
			<div class="page_title" style="background-color: black; height: 150px; padding: 20px;">
				<div style="font-size: 35px; color: white;">상품관리</div>
				<br/>
				<div style="font-size: 15px; color: white;">판매 할 상품을 관리합니다.</div>
			</div>
			<br/>
			<div>
				분류 코드 : 
				<!-- <input type="text" name="itemCode"/> &nbsp; &nbsp; -->
				<select name="itemCode">
				  <option value="FW">프랑스와인</option>
				  <option value="IW">이탈리아와인</option>
				  <option value="SW">스페인와인</option>
				  <option value="CW">칠레와인</option>
				  <option value="AW">호주와인</option>
				  <option value="NW">뉴질랜드와인</option>
				  <option value="AW">스카치위스키</option>
				  <option value="MW">몰트위스키</option>
				  <option value="EW">기타위스키</option>
				  <option value="G">꼬냑</option>
				  <option value="B">브랜디</option>
				  <option value="CC">썅빠뉴샴페인</option>
				  <option value="SC">스파클링샴페인</option>
				  <option value="L">리큐르</option>
				  <option value="J">사케</option>
				  <option value="Y">중국명주</option>
				</select>
				&nbsp;&nbsp; 품목명 : &nbsp;
				<input type="text" name="itemName"/>
				<br/><br/>
			</div>
			<div>
			  초기상품설명 <input type="text" name="shortCont" class="form-control"/>
			</div>
			<br/>
			<div>
			 	상품가격 <input type="number" name="itemPrice" class="form-control"/>
			</div>
		  <br/>
		  <div>
		  	상품메인사진
		  	<input type="file" name="file" id="file" class="form-control-file border"/>
		  	(업로드 가능한파일은 jpg, jpeg, gif, png 입니다.)
			  <!-- file속성의 name은 'file'로 해야 한다. -->
		  </div>
		  <br/>
		  <div>
		  	상품상세정보
		  	<textarea rows="10" name="content" id="CKEDITOR" class="form-control" required></textarea>
		  </div>
		  <br/>
			<script>
		    CKEDITOR.replace("content",{
		    	uploadUrl:"${ctp}/alcohol/imageUpload",     /* 그림파일 드래그&드롭 처리 */
		    	filebrowserUploadUrl: "${ctp}/alcohol/imageUpload",  /* 이미지 업로드 */
		    	height:460
		    });
		  </script>
			<br/>
			<input class="btn btn-dark" type="button" value="상품등록" onclick="fCheck()" >
			<br/><br/><br/><hr/>
			<table class="table table-hover m-3">
				<tr class="table-dark text-white text-center">
					<th>분류코드</th>
					<th>품목명</th>
					<th>상품가격</th>
					<th>비고</th>
				</tr>
				<c:forEach var="itemVO" items="${vos}" varStatus="st">
					<tr class="text-center">
						<td>${itemVO.itemCode}</td>
						<td>${itemVO.itemName}</td>
						<td>${itemVO.itemPrice}</td>
						<td><input type="button" value="삭제하기" onclick="delCategory(${itemVO.idx})"/> </td>
					</tr>
				</c:forEach>
			</table>
			
		</form>
		<br/>
		<hr/>
	</div>
</div>
<br/>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>