<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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

<link rel="stylesheet" href="https://kit.fontawesome.com/a31e2023c3.css"
	crossorigin="anonymous">
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
<!-- include summernote css/js >> jquery 링크 후 사용할것 -->
<link
	href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
</head>
<script type="text/javascript">
	$(function() {
		$("#noticeWrite").click(function() {
			$("#noticeWriteModal").modal("show");
		});

		$(".refresh").click(function() {
			location.href = "/notice";
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
				$("#D_no").val(result.notice_no);
				$("#D_title").text(result.notice_title);
				$("#D_content").text(result.notice_content);
				$("#D_date").text(result.listdate);
				$("#D_read").text(result.notice_read);
				$("#D_name").text(result.staff_name);
				
				
				if(result.staff_grade==<%=session.getAttribute("id")%>){
					$(".detailDelete").show();
					$(".detailUpdate").show();
				}else{
					
				}
			}).fail(function(xhr, status, errorThrown) {
				alert("실패");
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
					<h5 class="h5 mb-4 text-gray-900">
						<b>공지사항</b>
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

									</tbody>
								</table>
							</div>
							<div>
								<button type="button" class="btn btn-primary noticeDelete">삭제</button>
								<button type="button" class="btn btn-primary noticeUpdate">수정</button>
							</div>

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
			<div class="modal fade" id="noticeWriteModal" tabindex="-1"
				role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
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
			<div class="modal fade" id="noticeDetailModal" tabindex="-1"
				role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
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
										<div class="col-md-8">
											<i class="fa-solid fa-user"></i>&nbsp;&nbsp;<span id="D_name"></span>
										</div>
										<div class="col-md-2">
											<i class="fa-solid fa-eye"></i>&nbsp;<span id="D_read"></span>
										</div>
										<div class="col-md-2">
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
						<div class="modal-footer">
							<button type="button" class="btn btn-primary noticeWrite">글쓰기</button>
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
