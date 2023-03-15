<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<%
if (session.getAttribute("id") == null) {
	response.sendRedirect("/login");
}
%>
<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>Team 3</title>
<link rel="stylesheet"
	href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<!-- Custom fonts for this template-->
<script src="https://kit.fontawesome.com/a31e2023c3.js"
	crossorigin="anonymous"></script>
<link
	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">
<!-- Custom styles for this template-->

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<link href="css/sb-admin-2.min.css" rel="stylesheet">
<script type="text/javascript"
	src="cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
<!-- JQUERY -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
<link rel="stylesheet" href="css/reservation/calender/calender2.css">
</head>
<script type="text/javascript">
	$(function() {

		$
				.post({
					url : "/noticeAjax",
					dataType : "json"

				})
				.done(
						function(data) {
							let notice = data.notice;
							var table = "<table class='table table-sm' id='dataTable' width='100%' cellspacing='0'><thead>"
									+ "<tr class='text-center'>"
									+ "<th class='col-2'>번호</th>"
									+ "<th class='col-5 text-left'>제목</th>"
									+ "<th class='col-4'><i class='fa-regular fa-calendar'></i></th>"
									+ "<th class='col-1'><i class='fa-solid fa-eye'></i></th>"
									+ "</tr></thead>";

							for (let i = 0; notice.length > i; i++) {
								var listdate = notice[i].listdate;
								var nno = notice[i].nno;
								var notice_no = notice[i].notice_no;
								var notice_title = notice[i].notice_title;
								var notice_read = notice[i].notice_read;

								table += "<tbody>";
								table += "<tr class='text-center'>";
								table += "<td>" + nno + "</td>";
								table += "<td class='text-left'><a href='#' style='text-decoration: none;' class='noticeDetailModal' data-toggle='modal' data-value='"+ notice_no +"'>"
										+ notice_title + "</a></td>";
								table += "<td>" + listdate + "</td>";
								table += "<td>" + notice_read + "</td>";
								table += "</tr>";
							}
							$("#notice").append(table);
						}).fail(function() {
					alert("문제가 발생했습니다.");
				});
		$(document).on("click", ".noticeDetailModal", function() {
			$("#noticeDetailModal").modal("show");
			var notice_no = $(this).attr("data-value");
			$.post({
				url : "/noticeDetail",
				cache : false,
				data : {
					"notice_no" : notice_no
				},
				dataType : "json"
			}).done(function(data) {
				let result = data.result;
				let read = data.read;
				if (read == 1) {
					$("#D_no").val(result.notice_no);
					$("#D_title").text(result.notice_title);
					$("#D_content").text(result.notice_content);
					$("#D_date").text(result.listdate);
					$("#D_read").text(result.notice_read);
					$("#D_name").text(result.staff_name);
				}
			}).fail(function(xhr, status, errorThrown) {
				alert("실패");
			});
		});

	});

	$(function() {
		$
				.post({
					url : "/reservindexAjax",
					dataType : "json"

				})
				.done(
						function(data) {
							let reserv = data.reserv;
							var table = "<table class='table table-sm' id='dataTable' width='100%' cellspacing='0'><thead>"
									+ "<tr class='text-center'>"
									+ "<th class='col-3'>번호</th>"
									+ "<th class='col-3'>동물명</th>"
									+ "<th class='col-3'>보호자명</th>"
									+ "<th class='col-3'>예약시간</th>"
									+ "</tr></thead>";

							for (let i = 0; reserv.length > i; i++) {
								var rno = reserv[i].rno;
								var pet_name = reserv[i].pet_name;
								var owner_name = reserv[i].owner_name;
								var reserv_date = reserv[i].reserv_date;

								table += "<tbody>";
								table += "<tr class='text-center'>";
								table += "<td>" + rno + "</td>";
								table += "<td>" + pet_name + "</td>";
								table += "<td>" + owner_name + "</td>";
								table += "<td>" + reserv_date + "</td>";
								table += "</tr>";
							}
							$("#reserv").append(table);
						}).fail(function() {
					alert("문제가 발생했습니다.");
				});
		$
				.post({
					url : "/payAjax",
					dataType : "json"

				})
				.done(
						function(data) {
							let pay = data.pay;
							var table = "<table class='table table-sm' id='dataTable' width='100%' cellspacing='0'><thead>"
									+ "<tr class='text-center'>"
									+ "<th class='col-3'>차트번호</th>"
									+ "<th class='col-3'>동물명</th>"
									+ "<th class='col-3'>보호자명</th>"
									+ "<th class='col-3'>수납금액</th>"
									+ "</tr></thead>";

							for (let i = 0; pay.length > i; i++) {
								var chart_no = pay[i].chart_no;
								var pet_name = pay[i].pet_name;
								var owner_name = pay[i].owner_name;
								var totalprice = pay[i].totalprice;

								table += "<tbody>";
								table += "<tr class='text-center'>";
								table += "<td>" + chart_no + "</td>";
								table += "<td>" + pet_name + "</td>";
								table += "<td>" + owner_name + "</td>";
								table += "<td>" + totalprice + "</td>";
								table += "</tr>";
							}
							$("#pay").append(table);
						}).fail(function() {
					alert("문제가 발생했습니다.");
				});
		$
				.post({
					url : "/receivepay",
					dataType : "json"

				})
				.done(
						function(data) {
							let receivepay = data.receivepay;
							var table = "<table class='table table-sm text-center' id='dataTable' width='100%' cellspacing='0'><thead>"
									+ "<tr class='text-center'>"
									+ "<th class='col-2'>번호</th>"
									+ "<th class='col-3'>동물명</th>"
									+ "<th class='col-3'>보호자명</th>"
									+ "<th class='col-4'>접수수납현황</th>"
									+ "</tr></thead>";

							for (let i = 0; receivepay.length > i; i++) {
								var ino = receivepay[i].ino;
								var pet_name = receivepay[i].pet_name;
								var owner_name = receivepay[i].owner_name;
								var state = receivepay[i].receive_state;
								var pay_yn = receivepay[i].pay_yn;

								table += "<tbody>";
								table += "<tr class='text-center'>";
								table += "<td>" + ino + "</td>";
								table += "<td>" + pet_name + "</td>";
								table += "<td>" + owner_name + "</td>";
								if(state == 3){
									if(pay_yn=="Y"){
									table += "<td><span class='badge text-bg-primary'>수납대기</span></td>";
									}else{
										table += "<td><span class='badge text-bg-secondary'>수납완료</span></td>";
									}
								}else if(state == 2){
								table += "<td><span class='badge text-bg-danger' >진료 중</span></td>";
								}else if(state == 1){
								table += "<td><span class='badge text-bg-success' >대기 중</span></td>";
									
								}
								table += "</tr>";
							}
							$("#receivepay").append(table);
						}).fail(function() {
					alert("문제가 발생했습니다.");
				});
	});
	$(function() {
		$.post({
			url : "/petAjax",
			dataType : "json"

		})

		.done(function(data) {
			let pet = data.pet;
			var table = "";

			for (let i = 0; pet.length > i; i++) {
				var pet_no = pet[i].pet_no;
				var pet_name = pet[i].pet_name;
				var owner_name = pet[i].owner_name;
				var owner_tel = pet[i].owner_tel;

				table += "<tr class='text-center' >";
				table += "<td>" + pet_no + "</td>";
				table += "<td>" + pet_name + "</td>";
				table += "<td>" + owner_name + "</td>";
				table += "<td>" + owner_tel + "</td>";
				table += "</tr>";
			}
			$(".petTable").append(table);
		}).fail(function() {
			alert("문제가 발생했습니다.");
		});
		$(document)
				.on(
						"click",
						"#search_btn",
						function() {
							let searchValue = $("#search_value").val();

							if (searchValue == "" || searchValue.length < 2) {
								alert("검색어를 입력하세요.\n2글자 이상입력하세요.");
								return false;
							} else {

								$
										.ajax({
											url : '/petAjax',
											type : 'POST',
											data : {
												"search_value" : searchValue
											},
											success : function(data) {
												let pet = data.pet;
												$(".petTable").empty();
												var table = "";
												if (pet == "") {
													table += "<tr class='text-center'> <td colspan='4'>존재하지 않습니다.<br><br>";
													table += "<button class='btn btn-sm btn-primary' id='reg_btn'>신규등록</button></td></tr>";
												} else {
													for (let i = 0; pet.length > i; i++) {
														var pet_no = pet[i].pet_no;
														var pet_name = pet[i].pet_name;
														var owner_name = pet[i].owner_name;
														var owner_tel = pet[i].owner_tel;

														table += "<tr class='text-center' >";
														table += "<td class='col-2'>"
																+ pet_no
																+ "</td>";
														table += "<td class='col-3'>"
																+ pet_name
																+ "</td>";
														table += "<td class='col-3'>"
																+ owner_name
																+ "</td>";
														table += "<td class='col-4'>"
																+ owner_tel
																+ "</td>";
														table += "</tr>";

													}

												}
												$(".petTable").append(table);
											},
											error : function(e) {
												alert("실패");
											}
										});
							}
						});

		$(document).on("click", "#reg_btn", function() {
			location.href = "/profile";

		});

	});
</script>




<body id="page-top">

	<!-- Page Wrapper -->
	<div id="wrapper">

		<%@ include file="bar/sideBar.jsp"%>

		<!-- Content Wrapper -->
		<div id="content-wrapper" class="d-flex flex-column">

			<!-- Main Content -->
			<div id="content">

				<%@ include file="bar/topBar.jsp"%>


				<!-- Begin Page Content -->
				<div class="container-fluid">

					<!-- Page Heading -->


					<div class="row">

						<!-- 캘린더 -->
						<div class="col-xl-4 col-lg-5 ">
							<div class="card shadow mb-3">
								<!-- Card Header - Dropdown -->


								<!-- Card Body -->
								<div class="card-body">
									<!-- <div class="calendar-container d-flex justify-content-center"
										style="width: 100%">
										<div class="calendar">

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

										</div>
									</div> -->
								</div>
							</div>
						</div>
						<!-- 공지사항 -->
						<div class="col-xl-4 col-lg-5">
							<div class="card shadow mb-4">
								<!-- Card Header -->
								<div
									class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
									<h6 class="m-0 font-weight-bold text-primary">공지사항</h6>
									<div class="dropdown no-arrow">
										<a href="/notice" role="button">+more </a>

									</div>
								</div>

								<!-- Card Body -->
								<div class="card-body" style="margin-top: -10px;">

									<div class="table-responsive" id="notice" style="height: 270px;">
										</tbody>
										</table>
									</div>
								</div>
							</div>
						</div>
						<!-- 반려견, 보호자 검색 리스트 -->
						<div class="col-xl-4 col-lg-5">
							<div class="card shadow mb-4">
								<!-- Card Header -->
								<div
									class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
									<h6 class="m-0 font-weight-bold text-primary">빠른 검색</h6>
								</div>
								<!-- Card Body -->
								<div class="card-body" style="margin-top: -10px;">

									<div class="input-group mb-2">
										<input type="text"
											class="form-control form-control-sm border-gray col-md-12"
											placeholder="검색어를 입력하세요" name="search_value"
											id="search_value">
										<div class="input-group-append">
											<button class="btn btn-primary btn-sm" type="button"
												id="search_btn">
												<i class="fas fa-search"></i>
											</button>
										</div>
									</div>

									<div class="table-responsive" id="pet" style="height: 230px;">
										<table class="table table-sm" width="100%" cellspacing="0">
											<thead>
												<tr class="text-center">
													<th class="col-2">번호</th>
													<th class="col-3">동물명</th>
													<th class="col-3">보호자명</th>
													<th class="col-4">전화번호</th>
												</tr>
											</thead>
											<tbody class="petTable" style="overflow: auto;">
											</tbody>
										</table>
									</div>
									<!-- </div> -->
								</div>
							</div>
						</div>



					</div>
					<div class="row">
						<!-- 당일예약리스트 -->
						<div class="col-xl-4 col-lg-5">
							<div class="card shadow mb-3">
								<!-- Card Header - Dropdown -->
								<div
									class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
									<h6 class="m-0 font-weight-bold text-primary">당일예약</h6>

								</div>

								<!-- Card Body -->
								<div class="card-body" style="margin-top: -10px;">
									<div class="table-responsive" id="reserv" style="height: 280px;">
										</tbody>
										</table>
									</div>

								</div>
							</div>
						</div>

						<!-- 접수수납 -->
						
						<div class="col-xl-8 col-lg-5">
							<div class="card shadow mb-4">
								<!-- Card Header -->
								<div
									class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
									<h6 class="m-0 font-weight-bold text-primary">접수/수납 현황</h6>
									<div class="dropdown no-arrow">
										<a href="/pay" role="button">+more </a>

									</div>
								</div>

								<!-- Card Body -->
								<div class="card-body" style="margin-top: -10px;">

									<div class="table-responsive" id="receivepay" style="height: 280px;">
										</tbody>
										</table>
									</div>
								</div>
							</div>
						</div>


					</div>



				</div>
				<!-- /.container-fluid -->

			</div>
			<!-- End of Main Content -->

			<%@ include file="bar/footer.jsp"%>
			<%@ include file="bar/logoutModal.jsp"%>
			<%-- 			<%@ include file="bar/logoutModal.jsp" %> --%>

			<!-- 공지사항 상세보기 Modal-->
			<div class="modal fade" id="noticeDetailModal" data-backdrop="static"
				tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
				aria-hidden="true">
				<div class="modal-dialog modal-lg modal-dialog-centered"
					role="document">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="exampleModalLabel">공지사항 상세보기</h5>
							<button class="close refresh" type="button" data-dismiss="modal"
								aria-label="Close">
								<span aria-hidden="true">×</span>
							</button>
						</div>
						<div class="modal-body">
							<input type="hidden" id="D_no" name="D_no">
							<ul class="list-group list-group-flush">
								<li class="list-group-item">
									<div class="row">
										<div
											class="col-md-12 text-lg font-weight-bold text-gray-900 text-center"
											id="D_title"></div>
									</div>
								</li>
								<li class="list-group-item">
									<div class="row">
										<div class="col-md-7">
											<i class="fa-solid fa-user"></i>&nbsp;&nbsp;<span id="D_name"></span>
										</div>
										<div class="col-md-2">
											<i class="fa-solid fa-eye"></i>&nbsp;<span id="D_read"></span>
										</div>
										<div class="col-md-3">
											<i class="fa-regular fa-calendar"></i>&nbsp;<span id="D_date"></span>
										</div>
									</div>
								</li>
								<li class="list-group-item">
									<div class="row">
										<div id="D_content"></div>
									</div>
								</li>

							</ul>
						</div>

					</div>
				</div>
			</div>


			<!-- Bootstrap core JavaScript-->
			<script src="js/reservation/calender/calender.js"></script>
			<script src="vendor/jquery/jquery.min.js"></script>
			<script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

			<!-- Core plugin JavaScript-->
			<script src="vendor/jquery-easing/jquery.easing.min.js"></script>

			<!-- Custom scripts for all pages-->
			<script src="js/sb-admin-2.min.js"></script>
</body>

</html>
