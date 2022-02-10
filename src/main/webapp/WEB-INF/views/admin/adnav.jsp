<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
<html>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<nav class="navbar navbar-expand-sm bg-dark text-white justify-content-center">
  <ul class="navbar-nav text-white">
    <li class="nav-item">
      <a class="nav-link" href="${ctp}/admin/adminMain">��������</a>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="${ctp}/admin/userManager" target="adContent">ȸ�� ����</a>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="${ctp}/admin/adCalendarManager" target="adContent">���� Ȯ��</a>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="${ctp}/admin/adBoardList" target="adContent">�Խñ۰���</a>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="${ctp}/alcohol/alcoholOrderManager" target="adContent">�ֹ�����</a>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="${ctp}/alcohol/alcoholCategory" target="adContent">��ǰ�з�����</a>
    </li>
  </ul>
</nav>
</html>