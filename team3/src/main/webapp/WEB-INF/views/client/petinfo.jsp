<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en">
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

<title>pet data</title>
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<!-- Custom fonts for this template-->
<link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet">
<!-- 	type="text/css"> -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css">
<link rel="stylesheet" href="https://kit.fontawesome.com/a31e2023c3.css" crossorigin="anonymous">
<script src="https://kit.fontawesome.com/a31e2023c3.js" crossorigin="anonymous"></script>
<link
	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">

<!-- CSS only -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<!-- Custom styles for this template-->
<link href="../css/sb-admin-2.min.css" rel="stylesheet">

<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js" integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js" integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>

<script type="text/javascript">
$(function(){
	
});
</script>
<script src="js/client/client_add.js"></script>
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
				<div class="row align-top">	
				  <!-- pet 정보 -->
				  
				   <div class="col-5">	
					<div class="card shadow mb-4">
						<div class="card-header py-3">
							<h6 class="m-0 font-weight-bold text-primary">반려견 Info</h6>
						</div>
						<div class="card-body">
							<div style="height: 300px;">
								<div class="list-group list-group-flush">
  								 <div class="list-group-item row">
  									<div class="col-4 font-weight-bold float-left">이름</div>
  									<div class="col-8 float-left">이름정보</div>
  								 </div>	
  								 <div class="list-group-item row">
  									<div class="col-4 font-weight-bold float-left">견종</div>
  									<div class="col-8 float-left">견종정보</div>
  								 </div>	
  								 <div class="list-group-item row">
  									<div class="col-4 font-weight-bold float-left">생일</div>
  									<div class="col-8 float-left">생일정보</div>
  								 </div>	
  								 <div class="list-group-item row">
  									<div class="col-4 font-weight-bold float-left">성별</div>
  									<div class="col-8 float-left">성별정보</div>
  								 </div>	
  								 <div class="list-group-item row">
  									<div class="col-4 font-weight-bold float-left">몸무게</div>
  									<div class="col-8 float-left">몸무게정보</div>
  								 </div>	
  								 <div class="list-group-item row">
  									<div class="col-4 font-weight-bold float-left">특이사항</div>
  									<div class="col-8 float-left">특이사항정보</div>
  								 </div>	
								</div>
							</div>
						</div>
					</div>
				  </div>

					<!-- 접종 내역 -->
					<div class="col-7">	
					<div class="card shadow mb-4">
						<div class="card-header py-3">
							<h6 class="m-0 font-weight-bold text-primary">접종</h6>
						</div>
						<div class="card-body">
							<div style="height: 300px;">
								내용
							</div>
						</div>
					</div>
					</div>
				</div>
				  
				
				<!-- 이전 진료 내역 part -->
					<div class="card shadow mb-4 align-bottom">
						<div class="card-header py-3">
							<h6 class="m-0 font-weight-bold text-primary">이전진료</h6>
						</div>
						<div class="card-body">
							<div style="height: 250px; overflow: auto;">
							
							
								<!-- 진료 내역 -->
								<div class="accordion" id="accordionExample">
									<div class="accordion-item">
										<h2 class="accordion-header" id="headingOne">
											<button class="accordion-button" type="button"
												data-toggle="collapse" data-target="#collapseOne"
												aria-expanded="false" aria-controls="collapseOne">
												<div class="font-weight-bold">담당의 :</div>
												<div class="ml-2 font-weith">(담당의)정보가 없습니다.</div>
												<div class="ml-4 font-weight-bold">진료날짜 :</div>
												<div class="ml-2">(진료날짜)정보가 없습니다.</div>
												</button>
										</h2>
										<div id="collapseOne" class="accordion-collapse collapse"
											aria-labelledby="headingOne"
											data-bs-parent="#accordionExample">
											<div class="accordion-body">
												내용
											</div>
										</div>
									</div>
								</div>



							</div>
						</div>
					</div>


				</div>
				<!-- /.container-fluid -->

			</div>
			<!-- End of Main Content -->
			
			      <%@ include file="../bar/footer.jsp" %>
         		  <%@ include file="../bar/logoutModal.jsp" %>
			

	<!-- Bootstrap core JavaScript-->
	<script src="vendor/jquery/jquery.min.js"></script>
	<script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

	<!-- Core plugin JavaScript-->
	<script src="vendor/jquery-easing/jquery.easing.min.js"></script>
	

	<!-- Custom scripts for all pages-->
	<script src="js/sb-admin-2.min.js"></script>
	<!-- JavaScript Bundle with Popper -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>

</body>

</html>