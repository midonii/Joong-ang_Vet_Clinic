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
	function page(idx, search_name, search_value) {
		var pagenum = idx;
		let searchValue = search_value;
		let searchName = search_name;
		var contentnum = $("#contentnum").val();
		location.href = "${pageContext.request.contextPath}/inspection?pagenum="
				+ pagenum
				+ "&contentnum="
				+ contentnum
				+ "&search_name="
				+ searchName + "&search_value=" + searchValue;

	}

	$(function() {
		$("#addBtn").click(function() {

			var medical_name = $.trim($("#medical_name").val());
			$("#medical_name").val(medical_name);
			var medical_price = $.trim($("#medical_price").val());
			$("#medical_price").val(medical_price);
			var medical_category = $("#medical_category").val();
			var medical_subcate = $("#medical_subcate").val();

			if (medical_name == "") {
				alert("진료명을 입력해주세요.");
				$("#medical_name").focus();
				return false;
			}

			if (medical_subcate == null) {
				alert("분류항목을 선택해주세요.");
				$("#medical_subcate").focus();
				return false;
			}
			if (medical_price == "" || $.isNumeric(medical_price) == false) {
				alert("처방가격을 올바르게 입력해주세요.");
				$("#medical_price").focus();
				return false;
			}

		});

		$(".inspectionUpdate").click(function() {
			var medical_no = $(this).attr("value");
			$.post({
				url : "/medicalDetail",
				cache : false,
				data : {
					"medical_no" : medical_no
				},
				dataType : "json"
			}).done(function(data) {
				let result = data.result;
				if (confirm("수정하시겠습니까?")) {

					$("#inspection_noU").val(result.medical_no);
					$("#inspection_nameU").val(result.medical_name);
					$("#inspection_priceU").val(result.medical_price);
					$("#medical_subcateU").val(result.medical_subcate);

					$("#updateModal").modal("show"); //수정화면 모달 보기
				}
			}).fail(function(xhr, status, errorThrown) {
				alert("실패");
			});
		});
		$(".updateFrm").click(function() {

			let medical_no = $("#inspection_noU").val();
			let medical_name = $.trim($("#inspection_nameU").val());
			let medical_price = $.trim($("#inspection_priceU").val());
			let medical_subcate = $("#medical_subcateU").val();

			$.post({
				url : "/medicalUpdate",
				data : {
					"medical_no" : medical_no,
					"medical_name" : medical_name,
					"medical_price" : medical_price,
					"medical_subcate" : medical_subcate
				},
				dataType : "json"
			}).done(function(data) {
				if (data.result == 1) {
					alert("수정이 완료되었습니다.");
					$("#updateModal").modal("hide");
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

		$("#search_btn").click(function() {
			let searchValue = $.trim($("#search_value").val());
			let searchName = $("#search_name").val();
			$("#search_value").val(searchValue);
			
			if (searchName == "all" && searchValue == "") {
				location.href="/inspection";
			}
			
			if((searchName == "name" || searchName == "category") && searchValue == "" ){
				alert("검색어를 입력하세요.");
				return false;
			}
			
			searchForm.submit();
		});

		let searchName2 = $("#searchName").val();
		if (searchName2 == "") {
			$("#search_name option[value='all']").attr('selected', 'selected');
		} else {
			$("#search_name").val(searchName2);
		}

		$(".medicalDel").click(function() {
			var medical_no = $(this).attr("value");
			if (confirm("정말 삭제하시겠습니까?")) {
				$.post({
					url : "/medicalDel",
					cache : false,
					data : {
						"medical_no" : medical_no
					},
					dataType : "json"
				}).done(function(data) {
					let result = data.result;
					if (result == 1) {
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
					<div class="mb-1"
						style="font-size: 13px; margin-top: -10px; padding-left: 8px;">
						<a href="/index" style="text-decoration: none;"
							class="text-gray-600"><i class="fa-solid fa-house-chimney"></i></a>&nbsp;&nbsp;<i
							class="fa-sharp fa-solid fa-chevron-right"></i>&nbsp; <a
							href="/medicine" style="text-decoration: none;"
							class="text-gray-700">관리자(데이터 관리)</a>&nbsp;&nbsp;<i
							class="fa-sharp fa-solid fa-chevron-right"></i> &nbsp;<a
							href="/inspection" style="text-decoration: none;"
							class="text-gray-700">진료</a>
					</div>

					<!-- DataTales Example -->
					<div class="card shadow mb-4">
						<div class="card-header py-3">
							<h6 class="m-0 font-weight-bold text-primary">데이터관리</h6>

						</div>

						<div class="card-body">
							<div style="margin-top: -5px;">
								<ul class="nav nav-tabs">
									<li class="nav-item"><a class="nav-link"
										aria-current="page" href="/medicine" tabindex="0">약품</a></li>
									<li class="nav-item "><a
										class="nav-link  active font-weight-bolder text-primary"
										href="/inspection">진료</a></li>
									<li class="nav-item"><a class="nav-link" href="/vaccine">접종</a></li>
									<li class="nav-item"><a class="nav-link" href="/petType">견종</a></li>
								</ul>
							</div>
							<div class="row justify-content-center">

								<!-- 데이터 추가 -->
								<div class="border-right col-4 col-md-4"
									style="padding: 10px; height: 570px;">
									<form id="mediAddFrm" name="mediAddFrm" action="/inspectionAdd"
										method="post">
										<input type="hidden" value="진료" id="medical_category"
											name="medical_category">
										<ul class="list-group list-group-flush">
											<li class="list-group-item">
												<div class="row">
													<div class="col-md-12 text-center font-weight-bold text-lg"
														style="line-height: 38px;">진료데이터 추가</div>

												</div>
											</li>
											<li class="list-group-item">
												<div class="row">
													<div class="col-md-3 text-center"
														style="line-height: 38px;">진료명</div>
													<div class="col-md-9">
														<input type="text" class="form-control" id="medical_name"
															name="medical_name">
													</div>
												</div>
											</li>
											<li class="list-group-item">
												<div class="row">
													<div class="col-md-3 text-center "
														style="line-height: 40px;">분류</div>
													<div class="col-md-9">
														<select class="form-control" id="medical_subcate"
															name="medical_subcate">
															<option selected disabled="disabled">선택</option>
															<c:forEach items="${subcate}" var="sc">
																<option value="${sc }">${sc }</option>
															</c:forEach>
														</select>
													</div>

												</div>
											</li>
											<li class="list-group-item mb-4">
												<div class="row">
													<div class="col-md-3 text-center"
														style="line-height: 38px;">처방가격</div>
													<div class="col-md-9">
														<input type="text" class="form-control" id="medical_price"
															name="medical_price">
													</div>
												</div>
											</li>
										</ul>


										<div class="d-flex justify-content-center">
											<button type="submit" id="addBtn"
												class="btn btn-primary col-5">저장</button>
										</div>
									</form>
								</div>

								<!-- 리스트 출력 -->
								<div class="col-8 col-md-8"
									style="overflow: auto; height: 570px; padding: 10px;">

									<form action="/inspection" name="searchForm"
										onsubmit="return false" method="get">
										<input type="hidden" name="contentnum" id="contentnum"
											value="${page.getContentnum()}">
										<div class="input-group mb-3">
											<input type="hidden" value="${search.getSearch_name() }"
												id="searchName"> <select
												class="form-control col-md-3" name="search_name"
												id="search_name" style="border-radius: 5px 0 0 5px">
												<option value="all" selected>전체</option>
												<option value="name">진료명</option>
												<option value="category">분류</option>
											</select> <input type="text"
												class="form-control border-gray col-md-12"
												name="search_value" id="search_value"
												value="${search.getSearch_value() }"
												placeholder="검색어를 입력하세요">
											<div class="input-group-append">
												<button class="btn btn-primary" type="button"
													id="search_btn">
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
													<th class="col-2">분류</th>
													<th class="col-3">진료명</th>
													<th class="col-2">처방가격</th>
													<th class="col-1"></th>

												</tr>
											</thead>

											<tbody>
												<c:forEach items="${medicalList }" var="ml">
													<tr>
														<td>${ml.mno }</td>
														<td>${ml.medical_subcate }</td>
														<td>${ml.medical_name }</td>
														<td><fmt:formatNumber value="${ml.medical_price }"
																pattern="#,###" />원</td>
														<td>
															<button type="button"
																class="btn btn-circle btn-sm btn-warning inspectionUpdate"
																value="${ml.medical_no }">
																<i class="fa-solid fa-pen"></i>
															</button>
															<button type="button" value="${ml.medical_no }"
																class="btn btn-circle btn-sm btn-danger medicalDel">
																<i class="fa-solid fa-trash"></i>
															</button>
														</td>
													</tr>
												</c:forEach>

												<c:if test="${page.getTotalcount() eq 0}">
													<tr>
														<td colspan="5">검색 결과가 없습니다.</td>
													</tr>
												</c:if>
											</tbody>
										</table>
									</div>
									<input type="hidden" id="pagenum" value="${param.pagenum }">
									<c:if test="${page.getTotalcount() ne 0}">
										<nav aria-label="Page navigation example">
											<ul class="pagination pagination-sm justify-content-center">

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
									</c:if>


								</div>
							</div>
						</div>
					</div>
				</div>



				<!-- /.container-fluid -->

			</div>
			<!-- End of Main Content -->

			<%@ include file="../bar/footer.jsp"%>

			<%@ include file="../bar/logoutModal.jsp"%>


			<!-- 검사 데이터 수정 Modal-->
			<div class="modal fade" id="updateModal" tabindex="-1" role="dialog"
				aria-labelledby="exampleModalLabel" aria-hidden="true">
				<div class="modal-dialog" role="document">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="exampleModalLabel">진료 데이터 수정</h5>
							<button class="close" type="button" data-dismiss="modal"
								aria-label="Close">
								<span aria-hidden="true">×</span>
							</button>
						</div>
						<div class="modal-body">
							<input type="hidden" id="inspection_noU" name="inspection_noU">

							<ul class="list-group list-group-flush">
								<li class="list-group-item">
									<div class="row">
										<div class="col-md-3 text-center" style="line-height: 38px;">진료명</div>
										<div class="col-md-9">
											<input type="text" class="form-control" id="inspection_nameU"
												name="inspection_nameU">
										</div>
									</div>
								</li>
								<li class="list-group-item">
									<div class="row">
										<div class="col-md-3 text-center" style="line-height: 38px;">처방가격</div>
										<div class="col-md-9">
											<input type="text" class="form-control"
												id="inspection_priceU" name="inspection_priceU">
										</div>
									</div>
								</li>
								<li class="list-group-item mb-4">
									<div class="row">
										<div class="col-md-3 text-center" style="line-height: 40px;">분류</div>
										<div class="col-md-9">
											<select class="form-control" id="medical_subcateU"
												name="medical_subcateU">
												<c:forEach items="${subcate}" var="sc">
													<option value="${sc }">${sc }</option>
												</c:forEach>
											</select>
										</div>

									</div>
								</li>
							</ul>
						</div>
						<div class="modal-footer">
							<button type="submit" class="btn btn-primary updateFrm">수정</button>
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
