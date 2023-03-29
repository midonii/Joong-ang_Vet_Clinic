<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="en">
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
<link rel="shortcut icon" type="image/x-icon" href="../img/favicon.png" />
<link rel="stylesheet"
	href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css">
<link
	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">
	
<!-- Custom styles for this template-->
<link href="css/sb-admin-2.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://kit.fontawesome.com/a31e2023c3.js"
	crossorigin="anonymous"></script>
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
		$("#fromDate").change(function() {
			var fromdate = $("#fromDate").val();
			$("#toDate").attr("min", fromdate);
		}); 

		//검색후 입력한 값 잡고있기
		 let searchName2 = $("#hidden_search").val();
	 	if(searchName2 == ""){
	 		$("#search_name option[value='all']").attr('selected', 'selected');
	 	}else{
	 		$("#search_name").val(searchName2);
	 		} 

		//당일 버튼 클릭시 오늘날짜 잡기
		$("#todaybtn").click(function() {
			$("#todayDate").val(today);
		});
		
		
		
	}); //func
	/* 페이징 번호 버튼 누를시 보낼 값 */
	function page(idx, search_name, search_value, fromDate, toDate, todayDate, pay_yn) {
		var pagenum = idx;
		var contentnum = $("#contentnum").val();
		let searchName = search_name;
		let searchValue = search_value;
		location.href = "${pageContext.request.contextPath}/pay?pagenum="
				+ pagenum + "&contentnum=" + contentnum + "&fromDate="
				+ fromDate + "&toDate=" + toDate + "&search_name=" + searchName
				+ "&search_value=" + searchValue + "&todayDate=" + todayDate +"&pay_yn=" +pay_yn;

	};
	
</script>
<style type="text/css">


#btn_ra {
	border-radius: 0 3px 3px 0;
}

.headtotal {
	position: relative;
}

#dateform {
	margin-left: 11px;
	width: 500px;
}

#searchform {
	position: absolute;
	right: 15px;
}

#search_name {
	width: 150px;
}

.table {
	text-align: center;
}

/* #sortbtn:hover{
	background-color: #ccc;
} 
.test{
	width:74px;
} */ 
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
								<form action="/pay" method="get" id="dateform">
									<input type="hidden" name="contentnum" id="contentnum"
										value="${page.getContentnum()}">
									<div class="mb-3">
										<div class="input-group">
											<input type="date"
												class="form-control form-control-sm col-md-6" id="fromDate"
												name="fromDate" value="${param.fromDate}"> <input
												type="date" class="form-control form-control-sm col-md-6"
												id="toDate" name="toDate" value="${param.toDate}">
											<div class="input-group-append">
												<button class="btn btn-primary btn-sm" type="submit"
													id="btn_ra">조회</button>
											</div>
										</div>
									</div>
								</form>
								<form action="/pay" method="get">
									<input type="hidden" name="contentnum" id="contentnum"
										value="${page.getContentnum()}">
									 <input type="hidden" name="todayDate" id="todayDate">
									<button type="submit" id="todaybtn"
										class="btn btn-primary btn-sm ml-2">당일</button>
								</form>
								<!--input group -->
								
								<!-- 검색  -->
								<form action="/pay" method="get" id="searchform">
									<input type="hidden" name="contentnum" id="contentnum"
										value="${page.getContentnum()}">
									<div class="mb-2 mt-1">
										<div class="input-group">
											<input type="hidden" value="${page.getSearch_name() }"
												id="hidden_search"> 
											<select class="form-control form-control-sm col-md-3"
												name="search_name" id="search_name" style="border-radius: 3px 0 0 3px;">
												<option value="all">전체</option>
												<option value="petname">동물명</option>
												<option value="ownername">보호자명</option>
												<option value="chartno">차트번호</option>
											</select> 
											<input type="text"
												class="form-control form-control-sm border-gray col-md-9"
												placeholder="검색어를 입력하세요" name="search_value"
												value="${param.search_value}">
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
								<table class="table table-bordered " width="100%" cellspacing="0" >
									<thead>
										<tr class="bg-gray-100" style="height: 55px;">
											<th>번호</th>
											<th>차트번호</th>
											<th>동물명</th>
											<th>보호자명</th>
											<th>수납금액</th>
											<th> <!--수납현황 sort -->
											<form action="/pay" method="get">
												<div class="dropdown">
													<button class="btn btn-sm dropdown-toggle" 	type="button" data-bs-toggle="dropdown"
														aria-expanded="false" style="font-size: 16px; font-weight: bold;">
														수납현황</button>
													<ul class="dropdown-menu">
														<li>
														<button type="submit"  class="dropdown-item btn btn-sm " name="pay_yn"
																value="" id="sortbtn">전체보기</button></li>
														<li>
														<button type="submit"  class="dropdown-item btn btn-sm " name="pay_yn"
																value="N" id="sortbtn">수납대기</button></li>
														<li>
														<button type="submit" class="dropdown-item btn btn-sm " name="pay_yn"
																value="Y" id="sortbtn">수납완료</button></li>
													</ul>
												</div>
											</form>
											</th>
											<th>수납시간</th>
											<th>상세보기</th>
										</tr>
									</thead>
									<tbody>
										<form action="/payDetail" method="get">
											<c:forEach items="${payList }" var="pl">
												<tr>
													<td>${pl.rownum}</td>
													<td>${pl.chart_no }</td>
													<td>${pl.pet_name }</td>
													<td>${pl.owner_name }</td>
													<td><fmt:formatNumber value="${pl.totalPrice }"
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
													<td>${pl.listpay_date }</td>
													<td><buttton type="submit" id="detailBtn" name="payNo"
															class="btn btn-primary btn-sm" value="${pl.pay_no }"
															onclick="location.href='/payDetail?payNo='+'${pl.pay_no }'+'&chart_no='+'${pl.chart_no }'">상세보기</buttton></td>
												</tr>
											</c:forEach>
										</form>
									</tbody>
								</table>
								<!-- 페이징 -->
								<c:if test="${page.getTotalcount() ne 0}">
									<div class="mt-3">
										<nav aria-label="Page navigation example">
											<ul class="pagination justify-content-center">

												<c:if test="${page.prev}">
													<li class="page-item"><a class="page-link"
														href="javascript:page('${page.getStartPage()-1}','${page.getSearch_name()}','${page.getSearch_value()}',
													'${page.getFromDate() }','${page.getToDate() }','${page.getTodayDate() }','${page.getPay_yn() }');"
														aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
													</a></li>
												</c:if>
												
												<c:forEach begin="${page.getStartPage()}"
													end="${page.getEndPage()}" var="idx">
													<c:choose>
														<c:when test="${idx ne page.pagenum / 10 +1 }">
															<li class="page-item"><a class="page-link"
																href="javascript:page('${idx }','${page.getSearch_name()}','${page.getSearch_value()}',
															'${page.getFromDate()}','${page.getToDate() }','${page.getTodayDate()}','${page.getPay_yn() }');">${idx }</a></li>
														</c:when>
														<c:otherwise>
															<li class="page-item active"><a class="page-link"
																href="javascript:page('${idx }','${page.getSearch_name()}','${page.getSearch_value()}',
															'${page.getFromDate() }','${page.getToDate() }','${page.getTodayDate() }','${page.getPay_yn() }');">${idx }</a></li>
														</c:otherwise>
													</c:choose>
												</c:forEach>
												<c:if test="${page.next}">
													<li class="page-item"><a class="page-link"
														href="javascript:page('${page.getEndPage()+1}','${page.getSearch_name()}','${page.getSearch_value()}',
													'${page.getFromDate() }','${page.getToDate() }','${page.getTodayDate() }','${page.getPay_yn() }');"
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
			
			<!-- 수납현황 목록 드롭다운 -->
			<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js" integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3" crossorigin="anonymous"></script>
			<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.min.js" integrity="sha384-cuYeSxntonz0PPNlHhBs68uyIAVpIIOZZ5JqeqvYYIcEL727kskC66kF92t6Xl2V" crossorigin="anonymous"></script>
</body>

</html>
