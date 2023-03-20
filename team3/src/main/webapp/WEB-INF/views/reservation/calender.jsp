<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html lang="ko">
<%
if (session.getAttribute("id") == null) {
	response.sendRedirect("/login");
}
%>
<head>

<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>캘린더</title>
<link rel="stylesheet"
	href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<!-- <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" -->
<!-- 	type="text/css"> -->
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
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65"
	crossorigin="anonymous">
<link href="css/sb-admin-2.min.css" rel="stylesheet">
<link href="css/reservation/reserv.css" rel="stylesheet">
<!-- Favicon-->
<link rel="icon" type="image/x-icon"
	href="/resources/assets/favicon.ico" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
<!-- <link rel="stylesheet" href="style.css"> -->
<link rel="stylesheet" href="css/reservation/calender/calender.css">
<script type="text/javascript"
	src="../js/reservation/calender_search.js"></script>
<!-- <script type="text/javascript">
$(function(){
	
	$("#search_btn").click(function(){
		let searchValue = $("#search_value").val();
		if(searchValue == ""){
			alert("검색어를 입력하세요");
			return false;
		} 
		if(searchValue <2){
			alert("2글자 이상 입력하세요");
			return false;
		} 
		searchForm.submit();
	});
		
	 
 	$("#ok-button").click(function(){
 		let ownerName = $("#owner_name").val();
 		if(ownerName == ""){
			aleart("검색어를 입력하세요");
			return false;
		} 
 		reservForm.submit();
 	});
 	
	$('.cell').click(function(){
	    $('.cell').removeClass('select');
	    $(this).addClass('select');
	});

	$('.accordion').click(fuction(){
	    var time = $(this).attr("value");
		
		
	});
		
	}
	

	});
 });

</script> -->
</head>
<style type="text/css">
.form-inline {
	display: flex;
	flex-flow: row wrap;
	align-items: center;
}

.form-control {
	display: inline-block;
	width: auto;
	vertical-align: middle;
}

.marginTop5 {
	margin-top: -1rem;
}
.disabled {
	color: #616161 !important;
}
#accordion{
width:440px;
}
</style>
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

					<div class="content" style="height:580px;">
						<div class="calendar-container">
							<div class="calendar">
								<div class="year-header">
									<span class="left-button" id="prev"> &lang; </span> <span
										class="year" id="label"></span> <span class="right-button"
										id="next"> &rang; </span>
								</div>
								<table class="months-table"
									style="width: 100%; padding-left: 5px; padding-right: 5px;">
									<tbody style="border-width: 10px;">
										<tr class="months-row">
											<td class="month">Jan</td>
											<td class="month">Feb</td>
											<td class="month">Mar</td>
											<td class="month">Apr</td>
											<td class="month">May</td>
											<td class="month">Jun</td>
											<td class="month">Jul</td>
											<td class="month">Aug</td>
											<td class="month">Sep</td>
											<td class="month">Oct</td>
											<td class="month">Nov</td>
											<td class="month">Dec</td>
										</tr>
									</tbody>
								</table>

								<table class="days-table">
									<td class="day">Sun</td>
									<td class="day">Mon</td>
									<td class="day">Tue</td>
									<td class="day">Wed</td>
									<td class="day">Thu</td>
									<td class="day">Fri</td>
									<td class="day">Sat</td>
								</table>
								<div class="frame">
									<table class="dates-table" style="width: 100%;">
										<tbody class="tbody">
										</tbody>
									</table>
								</div>
								<button class="button" id="add-button">예약추가</button>
							</div>
						</div>
						
						
						
						
						
						
						
						<!-- 일정이 없습니다.란
						<div class="events-container" style="float:none; margin-left:27px;"></div> -->
						
						<!-- 예약창 -->
						<div class="dialog" id="dialog" style="overflow: auto;">
							<!-- 검색기능 -->
							<div class="input-group mt-4 mb-4">
								<input type="text"
									class="form-control form-contorl-sm boarder-gray col-md-12 h-25 pet_search"
									placeholder="검색어를 입력하세요" aria-label="Search"
									aria-describedby="basic-addon2" id="pet_search"
									name="pet_search">
								<div class="input-group-append">
									<button class="btn btn-primary shadow-sm" id="search_btn"
										type="button">
										<i class="fas fa-search fa-sm"></i>
									</button>
								</div>
							</div>
							
<!-- 							<div class="modal-body"> -->
							<form class="row g-2 form">
								<div class="col-md-6">
									<label for="owner_name" class="col-form-label">보호자 이름</label> <input
										type="text" class="form-control" id="owner_name" value="없음"
										readonly>
								</div>
								<div class="col-md-6">
									<label for="owne_tel" class="col-form-label">전화번호</label> <input
										type="text" class="form-control" id="owner_tel"
										placeholder="01012345678" value="없음" readonly>
								</div>
								<div class="col-md-6">
									<label for="pet_name" class="col-form-label">반려견 이름</label> <input
										type="text" class="form-control" id="pet_name" value="없음"
										readonly>
								</div>
								<div class="col-md-6">
									<label for="pet_gender" class="col-form-label">반려견 성별</label> <input
										type="text" class="form-control" id="pet_gender" value="없음"
										readonly>
								</div>
								<div class="col-md-6 mb-0">
									<label for="pet_birth" class="col-form-label">반려견 출생년도</label>
									<input type="text" class="form-control" id="pet_birth"
										value="없음" readonly>
								</div>
								<!-- 예약날짜 -->
								<p class="col-md-6 mb-0">
									<label for="reservation_date_day" class="col-form-label">예약날짜</label>
									<input class="form-control" style="width:97%;" type="date" value="년-월-일"
										id="reservation_date_day" tabindex="-1">
								</p>

								<!-- 시간설정 -->
								<div class="timeset" style="width: auto;">
									<!-- timeoption 부분-->	
									<%@ include file="timeoption.jsp"%>		
								</div>					
								<div class="">
									<label for="reservation_memo" class="col-form-label">예약메모</label>
									<textarea class="form-control" style="width:465px;" id="reservation_memo"></textarea>
								</div>
								<div class="modal-footer" style="border-top:none; padding:0;">
									<button type="button" class="btn btn-secondary"
										data-bs-dismiss="modal" id="cancel-button">취소</button>
									<button type="button" class="btn btn-primary" id="ok-button"
										name="" value="">예약하기</button>
								</div>
							</form>
<!-- 							</div> -->
						</div>
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
					</div>
				</div>





				<!-- 검색 modal  -->
				<div class="modal fade" id="petSearchModal" tabindex="-1"
					role="dialog" aria-labelledby="exampleModalLabel"
					aria-hidden="true">
					<div class="modal-dialog modal-lg" role="document">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title" id="exampleModalLabel">
									<b>전체 검색</b>
								</h5>
								<button type="button" class="btn-close" data-bs-dismiss="modal"
									aria-label="Close"></button>
							</div>
							<div class="modal-body">

								<form action="/petType" name="searchForm"
									onsubmit="return false" method="get">
									<div class="input-group mt-2 mb-3">
										<input type="text"
											class="form-control border-gray col-md-12 pet_search2"
											placeholder="검색어을 입력하세요" name="pet_search2" id="pet_search2">
										<div class="input-group-append">
											<button class="btn btn-primary" type="button"
												id="search_btn2">
												<i class="fas fa-search"></i>
											</button>
										</div>
									</div>
								</form>
								<div class="table-responsive">
									<table class="table table-sm table-bordered text-center"
										id="dataTable" width="100%" cellspacing="0"
										style="overflow: auto;">
										<thead>
											<tr class="bg-gray-200" style="line-height: 30px;">
												<th class="col-1">번호</th>
												<th class="col-2">보호자명</th>
												<th class="col-2">동물명</th>
												<th class="col-1">성별</th>
												<th class="col-4">전화번호</th>
												<th class="col-2"></th>
											</tr>
										</thead>

										<tbody class="petTable">


										</tbody>
									</table>
								</div>
							</div>
						</div>
					</div>
				</div>

				<!-- Bootstrap core JavaScript-->
				<script src="vendor/jquery/jquery.min.js"></script>
				<script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

				<!-- Core plugin JavaScript-->
				<script src="vendor/jquery-easing/jquery.easing.min.js"></script>

				<!-- Custom scripts for all pages-->
				<script src="js/sb-admin-2.min.js"></script>

				<!-- bootstrap -->
				<script
					src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>


</html>
<!-- Dialog Box-->
<script src="js/reservation/calender.js"></script>
<script src="js/reservation/calender_reserv.js"></script>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"
	integrity="sha256-hwg4gsxgFZhOsEEamdOYGBf13FyQuiTwlAQgxVSNgt4="
	crossorigin="anonymous">
  </script>
<script src="app.js"></script>

