
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="en">
<<<<<<< HEAD
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

<title>예약/접수</title>
<link rel="stylesheet"
	href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
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
<!-- bootstrap -->

<style type="text/css">
</style>
<script type="text/javascript">
	$(function() {

		//검색
		$('#search_btn')
				.click(
						function() {
							var searchValue = $("#search_value").val();
							//alert(searchValue.length < 2);
							if (searchValue == "") {
								alert("검색어를 입력하세요");
								return false;
							} else if (searchValue.length < 1) {
								alert("2글자 이상 입력하세요"); //ok
								return false;
							} else {
								$
										.ajax({
											url : "/reservsearch",
											type : "GET",
											data : {
												"searchValue" : searchValue
											},
											dataType : "json",
											cache : false
										})
										.done(
												function(data) { //controller다녀온후 mapper조회값으로 done실행
													alert("통신에 성공했습니다. "); //ok
													let result = data.result; //result: result안에 pet_birth, owner_name등 정보가 다 있음. 
													// 				alert("pet_birth: "+result[0].pet_birth);//ok
													//alert("data.result.length: "+data.result.length);//ok

													$('#ajaxTable').empty(); //리스트 초기화

													if (data.result.length == 0) {
														alert("검색 결과가 없습니다.");
													} else if (data.result.length > 0) {
														let table = '';
														for (let i = 0; i < result.length; i++) {
															table += '<tr class="search_result" style="border-bottom: 1px solid gray; padding-bottom: 5px;">';
															table += '<td style="font-size: 14px;">';
															table += '<div><a href="#" style="text-decoration: none;">';
															table += '<b style="font-size: 25px; color: black">'
																	+ result[i].pet_name
																	+ '</b></a>&nbsp;&nbsp;&nbsp;'
																	+ result[i].owner_name
																	+ '</div><br>';
															table += '<span>'
																	+ result[i].pet_birth
																	+ ' | 4살 | '
																	+ result[i].pet_gender
																	+ '</span><br>';
															table += '<span>'
																	+ result[i].pet_memo
																	+ '</span></td>';
															table += '<input type="hidden" id="petNo" value="'+result[i].pet_no+'">';
															table += '<td style="text-align: right;"><span></span><br><br><span>';
															table += '<button type="button" class="btn btn-sm reserv_btn" value="'+result[i].owner_no+'" style="border: 1px solid #0d6efd; color: #0d6efd;">예약</button>';
															table += '<button type="button" id="receipt_btn" class="btn btn-primary btn-sm" style="margin-left:5px; border: none;">접수</button></span></td></tr>';
														}
														$("#ajaxTable").append(
																table);
														$("#ajaxTable").show();
													}
												})
										.fail(
												function(jqXHR, textStatus,
														errorThrown) {
													alert("POST request failed: "
															+ errorThrown);
												});
							}

							//예약버튼
							$(document)
									.on(
											"click",
											".reserv_btn",
											function() { //.reserv_btn 클래스를 가진 버튼이 클릭되었을 때 함수를 실행
												//필수(모달띄우기 위함)
												//owner_no로 하면 안됨!!!!
												//controller에서 owner_no에 값을 넣어주기때문(owner_no관련 정보 전체다 출력됨.)reservDTO.setDetail_no(request.getParameter("detail_no"));
												let detail_no = $(this).attr(
														"value"); //owner_no정보 (button의 value값)
												//alert(detail_no + " : owner_no"); //ok

												//이제 이걸 post로 /reservAjax 컨트롤러로 전송
												$
														.ajax(
																{
																	url : "/reservAjax",
																	type : "POST",
																	data : {
																		"detail_no" : detail_no
																	}, //button클릭하면 받아오는 owner_no정보를 컨트롤러(서버)에 보냄 //search_no기준으로 나머지 정보가져옴
																	dataType : "json",
																	cache : false
																})
														.done(
																function(data) { //data: 서버가 전송한 데이터(html의 태그안에 박혀있는 값들 넣기). {"search_no": search_no}가 아님!
																	alert('성공'); //ok
																	$(
																			"#exampleModal")
																			.modal(
																					'show')
																	let result = data.result; //result: html의 태그안에 박혀있는 값들 넣기
																	// 				    컨트롤러에 result 선언함. json.put("result", searchDetail);
																	// 				    data: 서버에서 반환되는 데이터(JSON 형식)
																	// 				    data.result: 서버에서 반환된 JSON 데이터 객체의 result 프로퍼티 값(0 or 1)
																	$(
																			'#owner_name')
																			.val(
																					result[0].owner_name);
																	$(
																			'#owner_tel')
																			.val(
																					result[0].owner_tel);
																	$(
																			'#pet_name')
																			.val(
																					result[0].pet_name);
																	$(
																			'#pet_gender')
																			.val(
																					result[0].pet_gender);
																	$(
																			'#pet_birth')
																			.val(
																					result[0].pet_birth);
																	$('#petNo')
																			.val(
																					result[0].pet_no);
																	//alert("petNo : "+result[0].pet_no);
																})
														.fail(
																function(
																		jqXHR,
																		textStatus,
																		errorThrown) {
																	alert("get request failed: "
																			+ errorThrown);
																});
												// 	    var ownerNo = $(this).data('owner-no'); //ok
												// 	    var petName = $(this).closest('div').find('b').data('pet-name'); //양우
												// 	    var ownerName = $(this).closest('div').find('a').text().trim();
												// 	    var petBirth = $(this).closest('div').next().find('span').data('pet-birth');
												// 	    var petGender = $(this).closest('div').next().find('span').data('pet-gender');
												// 	    var petMemo = $(this).closest('div').next().find('span').data('pet-memo');
												// 	    alert(($(this).closest('div').find('b').data('pet-name'))); //undefined

												//예약날짜 디폴트(today)
												var today = new Date();
												var todayYear = today
														.getFullYear();
												var todayMonth = ('0' + (today
														.getMonth() + 1))
														.slice(-2);
												var todayDate = ('0' + today
														.getDate()).slice(-2);
												var reservationdateday = todayYear
														+ '-'
														+ todayMonth
														+ '-' + todayDate; //디폴트날짜
												$('#reservation_date_day').val(
														reservationdateday);

												// (디폴트값에서)예약날짜 변경 시 final_date 변수에 저장
												$('#reservation_date_day')
														.change(
																function() {
																	//변경된 날짜(yyyy-mm-dd)
																	var reservation_date_day_input = $(
																			this)
																			.val();
																	//변경된 날짜를 '-'기준으로 자르기' (yyyy,mm,dd)
																	var reservation_date_day_parts = reservation_date_day_input
																			.split('-');
																	//(yy-mm-dd) 형식으로 바꾸기
																	var reservation_date_day = reservation_date_day_parts[0]
																			+ '-'
																			+ reservation_date_day_parts[1]
																			+ '-'
																			+ reservation_date_day_parts[2];
																	//alert("reservation_date_day : "+reservation_date_day); //최종 날짜
																	$(
																			'#reservation_date_day')
																			.val(
																					reservation_date_day);
																});

												//예약시간
												var reservation_date_time = ''; //시간
												var reservation_date = ''; //최종 날짜+시간

												$('.cell')
														.click(
																function() {
																	$('.cell')
																			.removeClass(
																					'select');
																	$(this)
																			.addClass(
																					'select');
																	reservation_date_time = $(
																			'.select')
																			.text(); //최종 시간
																	//alert("reservation_date_time : "+reservation_date_time); //ok

																	if (reservation_date_day !== ''
																			&& reservation_date_time !== '') {
																		//	 			        var reservationdate = new Date(reservation_date_day + 'T' + reservation_date_time + ':00'); //최종날짜+최종시간
																		//최종날짜+최종시간
																		var reservationdate = ($(
																				'#reservation_date_day')
																				.val()
																				+ ' '
																				+ reservation_date_time + ':00');
																		$(
																				'#reservation_date')
																				.val(
																						reservationdate); //최종날짜시간 value에 삽입
																		//alert("최종(hidden) reservation_date : " + reservationdate); //ok //2023-03-13 12:00:00
																	}
																});

												//예약완료 버튼
												$("#ok-button")
														.click(
																function() {
																	// 				$(document).on("click", "#ok-button", function(){
																	if (reservation_date_time === '') {
																		alert('예약 시간을 선택해주세요'); //ok
																		return;
																	}

																	$(
																			"#ok-button")
																			.val(
																					$(
																							"#petNo")
																							.val()); //ok

																	let petNo = $(
																			this)
																			.attr(
																					"value"); //button안의 pet_no값 //ok
																	//alert("ok-button value값 : "+ $("#ok-button").val()); //ok

																	var reservation_memo = $(
																			'#reservation_memo')
																			.val();
																	var reservation_date = $(
																			'#reservation_date')
																			.val();
																	//reservation_date = reservationdate.toISOString(); //최종 날짜+시간 //date객체 받아오는법
																	$(
																			"#exampleModal")
																			.modal(
																					'hide');
																	//백으로 보내서 삽입
																	$
																			.ajax(
																					{
																						url : "/reservAdd",
																						data : {
																							"petNo" : petNo,
																							"reservation_memo" : reservation_memo,
																							"reservation_date" : reservation_date
																						},
																						type : "POST"

																					})
																			.done(
																					function(
																							data) {
																						alert("통신성공?");
																						if (data.result == 1) {
																							alert("저장성공");
																							console
																									.log("저장성공");
																							location.href = "/reserv";
																						} else {
																							alert("저장실패");
																						}
																					})
																			.fail(
																					function() {
																						alert("통신실패 : "
																								+ data.result);
																					});
																});
											}); //예약버튼 끝

						});

		//예약창 닫았을때 text값 초기화
		$('#exampleModal').on('hidden.bs.modal', function(e) {
			if ($(this).find('form').length > 0) {
				$(this).find('form')[0].reset();
				var inputValue = $(this).find('select:eq(0) option:eq(0)');
			}
			//accordion창 접기
			$('.accordion-collapse').collapse('hide');
		});

		//예약수정
		$("#xeicon").click(function() {

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
				<%@ include file="../bar/topBar.jsp"%>
				<div style="margin-top: -23px;"></div>
				<%@ include file="../reservation/reserv_bar.jsp"%>
				<!-- Begin Page Content -->
				<div class="container-fluid">



					<!-- 검색창 / 예약창 / 접수창 -->
					<div class="row">
						<!-- 검색 -->
						<div class="col-xl-4">
							<div class="card shadow mb-4">
								<!--메뉴1 -->
								<div
									class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
									<h6 class="m-0 font-weight-bold text-primary">고객조회</h6>
								</div>
								<div class="card-body p-3" style="height: 660px;">
									<!-- 검색기능 -->
									<div class="input-group mb-2">
										<input type="text"
											class="form-control form-control-sm border-gray col-md-12"
											placeholder="이름 혹은 전화번호" aria-label="검색" name="search_value"
											id="search_value">
										<div class="input-group-append">
											<button class="btn btn-primary btn-sm" type="button"
												id="search_btn">
												<i class="fas fa-search"></i>
											</button>
										</div>
									</div>
									<table class="table table-borderless"
										style="color: gray; background-color: white;">
										<tbody id="ajaxTable">
											<tr id="search_result">

											</tr>
										</tbody>
									</table>
								</div>
							</div>
						</div>



						<!-- 예약 -->
						<div class="col-xl-4">
							<div class="card shadow mb-4">
								<!-- title -->
								<div class="card-header py-3">
									<h6 class="m-0 font-weight-bold text-primary">예약</h6>
								</div>
								<div class="card-body p-3" style="height: 660px; overflow: auto;">

									<table class="table table-borderless"
										style="color: gray; background-color: white;">

										<c:forEach items="${boardlist}" var="l">
											<tr style="border-bottom: 1px solid gray; padding-bottom: 5px;">
												<td style="font-size: 14px;">
													<div style="">
														<a href="#" style="text-decoration: none;"><b
															style="font-size: 25px; color: black">${l.pet_name}</b></a>&nbsp;&nbsp;&nbsp;${l.owner_name}&nbsp;
														<a class="xi-pen" id="xeicon"></a>
													</div> <br> <span>${l.pet_birth} | 4살 |
														${l.pet_gender}</span> <br> <span>${l.reservation_memo}</span>
												</td>
												<td style="text-align: right;"><span>${l.reservation_date}</span>
													<br> <br> <span>
														<button type="button" class="btn btn-secondary btn-sm"
															style="background-color: #7f8c8d; border: none;">취소</button>
														<button type="button" class="btn btn-primary btn-sm"
															style="border: none;">접수</button>
												</span></td>
											</tr>
										</c:forEach>
									</table>

								</div>
							</div>
						</div>
						<!-- 접수 -->
						<div class="col-xl-4">
							<div class="card shadow mb-4">
								<div class="card-header py-3">
									<h6 class="m-0 font-weight-bold text-primary">접수</h6>
								</div>
								<div class="card-body p-3" style="height: 660px; overflow: auto;">
									<table class="table table-borderless"
										style="color: gray; background-color: white;">
										<c:forEach items="${boardlist}" var="l">
											<tr
												style="border-bottom: 1px solid gray; padding-bottom: 5px;">
												<td style="font-size: 14px;">
													<div style="">
														<a href="#" style="text-decoration: none;"><b
															style="font-size: 25px; color: black">${l.pet_name}</b></a>&nbsp;&nbsp;&nbsp;윤지혜&nbsp;
														<span class="badge bg-secondary" style="vertical-align: 3px;">대기중</span>
													</div> <br> <span>2019.06.03 | 4살 | 여</span> <br> <span>결석,
														설사</span> <span class="badge"
													style="background-color: white; color: #0d6efd; border: 1px solid #0d6efd;">예약</span>
												</td>
												<td style="text-align: right;"><span>오전 11:30</span> <br>
													<br> <span>
														<button type="button" class="btn btn-secondary btn-sm"
															style="background-color: #7f8c8d; border: none;">취소</button>
														<button type="button" class="btn btn-success btn-sm"
															style="border: none;">수납</button>
												</span></td>
											</tr>
										</c:forEach>
									</table>
								</div>
							</div>
						</div>

					</div>
					<!-- /.container-fluid -->

				</div>
				<!-- End of Main Content -->


				<!-- End of Footer -->

			</div>
			<!-- End of Content Wrapper -->


			<!-- End of Page Wrapper -->

			<!-- Scroll to Top Button-->
			<a class="scroll-to-top rounded" href="#page-top"> <i
				class="fas fa-angle-up"></i>
			</a>


			<%@ include file="../bar/footer.jsp"%>
			<%@ include file="../bar/logoutModal.jsp"%>



			<!-- Modal -->
			<div class="modal fade" id="exampleModal" tabindex="-1"
				aria-labelledby="exampleModalLabel" aria-hidden="true">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<h1 class="modal-title fs-5" id="exampleModalLabel">예약하기</h1>
							<button type="button" class="btn-close" data-bs-dismiss="modal"
								aria-label="Close"></button>
						</div>
						<div class="modal-body">
							<form class="row g-4 form">
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
								<div class="col-md-6">
									<label for="pet_birth" class="col-form-label">반려견 출생년도</label>
									<input type="text" class="form-control" id="pet_birth"
										value="없음" readonly>
								</div>
								<!-- 예약시간 -->
								<p class="col-md-6">
									<label for="reservation_date_day" class="col-form-label">예약날짜</label>
									<input class="form-control" type="date" value="1000-01-10"
										id="reservation_date_day" tabindex="-1">
								</p>

								<!-- 시간설정 -->
								<div class="col-md-6" style="width: auto;">
									<label class="col-form-label" for="reservation_date_time">예약시간</label>
									<div class="accordion" id="accordionExample">
										<div class="accordion-item">
											<button class="accordion-button collapsed"
												style="width: 470px; height: 38px;" type="button"
												id="accordion" data-bs-toggle="collapse"
												data-bs-target="#collapseOne" aria-expanded="false"
												aria-controls="collapseOne">시간선택</button>
											<div id="collapseOne" class="accordion-collapse collapse"
												aria-labelledby="headingOne"
												data-bs-parent="#accordionExample">
												<div class="accordion-body">
													<div class="row text-center mx-0">
														<div class="col-md-3 col-4 my-1 px-2">
															<div class="cell py-1">11:00</div>
														</div>
														<div class="col-md-3 col-4 my-1 px-2">
															<div class="cell py-1">11:30</div>
														</div>
														<div class="col-md-3 col-4 my-1 px-2">
															<div class="cell py-1">12:00</div>
														</div>
														<div class="col-md-3 col-4 my-1 px-2">
															<div class="cell py-1">12:30</div>
														</div>
													</div>
													<div class="row text-center mx-0">
														<div class="col-md-3 col-4 my-1 px-2">
															<div class="cell py-1">13:00</div>
														</div>
														<div class="col-md-3 col-4 my-1 px-2">
															<div class="cell py-1">14:30</div>
														</div>
														<div class="col-md-3 col-4 my-1 px-2">
															<div class="cell py-1">15:00</div>
														</div>
														<div class="col-md-3 col-4 my-1 px-2">
															<div class="cell py-1">15:30</div>
														</div>
													</div>
													<div class="row text-center mx-0">
														<div class="col-md-3 col-4 my-1 px-2">
															<div class="cell py-1">16:00</div>
														</div>
														<div class="col-md-3 col-4 my-1 px-2">
															<div class="cell py-1">16:30</div>
														</div>
														<div class="col-md-3 col-4 my-1 px-2">
															<div class="cell py-1">17:00</div>
														</div>
														<div class="col-md-3 col-4 my-1 px-2">
															<div class="cell py-1">17:00</div>
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
								<input type="hidden" id="reservation_date"
									name="reservation_date">
								<div class="mb-3">
									<label for="reservation_memo" class="col-form-label">예약메모</label>
									<textarea class="form-control" id="reservation_memo"></textarea>
								</div>
								<div class="modal-footer">
									<button type="button" class="btn btn-secondary"
										data-bs-dismiss="modal" id="cancel-button">취소</button>
									<button type="button" class="btn btn-primary" id="ok-button"
										name="" value="">예약하기</button>
								</div>
							</form>
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
=======
<% if(session.getAttribute("id") == null){
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

<title>예약/접수</title>
<link rel="stylesheet"
	href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
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
<!-- Favicon-->
<link rel="icon" type="image/x-icon"
	href="/resources/assets/favicon.ico" />
<link href="css/reservation/reserv.css" rel="stylesheet">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
<!-- bootstrap -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script src="js/reservation/reserv.js"></script>
<style type="text/css">
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

					<%@ include file="../reservation/reserv_bar.jsp"%>


					<!-- 검색창 / 예약창 / 접수창 -->
					<div class="container-2">
						<!-- 검색 -->
						<div class="card shadow left mb-4 mr-2" style="width: 23rem;">
							<!--메뉴1 -->
							<div class="card-header py-3">
								<h6 class="m-0 font-weight-bold text-primary">고객조회</h6>
							</div>
							<div class="card-body"
								style="margin-top: 0; margin-left: 13px; margin-right: 13px; margin-bottom: 20px;">
								<div style="height: 520px; overflow-y: auto">
									<!-- 검색기능 -->
									<nav class="navbar navbar-light">
										<input class="form-control mr-sm-2" style="width: 230px;"
											type="text" placeholder="이름 혹은 전화번호" aria-label="검색"
											name="search_value" id="search_value">
										<button class="btn btn-outline-success my-2 my-sm-0"
											id="search_btn" value="">검색</button>

										<table class="table table-borderless"
											style="color: gray; background-color: white;">
											<tbody id="researchTable">
												<!-- ajax -->
											</tbody>
										</table>
									</nav>
								</div>
							</div>
						</div>
					</div>





					<!-- 예약 -->
					<div class="card shadow left mb-4 mr-2" style="width: 22rem;">
						<!-- title -->
						<div class="card-header py-3 ">
							<h6 class="m-0 font-weight-bold text-primary">예약</h6>
						</div>
						<div class="card-body"
							style="margin-top: 0; margin-left: 13px; margin-right: 13px; margin-bottom: 20px;">
							<div style="height: 520px; overflow-y: auto">

								<table class="table table-borderless"
									style="color: gray; background-color: white;">
									<tbody id="reservTable">
										<tr id="reserv_result">
											<c:forEach items="${reservlist }" var="l">
												<input type="hidden" id="age">
												<!--  -->
												<tr class="left reserv_result"
													style="border-bottom: 1px solid gray; padding-bottom: 5px;">
													<td style="font-size: 14px; width: 180px;">
														<div>
															<a href="#" style="text-decoration: none;"><b
																style="font-size: 25px; color: black"> ${l.pet_name}</b></a>&nbsp;&nbsp;&nbsp;${l.owner_name}&nbsp;
															<a class="reservUpdate" value="${l.reservation_no}"
																style="text-decoration: none;"> <i
																class="xi-file-text-o"></i>
															</a>${l.pet_no}


														</div> <br>
														<div>
															<span>${l.type_name} | ${l.pet_gender}</span>
														</div> <span> ${l.pet_birth} </span>

													</td>
													<td style="text-align: right;"><span><b><h5>${l.reserv_time}</h5></b></span><br>
														<input type="hidden" id="petNo" value="${l.pet_no}">
														<span>


															<button type="button" class="btn btn-sm reserv_btn"
																id="reserv_cancel" value="${l.reservation_no}"
																style="border: 1px solid #0d6efd; color: #0d6efd;">취소</button>
															<button type="button" id="receipt_btn"
																class="btn btn-primary btn-sm"
																style="margin-left: 5px; border: none;">접수</button>
													</span></td>
												</tr>
											</c:forEach>
										</tr>
									</tbody>
								</table>

							</div>
						</div>
					</div>



					<!-- 접수 -->
					<div class="card shadow left mb-4 mr-2" style="width: 22rem;">
						<!-- title -->
						<div class="card-header py-3 ">
							<h6 class="m-0 font-weight-bold text-primary">접수</h6>
						</div>
						<div class="card-body"
							style="margin-top: 0; margin-left: 13px; margin-right: 13px; margin-bottom: 20px;">
							<div style="height: 520px; overflow-y: auto">

								<table class="table table-borderless"
									style="color: gray; background-color: white;">
									<tbody id="recepTable">
										<tr id="recep_result">
											<c:forEach items="${receplist }" var="l">
												<input type="hidden" id="age">
												<tr class="left recep_result"
													style="border-bottom: 1px solid gray; padding-bottom: 5px;">
													<td style="font-size: 14px; width: 180px;">
														<div>
															<a href="#" style="text-decoration: none;"><b
																style="font-size: 25px; color: black"> ${l.pet_name}</b></a>&nbsp;&nbsp;&nbsp;${l.owner_name}&nbsp;
															<a class="reservUpdate" value="${l.reservation_no}"
																style="text-decoration: none;"> <i class="xi-pen"></i> <!--  -->
															</a>${l.pet_no}
														</div> <br>
														<div>
															<span>${l.type_name} | ${l.pet_gender}</span>
														</div> <span> ${l.pet_birth} </span>

													</td>
													<td style="text-align: right;"><span><b><h5>${l.reservation_date}</h5></b></span><br>
														<input type="hidden" id="reservNo"
														value="${l.reservation_no}"> 
														
														<span>
															<button type="button" class="btn btn-sm reserv_btn"
																id="reserv_cancel" value="${l.receive_no}"
																style="border: 1px solid #0d6efd; color: #0d6efd;">접수취소</button>
															<button type="button" id="receipt_btn"
																class="btn btn-primary btn-sm"
																style="margin-left: 5px; border: none;">수납</button>
													</span></td>
												</tr>
											</c:forEach>
										</tr>
									</tbody>
								</table>

							</div>
						</div>
					</div>












					<!-- 예약하기 modal -->
					<div class="modal fade" id="exampleModal" tabindex="-1"
						aria-labelledby="exampleModalLabel" aria-hidden="true">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-header">
									<h1 class="modal-title fs-5" id="exampleModalLabel">예약하기</h1>
									<button type="button" class="btn-close" data-bs-dismiss="modal"
										aria-label="Close"></button>
								</div>
								<div class="modal-body">
									<form class="row g-4 form">
										<div class="col-md-6">
											<label for="owner_name" class="col-form-label">보호자 이름</label>
											<input type="text" class="form-control" id="owner_name"
												value="없음" readonly>
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
											<label for="pet_gender" class="col-form-label">반려견 성별</label>
											<input type="text" class="form-control" id="pet_gender"
												value="없음" readonly>
										</div>
										<div class="col-md-6">
											<label for="pet_birth" class="col-form-label">반려견
												출생년도</label> <input type="text" class="form-control" id="pet_birth"
												value="없음" readonly>
										</div>
										<!-- 예약시간 -->
										<p class="col-md-6">
											<label for="reservation_date_day" class="col-form-label">예약날짜</label>
											<input class="form-control" type="date" value="1000-01-10"
												id="reservation_date_day" tabindex="-1">
										</p>

										<!-- 시간설정 -->
										<div class="col-md-6" style="width: auto;">
											<label class="col-form-label"
												for="update_reservation_date_time">예약시간</label>
											<div class="accordion" id="accordionExample">
												<div class="accordion-item">
													<button class="accordion-button collapsed"
														style="width: 470px; height: 38px;" type="button"
														id="accordion" data-bs-toggle="collapse"
														data-bs-target="#collapseOne" aria-expanded="false"
														aria-controls="collapseOne">시간선택</button>
													<div id="collapseOne" class="accordion-collapse collapse"
														aria-labelledby="headingOne"
														data-bs-parent="#accordionExample">
														<div class="accordion-body">
															<div class="row text-center mx-0">

																<div class="col-md-3 col-4 my-1 px-2">
																	<input class="cell py-1" type='radio'
																		name='reserv_time' value='09:00'>09:00
																</div>
																<div class="col-md-3 col-4 my-1 px-2">
																	<input class="cell py-1" type='radio'
																		name='reserv_time' value='09:30'>09:30
																</div>
																<div class="col-md-3 col-4 my-1 px-2">
																	<input class="cell py-1" type='radio'
																		name='reserv_time' value='10:00'>10:00
																</div>
																<div class="col-md-3 col-4 my-1 px-2">
																	<input class="cell py-1" type='radio'
																		name='reserv_time' value='10:30'>10:30
																</div>
																<div class="col-md-3 col-4 my-1 px-2">
																	<input class="cell py-1" type='radio'
																		name='reserv_time' value='11:00'>11:00
																</div>
																<div class="col-md-3 col-4 my-1 px-2">
																	<input class="cell py-1" type='radio'
																		name='reserv_time' value='11:30'>11:30
																</div>
																<div class="col-md-3 col-4 my-1 px-2">
																	<input class="cell py-1" type='radio'
																		name='reserv_time' value='13:00'>13:00
																</div>
																<div class="col-md-3 col-4 my-1 px-2">
																	<input class="cell py-1" type='radio'
																		name='reserv_time' value='13:30'>13:30
																</div>
																<div class="col-md-3 col-4 my-1 px-2">
																	<input class="cell py-1" type='radio'
																		name='reserv_time' value='14:00'>14:00
																</div>
																<div class="col-md-3 col-4 my-1 px-2">
																	<input class="cell py-1" type='radio'
																		name='reserv_time' value='14:30'>14:30
																</div>
																<div class="col-md-3 col-4 my-1 px-2">
																	<input class="cell py-1" type='radio'
																		name='reserv_time' value='15:00'>15:00
																</div>
																<div class="col-md-3 col-4 my-1 px-2">
																	<input class="cell py-1" type='radio'
																		name='reserv_time' value='15:30'>15:30
																</div>
																<div class="col-md-3 col-4 my-1 px-2">
																	<input class="cell py-1" type='radio'
																		name='reserv_time' value='15:30'>15:30
																</div>
																<div class="col-md-3 col-4 my-1 px-2">
																	<input class="cell py-1" type='radio'
																		name='reserv_time' value='15:30'>15:30
																</div>
																<div class="col-md-3 col-4 my-1 px-2">
																	<input class="cell py-1" type='radio'
																		name='reserv_time' value='16:00'>16:00
																</div>
																<div class="col-md-3 col-4 my-1 px-2">
																	<input class="cell py-1" type='radio'
																		name='reserv_time' value='16:30'>16:30
																</div>
																<div class="col-md-3 col-4 my-1 px-2">
																	<input class="cell py-1" type='radio'
																		name='reserv_time' value='17:00'>17:00
																</div>
																<div class="col-md-3 col-4 my-1 px-2">
																	<input class="cell py-1" type='radio'
																		name='reserv_time' value='17:30'>17:30
																</div>

															</div>
														</div>
													</div>
												</div>
											</div>
										</div>
										<input type="hidden" id="reservation_date"
											name="reservation_date">
										<div class="mb-3">
											<label for="reservation_memo" class="col-form-label">예약메모</label>
											<textarea class="form-control" id="reservation_memo"></textarea>
										</div>
										<div class="modal-footer">
											<button type="button" class="btn btn-secondary"
												data-bs-dismiss="modal" id="cancel-button">취소</button>
											<button type="button" class="btn btn-primary" id="ok-button"
												name="" value="">예약하기</button>
										</div>
									</form>
								</div>
							</div>
						</div>
					</div>


					<!-- 수정Modal -->
					<div class="modal fade" id="updateModal" tabindex="-1"
						aria-labelledby="exampleModalLabel" aria-hidden="true">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-header">
									<h1 class="modal-title fs-5" id="exampleModalLabel">예약하기</h1>
									<button type="button" class="btn-close" data-bs-dismiss="modal"
										aria-label="Close"></button>
								</div>
								<div class="modal-body">
									<form class="row g-4 form">
										<div class="col-md-6">
											<label for="update_owner_name" class="col-form-label">보호자
												이름</label> <input type="text" class="form-control"
												id="update_owner_name" value="없음" readonly>
										</div>
										<div class="col-md-6">
											<label for="update_owner_tel" class="col-form-label">전화번호</label>
											<input type="text" class="form-control" id="update_owner_tel"
												placeholder="01012345678" value="없음" readonly>
										</div>
										<div class="col-md-6">
											<label for="update_pet_name" class="col-form-label">반려견
												이름</label> <input type="text" class="form-control"
												id="update_pet_name" value="없음" readonly>
										</div>
										<div class="col-md-6">
											<label for="update_pet_gender" class="col-form-label">반려견
												성별</label> <input type="text" class="form-control"
												id="update_pet_gender" value="없음" readonly>
										</div>
										<div class="col-md-6">
											<label for="update_pet_birth" class="col-form-label">반려견
												출생년도</label> <input type="text" class="form-control"
												id="update_pet_birth" value="없음" readonly>
										</div>
										<!-- 예약시간 -->
										<p class="col-md-6">
											<label for="update_reservation_date_day"
												class="col-form-label">예약날짜</label> <input
												class="form-control" type="date" value="1000-01-10"
												id="update_reservation_date_day" tabindex="-1">
										</p>

										<!-- 시간설정 -->
										<div class="col-md-6" style="width: auto;">
											<label class="col-form-label"
												for="update_reservation_date_time">예약시간</label>
											<div class="accordion" id="accordionExample">
												<div class="accordion-item">
													<button class="accordion-button collapsed"
														style="width: 470px; height: 38px;" type="button"
														id="accordion" data-bs-toggle="collapse"
														data-bs-target="#collapseOne" aria-expanded="false"
														aria-controls="collapseOne">시간선택</button>
													<div id="collapseOne" class="accordion-collapse collapse"
														aria-labelledby="headingOne"
														data-bs-parent="#accordionExample">
														<div class="accordion-body">
															<div class="row text-center mx-0">
																<div class="col-md-3 col-4 my-1 px-2">
																	<input class="cell py-1" type='radio'
																		name='update_reserv_time' value='09:00'>09:00
																</div>
																<div class="col-md-3 col-4 my-1 px-2">
																	<input class="cell py-1" type='radio'
																		name='update_reserv_time' value='09:30'>09:30
																</div>
																<div class="col-md-3 col-4 my-1 px-2">
																	<input class="cell py-1" type='radio'
																		name='update_reserv_time' value='10:00'>10:00
																</div>
																<div class="col-md-3 col-4 my-1 px-2">
																	<input class="cell py-1" type='radio'
																		name='update_reserv_time' value='10:30'>10:30
																</div>
																<div class="col-md-3 col-4 my-1 px-2">
																	<input class="cell py-1" type='radio'
																		name='update_reserv_time' value='11:00'>11:00
																</div>
																<div class="col-md-3 col-4 my-1 px-2">
																	<input class="cell py-1" type='radio'
																		name='update_reserv_time' value='11:30'>11:30
																</div>
																<div class="col-md-3 col-4 my-1 px-2">
																	<input class="cell py-1" type='radio'
																		name='update_reserv_time' value='13:00'>13:00
																</div>
																<div class="col-md-3 col-4 my-1 px-2">
																	<input class="cell py-1" type='radio'
																		name='update_reserv_time' value='13:30'>13:30
																</div>
																<div class="col-md-3 col-4 my-1 px-2">
																	<input class="cell py-1" type='radio'
																		name='update_reserv_time' value='14:00'>14:00
																</div>
																<div class="col-md-3 col-4 my-1 px-2">
																	<input class="cell py-1" type='radio'
																		name='update_reserv_time' value='14:30'>14:30
																</div>
																<div class="col-md-3 col-4 my-1 px-2">
																	<input class="cell py-1" type='radio'
																		name='update_reserv_time' value='15:00'>15:00
																</div>
																<div class="col-md-3 col-4 my-1 px-2">
																	<input class="cell py-1" type='radio'
																		name='update_reserv_time' value='15:30'>15:30
																</div>
																<div class="col-md-3 col-4 my-1 px-2">
																	<input class="cell py-1" type='radio'
																		name='update_reserv_time' value='15:30'>15:30
																</div>
																<div class="col-md-3 col-4 my-1 px-2">
																	<input class="cell py-1" type='radio'
																		name='update_reserv_time' value='15:30'>15:30
																</div>
																<div class="col-md-3 col-4 my-1 px-2">
																	<input class="cell py-1" type='radio'
																		name='update_reserv_time' value='16:00'>16:00
																</div>
																<div class="col-md-3 col-4 my-1 px-2">
																	<input class="cell py-1" type='radio'
																		name='update_reserv_time' value='16:30'>16:30
																</div>
																<div class="col-md-3 col-4 my-1 px-2">
																	<input class="cell py-1" type='radio'
																		name='update_reserv_time' value='17:00'>17:00
																</div>
																<div class="col-md-3 col-4 my-1 px-2">
																	<input class="cell py-1" type='radio'
																		name='update_reserv_time' value='17:30'>17:30
																</div>
																<input type="hidden" id="update_reservation_date"
																	name="update_reservation_date">
															</div>
														</div>
													</div>
												</div>
											</div>
										</div>
										<input type="hidden" id="reservation_date"
											name="reservation_date">
										<div class="mb-3">
											<label for="update_reservation_memo" class="col-form-label">예약메모</label>
											<textarea class="form-control" id="update_reservation_memo"></textarea>
										</div>
										<div class="modal-footer">
											<button type="button" class="btn btn-secondary"
												data-bs-dismiss="modal" id="update_cancel-button">취소</button>
											<button type="button" class="btn btn-primary"
												id="update_ok-button" value="">수정하기</button>
										</div>
									</form>
								</div>
							</div>
						</div>
					</div>
					</nav>
				</div>
			</div>
		</div>


		<!-- /.container-fluid -->

	</div>
	<!-- End of Main Content -->


	<!-- End of Footer -->

	</div>
	<!-- End of Content Wrapper -->
	</div>
	</div>
	<!-- End of Page Wrapper -->

	<!-- Scroll to Top Button-->
	<a class="scroll-to-top rounded" href="#page-top"> <i
		class="fas fa-angle-up"></i>
	</a>


	<%@ include file="../bar/footer.jsp"%>
	<%@ include file="../bar/logoutModal.jsp"%>

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
>>>>>>> branch 'master' of https://github.com/e1itepaper/team3.git
</body>
</html>



































