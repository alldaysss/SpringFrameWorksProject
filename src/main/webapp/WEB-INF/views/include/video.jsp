<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>

<style>
p{
	font-family: 'pretendard';
}
body{
	font-family: 'pretendard';	
	background-color : #171721;
}
.container{
	position : relative;
}
video{
	z-index:-1;
	position : relative;
}
.mainTitle{
	font-size : 4em;
	color : white;
	font-family : '중고딕';
	text-shadow : 3px 1px 0 gray;
	position: absolute;
	top: 100%;
	left : 20%;
	margin: 0;
	padding: 0;
} 
</style>
<div style="width: 100%; height: auto; margin: 0; padding: 0;">
	<video id="mainVideo" style="width: 100%; height: auto; margin: 0; padding: 0;" muted autoplay loop>
		<source src="" type="video/mp4"/>
	</video>
	<div class="mainTitle">
		<p>당신의 지인들과 최고의 하루를 즐기십시오!</p>
	</div>
</div>
<script>
var image = new Array();
image[0] = src="${ctp}/images/main1.mp4";
image[1] = src="${ctp}/images/main2.mp4";
image[2] = src="${ctp}/images/main3.mp4";
index = Math.floor(Math.random() * image.length);
$("#mainVideo").prop("src", image[index]);
/* document.write("<embed src='"+image[index]+"'>"); */
</script>
