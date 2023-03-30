<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<%
if (session.getAttribute("id") != null) {
	if (!session.getAttribute("staff_grade").equals("admin")) {
		response.sendRedirect("/index?error=1234");
	}
} else {
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
<link rel="shortcut icon" type="image/x-icon" href="../img/favicon.png" />
<link rel="shortcut icon" type="image/x-icon" href="/img/favicon.png" />
<link rel="stylesheet"
	href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<!-- Custom fonts for this template-->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css">
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

		let searchName2 = $("#searchName").val();

		if (searchName2 == "") {
			$("#search_name option[value='all']").attr('selected', 'selected');
		} else {
			$("#search_name").val(searchName2);
		}

		$(".staffDetailModal")
				.click(
						function() {
							$("#staffDetailModal").modal("show");
							var staff_no = $(this).attr("data-value");

							$
									.post({
										url : "/staffDetail",
										cache : false,
										data : {
											"staff_no" : staff_no
										},
										dataType : "json"
									})
									.done(
											function(data) {
												let result = data.result;
												$("#staff_no").val(
														result.staff_no);
												$("#staff_name").text(
														result.staff_name);
												$("#staff_id").text(
														result.staff_id);
												var staff_tel = result.staff_tel
												var staff_telH = staff_tel
														.replace(
																/(^02.{0}|^01.{1}|[0-9]{3})([0-9]+)([0-9]{4})/,
																"$1-$2-$3");
												$("#staff_tel")
														.text(staff_telH);
												$("#staff_birth").text(
														result.staff_birth);
												$("#staff_addr").text(
														result.staff_addr);
												$("#staff_email").text(
														result.staff_email);
												$("#staff_grade").val(
														result.staff_grade);

											}).fail(
											function(xhr, status, errorThrown) {
												alert("실패");
											});
						});

		$(".refresh").click(function() {
			var pagenum = $("#pagenum").val();
			let searchValue = $("#search_value").val();
			page(pagenum, searchName2, searchValue);
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
					$("#staffDetailModal").modal("hide");

					var pagenum = $("#pagenum").val();
					let searchValue = $("#search_value").val();
					page(pagenum, searchName2, searchValue);

				} else {
					alert("문제가 발생했습니다. \n다시 시도해주세요.");
				}
			}).fail(function() {
				alert("문제발생");
			});
		});

		$(".deleteStaff").click(function() {
			let staff_no = $("#staff_no").val();
			if (confirm("정말 삭제하시겠습니까?")) {
				$.post({
					url : "/staffDel",
					cache : false,
					data : {
						"staff_no" : staff_no
					},
					dataType : "json"
				}).done(function(data) {
					let result = data.result;
					if (result == 1) {
						$("#staffDetailModal").modal("hide");
						alert("삭제가 완료되었습니다.");
						var pagenum = $("#pagenum").val();
						let searchValue = $("#search_value").val();
						page(pagenum, searchName2, searchValue);
					} else {
						alert("문제가 발생했습니다. \n다시 시도해주세요.");
					}
				}).fail(function(xhr, status, errorThrown) {
					alert("실패");
				});
			}
		});

		$("#search_btn").click(function() {
			let searchName = $("#search_name").val();
			let searchValue = $.trim($("#search_value").val());
			let staff_grade=$("#staff_grade2").val();
			$("#search_value").val(searchValue);
			if (searchName == "all" && searchValue == "" || staff_grade == "") {
				location.href = "/staffList";
			}

			if((searchName == "id" || searchName == "tel"|| searchName == "name"|| searchName == "email") && searchValue == "" ){
				alert("검색어를 입력하세요.");
				return false;
			}
			searchForm.submit();

		});

		
		
		
		
		
	});

	function page(idx, search_name, search_value) {
		var pagenum = idx;
		let searchName = search_name;
		let searchValue = search_value;
		var contentnum = $("#contentnum").val();
		location.href = "${pageContext.request.contextPath}/staffList?pagenum="
				+ pagenum + "&contentnum=" + contentnum + "&search_name="
				+ searchName + "&search_value=" + searchValue;

	}
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
					<div class="mb-1"
						style="font-size: 13px; margin-top: -10px; padding-left: 8px;">
						<a href="/index" style="text-decoration: none;"
							class="text-gray-600"><i class="fa-solid fa-house-chimney"></i></a>&nbsp;&nbsp;<i
							class="fa-sharp fa-solid fa-chevron-right"></i>&nbsp; <a
							href="/staffList" style="text-decoration: none;"
							class="text-gray-700">직원관리</a>
					</div>


					<!-- DataTales Example -->
					<div class="card shadow mb-4">

						<div class="card-body" style="height: 725px;">
							<div class="d-flex justify-content-end"
								style="margin-top: -10px;">
								<form action="/staffList" name="searchForm"
									onsubmit="return false" method="get">
									<div class="mb-2 mt-3">
										<input type="hidden" name="contentnum" id="contentnum"
											value="${page.getContentnum()}">
										<div class="input-group">
											<input type="hidden" value="${search.getStaff_grade() }"
														name="staff_grade" id="staff_grade2">
											<input type="hidden" value="${search.getSearch_name() }"
												id="searchName"> <select
												class="form-control col-md-4" name="search_name"
												id="search_name" style="border-radius: 5px 0 0 5px">
												<option value="all" selected>전체</option>
												<option value="name">이름</option>
												<option value="id">아이디</option>
												<option value="tel">전화번호</option>
												<option value="email">이메일</option>
											</select> <input type="text" name="search_value" id="search_value"
												value="${search.getSearch_value() }"
												class="form-control border-gray col-md-8"
												placeholder="검색어를 입력하세요">
											<div class="input-group-append">
												<button class="btn btn-primary" type="button"
													id="search_btn">
													<i class="fas fa-search"></i>
												</button>
											</div>
										</div>
									</div>
								</form>
							</div>
							<div class="table-responsive">
								<table class="table table-bordered text-center" id="dataTable"
									width="100%" cellspacing="0">
									<thead>
										<tr class="bg-gray-200">
											<th class="col-1">번호</th>
											<th class="col-2">이름</th>
											<th class="col-2">ID</th>
											<th class="col-3">전화번호</th>
											<th class="col-3">이메일</th>
											<th class="col-1">
												<form action="/staffList" method="get">
													<input type="hidden" value="${search.getSearch_name() }"
														 name="search_name">
													<input type="hidden" value="${search.getSearch_value() }"
														name="search_value">
													<div class="dropdown">
														<button class="btn dropdown-toggle" type="button"
															data-bs-toggle="dropdown" aria-expanded="false"
															style="font-size: 16px; font-weight: bold;height:20px; vertical-align:-1px;line-height:1px;">직책</button>
														<ul class="dropdown-menu">
															<li>
																<button type="submit" class="dropdown-item btn btn-sm "
																	name="staff_grade" value="doctor" id="sortbtn">의사</button>
															</li>
															<li>
																<button type="submit" class="dropdown-item btn btn-sm "
																	name="staff_grade" value="technician">테크니션</button>
															</li>
															<li>
																<button type="submit" class="dropdown-item btn btn-sm "
																	name="staff_grade" value="admin">관리자</button>
															</li>
														</ul>
													</div>
												</form>
											</th>
										</tr>
									</thead>

									<tbody id="tbody1">
										<c:forEach items="${staffList }" var="sl">
											<tr>
												<td>${sl.sno }</td>
												<td><a href="#" style="text-decoration: none;"
													class="staffDetailModal" data-toggle="modal"
													data-value="${sl.staff_no }"> ${sl.staff_name }</a></td>
												<td>${sl.staff_id }</td>
												<td>${sl.s_Tel}</td>
												<td>${sl.staff_email }</td>
												<c:choose>
													<c:when test="${sl.staff_grade eq 'doctor' }">
														<td>의사</td>
													</c:when>
													<c:when test="${sl.staff_grade eq 'admin' }">
														<td>관리자</td>
													</c:when>
													<c:when test="${sl.staff_grade eq 'technician' }">
														<td>테크니션</td>
													</c:when>
												</c:choose>
											</tr>
										</c:forEach>
										<c:if test="${page.getTotalcount() eq 0}">
											<tr>
												<td colspan="6">데이터가 없습니다.</td>
											</tr>
										</c:if>
									</tbody>
								</table>
							</div>
							<input type="hidden" id="pagenum" value="${param.pagenum }">
							<c:if test="${page.getTotalcount() ne 0}">
								<div class="mt-3">
									<nav aria-label="Page navigation example">
										<ul class="pagination justify-content-center">

											<c:if test="${page.prev}">
												<li class="page-item"><a class="page-link"
													href="javascript:page('${page.getStartPage()-1}','${search.getSearch_name()}','${search.getSearch_value()}');"
													aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
												</a></li>
											</c:if>
											<c:forEach begin="${page.getStartPage()}"
												end="${page.getEndPage()}" var="idx">
												<c:choose>
													<c:when test="${idx ne page.pagenum+1 }">
														<li class="page-item"><a class="page-link"
															href="javascript:page('${idx}','${search.getSearch_name()}','${search.getSearch_value()}');">${idx }</a></li>
													</c:when>
													<c:otherwise>
														<li class="page-item active"><a class="page-link"
															href="javascript:page('${idx}','${search.getSearch_name()}','${search.getSearch_value()}');">${idx }</a></li>
													</c:otherwise>
												</c:choose>
											</c:forEach>
											<c:if test="${page.next}">
												<li class="page-item"><a class="page-link"
													href="javascript:page('${page.getEndPage()+1}','${search.getSearch_name()}','${search.getSearch_value()}');"
													aria-label="Next"> <span aria-hidden="true">&raquo;</span>
												</a></li>
											</c:if>
										</ul>
									</nav>
								</div>

							</c:if>
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
				data-backdrop="static" role="dialog"
				aria-labelledby="exampleModalLabel" aria-hidden="true">
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

			<!-- 수납현황 목록 드롭다운 -->
			<script
				src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"
				integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3"
				crossorigin="anonymous"></script>
			<script
				src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.min.js"
				integrity="sha384-cuYeSxntonz0PPNlHhBs68uyIAVpIIOZZ5JqeqvYYIcEL727kskC66kF92t6Xl2V"
				crossorigin="anonymous"></script>
</body>

</html>
