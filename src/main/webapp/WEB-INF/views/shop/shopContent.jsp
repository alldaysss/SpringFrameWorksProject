<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="EUC-KR">
	<title>제 품 상 세 보 기</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<script>
		var idxArray = new Array();
		//수량 변경 시 함수
		function quanTityMinus() {
			var quanTity = myform.quanTity.value;
			if(quanTity > 1) {
				quanTity--;
			  myform.quanTity.value = quanTity;
			}
			else {
				alert("최소 수량은 1병입니다.");
			}
			onTotal();
		}
		
		function quanTityPlus() {
			var quanTity = myform.quanTity.value;
			if(quanTity < 100) {
				quanTity++;
			  myform.quanTity.value = quanTity;
			}
			else {
				alert("최대 수량은 99병입니다.");
			}
			onTotal();
		}
		
		$(function(){
			$("#quanTity").keyup(function(){
				var quanTity = myform.quanTity.value;
				if(quanTity > 99) {
					alert("수량은 99병 까지 구입할수 입니다.");
					myform.quanTity.value = 99;
					myform.quanTity.focus();
				}
				else if(quanTity < 1) {
					alert("수량은 1 부터 구입할수 입니다.");
					myform.quanTity.value = 1;
					myform.quanTity.focus();
				}
				onTotal();
			});
		});
		
    // 상품의 총 금액 계산하기 및 값 가져가기
    function onTotal() {
    	var quanTity = myform.quanTity.value;
  		//var totalPrice = myfrom.totalPrice.value==0?:;
  		var itemPrice = $('#itemPrice').val();
  	  var total = 0;
  	  total = Number(quanTity) * Number(itemPrice);
  	  //출력(ID)
  	  $('#totPrice').val(numberWithCommas(total));
  	  //hidden(Name값)
  	  myform.totalPrice.value = total;
    }
    // 창으로 오자마자 값 계산
    $(document).ready(function() {
	    onTotal();
		});
    // 콤마 표시 함수
    function numberWithCommas(x) {
    	return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g,",");
    }
    
    function orderCheck(flag) {
    	if(flag == 'W') {
    		var ans = confirm("장바구니로 이동하시겠습니까?");
    		if(!ans) return false;
    		myform.action = "${ctp}/alcohol/cartInput";
    	}
    	else {
    		myform.action = "${ctp}/alcohol/orderList";
    	}
		  myform.submit();
    }
	</script>

</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<p><br/></p>
<br><br><br>
<div class="container">
  <div class="row">
  	<div class="container col col-1">
  	</div>
  	<div class="col-4 p-3 text-center"  style="border: 1px solid #ccc">
  		<!-- 상품 이미지 구역 -->
  		<div id="itemImage" style="height: 500px; overflow: hidden;">
  			<img src="${ctp}/data/shop/${vo.FName}" height="500px"/>
  		</div>
  	</div>
  	<div class="container col col-1">
  	</div>
		<div class="container col col-5  text-left">
		  <!-- 상품 기본정보 -->
	  	<form name="myform" method="post"> <!-- 상품의 정보를 넘겨주기 위한 폼 -->
			  <hr/><br/>
			  <div id="iteminfor">
			    <h3><font style="font-family:'HY울릉도B';">${vo.itemName}</font></h3>
			    <p>${vo.shortCont}</p><br/>
			    <h3><b><font style="font-family: 'HY강M'"><fmt:formatNumber value="${vo.itemPrice}"/>원</font></b></h3>
			  </div>
			  <br/>
		  	<div class="form-group select_box">
	  	  <!-- 구매수량 <input type="number" value="1" min="1" max="99" name="quanTity"/>병 &nbsp; -->
		  	  구매수량 : <input type="text" value="1" style="width: 50px;" name="quanTity" id="quanTity"/>병 &nbsp;
		  		<a onclick='quanTityMinus()' style="cursor:pointer;">(➖)</a>
	        <a onclick='quanTityPlus()' style="cursor:pointer;">(➕)</a>
			  </div>
				    <input type="hidden" name="mid" value="${sMid}"/>
				    <input type="hidden" name="itemIdx" value="${vo.idx}"/>
				    <input type="hidden" name="itemName" value="${vo.itemName}"/>
				    <input type="hidden" id="itemPrice" name="itemPrice" value="${vo.itemPrice}"/>
				    <input type="hidden" name="pdImage" value="${vo.FName}"/>
				    <input type="hidden" name="totalPrice" id="totalPrice"/>
				    <div id="item1"></div>
				<!-- 상품 상세 주문내역(세션 장바구니) -->
				
			  <!-- 상품의 총 가격 출력처리 -->
			  <div class="product2">
			  <br/>
			  <hr/>
			  <br/>
			    <p align="left" >
			    	&nbsp;&nbsp;<font size="3" color="black">총 상품금액 : </font>  &nbsp;
		        <b><input type="text" name="totPrice" id="totPrice" value="${vo.itemPrice}" class="text-right" readonly> 원</b>
			    </p>
			  </div>
			  <br/>
			  <!-- 위시리스트 보기/주문하기/계속 쇼핑하기 -->
			  <div class="buttongroup">
			  	<button type="button" class="btn btn-dark" onclick="orderCheck('W')">WishList이동 / 주문하기</button> &nbsp;
			  	<!-- <button type="button" class="btn btn-dark" onclick="orderCheck('O')">주문하기</button> &nbsp; -->
			  	<button type="button" class="btn btn-dark" onclick="location.href='${ctp}/alcohol/shopList?itemCode=${vo.itemCodeJoin}';">계속쇼핑하기</button> &nbsp;
			  </div>
			  <br/>
	  	</form>
  	</div>
  	<div class="container col col-1">
  	</div>
	</div>
  <!-- 상품 상세설명 보여주기 -->
	<div class="container">
	  <div class="container col col-1">
		</div>
	  	<br><br><br>
		  <!-- 탭 바꾸기 -->
		  <ul class="nav nav-tabs" role="tablist">
		    <li class="nav-item ">
		      <a class="nav-link active text-black border-gray" data-toggle="tab" href="#home" >상품설명</a>
		    </li>
		  </ul>
			<div style="border: solid 0.5px rgba(0,0,0,0.1); border-top: none;">
			  <!-- Tab panes -->
			  <div class="tab-content">
			    <div id="home" class="container tab-pane active"><br>
			      <h3>${vo.itemName}</h3>
			      <hr/>
			      <br/>
			      <p>${vo.content}</p>
			    </div>
			  </div>
			</div>
	  <div class="container col col-1">
		</div>
	</div>
</div>
<br/>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>