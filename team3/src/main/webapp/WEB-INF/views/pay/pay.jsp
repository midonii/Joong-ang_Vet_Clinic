<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


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

<title>중앙동물병원</title>
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
<!-- <script src="//code.jquery.com/jquery.min.js"></script> -->
<link
	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">
<!-- Custom styles for this template-->
<link href="css/sb-admin-2.min.css" rel="stylesheet">
<!-- <script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script> -->
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>

<script>
	/* 수납대기 버튼 */
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
		/* 수납완료 버튼 */

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

		//날짜 선택시 오늘까지만 제한주기
		var now_utc = Date.now()
		var timeOff = new Date().getTimezoneOffset() * 60000;
		var today = new Date(now_utc - timeOff).toISOString().split("T")[0];
		$("#fromDate").attr("max", today);
		$("#toDate").attr("max", today);
		
		//기간 설정시 종료일 제한 
		$("#fromDate").change(function(){
			var fromdate = $("#fromDate").val();
			$("#toDate").attr("min", fromdate);
		});
		
		//검색후 입력한 값 잡고있기
		if ($("#hidden_search").val() != null) {
			var searchname = $("#hidden_search").val();
			$("#search_name").val(searchname);
		}

		//당일 버튼 클릭시 오늘날짜 잡기
		$("#filterDate").click(function() {
			$("#todayDate").val(today);
		});

	}); //func
</script>
<style type="text/css">
.paging-div {
	padding: 15px 0 5px 10px;
	display: table;
	margin-left: auto;
	margin-right: auto;
	text-align: center;
}

#btn_ra {
	border-radius: 0 3px 3px 0;
}

.headtotal {
	position: relative;
}

#form2 {
	margin-left: 11px;
}

#form3 {
	position: absolute;
	right: 15px;
}

#fromDate,#toDate {
	width: 250px;
}

#search_name {
	width: 150px;
}

.table {
	text-align: center;
}
</style>
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
			<!-- 본문 시작 -->
			<div class="container-fluid">
				<!-- 데이터테이블 시작 -->
				<div class="card shadow mb-4">
					<div class="card-header py-3">
						<h6 class="m-0 font-weight-bold text-primary">수납</h6>
					</div>
					<div class="card-body">
						<!--날짜 조회  -->
						<div class="row headtotal">
							<form action="/pay" method="get" id="form2">
								<div class="mb-3">
									<div class="input-group">
										<input type="date"
											class="form-control form-control-sm col-md-6 " id="fromDate"
											name="fromDate" value="${cri.getFromDate() }">
										 <input type="date" class="form-control form-control-sm col-md-6"
											id="toDate" name="toDate" value="${cri.getToDate() }">
										<div class="input-group-append">
											<button class="btn btn-primary btn-sm" type="submit"
												id="btn_ra">조회</button>
										</div>
									</div>
								</div>
							</form>
							<form action="/pay" method="get">
								<input type="hidden" name="todayDate"  id="todayDate">
								<button type="submit" id="filterDate" class="btn btn-primary btn-sm ml-2">당일</button>
							</form>
							<!--input group -->
							<!-- 검색  -->
							<form action="/pay" method="get" id="form3">
								<div class="mb-2 mt-1">
									<div class="input-group">
										<input type="hidden" value="${cri.getSearch_name() }"
											id="hidden_search"> <select
											class="form-control form-control-sm col-md-3"
											name="search_name" id="search_name">
											<option value="" selected disabled="disabled">선택</option>
											<option value="petname">동물명</option>
											<option value="ownername">보호자명</option>
											<option value="chartno">차트번호</option>
										</select> <input type="text"
											class="form-control form-control-sm border-gray col-md-9"
											placeholder="검색어를 입력하세요" name="search_content"
											value="${cri.getSearch_content()}">
										<div class="input-group-append">
											<button class="btn btn-primary btn-sm" type="submit">
												<i class="fas fa-search"></i>
											</button>
										</div>
									</div>
								</div>
							</form>
						</div>

						<div class="table-responsive">
							<table class="table table-bordered" width="100%" cellspacing="0">
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
														<button type="button"
															class="btn btn-outline-primary btn-sm payCancel"
															value="${pl.pay_no }">수납완료</button>

													</td>
												</c:if>
												<c:if test="${pl.pay_yn eq 'N'}">
													<td>
														<button type="button"
															class="btn btn-outline-danger btn-sm payBefore"
															value="${pl.pay_no }">수납대기</button>
													</td>
												</c:if>


												<td><buttton type="submit" id="detailBtn" name="payNo"
														class="btn btn-primary btn-sm" value="${pl.pay_no }"
														onclick="location.href='/payDetail?payNo='+'${pl.pay_no }'">상세보기</buttton></td>
											</tr>
										</c:forEach>
									</form>
								</tbody>
							</table>
							<ul class="paging">
								<c:if test="${paging.prev}">
									<span><a
										href='<c:url value="/pay?page=${paging.startPage-1}"/>'>이전</a></span>
								</c:if>
								<c:forEach begin="${paging.startPage}" end="${paging.endPage}"
									var="num">
									<span><a href='<c:url value="/pay?page=${num}"/>'>${num}</a></span>
								</c:forEach>
								<c:if test="${paging.next && paging.endPage>0}">
									<span><a
										href='<c:url value="/pay?page=${paging.endPage+1}"/>'>다음</a></span>
								</c:if>
							</ul>

						</div>
					</div>
				</div>

				<!-- /.container-fluid -->

			</div>
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
