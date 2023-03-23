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
<link href="css/chart/chart1.css" rel="stylesheet">
<script type="text/javascript" src="js/chart/chart1.js"></script>
<script type="text/javascript" src="js/chart/chart3.js"></script>
<script type="text/javascript">
	$(function() {
		var pet_no = $("#pet_no").val();

		$
				.post({
					url : "/petVacAjax",
					cache : false,
					data : {
						"pet_no" : pet_no
					},
					dataType : "json"
				})
				.done(
						function(data) {
							let pet = data.pet;
							$("#vac").empty();
							var div = "";
							if (pet == "") {
								div += "<div style='height:300px;line-height: 300px;text-align: center;'>접종 내역이 없습니다.</div>";
							} else {
								for (let i = 0; i < pet.length; i++) {
									var vac_name = pet[i].vac_name;
									var vacdata_date = pet[i].vacdata_date;
									div += "<div class='list-group-item row'><div class='col-7 font-weight-bold float-left text-center'>"
											+ vac_name
											+ "</div><div class='col-5 float-left text-center'>"
											+ vacdata_date + "</div></div>";
								}
							}
							$("#vac").append(div);
						}).fail(function(xhr, status, errorThrown) {
					alert("실패");
				});
	});

	$(function() {
		var pet_no = $("#pet_no").val();
		$
				.post({
					url : "/chartAjax",
					cache : false,
					data : {
						"pet_no" : pet_no
					},
					dataType : "json"
				})
				.done(
						function(data) {
							let chart = data.chart;
							$("#chart").empty();
							var chartdiv = "";
							if (data.chart == "") {
								chartdiv += "<div class='text-center' style='height:705px; line-height:705px;'>진료 내역이 없습니다.</div>";
							} else {
								for (let i = 0; i < chart.length; i++) {
									var receieve_no = chart[i].receieve_no;
									var pet_no = chart[i].pet_no;
									var pet_name = chart[i].pet_name;
									var chart_no = chart[i].chart_no;
									var chart_memo = chart[i].chart_memo;
									var chart_date = chart[i].chart_date;
									var staff_no = chart[i].staff_no;
									var staff_name = chart[i].staff_name;
									var staff_grade = chart[i].staff_grade;
									$("#chart_no").val(chart[i].chart_no);
									chartdiv += "<div class='accordion' id='accordionExample' >"
									chartdiv += "<div class='accordion-item'><h2 class='accordion-header' id='"+chart_date+"'>"
									chartdiv += "<button class='accordion-button collapsed pastChart' type='button' data-toggle='collapse' data-target='#A"
											+ chart_no + "' "
									chartdiv += "aria-expanded='";
									chartdiv += i == 0 ? true : false + "'";
									chartdiv += " aria-controls='A" + chart_no
											+ "' value='" + chart_no + "'>";
									chartdiv += "	<div class='font-weight-bold'>차트번호 :</div>";
									chartdiv += "	<div class='ml-2 font-weith'>"
											+ chart_no + "</div>";
									chartdiv += "	<div class='ml-5 font-weight-bold'>진료날짜 :</div>";
									chartdiv += "	<div class='ml-2'>"
											+ chart_date + "</div>";
									chartdiv += "	</button></h2>";
									chartdiv += "<div id='A"+chart_no+"' class='accordion-collapse collapse' aria-labelledby='"+chart_date+"' data-bs-parent='#accordionExample'>";
									chartdiv += "<div class='accordion-body' >"
									chartdiv += "<div class='d-flex justify-content-end'><span>담당의 : </span><span class='font-weight-bold'>&nbsp;"
											+ staff_name + "</span></div>";

									chartdiv += "<div class='mb-4'> <div class='card h-100 py-2'> <div class='card-body'>";
									chartdiv += "<div class='row no-gutters align-items-center'> <div class='col mr-2'>";
									chartdiv += "<div class='text-sm font-weight-bold text-info text-uppercase mb-1'>의사소견 </div>";
									chartdiv += "<div class='row no-gutters align-items-center'>"
											+ chart_memo
											+ "</div></div></div></div></div></div>";

									chartdiv += "<div class='card mb-4'><div class='card-body'><div class='d-flex justify-content-center'>";
									chartdiv += "<div class='text-sm font-weight-bold text-info text-uppercase mb-3 '>처방 상세 내역</div></div><div class='table-responsive' style='height:200px; overflow: auto;'><div id='clientScroll'>";
									chartdiv += "<table class='table table-center table-sm table-bordered text-center'  id='dataTable' width='100%' cellspacing='0'>";
									chartdiv += "<thead><tr>";
									chartdiv += "<th class='col-md-2'>구분</th>";
									chartdiv += "<th class='col-md-2'>분류</th>";
									chartdiv += "<th class='col-md-4'>처방명</th>";
									chartdiv += "<th class='col-md-2'>수량</th>";
									chartdiv += "<th class='col-sm-2'>담당자</th></tr></thead>";

									chartdiv += "<tbody id='client-table"+chart_no+"' data-spy='scroll' data-target='#list-example' data-offset='0' class='scrollspy-example'>";

									chartdiv += "<tr class='chartList"+chart_no+"'>";
									chartdiv += "<td>(카테고리)</td>";
									chartdiv += "<td>(상세 카테고리)</td>";
									chartdiv += "<td class='text-left'>(처방내역)</td>";
									chartdiv += "<td>(수량)</td>";
									chartdiv += "<td>(담당자)</td>";
									chartdiv += "</tbody></table></div></div></div></div></div></div></div>";

								}

							}
							$("#chart").append(chartdiv);

							$(document)
									.on(
											"click",
											".pastChart",
											function() {
												var chartNo = $(this).attr(
														"value");
												$("#chart_no").val(chartNo);
												$("#memo").val("");
												$
														.post(
																{
																	url : "/CDetailAjax",
																	data : {
																		"chart_no" : chartNo,
																		"pet_no" : pet_no
																	},
																	dataType : "json"
																})
														.done(
																function(data) {
																	let petExam = data.petExam;
																	let petDrug = data.petDrug;
																	let petVac = data.petVac;
																	let petChart = data.chart;
																	$("#memo").val(petChart[0].chart_memo);
															
																})
														.fail(
																function() {
																	alert("문제가 발생했습니다.");
																});

												$
														.post(
																{
																	url : "/preAjax",
																	data : {
																		"chart_no" : chartNo,
																		"pet_no" : pet_no
																	},
																	dataType : "json"
																})
														.done(
																function(data) {
																	let petExam = data.petExam;
																	let petDrug = data.petDrug;
																	let petVac = data.petVac;

																	var table = "";
																	$(
																			'.chartList'
																					+ chartNo)
																			.hide();
																	//상세보기 클릭 시 이전 기록 reset
																	$(
																			"#client-table"
																					+ chartNo)
																			.empty();

																	// -- 검사
																	for (let i = 0; petExam.length > i; i++) {
																		var medical_category_Ex = petExam[i].medical_category;
																		var medical_subcate_Ex = petExam[i].medical_subcate;
																		var medical_name_Ex = petExam[i].medical_name;
																		var staff_name_Ex = petExam[i].staff_name;
																		var staff_grade_Ex = petExam[i].staff_grade;
																		var examdata_ea = petExam[i].examdata_ea;

																		table += "<tr class='chartList"+chartNo+"'>";
																		table += "<td>"
																				+ medical_category_Ex
																				+ "</td>";
																		table += "<td>"
																				+ medical_subcate_Ex
																				+ "</td>";
																		table += "<td class='text-left'>"
																				+ medical_name_Ex
																				+ "</td>";
																		table += "<td>"
																				+ examdata_ea
																				+ "</td>";
																		table += "<td>"
																				+ staff_name_Ex
																				+ "</td>";
																		table += "</tr>";

																	}

																	// -- 약처방
																	for (let i = 0; petDrug.length > i; i++) {
																		var medical_category_Dg = petDrug[i].medical_category;
																		var medical_subcate_Dg = petDrug[i].medical_subcate;
																		var medical_name_Dg = petDrug[i].medical_name;
																		var staff_name_Dg = petDrug[i].staff_name;
																		var staff_grade_Dg = petDrug[i].staff_grade;
																		var drugdata_ea = petDrug[i].drugdata_ea;

																		table += "<tr class='chartList"+chartNo+"'>";
																		table += "<td>"
																				+ medical_category_Dg
																				+ "</td>";
																		table += "<td>"
																				+ medical_subcate_Dg
																				+ "</td>";
																		table += "<td class='text-left'>"
																				+ medical_name_Dg
																				+ "</td>";
																		table += "<td>"
																				+ drugdata_ea
																				+ "</td>";
																		table += "<td>"
																				+ staff_name_Dg
																				+ "</td>";
																		table += "</tr>";

																	}

																	// -- 접종
																	for (let i = 0; petVac.length > i; i++) {
																		var vac_name = petVac[i].vac_name;
																		var medical_category = petVac[i].medical_category;
																		var staff_name_Vac = petVac[i].staff_name;
																		var staff_grade_Vac = petVac[i].staff_grade;

																		table += "<tr class='chartList"+chartNo+"'>";
																		table += "<td>접종</td>";
																		table += "<td>접종</td>";
																		table += "<td class='text-left'>"
																				+ vac_name
																				+ "</td>";
																		table += "<td>1</td>";
																		table += "<td>"
																				+ staff_name_Vac
																				+ "</td>";
																		table += "</tr>";

																	}

																	//$(this).children("#client-table").append(table);
																	$(
																			"#client-table"
																					+ chartNo)
																			.append(
																					table);
																	$(
																			"#client-table"
																					+ chartNo)
																			.show();

																})
														.fail(
																function() {
																	alert("문제가 발생했습니다.");
																});

											});
						}).fail(function(xhr, status, errorThrown) {
					alert("실패");
				});

		$("#chartUpdate").click(function() {
			var chart_no = $("#chart_no").val();
			var chart_memo = $("#memo").val();
			$.post({
				url : "/chartUpdate",
				data : {
					"chart_no" : chart_no,
					"chart_memo" : chart_memo,
				},
				dataType : "json"
			}).done(function(data) {
				if (confirm("차트를 수정하시겠습니까?")) {
					if (data.result == 1) {
						alert("차트가 수정되었습니다.");
						location.href = "/chartUpdate?pet_no=" + pet_no;
					} else {
						alert("권한이 없습니다.");
					}
				}
			}).fail(function() {
				alert("문제발생");
			});
		});
	});
</script>

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
											<input type="hidden" id="pet_no" name="pet_no"
												value="${param.pet_no }">
											<input type="hidden" id="chart_no" name="chart_no">
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
										<button type="button" class=" btn btn-warning btn-sm"
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

								</div>

								<!-- Card Body -->
								<div class="card-body" style="height: 329px;"></div>
							</div>
						</div>

						<div class="col-xl-4 col-lg-5 px-1">
							<div class="card  mb-2">
								<div
									class="card-header py-2 d-flex flex-row align-items-center justify-content-between">
									<h6 class="m-0 font-weight-bold text-primary">접수현황</h6>

								</div>

								<!-- Card Body -->
								<div class="card-body" style="height: 328px;">
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
