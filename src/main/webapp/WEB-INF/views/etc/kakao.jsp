<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>오시는 길</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<p><br/></p>
<div class="container p-0" style="border: solid 0.1px gray;">
	<div style="background-color: black; height: 100px; padding: 20px;">
	<div style="font-size: 25px; color: white;">찾아오시는 길</div>
	<div style="font-size: 15px; color: white;">찾아오시는 길을 안내 드립니다.</div>
	</div><br/><br/>
	<div align="center">
	  <div class="info_box right">
			<div id="daumRoughmapContainer1643959472578" class="root_daum_roughmap root_daum_roughmap_landing"></div>
			<script charset="UTF-8" class="daum_roughmap_loader_script" src="https://ssl.daumcdn.net/dmaps/map_js_init/roughmapLoader.js"></script>
			<script charset="UTF-8">
				new daum.roughmap.Lander({
					"timestamp" : "1643959472578",
					"key" : "29zr4",
					"mapWidth" : "800",
					"mapHeight" : "450"
				}).render();
			</script><br/>
	  </div>
	 </div>
	 <div style="width: 100%; font-weight:400; font-family: '맑은고딕';" >
	 	<div style="background-color: rgba(255,255,255,0.05); padding: 20px;">
		 	<div style="font-size: 25px; color: black;" >버스</div><hr/>
			<div style="font-size: 15px; color: black;"><b>일반 : </b>  101, 20-2, 311, 40-1, 50-2, 500(동부종점승차-보건의료행정타운), 511(정하-충북대오송바이오캠퍼스),<br>
				514, 516, 611, 711, 714, 717, 718, 720-1, 721, 811-2, 823, 831, 918,
				001(심야), 003(심야), 007(심야), 010(심야), 015(심야), 20-2 (단축),<br>
				311-1, 313-1, 313-1(단축), 419, 50-2(단축), 513, 513-1, 515, 517, 612, 616, 617, 712, 712-1, 715, 716, 719, 720, 722,
				722-1, 823(단축), 831(단축), 911, 911-1, 912, 913, 913(단축), 916-1, 916-1(단축), 917, 918-1, 919<br><br>
				<b>좌석 : </b> 105, 105-1, 502<br/><br>
				<b>급행 : </b> 747<hr/>
			</div>
			<div style="font-size: 15px; color: black;" ><b>연락처 : </b> 043-225-2111 <br/></div><hr/>
			<div style="font-size: 15px; color: black;" ><b>휴대폰 : </b> 010-4435-1883<br></div><hr/>
			<div style="font-size: 15px; color: black;" ><b>주소 : </b> 충북 청주시 서원구 사직대로 109</div><hr/>
		</div>
	 </div>
</div>
<br/>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>