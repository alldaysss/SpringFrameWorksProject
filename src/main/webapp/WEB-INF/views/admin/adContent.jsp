<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>관리자컨텐츠</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
  <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
  <script type='text/javascript' src='http://www.google.com/jsapi'></script>
  <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
	<script>google.charts.load('current', {packages:['corechart']});</script>
  <script>
	  google.charts.load('current', {packages: ['calendar']});    // 패키지에 캘린더 추가 , 다른패키지 이ㅆ으면 ',' 로 이어서 씀
	  google.charts.setOnLoadCallback(drawCalendarChart);
	  function drawCalendarChart() {
      var data = new google.visualization.DataTable();
      data.addColumn({ type: 'date', id: 'Date'});    //x축 타입 date
      data.addColumn({ type: 'number', id: 'Visitant'});            
      // 옵션
      var options = {        
         title: "일 별 게시글 수 ", 
         height: 190,
         colors: ['#54a18e','#710917']
      };
      var myData = [];    // ajax로 받은 값 넣을 빈 배열
      $.ajax({
           type: "post", 
           url : "${ctp}/admin/visitChart", 
           data : {range:'date'}, 
           success : function(dt){
               for(let i=0;i<dt.length; i++) {
                   myData.push([new Date(dt[i].wdate), dt[i].count]);    // 배열에 넣기 [new Date('날짜2022-02-10'), 방문수10]
               }
               data.addRows(myData);
            var chart = new google.visualization.Calendar(document.getElementById('VisitantCalendarChart'));     //VisitantCalendarChart : 빈 div의 아이디
            chart.draw(data, options);
           },
        error : function() {
            alert("전송오류!");
        }
      });
    }
  </script>
	<script>
		google.charts.load('current', {packages:['corechart']});
		google.charts.setOnLoadCallback(drawChart);
		function drawChart() {
			let data = new google.visualization.DataTable();
      data.addColumn({ type: 'date', id: 'Date'});    //x축 타입 date
      data.addColumn({ type: 'number', id: 'todayAmount'});
      //옵션
			let chart_options = {
					title : '날짜 별 매출액',
					height : 300,
					bar : {
						groupWidth : '80%' // 예제에서 이 값을 수정
					},
					legend : {
						position : 'none' // 이걸 주석처리 해보면 ..
					}
			};
			let myData = [];    // ajax로 받은 값 넣을 빈 배열
      $.ajax({
           type: "post", 
           url : "${ctp}/admin/amountChart", 
           data : {range:'date'}, 
           success : function(dt){
               for(let i=0;i<dt.length; i++) {
                 myData.push([new Date(dt[i].orderDate), dt[i].todayAmount]);
               }
               data.addRows(myData);
           	let chart = new google.visualization.ColumnChart(document.getElementById('dateAmount'));     //VisitantCalendarChart : 빈 div의 아이디
            chart.draw(data, chart_options);
           },
        error : function() {
            alert("전송오류!");
        }
      });
		}
	</script>
	<!-- 2번째 막대 차트 -->
	<script>
		google.charts.setOnLoadCallback(drawChart2);
		function drawChart2() {
			let datas = new google.visualization.DataTable();
      datas.addColumn({ type: 'date', id: 'Date'});    //x축 타입 date
      datas.addColumn({ type: 'number', id: 'count'});
      //옵션
			let chart_options2 = {
					title : '날짜 별 예약현황',
					height : 300,
					colors:['#5a9d8f'],
					bar : {
						groupWidth : '80%' // 예제에서 이 값을 수정
					},
					legend : {
						position : 'none' // 이걸 주석처리 해보면 ..
					}
			};
			let myData2 = [];    // ajax로 받은 값 넣을 빈 배열
      $.ajax({
           type: "post", 
           url : "${ctp}/admin/reserveChart", 
           data : {range:'date'}, 
           success : function(dt2){
               for(let i=0; i<dt2.length; i++) {
            	   myData2.push([new Date(dt2[i].cdate), dt2[i].count]);
               }
               datas.addRows(myData2);
            let charts = new google.visualization.ColumnChart(document.getElementById('dateReserve'));
            charts.draw(datas, chart_options2);
           },
        error : function() {
            alert("전송오류!");
        }
      });
		}
	</script>
</head>
<body>
<p><br/></p>
<div class="container">
  <h2>일일 현황조회</h2>
  <hr/>
  <div class="container p-0" style="width: 100%; padding: 0; margin: 0;">
  	<div class="row" >
	  	<div class="col" style="width: 50%;" align="center">
			  <div id="dateAmount"></div>  
	  	</div>
	  	<div class="col" style="width: 50%;" align="center">
			  <div id="dateReserve"></div>  
	  	</div>
  	</div>
  </div>
  <br/>
  <div id="VisitantCalendarChart"></div><br/>
  <div id=""></div>
  <hr/>
  <p><a href="${ctp}/admin/userManager?level=4">새로운 가입자(<font color="red"><b>${newMember}</b></font> 명)</a><br/>  <!-- 준회원이 있을경우 인원출력 -->
   <a href="${ctp}/admin/adBoardList?lately=1&pag=1&pageSize=1">최근 게시글(<font color="red"><b>${newBoard}</b></font> 건)</a>	<!-- 최근 게시글 보기 --><br/>
  </p>
  <hr/>
</div>
<br/>
</body>
</html>