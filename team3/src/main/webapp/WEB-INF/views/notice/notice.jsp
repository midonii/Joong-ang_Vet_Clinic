<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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

<title>Team 3</title>
<link rel="stylesheet"
	href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<!-- Custom fonts for this template-->
<script src="https://kit.fontawesome.com/a31e2023c3.js"
	crossorigin="anonymous"></script>
<link
	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">

<!-- Custom styles for this template-->

<link href="css/sb-admin-2.min.css" rel="stylesheet">
<script type="text/javascript"
	src="cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
<!-- JQUERY -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>


<script type="text/javascript">
	function page(idx, search_name, search_value) {
		var pagenum = idx;
		let searchName = search_name;
		let searchValue = search_value;
		var contentnum = $("#contentnum").val();
		location.href = "${pageContext.request.contextPath}/notice?pagenum="
				+ pagenum + "&contentnum=" + contentnum + "&search_name="
				+ searchName + "&search_value=" + searchValue;

	}

	$(function() {
		$("#noticeWrite").click(function() {
			$("#noticeWriteModal").modal("show");
		});

		let searchName2 = $("#searchName").val();
		$("#search_name").val(searchName2);

		$(".refresh").click(function() {
			location.href = "/notice";
		});

		$("#search_btn").click(function() {
			let searchName = $("#search_name").val();
			let searchValue = $("#search_value").val();
			// 		alert(searchName + " ::" +searchValue);

			if (searchName == 0) {
				alert("검색하시려는 항목을 선택하세요");
				return false;
			}

			if (searchValue == "" || searchValue.length < 2) {
				alert("검색어를 입력하세요.\n2글자 이상입력하세요.");
				return false;
			}
			searchForm.submit();
		});

		$(".noticeWrite").click(function() {
			let notice_title = $("#notice_title").val();
			let notice_content = $("#notice_content").val();

			$.post({
				url : "/noticeWrite",
				data : {
					"notice_title" : notice_title,
					"notice_content" : notice_content
				},
				dataType : "json"
			}).done(function(data) {
				if (data.result == 1) {
					alert("글쓰기가 완료되었습니다.");
					$("#noticeWriteModal").modal("hide");
					location.href = "/notice";

				} else {
					alert("문제가 발생했습니다. \n다시 시도해주세요.");
				}
			}).fail(function() {
				alert("문제발생");
			});
		});

		$(".noticeDetailModal").click(function() {
			$("#noticeDetailModal").modal("show");
			var notice_no = $(this).attr("data-value");
			$.post({
				url : "/noticeDetail",
				cache : false,
				data : {
					"notice_no" : notice_no
				},
				dataType : "json"
			}).done(function(data) {
				let result = data.result;
				let read = data.read;
				if (read == 1) {
					$("#D_no").val(result.notice_no);
					$("#D_title").text(result.notice_title);
					$("#D_content").text(result.notice_content);
					$("#D_date").text(result.listdate);
					$("#D_read").text(result.notice_read);
					$("#D_name").text(result.staff_name);
				}
			}).fail(function(xhr, status, errorThrown) {
				alert("실패");
			});
		});

		$(".noticeDelete").click(function() {
			var notice_no = $("#D_no").val();

			$.post({
				url : "/noticeDelete",
				cache : false,
				data : {
					"notice_no" : notice_no
				},
				dataType : "json"
			}).done(function(data) {
				if (data.result == 1) {
					$("#noticeDetailModal").modal("hide");
					location.href = "/notice";
				}
			}).fail(function(xhr, status, errorThrown) {
				alert("실패");
			});

		});

		$(".noticeUpdate").click(function() {
			var notice_no = $("#D_no").val();
			$.post({
				url : "/noticeDetailU",
				cache : false,
				data : {
					"notice_no" : notice_no
				},
				dataType : "json"
			}).done(function(data) {
				let result = data.result;
				if (confirm("수정하시겠습니까?")) {
					$("#noU").val(result.notice_no);
					$("#titleU").val(result.notice_title);
					$("#contentU").val(result.notice_content);
					$("#noticeDetailModal").modal("hide");
					$("#noticeUpdateModal").modal("show");
				}
			}).fail(function(xhr, status, errorThrown) {
				alert("실패");
			});

		});

		$("#noticeUpdate").click(function() {
			var notice_no = $("#noU").val();
			var notice_title = $("#titleU").val();
			var notice_content = $("#contentU").val();

			$.post({
				url : "/noticeUpdate",
				data : {
					"notice_no" : notice_no,
					"notice_title" : notice_title,
					"notice_content" : notice_content
				},
				dataType : "json"
			}).done(function(data) {
				let result = data.result;
				if (data.result2 == 1) {
					alert("수정이 완료되었습니다.");
					$("#noticeUpdateModal").modal("hide");
					$("#D_no").val(result.notice_no);
					$("#D_title").text(result.notice_title);
					$("#D_content").text(result.notice_content);
					$("#D_date").text(result.listdate);
					$("#D_read").text(result.notice_read);
					$("#D_name").text(result.staff_name);
					$("#noticeDetailModal").modal("show");
				} else {
					alert("문제가 발생했습니다. \n다시 시도해주세요.");
				}
			}).fail(function() {
				alert("문제발생");
			});

		});

	});
</script>
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
							href="/notice" style="text-decoration: none;"
							class="text-gray-700">공지사항</a>
					</div>



					<!-- DataTales Example -->
					<div class="card shadow mb-1">




						<!-- <div class="card-header py-3">
							<h6 class="m-0 font-weight-bold text-primary">공지사항</h6>
						</div>  -->
						<div class="card-body">

							<div class="d-flex justify-content-between"
								style="margin-top: -10px;">
								<form action="/notice" name="searchForm" onsubmit="return false"
									method="get">
									<div class="mb-2 mt-3">
										<input type="hidden" name="contentnum" id="contentnum"
											value="${page.getContentnum()}">
										<div class="input-group">
											<input type="hidden" value="${search.getSearch_name() }"
												id="searchName"> <select
												class="form-control col-md-3" name="search_name"
												id="search_name" style="border-radius: 5px 0 0 5px">
												<option value="" selected disabled="disabled">선택</option>
												<option value="title">제목</option>
												<option value="content">내용</option>
											</select> <input type="text" name="search_value" id="search_value"
												value="${search.getSearch_value() }"
												class="form-control border-gray col-md-9"
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
								<c:if test="${sessionScope.staff_grade eq 'admin'}">
									<div class="mb-2 mt-3">
										<button type="button" class="btn btn-primary" id="noticeWrite">글쓰기</button>
									</div>
								</c:if>
							</div>


							<div class="table-responsive">

								<table class="table table-bordered text-center" id="dataTable"
									width="100%" cellspacing="0">
									<thead>
										<tr class="bg-gray-200">
											<th class="col-1">글번호</th>
											<th class="col-6 text-left">제목</th>
											<th class="col-1">글쓴이</th>
											<th class="col-2">날짜</th>
											<th class="col-1">조회수</th>
										</tr>
									</thead>

									<tbody>
										<c:forEach items="${noticeList }" var="nl">
											<tr>
												<td>${nl.nno }</td>
												<td class="text-left"><a href="#"
													style="text-decoration: none;" class="noticeDetailModal"
													data-toggle="modal" data-value="${nl.notice_no }">
														${nl.notice_title}</a></td>
												<td>${nl.staff_name }</td>
												<td>${nl.listdate }</td>
												<td>${nl.notice_read }</td>
											</tr>
										</c:forEach>
									<c:if test="${page.getTotalcount() eq 0}">
										<tr>
											<td colspan="5">데이터가 없습니다.</td>
										</tr>
									</c:if>
									</tbody>
								</table>
							</div>


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
			<%-- 			<%@ include file="bar/logoutModal.jsp" %> --%>



			<!-- 공지사항 글쓰기 Modal-->
			<div class="modal fade" id="noticeWriteModal" data-backdrop="static"
				tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
				aria-hidden="true">
				<div class="modal-dialog modal-lg modal-dialog-centered"
					role="document">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="exampleModalLabel">공지사항 글쓰기</h5>
							<button class="close refresh" type="button" data-dismiss="modal"
								aria-label="Close">
								<span aria-hidden="true">×</span>
							</button>
						</div>
						<div class="modal-body">
							<ul class="list-group list-group-flush">
								<li class="list-group-item">
									<div class="row">
										<input type="text" id="notice_title" name="notice_title"
											class="form-control" placeholder="제목을 입력하세요">
									</div>
								</li>
								<li class="list-group-item">
									<div class="row">
										<textarea class="form-control" rows="18" id="notice_content"
											name="notice_content"></textarea>
									</div>
								</li>
							</ul>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-primary noticeWrite">글쓰기</button>
						</div>
					</div>
				</div>
			</div>

			<!-- 공지사항 상세보기 Modal-->
			<div class="modal fade" id="noticeDetailModal" data-backdrop="static"
				tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
				aria-hidden="true">
				<div class="modal-dialog modal-lg modal-dialog-centered"
					role="document">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="exampleModalLabel">공지사항 상세보기</h5>
							<button class="close refresh" type="button" data-dismiss="modal"
								aria-label="Close">
								<span aria-hidden="true">×</span>
							</button>
						</div>
						<div class="modal-body">
							<input type="hidden" id="D_no" name="D_no">
							<ul class="list-group list-group-flush">
								<li class="list-group-item">
									<div class="row">
										<div
											class="col-md-12 text-lg font-weight-bold text-gray-900 text-center"
											id="D_title"></div>
									</div>
								</li>
								<li class="list-group-item">
									<div class="row">
										<div class="col-md-7">
											<i class="fa-solid fa-user"></i>&nbsp;&nbsp;<span id="D_name"></span>
										</div>
										<div class="col-md-2">
											<i class="fa-solid fa-eye"></i>&nbsp;<span id="D_read"></span>
										</div>
										<div class="col-md-3">
											<i class="fa-regular fa-calendar"></i>&nbsp;<span id="D_date"></span>
										</div>
									</div>
								</li>
								<li class="list-group-item">
									<div class="row">
										<div id="D_content"></div>
									</div>
								</li>

							</ul>
						</div>
						<c:if test="${sessionScope.staff_grade eq 'admin'}">
							<div class="modal-footer">
								<button type="button"
									class="btn btn-outline-warning btn-sm noticeUpdate">수정</button>
								<button type="button"
									class="btn btn-outline-danger btn-sm noticeDelete">삭제</button>
							</div>
						</c:if>
					</div>
				</div>
			</div>

			<!-- 공지사항 수정 Modal-->
			<div class="modal fade" id="noticeUpdateModal" data-backdrop="static"
				tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
				aria-hidden="true">
				<div class="modal-dialog modal-lg modal-dialog-centered"
					role="document">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="exampleModalLabel">공지사항 글쓰기</h5>
							<button class="close refresh" type="button" data-dismiss="modal"
								aria-label="Close">
								<span aria-hidden="true">×</span>
							</button>
						</div>
						<div class="modal-body">
							<ul class="list-group list-group-flush">
								<li class="list-group-item">
									<div class="row">
										<input type="hidden" id="noU" name="noU"> <input
											type="text" id="titleU" name="titleU" class="form-control"
											placeholder="제목을 입력하세요">
									</div>
								</li>
								<li class="list-group-item">
									<div class="row">
										<textarea class="form-control" rows="18" id="contentU"
											name="contentU"></textarea>
									</div>
								</li>
							</ul>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-warning" id="noticeUpdate">수정</button>
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
