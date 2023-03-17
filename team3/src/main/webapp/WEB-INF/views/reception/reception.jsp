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

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65"
	crossorigin="anonymous">
<link href="css/sb-admin-2.min.css" rel="stylesheet">
<script type="text/javascript"
	src="cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
<!-- JQUERY -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>

<script type="text/javascript">
	$(function() {
		$("#search_btn")
				.click(
						function() {
							var pet_search = $("#pet_search").val();

							if (pet_search == "") {
								alert("검색어를 입력하세요");
								$("#pet_search").focus();
								return false;
							} else {
								$("#petSearchModal").modal("show");
								$
										.ajax({
											url : '/petSearchAjax',
											type : 'POST',
											data : {
												"pet_search" : pet_search
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
														var pet_no = pet[i].pno;
														var pet_name = pet[i].pet_name;
														var owner_name = pet[i].owner_name;
														var owner_tel = pet[i].owner_tel;
														var pet_gender = pet[i].pet_gender;

														table += "<tr class='text-center' >";
														table += "<td class='col-1'>"
																+ pet_no
																+ "</td>";
														table += "<td class='col-3'>"
																+ pet_name
																+ "</td>";
														table += "<td class='col-3'>"
																+ owner_name
																+ "</td>";
														table += "<td class='col-1'>"
																+ pet_gender
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
		$("#search_btn2")
				.click(
						function() {
							console.log("search_btn2 클릭");
							var pet_search = $("#pet_search").val();

							if (pet_search == "") {
								alert("검색어를 입력하세요");
								$("#pet_search").focus();
								return false;
							} else {
								$
										.ajax({
											url : '/petSearchAjax',
											type : 'POST',
											data : {
												"pet_search" : pet_search
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
														var pet_no = pet[i].pno;
														var pet_name = pet[i].pet_name;
														var owner_name = pet[i].owner_name;
														var owner_tel = pet[i].owner_tel;
														var pet_gender = pet[i].pet_gender;

														table += "<tr class='text-center' >";
														table += "<td class='col-1'>"
																+ pet_no
																+ "</td>";
														table += "<td class='col-3'>"
																+ pet_name
																+ "</td>";
														table += "<td class='col-3'>"
																+ owner_name
																+ "</td>";
														table += "<td class='col-1'>"
																+ pet_gender
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
	});
</script>

</head>
<script type="text/javascript">
$(function() {
	$.post({
		url : "/receiveboard",
		dataType : "json"
	})
	
});//func

</script>
<body id="page-top">

	<!-- Page Wrapper -->
	<div id="wrapper">

		<%@ include file="../bar/sideBar.jsp"%>

		<!-- Content Wrapper -->
		<div id="content-wrapper" class="d-flex flex-column">

			<!-- Main Content -->
			<div id="content">

				<%@ include file="../bar/chartTop.jsp"%>
				<%-- 				<%@ include file="../bar/chartTopBar.jsp"%> --%>


				<!-- Begin Page Content -->
				<div class="container-fluid">

					<!-- Page Heading -->
					<div class="row">
						<div class="col-xl-12 col-lg-5 px-1 mt-2" style="border: 0;">
							<div class="card mb-1 ">
								<!-- Card Header - Dropdown -->
								<div class="card-header py-2 d-flex flex-row align-items-center">

									<div class="col-8">

										<table border="0" cellspacing="0"
											style="font-size: 14px; margin-left: -10px;">

											<tr>
												<td>보호자명 : 윤지혜&nbsp;</td>
												<td>동물명 : 까미&nbsp;</td>
												<td>견종 : 포메라니안&nbsp;</td>
												<td>성별 : IF/NF&nbsp;</td>
												<td>생년월일 : 2022-01-03&nbsp;</td>
												<td>체중 : 12.0kg&nbsp;</td>
												<td>담당의 : doctor&nbsp;</td>

											</tr>


										</table>

									</div>
									<div class="col-4 d-flex justify-content-end">
										<button type="button" class=" btn btn-primary btn-sm">저장</button>
									</div>
								</div>
							</div>
						</div>
					</div>



					<div class="row">
					
<!--  ------------ 이전차트내역 ----------------- -->
						<div class="col-xl-4 col-lg-5 px-1" style="border: 0;">
							<div class="card mb-2 ">
								<!-- Card Header - Dropdown -->
								<div
									class="card-header py-2 d-flex flex-row align-items-center justify-content-between">
									<h6 class="m-0 font-weight-bold text-primary">이전차트내역</h6>

								</div>

								<!-- Card Body -->
								<div class="card-body" style="height: 705px;"></div>
							</div>
						</div>
<!--  ------------ 의사소견 & 처방내역 ----------------- -->
						<div class="col-xl-4 col-lg-5 px-1">
						
						<!-- ------ 의사소견 ------- -->
							<div class="card  mb-2">
								<div
									class="card-header py-2 d-flex flex-row align-items-center justify-content-between">
									<h6 class="m-0 font-weight-bold text-primary">의사소견</h6>

								</div>

								<!-- Card Body -->
								<div class="card-body" style="height: 328px;"></div>
							</div>

						<!-- ------ 처방내역 ------- -->
							<div class="card  mb-2">
								<div
									class="card-header py-2 d-flex flex-row align-items-center justify-content-between">
									<h6 class="m-0 font-weight-bold text-primary">처방내역</h6>
									<div class="dropdown no-arrow">
										<a href="#" role="button">추가 </a>
									</div>
								</div>

								<!-- Card Body -->
								<div class="card-body" style="height: 329px;"></div>
							</div>
						</div>
						
						
<!--  ------------ 접수현황 & 접종내역 ----------------- -->
						<div class="col-xl-4 col-lg-5 px-1">
						
						<!-- ------ 접수현황 ------- -->
							<div class="card  mb-2">
								<div
									class="card-header py-2 d-flex flex-row align-items-center justify-content-between">
									<h6 class="m-0 font-weight-bold text-primary">접수현황</h6>

								</div>

								<!-- Card Body -->
								<div class="card-body" style="height: 328px;">
									<div class="table-responsive" id="receiveboard">
									
									</div>
								</div>
							</div>
							
						<!-- ------ 접종내역 ------- -->
							<div class="card  mb-2">
								<div
									class="card-header py-2 d-flex flex-row align-items-center justify-content-between">
									<h6 class="m-0 font-weight-bold text-primary">접종내역</h6>

								</div>

								<!-- Card Body -->
								<div class="card-body" style="height: 329px;"></div>
							</div>
						</div>




					</div>







				</div>
				<!-- /.container-fluid -->

			</div>
			<!-- End of Main Content -->

			<!-- 검색모달  -->
			<div class="modal fade" id="petSearchModal" tabindex="-1"
				role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
				<div class="modal-dialog modal-lg" role="document">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="exampleModalLabel">
								<b>전체 검색</b>
							</h5>
							<button class="close" type="button" data-dismiss="modal"
								aria-label="Close">
								<span aria-hidden="true">×</span>
							</button>
						</div>
						<div class="modal-body">

							<form action="/petType" name="searchForm" onsubmit="return false"
								method="get">
								<div class="input-group mt-2 mb-3">
									<input type="text"
										class="form-control border-gray col-md-12 pet_search2"
										placeholder="검색어을 입력하세요" name="pet_search2" id="pet_search2">
									<div class="input-group-append">
										<button class="btn btn-primary" type="button" id="search_btn2">
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
											<th class="col-3">보호자명</th>
											<th class="col-3">동물명</th>
											<th class="col-1">성별</th>
											<th class="col-4">전화번호</th>
										</tr>
									</thead>

									<tbody class="petTable">


									</tbody>
								</table>
							</div>





						</div>
						<!-- <div class="modal-footer"></div> -->
					</div>
				</div>
			</div>


			<%@ include file="../bar/footer.jsp"%>
			<%@ include file="../bar/logoutModal.jsp"%>



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
