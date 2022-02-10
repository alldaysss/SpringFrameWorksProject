<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>자주묻는 질문</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
  <style>
		.que{
			position: relative;
			padding: 17px 0;
		  	cursor: pointer;
		  	font-size: 15px;
		  	border-bottom: 1px solid #dddddd;
		}
		.que::before{
		  display: inline-block;
		  content: 'Q';
		  font-size: 15px;
		  color: #263155;
		  margin-right: 5px;
		}
		
		.que.on>span{
		  font-weight: bold;
		  color: #263155; 
		}
	  	.anw {
		  display: none;
		  overflow: hidden;
		  font-size: 15px;
		  background-color: #f4f4f2;
		  padding: 27px 15px;
		}
		.anw::before {
		  display: inline-block;
		  content: 'A';
		  font-size: 15px;
		  font-weight: bold;
		  color: #555;
		  margin-right: 5px;
		}
		
		
  </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<p><br/></p>
<div class="container">
	<div style="background-color: black; height: 100px; padding: 20px;">
		<div style="font-size: 25px; color: white;">자주 묻는 질문</div>
		<div style="font-size: 15px; color: white;">회원이 궁금한 질문사항에 대한 답변입니다.</div>
	</div><hr/><br/><br/>
	<div class="que">
		<span><b>고객의 소리 운영시간 </b></span>
	</div>
	<div class="anw">
		<span><br/>
			CUSTOMER SERVICE <br/>
			ONLINE <br/>
			MON-FRI, PM 1:30 ~ PM 6:00 <br/>
			010-4435-1883	<br/>
			OFFLINE<br/>
			TUE-SUN, PM 1:30 ~ PM 8:00<br/>
			043-1234-1234
			<br/>
		</span>
	</div>
	<div class="que">
		<span><b>배송문의</b></span>
	</div>
	<div class="anw">
		<span><br/>
			<font color="red">평일 오후 3시 이전 결제 완료된 주문 건은 당일 출고되며 </font><br/>
			물류 센터에서 상품 출고 후<br/>
			영업일 기준(주말 제외) 3일 이내로 수령할 수 있습니다.<br/>
			월요일은 주말 간 물량 증가로 인하여<br/>
			일부 배송이 늦어질 수 있는 점 양해 부탁드립니다.<br/>
			프리오더 및 예약 발송 상품의 경우 해당 출고일을 확인해 주세요.<br/>
			*배송 보류의 경우 물류센터에서 상품을 준비 중이며,<br/>
			1~3일 정도 기간이 추가 소요될 수 있습니다.<br/>
			<font color="blue">* 전 상품 무료 배송/교환/반품!</font> 교환 및 반품은<br/>
			상품 수령일로부터 7일(1주일) 내에 보내주셔야 합니다.<br/>
			단 일부 도서산간 지역에 따라 배송비가 부과될 수 있습니다.
		</span>
	</div>
	<div class="que">
		<span><b>휴대폰 결제</b></span>
	</div>
	<div class="anw">
		<span><br/>
			휴대폰결제 수단 특성상 당월 결제에 한해서만<br/>
			취소가 가능하며, 익월 취소의 경우<br/>
			1) 전액 적립금 환불<br/>
			2) 결제 수수료 4.18%+vat 차감 후 무통장 환불<br/>
			두 가지의 방법으로 처리가 가능합니다.<br/>
			자세한 문의는 Q&A 또는 유선으로 연락 부탁드립니다.<br/>
		</span>
	</div>
	<div class="que">
		<span><b>반품문의</b></span>
	</div>
	<div class="anw">
		<span><br/>
				당사는 반품, 교환 서비스를 제공하지 않으나, 고객의 무리한 요구시 제공합니다. <br/>
				(리턴 시 배송비가 따로 추가되지 않습니다.) <br/>
				교환 및 반품은 상품 수령일로부터 7일(1주일) 내에 보내주셔야 합니다. <br/>
				사전에 고지 없이 반품 및 아래 조건에 <br/>
				적합하지 않은 상품을 임의로 반품할 경우,  <br/>
				반품 접수 및 처리가 거부될 수 있습니다. <br/><br/>
				* 인위적으로 상품을 훼손시킨 경우 <br/>
				* 고객 부주의로 상품이 변형된 경우 <br/>
				* 공정거래 표준약관 15조 2항(청약철회)에 의거한 이용자의 <br/>
				사용 또는 일부 소비에 의하여 재화의 가치가 현저히 감소한 경우 <br/>
				* 소비자의 책임으로 상품이 훼손, 변형이 된 경우 반품 후 소비자 책임으로 <br/>
				판명될 경우 전자상거래에 의한 소비자 보호에 관한 법률에 의해 <br/>
				손해배상으로 청구될 수 있습니다. <br/><br/>
				*환불/교환은 배송 완료일로부터 7일 이내<br/>
				고객님의 오더 리스트에서 환불/교환을 신청하신 후 택배사를 통해 하기 반송지로<br/>
				택배 수거 예약 및 발송해 주셔야 합니다.<br/>
				(CJ대한통운 홈페이지 반품 예약을 통해 회수 접수를 해주시면 보다 간편하게 반송이 가능합니다.)<br/>
				상품 수령 후 택 유무, 오염 등 검수 절차를 거쳐 환불/교환처리 도와드리겠습니다.<br/><br/>
				* 타 택배사 이용 시에는 반드시 반품 배송비를 <font color="blue">선불</font>로 보내주셔야 합니다.<br/><br/>
				* 단, 네이버 페이의 경우, 우체국 택배로 반송 시에 자동 수거가 됩니다.<br/><br/>
				반품 주소 : 충북 청주시 흥덕구 서원구 내수동로 116 사거리 앞<br/>
				연락처 : 043-1234-1234<br/>
				종일은행 : 123-123456-123456 올데이</span>
	</div>
	<div class="que">
		<span><b>회원등급</b></span>
	</div>
	<div class="anw">
		<span><br/>
			회원등급은 다음의 단계로 이루어져 있습니다.<br><br>
				우수회원 <br>
				특별회원 <br>
				정회원 <br>
				준회원 <br>
			회원등급별 적립 <br><br>
				우수회원 5% + 3% <br>
				특별회원 5% + 2% <br>
				정회원 5% + 1% <br>
				준회원 5% <br>
			회원등급별 혜택 <br><br>
				매분기 등급별 구매액에 맞는 추가 포인트 지급 <br>
				우수회원 구매금액의 3% <br>
				특별회원 구매금액의 2% <br>
				정회원  구매금액의 1% <br>
				회원 등급 기준 <br>
				최근 1개월 실 결제금액 기준 <br>
				매월 1일 <br>
				PM 12:00 등급변경 <br>
		</span>
	</div>
	<div class="que">
		<span><b>포인트</b></span>
	</div>
	<div class="anw">
		<span><br/>
			- 적립금은 온라인 스토어에서 상품을 구매하실 때 적립되는 누적 포인트 점수로, <br/>
			- 이를 사용해서 샵에서 판매하는 모든 상품을 구매하실 수 있습니다. <br/>
			- 적립금은 1,000원 이상부터 사용 가능합니다. <br/>
			- 회원가입시 적립금 1,000원이 지급됩니다. <br/>
			- 주문 시 적립금으로 결제가 가능하며, 다른 결제 수단과 혼용하여 사용하실 수 있습니다. <br/>
			- 적립금으로 구매하신 상품은 구매 시 적립금 지급 조건에서 제외됩니다. <br/>
			- 적립금은 현금으로의 환불이 불가능합니다. <br/>
			- 적립금으로 구매하신 상품의 환불은 적립금의 재적립으로만 가능합니다.<br/>
			- 적립금은 상품 구매 시에만 사용하실 수 있으며, 반품 배송비 또는 
			다른 결제 용도로의 사용이 불가능합니다.<br/>
		</span>
	</div>
	<br/><br/><br/><br/><br/><hr/>
</div>
<br/>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />

  <script>
	  $(".que").click(function() {
			$(this).next(".anw").stop().slideToggle(300);
			$(this).toggleClass('on').siblings().removeClass('on');
			$(this).next(".anw").siblings(".anw").slideUp(300); // 1개씩 펼치기
		});
  </script>

</body>
</html>