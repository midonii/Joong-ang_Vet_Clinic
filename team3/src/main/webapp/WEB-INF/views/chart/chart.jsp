<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="ko">
<%
if (session.getAttribute("id") == null) {
	response.sendRedirect("/login?error=4321");
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
<link href="css/chart/chart1.css" rel="stylesheet">
<!-- 시라 css  -->

<!-- JQUERY -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
<script type="text/javascript" src="../js/chart/chart1.js"></script>
<!-- 시라 js  -->
<script type="text/javascript" src="../js/chart/chart3.js"></script>
<!-- 예지 js -->

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
								<%@ include file="./chart_head.jsp"%>
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
								<%@ include file="./chart_before.jsp"%>

							</div>
						</div>

						<div class="col-xl-4 col-lg-5 px-1">
							<div class="card  mb-2">
								<div
									class="card-header py-2 d-flex flex-row align-items-center justify-content-between">
									<h6 class="m-0 font-weight-bold text-primary">의사소견</h6>

								</div>
								<%@ include file="./chart_memo.jsp"%>
							</div>

							<div class="card  mb-2">
								<div
									class="card-header py-2 d-flex flex-row align-items-center justify-content-between">
									<h6 class="m-0 font-weight-bold text-primary">처방내역</h6>
									<a class="text-primary" style=" font-size:14px; text-decoration: none; "id="presc" >
									추가<i class="fa-regular fa-plus" style="margin-left: 2px;"></i></a>

								</div>
								
								<%@ include file="./chart_cheobang.jsp"%>
								
							</div>
						</div>

						<div class="col-xl-4 col-lg-5 px-1">
							<div class="card mb-2">
								<div
									class="card-header py-2 d-flex flex-row align-items-center justify-content-between">
									<h6 class="m-0 font-weight-bold text-primary">접수현황</h6>

								</div>

								<%@ include file="./chart_reception.jsp"%>

							</div>

							<div class="card  mb-2">
								<div
									class="card-header py-2 d-flex flex-row align-items-center justify-content-between">
									<h6 class="m-0 font-weight-bold text-primary">접종내역</h6>

								</div>

								<%@ include file="./chart_vac.jsp"%>
							</div>
						</div>

					</div>

				</div>
				<!-- /.container-fluid -->

			</div>
			<!-- End of Main Content -->




			<%@ include file="./chart_searchM.jsp"%>
			<%@ include file="./chart_cheobangM.jsp"%>
			<%@ include file="../bar/logoutModal.jsp"%>
			<%@ include file="../bar/footer.jsp"%>



			<script src="vendor/jquery/jquery.min.js"></script>
			<script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

			<!-- Core plugin JavaScript-->
			<script src="vendor/jquery-easing/jquery.easing.min.js"></script>

			<!-- Custom scripts for all pages-->
			<script src="js/sb-admin-2.min.js"></script>
</body>
</html>
