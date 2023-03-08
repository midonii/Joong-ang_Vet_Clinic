<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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

<title>수납</title>
<link rel="stylesheet"
	href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<!-- Custom fonts for this template-->
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
<link href="css/sb-admin-2.min.css" rel="stylesheet">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
<script>
	$(function() {
		$(".payBefore").click(function() {
			let payno = $(this).attr("value");// 수납대기버튼의 value
			$.post({
				url : "/payBefore",
				cache : false,
				data : {
					"payno" : payno
				},
				dataType : "json"
			}).done(function(data) {
				location.reload();

			})

		});//click
		$(".payCancel").click(function() {

			let payno = $(this).attr("value");// 수납취소버튼의 value
			if (confirm("수납대기로 변경하시겠습니까?")) {

				$.post({
					url : "/payCancel",
					cache : false,
					data : {
						"payno" : payno
					},
					dataType : "json"
				}).done(function(data) {
					location.reload();
				}).fail(function(xhr, status, errorThrown) {
					alert("문제가 발생했습니다.");
				});
			}

		});//click
	}); //func
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

					<!-- 헤드 - 검색기능 + 날짜별 출력 -->


					<!-- DataTales Example -->
					<div class="card shadow mb-4">
						<div class="card-header py-3">
							<h6 class="m-0 font-weight-bold text-primary">수납</h6>

						</div>
						<div class="card-body">
							<div class="table-responsive" id="printme">
								<table class="table table-bordered" id="dataTable" width="100%"
									cellspacing="0">
									<thead>
										<tr>
											<th>번호</th>
											<th>방문일</th>
											<th>차트번호</th>
											<th>동물명</th>
											<th>보호자명</th>
											<th>수납금액</th>
											<th>수납현황</th>
											<th>상세보기</th>
										</tr>
									</thead>
									<tbody>
										<form action="/payDetail" method="get">
											<c:forEach items="${payList }" var="pl">
												<tr>
													<td>${pl.pay_no }</td>
													<td>${pl.pay_date }</td>
													<td>${pl.chart_no }</td>
													<td>${pl.pet_name }</td>
													<td>${pl.owner_name }</td>
													<td><fmt:formatNumber value="${pl.totalprice }"
															pattern="#,###" />원</td>
													<c:if test="${pl.pay_yn eq 'Y'}">
													<td calss="btn btn-secondary"> 
													<button type="button" class="btn btn-outline-primary btn-sm payCancel"  value="${pl.pay_no }">수납완료</button>
													
													</td></c:if>
													<c:if test="${pl.pay_yn eq 'N'}">
													<td>
													<button type="button" class="btn btn-outline-danger btn-sm payBefore" value="${pl.pay_no }" >수납대기</button>
													</td></c:if>
													

													<td><buttton type="submit" id="detailBtn" name="payNo"
															class="btn btn-primary btn-sm" value="${pl.pay_no }"
															onclick="location.href='/payDetail?payNo='+'${pl.pay_no }'">상세보기</buttton></td>
												</tr>
											</c:forEach>
										</form>
									</tbody>
								</table>
							</div>
						</div>
					</div>

				</div>
				<!-- /.container-fluid -->

			</div>
			<!-- End of Main Content -->

			<!-- 푸터, 로그아웃 모달  -->
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
