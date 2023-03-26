<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<html lang="ko">
<%
if (session.getAttribute("id") == null) {
   response.sendRedirect("/login?error=4321");
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
<link rel="stylesheet" href="css/reservation/calender_sm2.css">
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
<link rel="stylesheet" href="css/reservation/calender_sm.css">
<link rel="stylesheet" href="css/reservation/calender_sm2.css">
<!-- <script src="js/reservation/calender_reserv.js"></script> -->

<script type="text/javascript"
	src="../js/reservation/calender_search.js"></script>
</head>
<script type="text/javascript">

</script>
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
#add-button:hover{
/* color: white; */
background-color: #4e73df;
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
						<div class="calendar-container" style="border-right: 1px #d1d3e2 solid;">
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
											<td class="month"><span style="font-size:15px;">1</span>월</td>
											<td class="month"><span style="font-size:15px;">2</span>월</td>
											<td class="month"><span style="font-size:15px;">3</span>월</td>
											<td class="month"><span style="font-size:15px;">4</span>월</td>
											<td class="month"><span style="font-size:15px;">5</span>월</td>
											<td class="month"><span style="font-size:15px;">6</span>월</td>
											<td class="month"><span style="font-size:15px;">7</span>월</td>
											<td class="month"><span style="font-size:15px;">8</span>월</td>
											<td class="month"><span style="font-size:15px;">9</span>월</td>
											<td class="month"><span style="font-size:15px;">10</span>월</td>
											<td class="month"><span style="font-size:15px;">11</span>월</td>
											<td class="month"><span style="font-size:15px;">12</span>월</td>
										</tr>
									</tbody>
								</table>

								<table class="days-table">
									<td class="day">일</td>
									<td class="day">월</td>
									<td class="day">화</td>
									<td class="day">수</td>
									<td class="day">목</td>
									<td class="day">금</td>
									<td class="day">토</td>
								</table>
								<div class="frame">
									<table class="dates-table" style="width: 100%;">
										<tbody class="tbody">
										</tbody>
									</table>
								</div>
								<button class="btn" id="add-button" style="border: 2px solid #4e73df; color: #4e73df;"
								onMouseOver="this.style.color='white';" onMouseOut="this.style.color='#0d6efd'"
								>예약추가</button>
							</div>
						</div>
						
						
						
						
						
						
						<!-- 주간캘린더 -->
						<div class="dialog2" id="dialog2" style="overflow: auto;">
<%-- 						<%@ include file="calender_sm2.jsp"%> --%>
						<div class="weekcalendar">
						 <div class="timeline1">
						    <div class="spacer"></div>
						    <div class="time-marker" data-value="09:00">9 AM</div> 
						    <div class="time-marker" data-value="09:30"></div>
						    <div class="time-marker" data-value="10:00">10 AM</div>
						    <div class="time-marker" data-value="10:30"></div>
						    <div class="time-marker" data-value="11:00">11 AM</div>
						    <div class="time-marker" data-value="11:30"></div>
						    <div class="time-marker" data-value="12:00">12 PM</div>
						    <div class="time-marker" data-value="12:30"></div>
						    <div class="time-marker" data-value="13:00">1 PM</div>
						    <div class="time-marker" data-value="13:30"></div>
						    <div class="time-marker" data-value="14:00">2 PM</div>
						    <div class="time-marker" data-value="14:30"></div>
						    <div class="time-marker" data-value="15:00">3 PM</div>
						    <div class="time-marker" data-value="15:30"></div>
						    <div class="time-marker" data-value="16:00">4 PM</div>
						    <div class="time-marker" data-value="16:30"></div>
						    <div class="time-marker" data-value="17:00">5 PM</div>
						    <div class="time-marker" data-value="17:30"></div>
						  </div>
						  <!-- 
						  
						  * 값 1개 가져올때
						  var value = $(".time-marker").data("value");
						  
						  * 값 여러개 가져올때
						  $(".time-marker").each(function() {
							  var value = $(this).data("value");
							  // value 값을 사용하여 작업 수행
							});
													  
						   -->
						  
						  
						  <div class="days">
						  
						  
						  
						    <div class="day_">
						    <!-- 날짜/요일 -->
						      <div class="date day0">
						      	<!-- sm.js로 날짜,요일 넣기 -->
<!-- 						    <p class="date-num">11</p> -->
<!-- 						    <p class="date-day" id="date-day">월</p> -->
						      </div>
							  <!-- 예약내역 -->
							  <div class="events1">
								<div class="event1 start-9 securities">
							      	<c:forEach items="${reservlist}" var="r">
<%-- 								        <c:if test="${r.reserv_date == fulldate}"> --%>
											    <p class="title" style="font-size:5px;">${r.reservation_no}</p>
<%-- 								        </c:if> --%>
								       
									</c:forEach> 
<!-- 							 	 <p class="title" style="font-size:5px;">헤헤</p> -->
								</div>
							  </div>
						    </div>
						      
						      
						      
<%-- 								  	<c:choose>
										<c:when test="${reserv_date== ${'.date-num.data-date()'}">
												<input type="hidden" value="${r.reserv_time }">
										        <div class="event1 start-9 securities">
										          <p class="title" style="font-size:5px;">${r.pet_name } (${r.owner_name})</p>
										    </div>
										</c:when>
									</c:choose> --%>
						    
						    
						    
						    <div class="day_">
						      <div class="date day1">
						      	<!-- js에서 append -->
<!-- 						     <p class="date-num">12</p> -->
<!-- 						     <p class="date-day">화</p> -->
						      </div>
						      <div class="events1">
						<!--         <div class="event start-10 end-12 corp-fi"> -->
						<!--           <p class="title">Corporate Finance</p> -->
						<!--           <p class="time">10 AM - 12 PM</p> -->
						<!--         </div> -->
						<!--         <div class="event start-1 end-4 ent-law"> -->
						<!--           <p class="title">Entertainment Law</p> -->
						<!--           <p class="time">1PM - 4PM</p> -->
						<!--         </div> -->
						      </div>
						    </div>
						    <div class="day_">
						      <div class="date day2">
<!-- 						        <p class="date-num">11</p> -->
<!-- 						        <p class="date-day">수</p> -->
						      </div>
						      <div class="events1">
						
						
						
						      </div>
						    </div>
						    
						    
						    <div class="day_">
						      <div class="date day3">
<!-- 						        <p class="date-num">12</p> -->
<!-- 						        <p class="date-day">목</p> -->
						      </div>
						      <div class="events1">
						
						
						
						      </div>
						    </div>
						    <div class="day_">
						      <div class="date day4">
<!-- 						        <p class="date-num">13</p> -->
<!-- 						        <p class="date-day">금</p> -->
						      </div>
						      <div class="events1">
						      </div>
						    </div>
						  </div>
						</div>
						</div>
						
						
						
						
						
						<!-- 예약창 -->
						<div class="dialog" id="dialog" style="overflow: auto;">
							<!-- 검색기능 -->
							<div style="width:450px; margin-left:22px;">
							<div class="input-group mt-4 mb-4" style="text-align: center; border-radius:5px;
							box-shadow: 5px 5px 9px -5px #666;">
								<input type="text"
									class="form-control form-contorl-sm boarder-gray col-md-12 h-25 pet_search"
									placeholder="고객 조회하기" aria-label="Search"
									aria-describedby="basic-addon2" id="pet_search"
									name="pet_search">
								<div class="input-group-append">
									<button class="btn btn-primary shadow-sm" id="search_btn"
										type="button">
										<i class="fas fa-search fa-sm"></i>
									</button>
								</div>
							</div>
							</div>
							
							<div class="container">
							<form class="row g-2 form justify-content-md-center">
								<div class="col-md-6">
									<label for="owner_name" class="col-form-label">보호자 이름</label> <input
										type="text" class="form-control" id="owner_name" value="없음"
										readonly>
								</div>
								<div class="col-md-6">
									<label for="owne_tel" class="col-form-label">전화번호</label> <input
										type="text" class="form-control" id="owner_tel"
										placeholder="" value="없음" readonly>
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
									<label for="s_reservation_date_day" class="col-form-label">예약날짜</label>
									<input class="form-control" style="width:94%;" type="date" value="년-월-일"
										id="s_reservation_date_day" tabindex="-1" readonly>
								</p>

								<!-- 시간설정 -->
								<div class="timeset" style="width: auto;">
									<!-- timeoption 부분-->	
<%-- 									<%@ include file="timeoption.jsp"%>		 --%>
								</div>					
								<div style="margin-left:10px;">
									<label for="reservation_memo" class="col-form-label">예약메모</label>
									<textarea class="form-control" style="width:476px; border:1px solid #d1d3e2;" id="reservation_memo"></textarea>
								</div>
								<input type="hidden" id="petNo" value="">
								<input type="hidden" id="reservation_date" name="reservation_date">
								<div class="modal-footer" style="border-top:none; padding:0;">
									<button type="button" class="btn btn-secondary" style="background-color: #7f8c8d; border: none;"
										data-bs-dismiss="modal" id="cancel-button">취소</button>
									<button type="button" class="btn btn-primary" id="s_ok-button"
										name="" value="">예약하기</button>
								</div>
							</form>
							</div>
						</div>
						
						
					</div>
				</div>
</div>

<%@ include file="../bar/footer.jsp"%>
<%@ include file="../bar/logoutModal.jsp"%>

<%-- <%@ include file="../reservation/calender_sm2.jsp"%> --%>

</div></div>


		<!-- 시간선택 html -->
			<div style="display: none;">
				<div class="timeoption">
					<label class="col-form-label" for="update_reservation_date_time">예약시간</label>
					<div class="accordion" id="accordionExample">
						<div class="accordion-item">
							<button class="accordion-button collapsed"
								style="width: 476px; height: 38px;" type="button" id="accordion"
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
<script src="js/reservation/calender_sm.js"></script>
<script src="js/reservation/calender_reserv.js"></script>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"
	integrity="sha256-hwg4gsxgFZhOsEEamdOYGBf13FyQuiTwlAQgxVSNgt4="
	crossorigin="anonymous">
  </script>
<script src="app.js"></script>
  
