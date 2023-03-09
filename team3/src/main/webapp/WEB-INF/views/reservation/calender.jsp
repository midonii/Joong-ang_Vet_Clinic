<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html lang="ko">
<%-- <% if(session.getAttribute("id") == null){
   response.sendRedirect("/login");
}
%> --%>
<head>

<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>예약접수</title>
<link rel="stylesheet"
	href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<!-- <!-- Custom fonts for this template-->
<link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet"
	type="text/css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css">
<link rel="stylesheet" href="https://kit.fontawesome.com/a31e2023c3.css"
	crossorigin="anonymous">
<script src="https://kit.fontawesome.com/a31e2023c3.js"
	crossorigin="anonymous"></script>
	<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>

<link
	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">

<!-- Custom styles for this template-->
<link href="css/sb-admin-2.min.css" rel="stylesheet">
<link href="css/reservation/reserv.css" rel="stylesheet">
<!-- <!-- bootstrap -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css"
	rel="stylesheet">
<!-- <link rel="stylesheet" href="style.css"> -->
<link rel="stylesheet" href="css/reservation/calender/calender.css">
<script type="text/javascript">
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

</script>
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
.marginTop5{
margin-top:-1rem;
}
/* 시간성정 */
cell {
 border: 1px solid #BDBDBD;
  border: 1px solid #3D5AFE;
  margin: 3px;
  cursor: pointer;
}

.cell:hover {
  border: 1px solid #3D5AFE;
}

.cell.select {
  background-color: #3D5AFE;
  color: #fff;
}
/* .active { */
/*   border-radius: 6px !important; */
/*   background-image: linear-gradient(#90CAF9, #64B5F6) !important; */
/*   color: #000 !important; */
/* } */

.disabled {
  color: #616161 !important;
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

					<%@ include file="../reservation/reserv_bar.jsp"%>




					<div class="content">
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
						<div class="events-container"></div>
						<div class="dialog" id="dialog" style="overflow:auto;">
						
							<!-- 검색기능 -->
							 <div style="width::50px; margin-top:10px; border-bottom:3px solid #9e9e9e;">
							  <form class="form-inline search_form" name="searchForm" action="/calender" method="get">
							    <input class="form-control ml-auto" style="width: 230px; margin-right:7px;" value="" type="text" name="search_value" id="search_value" placeholder="검색어를 입력하세요" aria-label="검색">
							    <button class="btn btn-outline-success my-2 my-sm-0 bi bi-search" id="search_btn">검색</button>
							  </form> 
							</div>
							
							
							
							
							
							<form class="row g-4 form" name="reservForm" action="/calender" method="post" style="margin-top:7px;">
							  <div class="col-md-6">  
							    <label class="form-label marginTop5" for="owner_name">보호자 이름</label>
							    <input type="text" class="form-control" id="owner_name">
							  </div>
							  <div class="col-md-6">
							    <label class="form-label marginTop5"  for="owner_tel">전화번호</label>
							    <input type="text" class="form-control" id="owner_tel" placeholder="01012345678">
							  </div>
							  <div class="col-md-6">
							    <label class="form-label marginTop5" for="pet_name">반려견 이름</label>
							    <input type="text" class="form-control" id="pet_name">
							  </div>
							  <div class="col-md-6">
							    <label class="form-label marginTop5"  for="pet_type">견종</label>
							    <input type="text" class="form-control" id="pet_type">
							  </div>
							  <!-- 시간설정 -->
							  <div class="col-md-6" style="width:auto;">
								<label for="inputAddress" class="form-label" for="owner_addr">시간선택</label>
								 <div class="accordion" id="accordionExample">
								  <div class="accordion-item">
								      <button class="accordion-button collapsed" style="width:470px; height:38px;" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne" aria-expanded="false" aria-controls="collapseOne">
								        시간선택
								      </button>
									    <div id="collapseOne" class="accordion-collapse collapse" aria-labelledby="headingOne" data-bs-parent="#accordionExample">
									      <div class="accordion-body">


											<div class="row text-center mx-0">
								              <div class="col-md-3 col-4 my-1 px-2"><div class="cell py-1" value="9:00"></div></div>
								              <div class="col-md-3 col-4 my-1 px-2"><div class="cell py-1" value="9:30"></div></div>
								              <div class="col-md-3 col-4 my-1 px-2"><div class="cell py-1" value="10:00"></div></div>
								              <div class="col-md-3 col-4 my-1 px-2"><div class="cell py-1" value="10:30"></div></div>
								            </div>
<!-- 								            <div class="row text-center mx-0"> -->
<!-- 								              <div class="col-md-3 col-4 my-1 px-2"><div class="cell py-1">11:00</div></div> -->
<!-- 								              <div class="col-md-3 col-4 my-1 px-2"><div class="cell py-1">11:30</div></div> -->
<!-- 								              <div class="col-md-3 col-4 my-1 px-2"><div class="cell py-1">12:00</div></div> -->
<!-- 								              <div class="col-md-3 col-4 my-1 px-2"><div class="cell py-1">12:30</div></div> -->
<!-- 								            </div> -->
<!-- 								            <div class="row text-center mx-0"> -->
<!-- 								              <div class="col-md-3 col-4 my-1 px-2"><div class="cell py-1">13:00</div></div> -->
<!-- 								              <div class="col-md-3 col-4 my-1 px-2"><div class="cell py-1">14:30</div></div> -->
<!-- 								              <div class="col-md-3 col-4 my-1 px-2"><div class="cell py-1">15:00</div></div> -->
<!-- 								              <div class="col-md-3 col-4 my-1 px-2"><div class="cell py-1">15:30</div></div> -->
<!-- 								            </div> -->
<!-- 								            <div class="row text-center mx-0"> -->
<!-- 								              <div class="col-md-3 col-4 my-1 px-2"><div class="cell py-1">16:00</div></div> -->
<!-- 								              <div class="col-md-3 col-4 my-1 px-2"><div class="cell py-1">16:30</div></div> -->
<!-- 								              <div class="col-md-3 col-4 my-1 px-2"><div class="cell py-1">17:00</div></div> -->
<!-- 								              <div class="col-md-3 col-4 my-1 px-2"><div class="cell py-1">17:00</div></div> -->
<!-- 								            </div> -->

									      </div>
									    </div>
								    </div>
								  </div>
							  </div>
							  <div class="col-md-6" style="right:5px;">
							    <label class="form-label" for="reserv_memo">예약메모</label>
							    <textarea class="form-control" id="reserv_memo" style="height:100px; width:460px;"></textarea>
							  </div>
							  
							  
							  <div class="buttons">
					            <input type="button" value="예약하기" class="button btn-reserv" id="ok-button">
					            <input type="button" value="취소하기" class="button btn-cancle" id="cancel-button">
							  </div>
							</form>
							
						</div>
					</div>
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

		<!-- Core plugin JavaScript
	-->
		<script src="vendor/jquery-easing/jquery.easing.min.js"></script>

		<!-- Custom scripts for all pages
	-->
		<script src="js/sb-admin-2.min.js"></script>

		<!-- bootstrap
	-->
		<script
			src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script> -->
</body>


</html>
<!-- Dialog Box-->
<script src="js/reservation/calender/calender.js"></script>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"
	integrity="sha256-hwg4gsxgFZhOsEEamdOYGBf13FyQuiTwlAQgxVSNgt4="
	crossorigin="anonymous">
  </script>
<script src="app.js"></script>

