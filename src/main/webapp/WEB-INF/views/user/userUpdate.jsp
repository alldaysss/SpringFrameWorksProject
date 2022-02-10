<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<%
  Date today = new Date();
  SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
  String sToday = sdf.format(today);
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>회원정보수정</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
  <!-- 아래는 다음 주소 API를 활용한 우편번호검색 -->
  <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  <script src="${ctp}/js/woo.js"></script>
  <script>
  	function deleteCheck() {
  		var ans = confirm("정말 탈퇴 하시겠습니까?");
  		if(ans) {
  			ans = confirm("정말로 탈퇴하시겠습니까? \n 탈퇴하시게 되면 1개월동안 동일한 아이디로 가입이 불가능 합니다.");
  			if(ans) location.href ="${ctp}/user/userDelete";
  		}
  	}
  </script>
  <script>
	var nickCheckOn = 0;
	function nickReset() {
  	var nickName = $("#nickName").val();
  	if('${sNickName}'== nickName) {
  		$('#nickNameDemo').html("<font color='orange'>기존 닉네임을 사용합니다.</font>");
  		nickCheckOn = 1;
  		return false;
  	}
  	
  	if(nickName=="" || $("#nickName").val().length<2 || $("#nickName").val().length>10) {
  		$('#nickNameDemo').html("<font color='red'>별명을 체크하세요!(최소 2자 ~ 최대 10자)</font>");
  		myform.nickName.focus();
  		return false;
  	}
  	$.ajax({
  		type : "post",
  		url  : "${ctp}/user/nickReset",
  		data : {nickName : nickName},
  		success:function(data) {
  			if(data == "o") {
  				$('#nickNameDemo').html("<font color='red'>이미 사용중인 닉네임 입니다.</font>");
  				$("#nickName").focus();
  				nickCheckOn = 0;
  			}
  			else {
  				$('#nickNameDemo').html("<font color='blue'>사용 가능한 닉네임 입니다.</font>");
  				nickCheckOn = 1;	// 닉네임 검색버튼을 클릭한경우는 nickCheckOn값이 1이 된다.
  			}
  		},
  		error : function() {
  			alert("전송오류!");
  			nickCheckOn = 0;
  		}
  	});
	}
	// 회원가입폼 체크
    function fCheck() {
  		var regExpEmail = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
  		
  		// 이메일 체크
    	var mid = myform.mid.value;
    	var pwd = myform.pwd.value;
    	var nickName = myform.nickName.value;
    	var name = myform.name.value;
    	var email = myform.email1.value + "@" + myform.email2.value;
    	var tel = myform.tel1.value + "-" + myform.tel2.value + "-" + myform.tel3.value;
    	
    	// 회원 사진 업로드
    	var fName = myform.fName.value;
    	var ext = fName.substring(fName.lastIndexOf(".")+1);	// 파일 확장자 발췌
    	var uExt = ext.toUpperCase();
    	var maxSize = 1024 * 1024 * 2;	// 업로드할 파일의 최대 용량은 2MByte로 한다.
    	if(mid == "") {
    		alert("아이디를 입력하세요");
    		myform.mid.focus();
    	}
    	else if(pwd == "") {
    		alert("비밀번호를 입력하세요");
    		myform.pwd.focus();
    	}
    	else if(nickName == "") {
    		alert("닉네임을 입력하세요");
    		myform.nickName.focus();
    	}
    	else if(name == "") {
    		alert("성명을 입력하세요");
    		myform.name.focus();
    	}
    	else if(!regExpEmail.test(email)) {
    		alert("이메일을 확인하세요");
    		myform.email1.focus();
    	}
    	// 기타 추가 체크해야 할 항목들을 모두 체크하세요.
    	else {
    		if(nickCheckOn == 1) {
    			var postcode = myform.postcode.value;
    			var roadAddress = myform.roadAddress.value;
    			var detailAddress = myform.detailAddress.value;
    			var extraAddress = myform.extraAddress.value;
    			var address = postcode + "/" + roadAddress + "/" + detailAddress + "/" + extraAddress
    			if(address == "///") address = "";
    			myform.address.value = address;
    			myform.email.value = email;
    			myform.tel.value = tel;
    			
    			// 사진파일 업로드 체크
    			if(fName.trim() != "") {
    				var fileSize = document.getElementById("fName").files[0].size;
    				
			    	if(uExt != "JPG" && uExt != "GIF" && uExt != "PNG") {
			    		alert("업로드 가능한 파일은 'JPG/GIF/PNG");
			    		return false;
			    	}
			    	else if(fName.indexOf(" ") != -1) {
			    		alert("업로드할 파일명에는 공백을 포함하실수 없습니다.");
			    		return false;
			    	}
			    	else if(fileSize > maxSize) {
			    		alert("업로드할 파일의 크기는 2MByte 이하입니다.");
			    		return false;
			    	}
		    	}
		    	myform.submit();
  			}
    		else {
    			if(nickCheckOn == 0) {
    				alert("닉네임을 확인해 주세요!");
    				myform.nickName.focus();
    			}
    		}
    	}
    }
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<p><br/></p>
<div class="container border border-top-0 p-0">
	<div class="page_title" style="background-color: black; height: 150px; padding: 20px;">
		<div style="font-size: 35px; color: white;">온라인 회원 정보 수정</div>
		<br/>
		<div style="font-size: 15px; color: white;">기존 회원 정보를 수정합니다.</div>
	</div>
		<br/>
		<h5><font color="red" >&nbsp; &nbsp; &nbsp; 개인정보</font>수정</h5>
		<hr style="margin: 20px">
	<form name="myform" method="post" action="${ctp}/user/userUpdateOk" class="was-validated" enctype="Multipart/form-data" style="margin: 50px;" >
    <div  class="form-group">
      회원 사진(파일용량:2MByte이내) : <a href="${ctp}/user/${vo.photo}" target="_blank"><img src="${ctp}/user/${vo.photo}" class="rounded-circle" alt="회원 이미지" width="100px"/></a>
      <input type="file" name="fName" id="fName" class="form-control-file border"/>
    </div>
		<div class="form-group ">
			아이디 : ${sMid}
		</div>
		<div class="form-group ">
      <label for="pwd">패스워드 :</label>
      <input type="password" class="form-control" id="pwd" placeholder="비밀번호를 입력하세요." name="pwd" value="${sPwd}" maxlength="9" required/>
    </div>
    <div class="form-group ">
      <label for="nickName">닉네임 : &nbsp; &nbsp; </label>
      <input type="text" class="form-control" id="nickName" onkeyup="nickReset()"  placeholder="별명은 2-10자로 입력하세요." name="nickName" value="${vo.nickName}" required/>
    	<div id="nickNameDemo"></div>
    </div>
		    <div class="form-group">
      <div class="input-group mb-3">
	      <div class="input-group-prepend">
	        <span class="input-group-text">전화번호 :</span> &nbsp;&nbsp;
			      <select name="tel1" class="custom-select">
			        <c:set var="tel1" value="${fn:split(vo.tel,'-')[0]}"/>
					    <option value="010" ${tel1=='010' ? 'selected' : ''}>010</option>
					    <option value="02"  ${tel1=='02' ? 'selected' : ''}>서울</option>
					    <option value="031" ${tel1=='031' ? 'selected' : ''}>경기</option>
					    <option value="032" ${tel1=='032' ? 'selected' : ''}>인천</option>
					    <option value="041" ${tel1=='041' ? 'selected' : ''}>충남</option>
					    <option value="042" ${tel1=='042' ? 'selected' : ''}>대전</option>
					    <option value="043" ${tel1=='043' ? 'selected' : ''}>충북</option>
			        <option value="051" ${tel1=='051' ? 'selected' : ''}>부산</option>
			        <option value="052" ${tel1=='052' ? 'selected' : ''}>울산</option>
			        <option value="061" ${tel1=='061' ? 'selected' : ''}>전북</option>
			        <option value="062" ${tel1=='062' ? 'selected' : ''}>광주</option>
					  </select>-
	      </div>
	      <input type="text" name="tel2" value="${fn:split(vo.tel,'-')[1]}" size=4 maxlength=4 class="form-control"/>-
	      <input type="text" name="tel3" value="${fn:split(vo.tel,'-')[2]}" size=4 maxlength=4 class="form-control"/>
	    </div> 
    </div>
    <div class="form-group ">
      <label for="name">이름 :</label>
      <input type="text" class="form-control" id="name" name="name" value="${vo.name}" required/>
    </div>
    <div class="form-group ">
      <label for="birthday">생년월일</label>
			<input type="date" name="birthday" value="${fn:substring(vo.birthday,0, 10)}" class="form-control"/>
    </div>
    <div class="form-group">
      <div class="form-check-inline">
        <span class="input-group-text">성별 :</span> &nbsp; &nbsp;
			  <label class="form-check-label">
			    <input type="radio" class="form-check-input" name="gender" value="남자" ${vo.gender=='남자' ? 'checked' : ''}>남자
			  </label>
			</div>
			<div class="form-check-inline">
			  <label class="form-check-label">
			    <input type="radio" class="form-check-input" name="gender" value="여자" ${vo.gender=='여자' ? 'checked' : ''}>여자
			  </label>
			</div>
    </div>
    <div class="form-group">
      <label for="address">주소</label>
      <input type="hidden" class="form-control" name="address"/>
      <input type="text" name="postcode" value="${fn:split(vo.address,'/')[0]}" id="sample4_postcode" placeholder="우편번호">
			<input type="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기"><br>
			<input type="text" name="roadAddress" value="${fn:split(vo.address,'/')[1]}" id="sample4_roadAddress" size="50" placeholder="도로명주소">
			<!-- <input type="text" id="sample4_jibunAddress" placeholder="지번주소"> -->
			<span id="guide" style="color:#999;display:none"></span>
			<input type="text" name="detailAddress" value="${fn:split(vo.address,'/')[2]}" id="sample4_detailAddress" size="30" placeholder="상세주소">
			<input type="hidden" name="extraAddress" value="${fn:split(vo.address,'/')[3]}" id="sample4_extraAddress" placeholder="참고항목">
    </div>
    <div class="form-group">
      <label for="email">이메일 :</label>
				<div class="input-group mb-3">
				  <input type="text" class="form-control" placeholder="Email" id="email1" name="email1" value="${fn:split(vo.email,'@')[0]}" required/>
				  <div class="input-group-append">
				    <select name="email2" class="custom-select">
						  <c:set var="email2" value="${fn:split(vo.email,'@')[1]}"/>
					    <option value="naver.com" 	${email2=='naver.com'   ? 'selected' : ''}>naver.com</option>
					    <option value="hanmail.net" ${email2=='hanmail.net' ? 'selected' : ''}>hanmail.net</option>
					    <option value="hotmail.com" ${email2=='hotmail.com' ? 'selected' : ''}>hotmail.com</option>
					    <option value="gmail.com"   ${email2=='gmail.com'   ? 'selected' : ''}>gmail.com</option>
					    <option value="nate.com"    ${email2=='nate.com'    ? 'selected' : ''}>nate.com</option>
					    <option value="yahoo.com"   ${email2=='yahoo.com'   ? 'selected' : ''}>yahoo.com</option>
					  </select>
				  </div>
				</div>
	  </div>
    <button type="button" class="btn btn-dark" onclick="fCheck()">회원정보 수정</button>
    <button type="reset" class="btn btn-dark">다시작성</button>
    <button type="button" class="btn btn-dark" onclick="location.href='${ctp}/user/userMain';">돌아가기</button>
    <!-- <button type="button" class="btn btn-light" onclick="location.href='javascript:userDeletecheck()';">회원탈퇴</button> -->
    <button type="button" class="btn btn-light" onclick="deleteCheck()">회원탈퇴</button>
    <input type="hidden" name="mid" value="${sMid}"/>
    <input type="hidden" name="photo" value="${vo.photo}"/>
    <input type="hidden" name="email"/>
    <input type="hidden" name="tel"/>
	</form>
	<p><br/></p>
</div>
<br/>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>