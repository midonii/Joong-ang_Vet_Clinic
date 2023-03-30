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

<title>중앙동물병원</title>
<link rel="shortcut icon" type="image/x-icon" href="../img/favicon.png" />
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

<!-- JQUERY -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
<link href="css/chart/chart1.css" rel="stylesheet">
<script type="text/javascript" src="js/chart/chart3.js"></script>
<script type="text/javascript" src="js/chart/chartUpdate.js"></script>

</head>
<body id="page-top">

	<!-- Page Wrapper -->
	<div id="wrapper">

		<%@ include file="../bar/sideBar.jsp"%>

		<!-- Content Wrapper -->
		<div id="content-wrapper" class="d-flex flex-column">

			<!-- Main Content -->
			<div id="content">

				<%@ include file="../bar/chartTop.jsp"%>

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
											<input type="hidden" id="pet_no" name="pet_no"
												value="${param.pet_no }">
											<input type="hidden" id="chart_no" name="chart_no">
											<input type="hidden" id="chartDate">
											<tr>
												<td>보호자명 :<b class="text-gray-800">
														${profile.owner_name}</b>&nbsp;
												</td>
												<td>동물명 :<b class="text-gray-800">
														${profile.pet_name}</b>&nbsp;
												</td>
												<td>견종 : ${profile.type_name}&nbsp;</td>
												<td>성별 : ${profile.pet_gender}&nbsp;</td>
												<td>생년월일 : ${profile.pet_birth}&nbsp;</td>
												<td>나이 : ${profile.pet_Ym}&nbsp;</td>
												<td>체중 : ${profile.pet_weight}kg&nbsp;</td>
												<td>담당의 : ${sessionScope.username }&nbsp;</td>

											</tr>


										</table>

									</div>
									<div class="col-4 d-flex justify-content-end">
										<button type="button" class=" btn btn-warning btn-sm disabled chartUpdate"
											id="chartUpdate">수정</button>
									</div>
								</div>
							</div>
						</div>
					</div>



					<div class="row">

						<div class="col-xl-4 col-lg-5 px-1" style="border: 0;">
							<div class="card mb-2 ">
								<!-- Card Header - Dropdown -->
								<div
									class="card-header py-2 d-flex flex-row align-items-center justify-content-between">
									<h6 class="m-0 font-weight-bold text-primary">이전차트내역</h6>

								</div>

								<!-- Card Body -->
								<div class="card-body p-0" style="height: 705px;" id="chart"></div>
							</div>
						</div>

						<div class="col-xl-4 col-lg-5 px-1">
							<div class="card  mb-2">
								<div
									class="card-header py-2 d-flex flex-row align-items-center justify-content-between">
									<h6 class="m-0 font-weight-bold text-primary">의사소견</h6>

								</div>

								<!-- Card Body -->
								<div class="card-body p-0" style="height: 328px;">
									<textarea class="form-control"
										style="height: 328px; resize: none; border-radius: 0 0 5px 5px"
										id="memo"></textarea>

								</div>
							</div>

							<div class="card  mb-2">
								<div
									class="card-header py-2 d-flex flex-row align-items-center justify-content-between">
									<h6 class="m-0 font-weight-bold text-primary">처방내역</h6>
									<a class="text-primary"
										style="font-size: 14px; text-decoration: none;cursor: pointer;" id="presc">
										추가<i class="fa-regular fa-plus" style="margin-left: 2px;cursor: pointer; "></i>
									</a>
								</div>

								<!-- Card Body -->
								<div class="card-body" style="height: 329px; padding: 0;">
									<div class="table-responsive"
										style="min-height: 300px; float: left;">
										<div class="table-responsive"
											style="max-height: 300px; float: left;">
											<table class="table table-bordered table-sm" width="100%"
												cellspacing="0"
												style="text-align: center; overflow: auto; max-height: 280px;">
												<thead>
													<tr class="bg-gray-100" style="float: center;">
														<th class="col-2">구분</th>
														<th class="col-5">이름</th>
														<th class="col-2">수량</th>
														<th class="col-4">합계</th>
													</tr>
												</thead>
												<tbody class="CBTable">
												</tbody>
											</table>
										</div>
									</div>
									<div
										style="width: 100%; border-top: 1px solid #ccc; float: left; height: 40px;">
										<div
											style="float: left; width: calc(100% - 150px); text-align: right;">
											총 합계 :</div>
										<div class="totalPrice"
											style="float: left; width: 130px; text-align: right; margin-right: 10px;"></div>

									</div>
								</div>
							</div>
						</div>

						<div class="col-xl-4 col-lg-5 px-1">
							<div class="card  mb-2">
								<div
									class="card-header py-2 d-flex flex-row align-items-center justify-content-between">
									<h6 class="m-0 font-weight-bold text-primary">접수현황</h6>

								</div>

								<!-- Card Body -->
								<div class="card-body bg-gray-100" style="height: 328px;">
									<div class="table-responsive" id="receiveboard"
										style="overflow: auto; max-height: 280px;">

										</table>
									</div>
								</div>
							</div>

							<div class="card mb-2">
								<div
									class="card-header py-2 d-flex flex-row align-items-center justify-content-between">
									<h6 class="m-0 font-weight-bold text-primary">접종내역</h6>

								</div>

								<!-- Card Body -->
								<div class="card-body" style="height: 329px;">

									<div class="list-group list-group-flush"
										style="margin-top: -15px;" id="vac"></div>




								</div>
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
						<!-- <div class="modal-footer"></div> -->
					</div>
				</div>
			</div>

			<%@ include file="./chart_cheobangM.jsp"%>
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
