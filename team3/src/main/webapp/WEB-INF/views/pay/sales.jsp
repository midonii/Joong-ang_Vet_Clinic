<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>중앙동물병원</title>
<link rel="stylesheet"
	href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<!-- Custom fonts for this template-->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css">
<link rel="stylesheet" href="https://kit.fontawesome.com/a31e2023c3.css"
	crossorigin="anonymous">
<script src="https://kit.fontawesome.com/a31e2023c3.js"
	crossorigin="anonymous"></script>
<link
	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">

<!-- Custom styles for this template-->
<link href="css/sb-admin-2.min.css" rel="stylesheet">

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
$(function(){
	$("#dateSearch").click(function () {
		var toDate = $("#toDate").val();
		var fromDate = $("#fromDate").val();
		
		location.href="/sales?toDate="+toDate+"&fromDate="+fromDate;
		
	});/* click */
	
	//날짜 선택시 오늘까지만 제한
	var now_utc = Date.now()
	var timeOff = new Date().getTimezoneOffset() * 60000;
	var today = new Date(now_utc - timeOff).toISOString().split("T")[0];
	$("#fromDate").attr("max", today);
	$("#toDate").attr("max", today);
	
	//기간 설정시 종료일 제한 
	$("#fromDate").change(function(){
		var fromdate = $("#fromDate").val();
		$("#toDate").attr("min", fromdate);
	});
	


});/* func */

/* 구글 차트 */
google.charts.load('current', {
  packages: ['corechart', 'bar']
});
google.charts.setOnLoadCallback(drawBasic);

function drawBasic() {

  var data = new google.visualization.DataTable();
  data.addColumn('string', '날짜');
  data.addColumn('number', '매출액');

  data.addRows([
	  <c:forEach items="${salesList}" var="s">['${s.pay_date}', ${s.totalprice}],
      </c:forEach>
  ]);

  var options = {
    title: '중앙동물병원 매출액',
    'width':900,
    'height':500
  };

  var chart = new google.visualization.ColumnChart(
    document.getElementById('chart_div'));

  chart.draw(data, options);
}

</script>
<style type="text/css">
/* #chart_div{
	margin-left: -10px;
} */
</style>
</head>

<body id="page-top">

	<!-- Page Wrapper -->
	<div id="wrapper">

		<%@ include file="../bar/sideBar.jsp"%>

		<!-- Content Wrapper -->
		<div id="content-wrapper" class="d-flex flex-column">

			<!-- Main Content -->
			<div id="content">

				<%@ include file="../bar/topBar.jsp"%>


				<!-- Begin Page Content -->
				<div class="container-fluid">



					<!-- DataTales Example -->
					<div class="card shadow mb-4">
						<!-- 헤더  -->
						<div class="card-header py-3">
							<h6 class="m-0 font-weight-bold text-primary">매출관리</h6>
						</div>


							<!-- 본문 -->
						<div class="card-body">
								<!-- 좌우 전체 -->
							<div class="row justify-content-center">
								<!-- 왼쪽 리스트+검색 시작  -->
								<div class="border-right col-5 col-md-5" style="padding: 10px; height: 570px;">
									<!-- 날짜검색 시작  -->
									<div class="input-group mb-3">
										<input type="date"
											class="form-control form-control-sm col-md-6" id="fromDate"
											name="fromDate" value="${para.get('fromDate') }">
										 <input type="date" class="form-control form-control-sm col-md-6"
											id="toDate" name="toDate" value="${para.get('toDate') }">
										<div class="input-group-append">
											<button class="btn btn-primary btn-sm" type="submit"
												id="dateSearch" onclick="location.href='/sales'">조회</button>
										</div>
									</div>
									<!--리스트테이블 시작  -->
									<div class="table-responsive">
										<table class="table table-bordered" id="dataTable"
											width="100%" cellspacing="0" style="text-align:center">
											<thead>
												<tr>
													<th class="col-2">번호</th>
													<th class="col-4">날짜</th>
													<th class="col-6">매출액</th>
												</tr>
											</thead>
											<tbody>
											<c:forEach items="${salesList }" var="s">
												<tr>
												<td>${s.rownum }</td>
												<td>${s.pay_date }</td>
												<td><fmt:formatNumber value="${s.totalprice }"
												pattern="#,###" />원</td>
												</tr>
											</c:forEach>
											</tbody>
										</table>
									</div>


								</div>
								<!-- 매출리스트끝  -->
								<!-- 우측 차트 시작 -->
								<div class="col-7 col-md-7"
									style="overflow: auto; height: 570px; padding: 10px;">
								 <div id="chart_div"></div>
								
								</div><!-- 구글차트끝 -->


							</div>
						</div>



						<!-- /.container-fluid -->

					</div>
					<!-- End of Main Content -->

					<%@ include file="../bar/footer.jsp"%>

					<%@ include file="../bar/logoutModal.jsp"%>






					<!-- Bootstrap core JavaScript-->
					<script src="vendor/jquery/jquery.min.js"></script>
					<script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

					<!-- Core plugin JavaScript-->
					<script src="vendor/jquery-easing/jquery.easing.min.js"></script>

					<!-- Custom scripts for all pages-->
					<script src="js/sb-admin-2.min.js"></script>
</body>

</html>
