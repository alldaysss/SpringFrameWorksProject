<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
	<title>User Input</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
  <!-- 아래는 다음 주소 API를 활용한 우편번호검색 -->
  <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  <script src="${ctp}/js/woo.js"></script>
  <script>
	function idReset() {
		idCheckOn = 0;
		var mid = $("#mid").val();
  	if(mid=="" || $("#mid").val().length<4 || $("#mid").val().length>20) {
			$('#midDemo').html("<font color='red'>아이디를 체크하세요!(아이디는 4~20자 이내로 사용하세요.)</font>");
  		myform.mid.focus();
  		return false;
  	}
  	
  	$.ajax({
  		type : "post",
  		url  : "${ctp}/user/idReset",
  		data : {mid : mid},
  		success:function(data) {
  			if(data == "o") {
  				$('#midDemo').html("<font color='red'>이미 사용중인 아이디 입니다.</font>");
  				$("#mid").focus();
					idCheckOn = 0;
  			}
  			else {
  				$('#midDemo').html("<font color='blue'>사용 가능한 아이디입니다.</font>");
  				idCheckOn = 1;	// 아이디 검색버튼을 클릭한경우는 idCheckOn값이 1이 된다.
  			}
  		},
  		error : function() {
  			alert("전송오류!");
				idCheckOn = 0;
  		}
  	});
	}
	
	function nickReset() {
		nickCheckOn = 0;
  	var nickName = $("#nickName").val();
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
    	else if(myform.useragree.value == "no" || myform.useragree.value == "") {
    		alert("약관에 동의하셔야 합니다.");
    	}
    	// 기타 추가 체크해야 할 항목들을 모두 체크하세요.
    	else {
    		if(idCheckOn == 1 && nickCheckOn == 1) {
    			//alert("입력처리 되었습니다.!");
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
    			if(fName.trim() == "") {
		    		myform.photo.value = "noimage.jpg";
		    	}
    			else {
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
    			if(idCheckOn == 0) {
    				alert("아이디를 확인해 주세요!");
    			}
    			else {
    				alert("닉네임을 확인해 주세요!");
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
		<div style="font-size: 35px; color: white;">온라인 회원가입</div>
		<br/>
		<div style="font-size: 15px; color: white;">회원가입을 하시면 다양한 이벤트 참여와 혜택이 주어집니다.</div>
	</div>
		<br/>
		<h5><font color="red" >&nbsp; &nbsp; &nbsp; 개인정보</font>입력</h5>
		<hr style="margin: 20px">
	<form name="myform" method="post" class="was-validated" enctype="Multipart/form-data" style="margin: 50px;" >
    <div  class="form-group">
      회원 사진(파일용량:2MByte이내) :
      <input type="file" name="fName" id="fName" class="form-control-file border"/>
    </div>
		<div class="form-group ">
			<label for="mid">아이디 : &nbsp; &nbsp;</label>
      <input type="text" class="form-control" id="mid" onkeyup="idReset()" placeholder="아이디를 입력하세요." name="mid" required autofocus/>
      <div id="midDemo">　</div>
		</div>
		<div class="form-group ">
      <label for="pwd">패스워드 :</label>
      <input type="password" class="form-control" id="pwd" placeholder="비밀번호를 입력하세요." name="pwd" maxlength="9" required/>
    </div>
    <div class="form-group ">
      <label for="nickname">닉네임 : &nbsp; &nbsp; </label>
      <input type="text" class="form-control" id="nickName" onkeyup="nickReset()"  placeholder="별명을 입력하세요." name="nickName" required/>
    	<div id="nickNameDemo"></div>
    </div>
		<div class="form-group ">
			<div class="input-group mb-3">
				<div class="input-group-prepend">
					<span class="input-group-text">휴대폰 :</span> &nbsp;&nbsp; 
					<select name="tel1" class="custom-select">
						<option value="010" selected>010</option>
						<option value="02">서울</option>
						<option value="031">경기</option>
						<option value="032">인천</option>
						<option value="041">충남</option>
						<option value="042">대전</option>
						<option value="043">충북</option>
						<option value="051">부산</option>
						<option value="052">울산</option>
						<option value="061">전북</option>
						<option value="062">광주</option>
					</select>
				</div>&nbsp; - &nbsp;
				<input type="text" name="tel2" size=4 maxlength=4
					class="form-control" /> &nbsp; - &nbsp;<input type="text" name="tel3" size=4
					maxlength=4 class="form-control" />
			</div>
		</div>
    <div class="form-group ">
      <label for="name">이름 :</label>
      <input type="text" class="form-control" id="name" placeholder="성명을 입력하세요." name="name" required/>
    </div>
    <div class="form-group ">
      <label for="birthday">생년월일</label>
			<input type="date" name="birthday" value="<%=sToday%>" class="form-control"/>
    </div>
    <div class="form-group ">
      <div class="form-check-inline">
        <span class="input-group-text">성별 :</span> &nbsp; &nbsp;
			  <label class="form-check-label">
			    <input type="radio" class="form-check-input" name="gender" value="남자" checked>남자
			  </label>
			</div>
			<div class="form-check-inline">
			  <label class="form-check-label">
			    <input type="radio" class="form-check-input" name="gender" value="여자">여자
			  </label>
			</div>
    </div>
    <div class="form-group ">
      <label for="address">주소 : </label>
      <input type="hidden" class="form-control" name="address"/>
      <input type="text" name="postcode" id="sample4_postcode" placeholder="우편번호">
			<input type="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기"><br>
			<input type="text" name="roadAddress" id="sample4_roadAddress" size="50" placeholder="도로명주소">
			<!-- <input type="text" id="sample4_jibunAddress" placeholder="지번주소"> -->
			<span id="guide" style="color:#999;display:none"></span>
			<input type="text" name="detailAddress" id="sample4_detailAddress" size="30" placeholder="상세주소">
			<input type="hidden" name="extraAddress" id="sample4_extraAddress" placeholder="참고항목">
    </div>
    <div class="form-group">
      <label for="email">이메일 :</label>
				<div class="input-group mb-3">
				  <input type="text" class="form-control" placeholder="Email" id="email1" name="email1" required/>
				  <div class="input-group-append">
				    <select name="email2" class="custom-select">
					    <option value="naver.com" selected>naver.com</option>
					    <option value="hanmail.net">hanmail.net</option>
					    <option value="hotmail.com">hotmail.com</option>
					    <option value="gmail.com">gmail.com</option>
					    <option value="nate.com">nate.com</option>
					    <option value="yahoo.com">yahoo.com</option>
					  </select>
				  </div>
				</div>
	  </div>
    <div class="form-group">
      <div class="form-check-inline">
        <span class="input-group-text">이용약관 동의</span>  &nbsp; &nbsp; 
			  <label class="form-check-label">
			    <input type="radio" class="form-check-input" name="useragree" id="useragree" value="ok"/>동의
			  </label>
			</div>
			<div class="form-check-inline">
			  <label class="form-check-label">
			    <input type="radio" class="form-check-input" name="useragree" id="useragree" value="no"/>비동의
			  </label>
			</div>
    </div>
    <button type="button" class="btn btn-secondary" onclick="fCheck()">회원가입</button>
    <button type="reset" class="btn btn-secondary">다시작성</button>
    <button type="button" class="btn btn-secondary" onclick="location.href='${ctp}/user/userLogin';">돌아가기</button>
		<input type="hidden" name="photo"/>
    <input type="hidden" name="email"/>
    <input type="hidden" name="tel"/>
	</form>
</div>
<br/>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>