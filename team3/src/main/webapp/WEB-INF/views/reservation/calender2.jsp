
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
<!-- <script -->
<!-- 	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script> -->
<!-- bootstrap -->

 <link rel="stylesheet" href="js/reservation/vendor_cal/css/fullcalendar.min.css" />
    <link rel="stylesheet" href="js/reservation/vendor_cal/css/bootstrap.min.css">
    <link rel="stylesheet" href='js/reservation/vendor_cal/css/select2.min.css' />
    <link rel="stylesheet" href='js/reservation/vendor_cal/css/bootstrap-datetimepicker.min.css' />

    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Open+Sans:400,500,600">
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">

    <link rel="stylesheet" href="css/reservatoin/css2/main.css"><!-- js -->
   
   
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



					
					
    <div class="container">

        <!-- 일자 클릭시 메뉴오픈 -->
         <div id="contextMenu" class="dropdown clearfix">
            <ul class="dropdown-menu dropNewEvent" role="menu" aria-labelledby="dropdownMenu"
                style="display:block;position:static;margin-bottom:5px;">
                <li><a tabindex="-1" href="#">카테고리1</a></li>
                <li><a tabindex="-1" href="#">카테고리2</a></li>
                <li><a tabindex="-1" href="#">카테고리3</a></li>
                <li><a tabindex="-1" href="#">카테고리4</a></li>
                <li class="divider"></li>
                <li><a tabindex="-1" href="#" data-role="close">Close</a></li>
            </ul>
        </div> 

        <div id="wrapper">
            <div id="loading"></div>
            <div id="calendar"></div>
        </div>








        <!-- 일정 추가 MODAL -->
        <div class="modal fade" id="eventModal"
				tabindex="-1" role="dialog">
				<div class="modal-dialog" role="document">
					<div class="modal-content">
<!-- 						<div class="modal-header"> -->
<!-- 							<h1 class="modal-title fs-5" id="exampleModalLabel">예약하기</h1> -->
<!-- 							<button type="button" class="btn-close" data-bs-dismiss="modal" -->
<!-- 								aria-label="Close"></button> -->
<!-- 						</div> -->

						<div class="modal-body">
<!-- 							<form class="row g-4 form"> -->
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
								<div class="timeset" style="width: auto;"></div>
									<!-- timeoption 부분-->								
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
<!-- 							</form> -->
						</div>

					</div>
				</div>
			</div>
			
		


        <!--  <d iv class="panel panel-default">

            <div class="panel-heading">
                <h3 class="panel-title">필터</h3>
            </div>

            <div class="panel-body">

                <div class="col-lg-6">
                    <label for="calendar_view">구분별</label>
                    <div class="input-group">
                        <select class="filter" id="type_filter" multiple="multiple">
                            <option value="카테고리1">카테고리1</option>
                            <option value="카테고리2">카테고리2</option>
                            <option value="카테고리3">카테고리3</option>
                            <option value="카테고리4">카테고리4</option>
                        </select>
                    </div>
                </div>

                <div class="col-lg-6">
                    <label for="calendar_view">등록자별</label>
                    <div class="input-group">
                        <label class="checkbox-inline"><input class='filter' type="checkbox" value="정연"
                                checked>정연</label>
                        <label class="checkbox-inline"><input class='filter' type="checkbox" value="다현"
                                checked>다현</label>
                        <label class="checkbox-inline"><input class='filter' type="checkbox" value="사나"
                                checked>사나</label>
                        <label class="checkbox-inline"><input class='filter' type="checkbox" value="나연"
                                checked>나연</label>
                        <label class="checkbox-inline"><input class='filter' type="checkbox" value="지효"
                                checked>지효</label>
                    </div>
                </div>

            </div>
        </div> 
        <!-- /.filter panel -->
    </div>
    <!-- /.container -->

    
					
					
					
					
					
					
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

</div></div>


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
			
			
			
			
			<script src="js/reservation/vendor_cal/js/jquery.min.js"></script>
    <script src="js/reservation/vendor_cal/js/bootstrap.min.js"></script>
    <script src="js/reservation/vendor_cal/js/moment.min.js"></script>
    <script src="js/reservation/vendor_cal/js/fullcalendar.min.js"></script>
    <script src="js/reservation/vendor_cal/js/ko.js"></script>
    <script src="js/reservation/vendor_cal/js/select2.min.js"></script>
    <script src="js/reservation/vendor_cal/js/bootstrap-datetimepicker.min.js"></script>
    <script src="js/reservation/js/main.js"></script>
    <script src="js/reservation/js/addEvent.js"></script>
    <script src="js/reservation/js/editEvent.js"></script>
    <script src="js/reservation/js/etcSetting.js"></script>
			
			
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


































