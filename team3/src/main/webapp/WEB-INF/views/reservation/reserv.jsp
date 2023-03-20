
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
<script src="js/reservation/reserv.js"></script>
<!-- js -->
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
				<div></div>
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
								<div class="card-body p-3"
									style="height: 660px; overflow: auto;">
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
										<tbody id="researchTable">
											<c:forEach items="${boardlist}" var="s">
												<tr class="search_result"
													style="border-bottom: 1px solid gray; padding-bottom: 5px;">
													<td style="font-size: 14px;">
														<div>
															<a style="text-decoration: none;"><b
																style="font-size: 25px; color: black">${s.pet_name}</b></a>&nbsp;&nbsp;&nbsp;${s.owner_name}
														</div> <br> <span>${s.type_name} | ${s.pet_gender}<br>
															${s.pet_birth}
													</span><br>
													</td>
													<input type="hidden" id="search_petNo" value="${s.pet_no}">
													<input type="hidden" id="search_ownerNo"
														value="${s.owner_no}">
													<td style="text-align: right;"><span></span><br>
														<br> <span>
															<button type="button" class="btn btn-sm reserv_btn"
																value="${s.pet_no}"
																style="border: 1px solid #0d6efd; color: #0d6efd;">예약</button>
															<button type="button" id="search_receipt_btn"
																class="btn btn-primary btn-sm search_receipt_btn"
																value="${s.pet_no}"
																style="margin-left: 5px; border: none;">접수</button>
													</span></td>
												</tr>
											</c:forEach>








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
								<div class="card-body p-3"
									style="height: 660px; overflow: auto;">

									<table class="table table-borderless"
										style="color: gray; background-color: white;">

										<c:forEach items="${reservlist}" var="l">
											<input type="hidden" id="age">
											<tr
												style="border-bottom: 1px solid gray; padding-bottom: 5px;">
												<td style="font-size: 14px;">
													<div style="">
														<a style="text-decoration: none;"><b
															style="font-size: 25px; color: black"> ${l.pet_name}</b></a>&nbsp;&nbsp;&nbsp;${l.owner_name}&nbsp;
														<a class="reservUpdate" value="${l.reservation_no}"
															style="text-decoration: none;"> <i
															class="xi-file-text-o"></i>
														</a>${l.pet_no}


													</div> <br>
													<div>
														<span>${l.type_name} | ${l.pet_birth} |
															${l.pet_gender}</span>
													</div> <span> ${l.reservation_memo} </span>
												<td style="text-align: right;"><span><b><h5>${l.reserv_time}</h5></b></span><br>
													<input type="hidden" id="petNo" value="${l.pet_no}">
													<input type="hidden" id="ownerNo" value="${l.owner_no}">
													<input type="hidden" id="reservation_Yn"
													value="${l.reservation_yn}"> <span>
														<button type="button"
															class="btn btn-secondary btn-sm reserv_cancel" id=""
															value="${l.reservation_no}"
															style="background-color: #7f8c8d; border: none;">취소</button>
														<button type="button"
															class="btn btn-primary btn-sm receipt_btn"
															value="${l.reservation_no}" style="border: none;">접수</button>
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
								<div class="card-body p-3"
									style="height: 660px; overflow: auto;">
									<table class="table table-borderless"
										style="color: gray; background-color: white;">


										<c:forEach items="${receplist}" var="l">

											<input type="hidden" id="age">
											<tr
												style="border-bottom: 1px solid gray; padding-bottom: 5px;">
												<td style="font-size: 14px;">
													<div style="">
														<a style="text-decoration: none;"><b
															style="font-size: 25px; color: black">${l.pet_name}</b></a>&nbsp;&nbsp;&nbsp;${l.owner_name}&nbsp;
														<br>
														<input type="hidden" id="receive_petNo"
															value="${l.pet_no}"> <span
															class="badge bg-secondary">대기중</span>&nbsp;
														<c:if test="${not empty l.reservation_no }">
															<span class="badge"
																style="background-color: white; color: #0d6efd; border: 1px solid #0d6efd;">예약</span>
														</c:if>

													</div> <br>

													<div>
														<span>${l.type_name} | ${l.pet_birth} |
															${l.pet_gender}</span>

													</div> <%-- 													<span> ${l.reservation_memo} </span> --%>

												</td>

												<td style="text-align: right; width: 140px;"><span><h7>${l.receive_time}</h7></span><br>
													<input type="hidden" id="reservNo"
													value="${l.reservation_no}"> <br> <span
													style="width: 200px;">
														<button type="button"
															class="btn btn-secondary btn-sm receipt_cancel" id=""
															value="${l.receive_no}"
															style="background-color: #7f8c8d; border: none;">접수취소</button>
														<button type="button" class="btn btn-success btn-sm"
															id="check_btn" style="border: none;">수납</button>
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




			<!-- 수정Modal -->
			<div class="modal fade" id="updateModal" tabindex="-1"
				aria-labelledby="exampleModalLabel" aria-hidden="true">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<h1 class="modal-title fs-5" id="exampleModalLabel">수정하기</h1>
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
									<label for="update_reservation_date_day" class="col-form-label">예약날짜</label>
									<input class="form-control" type="date" value="2023-01-01"
										id="update_reservation_date_day" tabindex="-1">
								</p>

								<!-- 시간설정 -->
								<div class="updatetimeset" style="width: auto;"></div>
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

			<!-- 예약하기 모달 -->
			<%@ include file="reservation_modal.jsp"%>


			<!-- 시간선택 html -->
			<div style="display: none;">
				<div class="timeoption">
					<label class="col-form-label" for="update_reservation_date_time">예약시간</label>
					<div class="accordion" id="accordionExample">
						<div class="accordion-item">
							<button class="accordion-button collapsed"
								style="width: 464px; height: 38px;" type="button" id="accordion"
								data-bs-toggle="collapse" data-bs-target="#collapseOne"
								aria-expanded="false" aria-controls="collapseOne">시간선택</button>
							<div id="collapseOne" class="accordion-collapse collapse"
								aria-labelledby="headingOne" style="margin-top: 10px;"
								data-bs-parent="#accordionExample">
								<div class="accordion-body1">
									<div class="row text-center mx-0" id="timeAppend">
										<div class="col-md-3 col-4 my-1 px-2">
											<input type="radio" class="btn-check" name="reserv_time"
												value="09:00" id="btn-check-2-outlined1" autocomplete="off">
											<label class="btn btn-outline-primary" id="09:00"
												for="btn-check-2-outlined1">09:00</label>
										</div>
										<br>
										<div class="col-md-3 col-4 my-1 px-2">
											<input type="radio" class="btn-check" name="reserv_time"
												value="09:30" id="btn-check-2-outlined2" autocomplete="off">
											<label class="btn btn-outline-primary"
												for="btn-check-2-outlined2">09:30</label>
										</div>
										<br>
										<div class="col-md-3 col-4 my-1 px-2">
											<input type="radio" class="btn-check" name="reserv_time"
												value="10:00" id="btn-check-2-outlined3" autocomplete="off">
											<label class="btn btn-outline-primary"
												for="btn-check-2-outlined3">10:00</label>
										</div>
										<br>
										<div class="col-md-3 col-4 my-1 px-2">
											<input type="radio" class="btn-check" name="reserv_time"
												value="10:30" id="btn-check-2-outlined4" autocomplete="off">
											<label class="btn btn-outline-primary"
												for="btn-check-2-outlined4">10:30</label>
										</div>
										<br>
										<div class="col-md-3 col-4 my-1 px-2">
											<input type="radio" class="btn-check" name="reserv_time"
												value="11:00" id="btn-check-2-outlined5" autocomplete="off">
											<label class="btn btn-outline-primary"
												for="btn-check-2-outlined5">11:00</label>
										</div>
										<br>
										<div class="col-md-3 col-4 my-1 px-2">
											<input type="radio" class="btn-check" name="reserv_time"
												value="11:30" id="btn-check-2-outlined6" autocomplete="off">
											<label class="btn btn-outline-primary"
												for="btn-check-2-outlined6">11:30</label>
										</div>
										<br>
										<div class="col-md-3 col-4 my-1 px-2">
											<input type="radio" class="btn-check" name="reserv_time"
												value="13:00" id="btn-check-2-outlined7" autocomplete="off">
											<label class="btn btn-outline-primary"
												for="btn-check-2-outlined7">13:00</label>
										</div>
										<br>
										<div class="col-md-3 col-4 my-1 px-2">
											<input type="radio" class="btn-check" name="reserv_time"
												value="13:30" id="btn-check-2-outlined8" autocomplete="off">
											<label class="btn btn-outline-primary"
												for="btn-check-2-outlined8">13:30</label>
										</div>
										<br>
										<div class="col-md-3 col-4 my-1 px-2">
											<input type="radio" class="btn-check" name="reserv_time"
												value="14:00" id="btn-check-2-outlined9" autocomplete="off">
											<label class="btn btn-outline-primary"
												for="btn-check-2-outlined9">14:00</label>
										</div>
										<br>
										<div class="col-md-3 col-4 my-1 px-2">
											<input type="radio" class="btn-check" name="reserv_time"
												value="14:30" id="btn-check-2-outlined10" autocomplete="off">
											<label class="btn btn-outline-primary"
												for="btn-check-2-outlined10">14:30</label>
										</div>
										<br>
										<div class="col-md-3 col-4 my-1 px-2">
											<input type="radio" class="btn-check" name="reserv_time"
												value="15:00" id="btn-check-2-outlined11" autocomplete="off">
											<label class="btn btn-outline-primary"
												for="btn-check-2-outlined11">15:00</label>
										</div>
										<br>
										<div class="col-md-3 col-4 my-1 px-2">
											<input type="radio" class="btn-check" name="reserv_time"
												value="15:30" id="btn-check-2-outlined12" autocomplete="off">
											<label class="btn btn-outline-primary"
												for="btn-check-2-outlined12">15:30</label>
										</div>
										<br>
										<div class="col-md-3 col-4 my-1 px-2">
											<input type="radio" class="btn-check" name="reserv_time"
												value="16:00" id="btn-check-2-outlined13" autocomplete="off">
											<label class="btn btn-outline-primary"
												for="btn-check-2-outlined13">16:00</label>
										</div>
										<br>
										<div class="col-md-3 col-4 my-1 px-2">
											<input type="radio" class="btn-check" name="reserv_time"
												value="16:30" id="btn-check-2-outlined14" autocomplete="off">
											<label class="btn btn-outline-primary"
												for="btn-check-2-outlined14">16:30</label>
										</div>
										<br>
										<div class="col-md-3 col-4 my-1 px-2">
											<input type="radio" class="btn-check" name="reserv_time"
												value="17:00" id="btn-check-2-outlined15" autocomplete="off">
											<label class="btn btn-outline-primary"
												for="btn-check-2-outlined15">17:00</label>
										</div>
										<br>
										<div class="col-md-3 col-4 my-1 px-2">
											<input type="radio" class="btn-check" name="reserv_time"
												value="17:30" id="btn-check-2-outlined16" autocomplete="off">
											<label class="btn btn-outline-primary"
												for="btn-check-2-outlined16">17:30</label>
										</div>
										<br>

									</div>
								</div>
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


































