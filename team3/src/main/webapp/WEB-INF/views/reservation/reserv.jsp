<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="en">

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

<script type="text/javascript">

$(function() {
	
	//검색
	$("#search_btn").click(function() {
		var searchValue = $("#search_value").val();

		if (searchValue == "") {
			alert("검색어를 입력하세요");
			return false;
		}
		if (searchValue < 2) {
			alert("2글자 이상 입력하세요");
			return false;
		}
		else {
			$.ajax({
			    url: "/reserv",
			    type: "GET",
			    data: { "searchValue": searchValue },
			    dataType: "json",
			    cache: false
			  }).done(function(data) {
				alert("통신에 성공했습니다. ");
				$("#owner_name").text(data.ownerName);
				$("#owner_tel").text(data.ownerTel);
				$("#pet_name").text(data.petName);
				$("#pet_gender").text(data.petGender);
				$("#pet_birth").text(data.petBirth);
				$("#reserv_memo").text(data.reservMemo);
				$("#reservation_date").text(data.reservationDate);
			}).fail(function(jqXHR, textStatus, errorThrown) {
			    console.log("POST request failed: " + errorThrown);
			  });
		}
	});
	
	
	//(검색통한)예약버튼
	$(".reserv_btn").click(function(){
				
				let reservNo = $(this).attr("value");
// 				alert(reservNo);
				//이제 이걸 post로 /reservAjax 컨트롤러로 전송
				$.ajax({
				    url: "/reservAjax",
				    type: "POST",
				    data: {"reservNo" : reservNo},
				    dataType: "json",
				    cache: false
				    
				  }). done (function(data){ //data: 서버가 전송한 데이터
					//모달창에 값 출력
$					$("#exampleModal #modal_owner_name").text(data.result[0].owner_name);
					$("#exampleModal #modal_owner_tel").text(data.result[0].owner_tel);
					$("#exampleModal #modal_pet_name").text(data.result[0].pet_name);
					$("#exampleModal #modal_pet_gender").text(data.result[0].pet_gender);
					$("#exampleModal #modal_pet_birth").text(data.result[0].pet_birth);
					$("#exampleModal #reserv_memo").text(data.result[0].reserv_memo);
					$("#exampleModal #reservation_date").text(data.result[0].reservation_date);
					
				    //모달 열기
				    $("#exampleModal").modal("show");
    			}).fail(function(jqXHR, textStatus, errorThrown) {
    			    // 오류 처리
    			    console.log("get request failed: " + errorThrown);
    			  });
				
			//예약날짜 디폴트설정
			var today = new Date();
			var todayYear = today.getFullYear();
			var todayMonth = ('0' + (today.getMonth() + 1)).slice(-2);
			var todayDate = ('0' + today.getDate()).slice(-2);
			$("#reservation_date").val(todayYear+"-"+todayMonth+"-"+todayDate);
			//slice(-2):문자열 뒤 2번째부터 끝까지의 문자열을 반환하는 메서드. "12345"에 slice(-2)를 적용하면 "45"가 반환
	 		   
		 });
			
	//예약완료
 	$("#ok-button").click(function(){
		/* if(data.result == 1){
			alert("예약이 완료되었습니다.");
			location.href = "/reserv";
				
		 } else {
			alert("문제가 발생했습니다. \n다시 시도해주세요.");
		} */
		
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
				<!-- Begin Page Content -->
				<div class="container-fluid">

					<%@ include file="../reservation/reserv_bar.jsp"%>


					<!-- 검색창 / 예약창 / 접수창 -->
					<div class="container-2 ">
						<!-- 검색 -->
						<div class="card shadow left mb-4 mr-2" style="max-width: 22rem;">
							<!--메뉴1 -->
							<div class="card-header py-3">
								<h6 class="m-0 font-weight-bold text-primary">고객조회</h6>
							</div>
							<div class="card-body"
								style="margin-top: 0; margin-left: 13px; margin-right: 13px; margin-bottom: 20px;">
								<div style="height: 520px; overflow-y: auto">
									<!-- 검색기능 -->
									<nav class="navbar navbar-light bg-light">
										<form action="/reserv" method="get" class="form-inline" name="search_form">
											<input class="form-control mr-sm-2" style="width: 230px;"
												type="text" placeholder="이름 혹은 전화번호" aria-label="검색"
												name="search_value" id="search_value">
											<button class="btn btn-outline-success my-2 my-sm-0"
												id="search_btn" type="submit">검색</button>
										</form>

										<table class="table table-borderless"
											style="color: gray; background-color: white;">
											<!-- 검색결과가 있다면 -->
											<c:choose>
												<c:when test="${fn:length(boardlist) gt 0 }">
													<!-- 검색결과 출력 -->
													<c:forEach items="${searchlist}" var="l">
														<tr class="left"
															style="border-bottom: 1px solid gray; padding-bottom: 5px;">
															<td style="font-size: 14px; width: 180px;">
																<div style="">
																	<a href="#" style="text-decoration: none;"><b
																		style="font-size: 25px; color: black">${l.pet_name}</b></a>&nbsp;&nbsp;&nbsp;${l.owner_name}
																</div> <br> 
																<span>${l.pet_birth} | 4살 |
																	${l.pet_gender}</span> <br> 
																<span>${l.pet_memo}</span>
															</td>
															<td style="text-align: right;"><span></span> <br>
																<br> <span>
																	<button type="button" id=""
																	 	data-bs-toggle="modal"
																		data-bs-target="#exampleModal" class="btn btn-sm reserv_btn"
																		style="border: 1px solid #0d6efd; color: #0d6efd;" name="${l.owner_no}" value="${l.owner_no}">예약</button>


																	<button type="button" id="receipt_btn"
																		class="btn btn-primary btn-sm" style="border: none;">접수</button>
															</span></td>
														</tr>
													</c:forEach>

												</c:when>
											</c:choose>
											
										</table>




										<!-- Modal -->
										<div class="modal fade" id="exampleModal" tabindex="-1"
											aria-labelledby="exampleModalLabel" aria-hidden="true">
											<div class="modal-dialog"">
												<div class="modal-content">
													<div class="modal-header">
														<h1 class="modal-title fs-5" id="exampleModalLabel">예약하기</h1>
														<button type="button" class="btn-close"
															data-bs-dismiss="modal" aria-label="Close"></button>
													</div>
													<div class="modal-body">
														<form class="row g-4 form">
															<div class="col-md-6">
																<label for="modal_owner_name" class="col-form-label">보호자
																	이름</label> <input type="text" class="form-control"
																	id="modal_owner_name" readonly>
															</div>
															<div class="col-md-6">
																<label for="modal_owner_tel" class="col-form-label">전화번호</label>
																<input type="text" class="form-control" id="modal_owner_tel"
																	placeholder="01012345678" readonly>
															</div>
															<div class="col-md-6">
																<label for="modal_pet_name" class="col-form-label">반려견
																	이름</label> <input type="text" class="form-control"
																	id="modal_pet_name" readonly>
															</div>
															<div class="col-md-6">
																<label for="modal_pet_gender" class="col-form-label">반려견
																	성별</label> <input type="text" class="form-control"
																	id="modal_pet_gender" readonly>
															</div>
															<div class="col-md-6">
																<label for="modal_pet_birth" class="col-form-label">반려견
																	출생년도</label> <input type="text" class="form-control"
																	id="modal_pet_birth" readonly>
															</div>
															<!-- 예약시간 -->
															<p class="col-md-6">
																<label for="reservation_date" class="col-form-label">예약날짜</label>
																<input class="form-control" type="date"
																	value="1000-01-10" id="reservation_date" tabindex="-1">
															</p>

															<!-- 시간설정 -->
															<div class="col-md-6" style="width: auto;">
																<label for="inputAddress" class="col-form-label"
																	for="owner_addr">예약시간</label>
																<div class="accordion" id="accordionExample">
																	<div class="accordion-item">
																		<button class="accordion-button collapsed"
																			style="width: 470px; height: 38px;" type="button"
																			data-bs-toggle="collapse"
																			data-bs-target="#collapseOne" aria-expanded="false"
																			aria-controls="collapseOne" value="11">시간선택</button>
																		<div id="collapseOne"
																			class="accordion-collapse collapse"
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
															<div class="mb-3">
																<label for="reserv_memo" class="col-form-label">예약메모</label>
																<textarea class="form-control" id="reserv_memo"></textarea>
															</div>
															<div class="modal-footer">
																<button type="button" class="btn btn-secondary"
																	data-bs-dismiss="modal" id="cancel-button">취소</button>
																<button type="button" class="btn btn-primary"
																	id="ok-button">예약하기</button>
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


						<!-- 예약 -->
						<div class="card shadow left mb-4 mr-2" style="max-width: 22rem;">
							<!-- title -->
							<div class="card-header py-3 ">
								<h6 class="m-0 font-weight-bold text-primary">예약</h6>
							</div>
							<div class="card-body"
								style="margin-top: 0; margin-left: 13px; margin-right: 13px; margin-bottom: 20px;">
								<div style="height: 520px; overflow-y: auto">
									<table class="table table-borderless"
										style="color: gray; background-color: white;">
										<tr>
											<th class="t-right"
												style="border-bottom: 1px solid gray; width: auto;">예약:
												2명</th>
										</tr>

										<c:forEach items="${boardlist}" var="l">
											<tr class="left"
												style="border-bottom: 1px solid gray; padding-bottom: 5px;">
												<td style="font-size: 14px; width: 180px;">
													<div style="">
														<a href="#" style="text-decoration: none;"><b
															style="font-size: 25px; color: black">${l.pet_name}</b></a>&nbsp;&nbsp;&nbsp;윤지혜&nbsp;
														<a class="xi-pen" id="xeicon"></a>
													</div> <br> <span>2019.06.03 | 4살 | 여</span> <br> <span>결석,
														설사</span>
												</td>
												<td style="text-align: right;"><span>오전 11:30</span> <br>
													<br> <span>
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
						<div class="card shadow left mb-4" style="max-width: 22rem;">
							<!--메뉴1 -->
							<div class="card-header py-3">
								<h6 class="m-0 font-weight-bold text-primary">접수</h6>
							</div>
							<div class="card-body"
								style="margin-top: 0; margin-left: 13px; margin-right: 13px; margin-bottom: 20px;">
								<div style="height: 520px; overflow-y: auto">
									<table class="table table-borderless"
										style="color: gray; background-color: white;">
										<tr>
											<th class="t-right"
												style="border-bottom: 1px solid gray; width: auto;">대기중:
												9명</th>
										</tr>

										<c:forEach items="${boardlist}" var="l">
											<tr class="left"
												style="border-bottom: 1px solid gray; padding-bottom: 5px;">
												<td style="font-size: 14px; width: 180px;">
													<div style="">
														<a href="#" style="text-decoration: none;"><b
															style="font-size: 25px; color: black">${l.pet_name}</b></a>&nbsp;&nbsp;&nbsp;윤지혜&nbsp;
														<span class="badge bg-secondary">대기중</span>
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
</body>
</html>



































