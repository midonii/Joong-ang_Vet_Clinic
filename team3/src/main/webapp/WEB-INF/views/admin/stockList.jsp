<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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

<!--   <link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css"> -->
<!--    <link rel="stylesheet" href="/resources/demos/style.css"> -->
<!--   <script src="https://code.jquery.com/jquery-3.6.0.js"></script> -->
<!--   <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script> -->

<link rel="stylesheet"
	href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css">

<script src="https://kit.fontawesome.com/a31e2023c3.js"
	crossorigin="anonymous"></script>
<link
	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">

<!-- Custom styles for this template-->
<link href="css/sb-admin-2.min.css" rel="stylesheet">
<style type="text/css">

.row-margin0{
	margin:0;
}

.border-radius{
	border: 1px solid #e3e6f0;
	border-radius: 0.35rem;
}
.search_criteria{
/* 	min-width:150px;  */
	height:35px; 
	text-align:center; 
	line-height:35px;
	margin: 0 0 5px 0;
	background-color: #f8f9fc;
	font-weight: bold;
	font-size:15px;
}
.cursor{
	cursor:pointer;
}
.radio-div{
	width: auto; 
	height:40px; 
	margin:0 15px;
	line-height:35px;
}
.radio{
	margin-top:10px;
	border-color: #f8f9fc;
}

thead {
  display: table; /* to take the same width as tr */
  width: calc(100% - 17px); /* - 17px because of the scrollbar width */
}

tbody {
  display: block; /* to enable vertical scrolling */
  max-height: 466px; /* e.g. */
  overflow-y: scroll; /* keeps the scrollbar even if it doesn't need it; display purpose */
}
tr {
  display: table; /* display purpose; th's border */
  width: 100%;
  box-sizing: border-box; /* because of the border (Chrome needs this line, but not FF) */
}

td {
  text-align: center;
  border-bottom: none;
  border-left: none;
}
</style>
</head>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script type="text/javascript">

$(function(){

	$("#reset").click(function(){
		location.href="/stockList";
	});
	
//-- 조회

	$("#select").click(function(){
		
		var radioValue = $("input[name='stock_radio']:checked").val();
		alert(radioValue);
		
		$.post({
			url : "/stockSelect",
			data : {"radioValue" : radioValue},
			dataType : "json"
		}).done(function(data){
			//alert(data.searchList[0].medical_name);
			$("tbody").empty();
			
			var searchList = data.searchList ;
			
			for(let i = 1 ; i <= searchList.length; i++){
				
				let medical_subcate = data.searchList[i-1].medical_subcate;
				let medical_name = data.searchList[i-1].medical_name;
				let medical_buyEa = data.searchList[i-1].medical_buyEa;
				let medical_company = data.searchList[i-1].medical_company;
				let medical_buying = (data.searchList[i-1].medical_buying).toLocaleString();
				let medical_price = (data.searchList[i-1].medical_price).toLocaleString();
				
				var tr = "<tr>"
							+"<td style='width: 3%'>"+i+"</td>"
							+"<td style='width: 5%'>"+medical_subcate+"</td>"
							+"<td style='width: 10%'>"+medical_name+"</td>"
							+"<td style='width: 5%'>"+"30"+"</td>"
							+"<td style='width: 10%'>"+medical_company+"</td>"
							+"<td style='width: 7%'>"+medical_buying+"</td>"
							+"<td style='width: 5%'>"+medical_buyEa+"</td>"
							+"<td style='width: 7%'>"+medical_price+"</td>"
							+"<td style='width: 5%'>25</td>"
							+"<td style='width: 3%'><i class='xi-border-color' style='color: #4E73DF;'></i></td>";
						+"</tr>"
						
				$(".tbody1").append(tr);
			}
			
		}).fail(function(xhr){
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
				<div class="container-fluid justify-content-md-center">
					<!-- Page Heading -->
					<div class="mb-1"
						style="font-size: 13px; margin-top: -10px; padding-left: 8px;">
						<a href="/index" style="text-decoration: none;"
							class="text-gray-600"> <i class="fa-solid fa-house-chimney"></i>
						</a>&nbsp;&nbsp; <i class="fa-sharp fa-solid fa-chevron-right"></i>&nbsp;
						<a href="/stockList" style="text-decoration: none;"
							class="text-gray-700">관리자(약품 재고 관리)</a>
					</div>
					<!-- card -->
					<div class="card shadow">
						<div class="card-body row row-margin0">
							<!----- 검색조회칸 ----->
							<div class="card"
								style="width: 100%; height: 165px; margin: 10px; padding: 15px; font-size: 15px;">
								<!----- 검색첫째줄 ----->
								<div class=" row row-margin0 "
									style="width: 100%; height: 40px;">
									<div class="card search_criteria" style="width: 9.8%;">
										카테고리</div>
									<div class="row row-margin0 align-middle"
										style="vertical-align: middle; padding-left: 10px;">
										<div class="form-check radio-div" style="margin: 0 10px 0 0;">
											<input class="form-check-input radio" type="radio"
												name="stock_radio" id="stock_radio0" checked value="전체보기"> <label
												class="form-check-label cursor" for="stock_radio0">
												전체보기 </label>
										</div>
										<c:forEach items="${m_subcate }" var="ms" varStatus="no">
											<div class="form-check radio-div">
												<input class="form-check-input radio" type="radio"
													name="stock_radio" id="stock_radio${no.count }" value="${ms }"> 
												<label
													class="form-check-label cursor" for="stock_radio${no.count }">
													${ms } </label>
											</div>
										</c:forEach>
									</div>
								</div>
								<!----- 검색둘째줄 ----->
								<div class="row row-margin0" style="width: 100%; height: 40px;">
									<!-- 약 -->
									<div class="row row-margin0 "
										style="width: 25%; margin-right: 10px;">
										<div class="card search_criteria" style="width: 39%;">약&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;명</div>
										<div class="card"
											style="width: 57%; height: 35px; margin: 0 0 5px 10px;">
											<input type="text" class="form-control"
												style="height: 33px; border: 0">
										</div>
									</div>
									<!-- 구매처 -->
									<div class="row row-margin0"
										style="width: 33%; margin-right: 10px;">
										<div class="card search_criteria" style="width: 32%;">구매처명</div>
										<div class=""
											style="width: 30%; height: 35px; margin: 0 0 5px 10px;">
											<select class="form-control form-select"
												aria-label="Default select example"
												style="height: 35px; font-size: 14px;">
												<option selected value="0">직접입력</option>
												<c:forEach items="${m_company }" var="mc">
													<option>${mc }</option>
												</c:forEach>
											</select>
										</div>
										<div class="card"
											style="width: 33%; height: 35px; margin: 0 0 5px 10px;">
											<input type="text" class="form-control"
												style="height: 33px; border: 0">
										</div>
									</div>
									<!-- 기간조회 -->
									<div class="row row-margin0"
										style="flex-grow: 1; line-height: 35px;">
										<div class="card search_criteria" style="width: 28%;">처방기간조회</div>
										<div class="row row-margin0" style="width: 70%;">
											<div class="card"
												style="width: 45%; height: 35px; margin: 0 10px 5px 10px;">
												<input class="datepicker"
													style="width: 100%; height: 33px; border: 0">
											</div>
											~
											<div class="card"
												style="width: 45%; height: 35px; margin: 0 0 5px 10px;">
												<input class="datepicker"
													style="width: 100%; height: 33px; border: 0">
											</div>
										</div>
									</div>
								</div>

								<!-- 조회/수정버튼 -->
								<div class="row row-margin0 d-flex justify-content-end mt-3"
									style="width: 100%; height: 35px;">
									<button type="button" class="btn btn-primary" name="select" id="select"
										style="width: 100px; height: 35px; margin-right: 10px;">조회</button>
									<button type="button" class="btn btn-outline-primary" name="reset" id="reset"
										style="width: 100px; height: 35px; margin-right: 10px;">초기화</button>
								</div>
							</div>

							<!----- 검색리스트 출력 ----->
							<div class="card"
								style="width: 100%; height: 505px; margin: 10px;">
								<div class="border-radius" style="width: 100%">
									<table class="border table-sm table-bordered"
										style="width: 100%; text-align: center; font-size: 14px;">
										<thead>
											<tr style="background-color: #f8f9fc;">
												<th class="" style="width: 3%">번호</th>
												<th class="" style="width: 5%">분류</th>
												<th class="" style="width: 10%">약품명</th>
												<th class="" style="width: 5%">재고수량(개)</th>
												<th class="" style="width: 10%">구매처</th>
												<th class="" style="width: 7%">매입가격(원)</th>
												<th class="" style="width: 5%">당월구매수량(개)</th>
												<th class="" style="width: 7%">처방가격(원)</th>
												<th class="" style="width: 5%">처방수량(개)</th>
												<th class="" style="width: 3%">수정</th>
											</tr>
										</thead>
										<tbody class="tbody1" value="1">
											<c:forEach items="${stockList }" var="sL" varStatus="status">
												<tr>
													<td class="" style="width: 3%">${status.count }</td>
													<td class="" style="width: 5%">${sL.medical_subcate }</td>
													<td class="" style="width: 10%">${sL.medical_name }</td>
													<td class="" style="width: 5%">${sL.medical_buyEa }</td>
													<td class="" style="width: 10%">${sL.medical_company }</td>
													<td class="" style="width: 7%">
														<fmt:formatNumber value="${sL.medical_buying }" pattern="#,###" />
													</td>
													<td class="" style="width: 5%">30</td>
													<td class="" style="width: 7%">
														<fmt:formatNumber value="${sL.medical_price }" pattern="#,###" />
													</td>
													<td class="" style="width: 5%">25</td>
													<td class="" style="width: 3%"><i
														class="xi-border-color" style="color: #4E73DF;"></i></td>
												</tr>
											</c:forEach>
										</tbody>
									</table>
								</div>
							</div>
						</div>
						<!-- card-body -->
					</div>
					<!-- card -->
				</div>
				<!-- /.container-fluid -->
				<!-- End of Main Content -->
				<%@ include file="../bar/footer.jsp"%>

				<!-- Bootstrap core JavaScript-->
				<script src="vendor/jquery/jquery.min.js"></script>
				<script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

				<!-- Core plugin JavaScript-->
				<script src="vendor/jquery-easing/jquery.easing.min.js"></script>

				<!-- Custom scripts for all pages-->
				<script src="js/sb-admin-2.min.js"></script>
</body>

</html>
