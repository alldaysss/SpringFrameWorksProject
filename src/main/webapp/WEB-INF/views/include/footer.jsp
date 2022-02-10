<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<style>
	div > #sub-menu > ul {
		list-style: none;
		color: white
	}
	div > #sub-menu > ul > li{
		float :left;
		list-style: none;
		color: white
	}
</style>
<!-- Footer -->
<footer>
<div style="background-color: black; height: 150px;">
	<div class="container" style="padding-top: 30px;">
		<div class="row">
			<div class="col-md-6">
				<p style="margin-left: 15px; color: white">* 국세청 고시(제2005-5호)에 따라 주류 통신판매는 금지</p>
			</div>
			<div class="col-md-6">
				<p style="margin-left: 15px; color: white">Made by Allday <a href="http://218.236.203.146:9090/spring2108_bji/">spring2108_bji</a></p>
			</div>
		</div>
		<div class="row">
			<div class="col-md-1">
				<a href="${ctp}/"><img src="${ctp}/images/logo.png" width="70px" style="margin-left: 15px;"></a>
			</div>
			<div class="col-md-5">
				<p style="margin-left: 15px; color: white">© Copyright 2022. All Rights Reserved.</p>
			</div>
			<div class="col-md-6">
				<nav id="sub-menu">
					<ul style="float: left; padding-left: 13px;">
						<li><a href="https://www.instagram.com/710th_j_i/"> 제작자 Instagram</a>&nbsp; | &nbsp;</li>
						<li><a href="${ctp}/user/terms"> 이용약관</a>&nbsp; | &nbsp;</li>
						<li><a href="${ctp}/user/kakaomap"> 찾아오시는길</a></li>
					</ul>
				</nav>
			</div>
		</div>
	</div>
</div>
</footer>