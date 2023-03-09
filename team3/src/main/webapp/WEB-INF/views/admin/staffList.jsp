<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>Team 3</title>
<link rel="stylesheet"
	href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<!-- Custom fonts for this template-->
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
<script type="text/javascript">
	$(function() {
		$(".staffDetailModal").click(function() {
			$("#staffDetailModal").modal("show");
			var staff_no = $(this).attr("data-value");

			$.post({
				url : "/staffDetail",
				cache : false,
				data : {
					"staff_no" : staff_no
				},
				dataType : "json"
			}).done(function(data) {
				let result = data.result;
				$("#staff_no").val(result.staff_no);
				$("#staff_name").text(result.staff_name);
				$("#staff_id").text(result.staff_id);
				$("#staff_tel").text(result.staff_tel);
				$("#staff_birth").text(result.staff_birth);
				$("#staff_addr").text(result.staff_addr);
				$("#staff_email").text(result.staff_email);
				$("#staff_grade").val(result.staff_grade);

			}).fail(function(xhr, status, errorThrown) {
				alert("실패");
			});
		});
		
		$(".refresh").click(function(){
			location.href="/staffList";
		});
		
		$(".gradeUpdate").click(function() {

			let staff_no = $("#staff_no").val();
			let staff_grade = $("#staff_grade").val();

			$.post({
				url : "/gradeUpdate",
				data : {
					"staff_no" : staff_no,
					"staff_grade" : staff_grade
				},
				dataType : "json"
			}).done(function(data) {
				if (data.result2 == 1) {
					alert("권한 수정이 완료되었습니다.");
					let result = data.result;
					$("#staff_no").val(result.staff_no);
					$("#staff_name").text(result.staff_name);
					$("#staff_id").text(result.staff_id);
					$("#staff_tel").text(result.staff_tel);
					$("#staff_birth").text(result.staff_birth);
					$("#staff_addr").text(result.staff_addr);
					$("#staff_email").text(result.staff_email);
					$("#staff_grade").val(result.staff_grade)
					$("#staffDetailModal").modal("show");

				} else {
					alert("문제가 발생했습니다. \n다시 시도해주세요.");
				}
			}).fail(function() {
				alert("문제발생");
			});
		});

		$(".deleteStaff").click(function() {
			let staff_no = $("#staff_no").val();
			if(confirm("정말 삭제하시겠습니까?")){
				location.href = "/staffDel?staff_no=" + staff_no;
			}
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

					<!-- Page Heading -->
					<h5 class="h5 mb-4 text-gray-900">
						<b>직원 관리</b>
					</h5>


					<!-- DataTales Example -->
					<div class="card shadow mb-4">
						<div class="card-header py-3">
							<h6 class="m-0 font-weight-bold text-primary">직원 리스트</h6>
						</div>
						<div class="card-body">
							<form class="mb-3 justify-content-end">





								<div class="input-group">
									<select class="form-control col-2">
										<option>이름</option>
										<option>ID</option>
										<option>전화번호</option>
										<option>이메일</option>
										<option>직책</option>
									</select> <input type="text" class="form-control border-gray"
										placeholder="검색어를 입력하세요">
									<div class="input-group-append">
										<button class="btn btn-primary" type="button">
											<i class="fas fa-search"></i>
										</button>
									</div>
								</div>

							</form>
							<div class="table-responsive">
								<table class="table table-sm table-bordered text-center"
									id="dataTable" width="100%" cellspacing="0">
									<thead>
										<tr class="bg-gray-200">
											<th class="col-1">번호</th>
											<th class="col-2">이름</th>
											<th class="col-2">ID</th>
											<th class="col-3">전화번호</th>
											<th class="col-3">이메일</th>
											<th class="col-1">직책</th>
										</tr>
									</thead>

									<tbody>

										<c:forEach items="${staffList }" var="sl">
											<tr>
												<td>${sl.sno }</td>
												<td><a href="#" style="text-decoration: none;"
													class="staffDetailModal" data-toggle="modal"
													data-value="${sl.staff_no }"> ${sl.staff_name }</a></td>
												<td>${sl.staff_id }</td>
												<td>${sl.staff_tel }</td>
												<td>${sl.staff_email }</td>
												<td>${sl.staff_grade }</td>
											</tr>
										</c:forEach>

									</tbody>
								</table>
							</div>
						</div>
					</div>


				</div>
				<!-- /.container-fluid -->

			</div>
			<!-- End of Main Content -->

			<%@ include file="../bar/footer.jsp"%>
			<%@ include file="../bar/logoutModal.jsp"%>


			<!-- staff 상세보기, 권한 수정 Modal-->
			<div class="modal fade" id="staffDetailModal" tabindex="-1"
				role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
				<div class="modal-dialog" role="document">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="exampleModalLabel">정보 상세보기</h5>
							<button class="close refresh" type="button" data-dismiss="modal"
								aria-label="Close">
								<span aria-hidden="true">×</span>
							</button>
						</div>
						<div class="modal-body">
							<input type="hidden" id="staff_no" name="staff_no">

							<ul class="list-group list-group-flush">
								<li class="list-group-item">
									<div class="row">
										<div class="col-md-3">이름</div>
										<div class="col-md-9" id="staff_name"></div>
									</div>
								</li>
								<li class="list-group-item">
									<div class="row">
										<div class="col-md-3">ID</div>
										<div class="col-md-9" id="staff_id"></div>
									</div>
								</li>
								<li class="list-group-item">
									<div class="row">
										<div class="col-md-3">이메일</div>
										<div class="col-md-9" id="staff_email"></div>
									</div>
								</li>
								<li class="list-group-item">
									<div class="row">
										<div class="col-md-3">생년월일</div>
										<div class="col-md-9" id="staff_birth"></div>
									</div>
								</li>
								<li class="list-group-item">
									<div class="row">
										<div class="col-md-3">전화번호</div>
										<div class="col-md-9" id="staff_tel"></div>
									</div>
								</li>
								<li class="list-group-item">
									<div class="row">
										<div class="col-md-3">주소</div>
										<div class="col-md-9" id="staff_addr"></div>
									</div>
								</li>
								<li class="list-group-item">
									<div class="row">
										<div class="col-md-3">권한 등급</div>
										<div class="col-md-6">
											<select class="form-control" id="staff_grade"
												name="staff_grade">
												<option value="admin">관리자</option>
												<option value="doctor">의사</option>
												<option value="technician">테크니션</option>
											</select>
										</div>
										<div class="col-md-3">
											<button type="button" class="btn btn-primary gradeUpdate">수정</button>
										</div>
									</div>
								</li>
							</ul>
						</div>
						<div class="modal-footer">
							<button type="button"
								class="btn btn-outline-danger btn-sm deleteStaff">삭제</button>
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
</body>

</html>
