<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<style>
	li {
		font-style: inherit;
	}
	
</style>
<nav class="navbar navbar-expand-sm bg-dark text-white justify-content-center">
  <ul class="navbar-nav">
    <li class="nav-item dropdown ml-5 mr-5">
      <a class="nav-link dropdown-toggle" href="#" id="navbardrop" data-toggle="dropdown">
        와인
      </a>
      <div class="dropdown-menu">
        <a class="dropdown-item" href="${ctp}/alcohol/shopList?itemCode=FW/프랑스와인">프랑스</a> 
        <a class="dropdown-item" href="${ctp}/alcohol/shopList?itemCode=IW/이탈리아와인">이탈리아</a>
        <a class="dropdown-item" href="${ctp}/alcohol/shopList?itemCode=SW/스페인와인">스페인</a>
        <a class="dropdown-item" href="${ctp}/alcohol/shopList?itemCode=CW/칠레와인">칠레</a>
        <a class="dropdown-item" href="${ctp}/alcohol/shopList?itemCode=AW/호주와인">호주</a>
        <a class="dropdown-item" href="${ctp}/alcohol/shopList?itemCode=NW/뉴질랜드와인">뉴질랜드</a>
      </div>
    </li>
    <li class="nav-item dropdown ml-5 mr-5">
      <a class="nav-link dropdown-toggle" href="#" id="navbardrop" data-toggle="dropdown">
        위스키
      </a>
      <div class="dropdown-menu">
        <a class="dropdown-item" href="${ctp}/alcohol/shopList?itemCode=SW/스카치위스키">스카치위스키</a>
        <a class="dropdown-item" href="${ctp}/alcohol/shopList?itemCode=MW/몰트위스키">몰트위스키</a>
        <a class="dropdown-item" href="${ctp}/alcohol/shopList?itemCode=EW/기타위스키">기타위스키</a>
      </div>
    </li>
    <li class="nav-item dropdown ml-5 mr-5">
      <a class="nav-link dropdown-toggle" href="#" id="navbardrop" data-toggle="dropdown">
        브랜디 / 꼬냑
      </a>
      <div class="dropdown-menu">
        <a class="dropdown-item" href="${ctp}/alcohol/shopList?itemCode=G/꼬냑">꼬냑</a>
        <a class="dropdown-item" href="${ctp}/alcohol/shopList?itemCode=B/브랜디">브랜디</a>
      </div>
    </li>
    <li class="nav-item dropdown ml-5 mr-5">
      <a class="nav-link dropdown-toggle" href="#" id="navbardrop" data-toggle="dropdown">
        샴페인
      </a>
      <div class="dropdown-menu">
        <a class="dropdown-item" href="${ctp}/alcohol/shopList?itemCode=CC/썅빠뉴">썅빠뉴</a>
        <a class="dropdown-item" href="${ctp}/alcohol/shopList?itemCode=SC/스파클링">스파클링</a>
      </div>
    </li>
    <li class="nav-item ml-5 mr-5">
      <a class="nav-link" style="cursor:pointer;" href="${ctp}/alcohol/shopList?itemCode=L/리큐르">리큐르</a>
    </li>
    <li class="nav-item ml-5 mr-5">
      <a class="nav-link" style="cursor:pointer;" href="${ctp}/alcohol/shopList?itemCode=J/사케">사케</a>
    </li>
    <li class="nav-item ml-5 mr-5">
      <a class="nav-link" style="cursor:pointer;" href="${ctp}/alcohol/shopList?itemCode=Y/중국명주">중국명주</a>
    </li>
    <li class="nav-item ml-5 mr-5">
      <a class="nav-link" style="cursor:pointer;" href="${ctp}/calendar/calendarForm">방문예약/취소</a>
    </li>
    <li class="nav-item dropdown ml-5">
      <a class="nav-link dropdown-toggle" href="#" id="navbardrop" data-toggle="dropdown">
        고객센터
      </a>
      <div class="dropdown-menu">
        <a class="dropdown-item" href="${ctp}/board/boardList">후기게시판</a>
        <a class="dropdown-item" href="${ctp}/user/kakaomap">찾아오시는길</a>
        <a class="dropdown-item" href="${ctp}/user/quesTion">자주묻는 질문</a>
        <a class="dropdown-item" href="${ctp}/user/companyIntro">회사소개</a>
      </div>
    </li>
  </ul>
</nav>