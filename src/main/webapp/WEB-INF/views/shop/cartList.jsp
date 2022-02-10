<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>나의 장바구니</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<p><br/></p>
<div class="container border border-top-0 p-0">
	<div class="page_title" style="background-color: black; height: 150px; padding: 20px;">
		<div class="vsign" style="font-size: 35px; color: white;">위시리스트</div>
		<div class="hsign" style="font-size: 35px; color: white; display: none;">주문 / 결제</div>
		<br/>
		<div class="vsign" style="font-size: 20px; color: white;"><b>${sMid}</b>님의 위시리스트 내역입니다.</div>
		<div class="hsign" style="font-size: 20px; color: white; display: none;"><b>${sMid}</b>님의 주문 / 결제 창입니다.</div>
	</div>
  <form name="myform" method="post">
		<div>
		  <table class="table table-hover text-center align-middle">
		    <tr>
		      <th>번호</th>
		      <th>이미지</th>
		      <th>상품명</th>
		      <th>가격</th>
		      <th>수량</th>
		      <th>합계</th>
		      <th>비고</th>
		    </tr>
		    <c:set var="totalAlcoholPrice" value="0"/>
				<c:forEach var="vo" items="${vos}" varStatus="st">
			    <tr class="text-center">
				    <td class="align-middle">${st.count}</td>
				    <td class="align-middle"><img src="${ctp}/data/shop/${vo.pdImage}" height="80px"/></td>
				    <td class="align-middle">${vo.itemName}</td>
				    <td class="align-middle ">${vo.itemPrice}</td>
				    <td class="align-middle">
				    	<!-- <form name="myform"> -->
					    	<input class="text-center" type="text" value="${vo.quanTitySum}" style="width: 30px; outline: none; border: 0px; border-bottom: 1px solid black; background-color: #0000;" name="quanTitySum" id="quanTitySum${vo.idx}" readonly/>병
				        <a onclick='quanTityPlusProcess(${vo.idx})' style="cursor:pointer;" class="sign"><br/>➕</a>
					  		<a onclick='quanTityMinusProcess(${vo.idx})' style="cursor:pointer;" class="sign">➖</a>
					    	<input type="hidden" name="itemPrice" id="itemPrice${vo.idx}" value="${vo.itemPrice}"/>
			        <!-- </form> -->
				    </td>
				    <%-- <td><input type="text" name="totalPrice" id="totalPrice" readonly value='<fmt:formatNumber value="${vo.itemPrice * vo.quanTitySum}"/>'/></td> --%>
				    <td class="align-middle"><input type="text" class="text-center" style="width: 110px; outline: none; border: 0px; border-bottom: 1px solid black; background-color: #0000;" name="totalPrice" id="totalPrice${vo.idx}" readonly value='<fmt:formatNumber value="${vo.itemPrice * vo.quanTitySum}"/>'/></td>
				    <td class="align-middle"><input type="button" value="삭제" class="sign" onclick="itemDelCheck(${vo.itemIdx})"/></td>
				    <c:set var="totalAlcoholPrice" value="${totalAlcoholPrice + (vo.itemPrice * vo.quanTitySum)}"/>
				  </tr>
					<input type="hidden" name="itemIdx" value="${vo.idx}"/>
					<input type="hidden" name="pdImage" value="${vo.pdImage}"/>
					<input type="hidden" name="itemName" value="${vo.itemName}"/>
<%-- 					<input type="hidden" name="itemPrice" value="${vo.itemPrice}"/> --%>
<%-- 					<input type="hidden" name="quanTitySum" value="${vo.quanTitySum}"/> --%>
				</c:forEach>
		  </table>
		</div>
	<!-- <form name="jumunForm" method="post"> -->
		<!-- 주문금액 계산 -->
		<div class="mb-0" id="orderView"></div> <!-- 숨긴상품결제창 -->
		<div style="display: none; background-color: #AAA; padding: 20px" id="card">
			<div>
				<h3>카드결제</h3><br/><br/>
				<p>
	        <select name="dvPayer" id="dvPayer1">
	          <option value="">카드선택</option>
	          <option value="국민">국민</option>
	          <option value="현대">현대</option>
	          <option value="신한">신한</option>
	          <option value="농협">농협</option>
	          <option value="BC">BC</option>
	          <option value="롯데">롯데</option>
	          <option value="삼성">삼성</option>
	          <option value="LG">LG</option>
	        </select>
	      </p><br/>
				<div>카드번호 : <input type="text" name="dvPaymentNumber" id="dvPaymentNumber1"/></div>
			</div>
		</div>
	  <div style="display: none; background-color: #BBB; padding: 20px;" id="bank">
	  	<h3>무통장입금</h3><br/><br/>
	    <p>
	      <select name="dvPaymentNumber" id="dvPaymentNumber2">
	        <option value="">은행선택</option>
	        <option value="국민">국민(111-111-111)</option>
	        <option value="신한">신한(222-222-222)</option>
	        <option value="우리">우리(3331-333-333666)</option>
	        <option value="농협">농협(444-444-444)</option>
	        <option value="신협">신협(555-555-555)</option>
	      </select>
	    </p><br/>
			<p>입금자명 : <input type="text" name="dvPayer" id="dvPayer2"/></p> 
	  </div>
	  <div style="display: none; background-color: #CCC; padding: 20px" id="phone">
	  	<h3>휴대폰결제</h3><br/><br/>
	    <p>
	      <select name="dvPayer" id="dvPayer3">
	        <option value="">통신사 선택</option>
	        <option value="KT">KT</option>
	        <option value="SKT">SKT</option>
	        <option value="LGUPLUS">LGUPLUS</option>
	        <option value="알뜰폰">알뜰폰</option>
	      </select>
	    </p><br/>
			<p>결제 휴대폰번호 입력 : <input type="text" name="dvPaymentNumber" id="dvPaymentNumber3"/></p>  
	  </div>
	<%-- 	<div class="container row text-center m-0 p-0" style="background-color: black; height: 125px; color: white; font-size: 22px;">
		  <div class="container col-1 pt-4">
		  </div>
		  <div class="container col-2 pt-4">
		    상품금액 &nbsp;<br/> <fmt:formatNumber value="${totalAlcoholPrice}"/> 원
		  </div>
		  <div class="container col-1 pt-5"> &nbsp; + &nbsp; </div>
		  <div class="container col-2 pt-4">
		    <c:set var="baesong" value="2500"/>
		    <c:if test="${totalAlcoholPrice >= 30000}"><c:set var="baesong" value="0"/></c:if>
		    배송비 &nbsp;<br/> <fmt:formatNumber value="${baesong}"/> 원
		  </div>
		  <div class="container col-1 pt-5"> &nbsp; = &nbsp; </div>
		  <div class="container col-2 pt-4">
		  	총액 &nbsp; <br/> <span id="totCalcPrice"><fmt:formatNumber value="${totalAlcoholPrice + baesong}"/></span>원
		  </div>
		  <div class="container col col-3 pt-5 btn-center">
				<input class="btn btn-outline-light text-white" type="button" value="상품상세가기" onclick="goBack();" id="orderInforView"/>
				<input class="btn btn-outline-light text-white" type="button" value="상품결제" onclick="goPayment();" id="orderInforHidden" style="display: none;"/>
	  		<input class="btn btn-outline-light text-white ml-2" type="button" value="주문서작성" onclick="orderInputViewClick()" id="orderInputView"/>
	  		<input class="btn btn-outline-light text-white ml-2" type="button" value="항목수정" onclick="orderInputHiddenClick()" id="orderInputHidden" style="display: none;"/>
		  </div>
		</div> --%>
		
		
		<div class="container row text-center m-0 p-0" style="background-color: black; height: 125px; color: white; font-size: 19px;">
		  <div class="container col-2 pt-4">
		    상품금액 &nbsp;<br/> <fmt:formatNumber value="${totalAlcoholPrice}"/> 원
		  </div>
		  <div class="container col-1 pt-5"> &nbsp; + &nbsp; </div>
		  <div class="container col-2 pt-4">
		    <c:set var="baesong" value="2500"/>
		    <c:if test="${totalAlcoholPrice >= 30000}"><c:set var="baesong" value="0"/></c:if>
		    배송비 &nbsp;<br/> <fmt:formatNumber value="${baesong}"/> 원
		  </div>
		  <div class="container col-1 pt-5">-</div>
		  <div class="col-1" style="padding: 22.5px 0 0 0;">
		  	포인트 <br/> <span id="usedPoint">0</span>원
		  </div>
		  <div class="container col-1 pt-5"> &nbsp; = &nbsp; </div>
		  <div class="container col-2 pt-4">
		  	총액 &nbsp; <br/> <span id="totCalcPrice"><fmt:formatNumber value="${totalAlcoholPrice + baesong}"/></span>원
		  </div>
		  <div class="container col col-2 pt-4 btn-center">
				<input class="btn btn-outline-light btn-sm text-white" type="button" value="상품상세가기" onclick="goBack();" id="orderInforView"/>
				<input class="btn btn-outline-light btn-sm text-white" type="button" value="상품결제" onclick="goPayment();" id="orderInforHidden" style="display: none;"/> <br/>
	  		<input class="btn btn-outline-light btn-sm text-white" type="button" value="주문서작성" onclick="orderInputViewClick()" id="orderInputView"/>
	  		<input class="btn btn-outline-light btn-sm text-white" type="button" value="항목수정" onclick="orderInputHiddenClick()" id="orderInputHidden" style="display: none;"/>
		  </div>
		</div>
		
		
		
		<input type="hidden" name="totCalcPrice" value="${totalAlcoholPrice + baesong}"/>
	</form>
</div>
<br/><br/><br/>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
  <script>
    //결제버튼클릭시 동장
    function goPayment() {
    	var dvPayment = myform.dvPayment.value;
    	var dvPayer = "";
    	var dvPaymentNumber = "";
    	var usePoint = 1000;
    	
    	if(dvPayment == "카드결제") {
	    	dvPayer = document.getElementById("dvPayer1").value;
	    	dvPaymentNumber = document.getElementById("dvPaymentNumber1").value;
	    }
    	else if(dvPayment == "무통장입금") {
	    	dvPayer = document.getElementById("dvPayer2").value;
	    	dvPaymentNumber = document.getElementById("dvPaymentNumber2").value;
    	}
    	else {
	    	dvPayer = document.getElementById("dvPayer3").value;
	    	dvPaymentNumber = document.getElementById("dvPaymentNumber3").value;
    	}
    	
    	if(dvPayment == "") {
    		alert("결제수단을 선택하세요.");
    		return false;
    	}
    	else if(dvPayer == "") {
    		alert("결제수단에 따른 항목을 입력하세요.");
    		dvPayer = null;
    		dvPaymentNumber = null;
    		return false;
    	}
    	else if(dvPaymentNumber == "") {
    		alert("결제항목에 해당되는 번호를 입력하세요.");
    		dvPayer = null;
    		dvPaymentNumber = null;
    		return false;
    	}
    	var ans = confirm("결제를 진행 하시겠습니까?");
    	if(ans) {
	    	myform.submit();    		
    	}
    	else {
    		dvPayer = null;
    		dvPaymentNumber = null;
    		return false;
    	}
    }
    // 수량 1 감소
    function quanTityMinusProcess(idx) {
    	var quanTitySum = document.getElementById("quanTitySum" + idx).value;
    	
    	if (quanTitySum < 2) {
				alert("수량은 최소 1개 이상이어야 합니다.")
				return;
			}
    	else {
	    	$.ajax({
	    		type : "post",
	    		url  : "${ctp}/alcohol/quanTityMinusProcess",
	    		data : {idx : idx},
	    		success:function(){
	    			location.reload();
	    		},
	    		error : function() {
	    			alert("전송에러!");
	    		}
	    	});
    	}
    }
    
    // 수량 1 증가
    function quanTityPlusProcess(idx) {
    	var quanTitySum = document.getElementById("quanTitySum" + idx).value;
    	
    	if (quanTitySum > 99) {
				alert("수량은 최대 99개 이하여야 합니다.")
				return;
			}
    	else {
	    	$.ajax({
	    		type : "post",
	    		url  : "${ctp}/alcohol/quanTityPlusProcess",
	    		data : {idx : idx},
	    		success:function(){
	    			location.reload();
	    		},
	    		error : function() {
	    			alert("전송에러!");
	    		}
	    	});
    	}
    }
    // 콤마 표시 함수
    function numberWithCommas(x) {
    	return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g,",");
    }
	     
    // 장바구니 목록 삭제 함수
    function itemDelCheck(itemIdx) {
      var ans = confirm("선택하신 상품을 장바구니에서 삭제하시겠습니까?");
      if(!ans) return false;
      
      $.ajax({
        type : "post",
        url  : "${ctp}/alcohol/itemDel",
        data : {itemIdx : itemIdx},
        success:function() {
          location.reload();
        },
        error : function() {
        	alert("전송에러!");
        }
      });
    }
    function partchange(selValue) {
    	document.getElementById("dvPayer1").value = "";
    	document.getElementById("dvPaymentNumber1").value = "";
    	document.getElementById("dvPayer2").value = "";
    	document.getElementById("dvPaymentNumber2").value = "";
    	document.getElementById("dvPayer3").value = "";
    	document.getElementById("dvPaymentNumber3").value = "";
    	//myform.dvPayment.value = "";
    	
    	if(selValue == "") {
    		alert("결제방법을 선택해주세요.");
	    	$('#bank').slideUp(1000);
	    	$('#phone').slideUp(1000);
	    	$('#card').slideUp(1000);
    	}
    	else if(selValue == "무통장입금") {
	    	$('#bank').slideDown(1000);
	    	$('#phone').slideUp(1000);
	    	$('#card').slideUp(1000);
    	} else if(selValue == "카드결제") {
	    	$('#card').slideDown(1000);
	    	$('#bank').slideUp(1000);
	    	$('#phone').slideUp(1000);
    	} else if(selValue == "휴대폰결제") {
	    	$('#phone').slideDown(1000);
	    	$('#card').slideUp(1000);
	    	$('#bank').slideUp(1000);
    	}
    }
    
    // 주문하기 창 열기
    function orderInputViewClick() {
    	//var orderInput = "<form name='myform' mehtod='post'>";
    	var orderInput = "";
    	orderInput += "<div class='hiddenorder' style='background-color: black; height: 80px; padding: 22px;''>";
    	orderInput += "<div style='font-size: 20px; color: white;'>주문서 입력</div>";
    	orderInput += "<br/>";
    	orderInput += "</div>";
    	orderInput += "<table style='width:100%; margin-bottom :0;' class='table table-bordered'>";
    	orderInput += "<tr><th class='text-center align-middle'>수령인</th><td><input type='text' name='dvName' value='${userVo.name}' class='form-control'/></td></tr>";
    	orderInput += "<tr><th class='text-center align-middle'>배송지</th><td><input type='text' name='dvAddress' value='${userVo.address}' class='form-control'/></td></tr>";
    	orderInput += "<tr><th class='text-center align-middle'>연락처</th><td><input type='text' name='dvTel' value='${userVo.tel}' class='form-control'/></td></tr>";
    	orderInput += "<tr><th class='text-center align-middle'>사용포인트</th><td><input type='number' name='usePoint' value='0' min='0' onchange='pointUsing()' class='form-control'/><font color='black' size='0.6em'>&nbsp; * 보유 포인트 : ${userVo.point}</font></td></tr>";
    	orderInput += "<tr><th class='text-center align-middle'>배송 시 요청사항</th><td><textarea name='dvRequest' rows='2' class='form-control' autofocus></textarea></td></tr>";
    	orderInput += "<tr><th class='text-center align-middle'>결제수단</th><td>";
    	orderInput += "<div class='form-group align-middle'>";
    	orderInput += "<select name='dvPayment' class='form-control mt-3' onchange='partchange(this.value)'>";
    	orderInput += "<option value=''>결제방법</option>";
    	orderInput += "<option value='카드결제'>카드결제</option>";
    	orderInput += "<option value='무통장입금'>무통장입금</option>";
    	orderInput += "<option value='휴대폰결제'>휴대폰결제</option>";
    	orderInput += "</select>";
    	orderInput += "</div>";
    	orderInput += "</td></tr>";
    	orderInput += "</table>";
    	//orderInput += "</form>";
    	
    	$("#orderInputHidden").show();
    	$("#orderInputView").hide();
    	$("#orderInforHidden").show();
    	$("#orderInforView").hide();
    	$(".hsign").show();
    	$(".sign").hide();
    	$(".vsign").hide();
    	$("#orderView").html(orderInput).hide().slideDown(1000);
    }
    
    // 주문 / 결제창 닫기
    function orderInputHiddenClick() {
    	$("#orderInputHidden").hide();
    	$("#orderInputView").show();
    	$("#orderInforHidden").hide();
    	$("#orderInforView").show();
    	$(".hsign").hide();
    	$(".sign").show();
    	$(".vsign").show();
    	$("#orderView").slideUp(1000);
    }

    function goBack(){
       window.history.back();
    }

    function pointUsing() {
    	var point = myform.usePoint.value;
    	if(point < 0) {
    		alert("포인트 < 0");
    		myform.usePoint.value = 0;
    	} else if(point > ${userVo.point}){
    		if(${userVo.point} >= ${totalAlcoholPrice + baesong}){
        		myform.usePoint.value = ${totalAlcoholPrice + baesong};
        } else {
        		myform.usePoint.value = ${userVo.point}
        }
    		alert("보유 포인트가 부족합니다. ");
    		myform.usePoint.value = 0;
    	} else if(point >= ${totalAlcoholPrice + baesong}){
    		myform.usePoint.value = ${totalAlcoholPrice + baesong};
    	}
    	document.getElementById("totCalcPrice").innerHTML = (${totalAlcoholPrice + baesong}- myform.usePoint.value).toLocaleString('ko-KR');
    	myform.totCalcPrice.value = ${totalAlcoholPrice + baesong}- myform.usePoint.value;
    	document.getElementById("usedPoint").innerHTML =  (parseInt(myform.usePoint.value)).toLocaleString('ko-KR');
    }
  </script>
</body>
</html>