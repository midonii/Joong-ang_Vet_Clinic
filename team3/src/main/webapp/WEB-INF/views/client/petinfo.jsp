<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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

<title>반려견 상세정보</title>
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<!-- Custom fonts for this template-->
<link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet">
<!-- 	type="text/css"> -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css">
<link rel="stylesheet" href="https://kit.fontawesome.com/a31e2023c3.css" crossorigin="anonymous">
<script src="https://kit.fontawesome.com/a31e2023c3.js" crossorigin="anonymous"></script>
<link
	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">

<!-- CSS only -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<!-- Custom styles for this template-->
<link href="../css/sb-admin-2.min.css" rel="stylesheet">
<link rel="shortcut icon" type="image/x-icon" href="../img/favicon.png" />

<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js" integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js" integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>

<script type="text/javascript">
$(function(){
	$("#excel-down").click(function(){
		/* alert("!"); */
		const urlParams = new URL(location.href).searchParams;
		const petNo = urlParams.get('petNo');
		//alert(petNo);
		
		location.href="/petVaccine.xls?petNo="+petNo;
		
	});
});

$(function(){
	
	
	 $(".pastChart").click(function(){
		//alert($(this).attr("value"));
		var chartNo = $(this).attr("value"); //클릭한 아코디언의 차트 번호
		var urlParams = new URL(location.href).searchParams;
		var petNo = urlParams.get('petNo');
		//alert(petNo); 
		
		
		
	 	$.post({
			url : "/pastChartAjax",
			data : {"chartNo" : chartNo,
					"petNo" : petNo
					},
			dataType : "json"
		}).done(function(data){
			//alert("정상소통" + data.petExam);
			let petMedicalData = data.petMedicalData;
			//alert(petExam[0].medical_subcate);
			var table = "";
			$('.chartList'+chartNo).hide();
			//상세보기 클릭 시 이전 기록 reset
			$("#client-table"+chartNo).empty();
			
			// -- 검사
			for (let i = 0; petMedicalData.length > i; i++) {
				var medical_category = petMedicalData[i].medical_category;
				var medical_subcate = "";
				if(petMedicalData[i].medical_subcate != undefined){
				    medical_subcate = petMedicalData[i].medical_subcate;
				}
				var medical_name = petMedicalData[i].medical_name;
				var staff_name = petMedicalData[i].staff_name;
				var staff_grade = petMedicalData[i].staff_grade;
				var medicaldata_ea = petMedicalData[i].medicaldata_ea;
				
				table += "<tr class='chartList"+chartNo+"'>";
				table += "<td>" + medical_category + "</td>";
				table += "<td>" + medical_subcate + "</td>";
				table += "<td class='text-left'>" + medical_name + "</td>";
				table += "<td>" + medicaldata_ea + "</td>";
				table += "<td>" + staff_name + "</td>";
				table += "<td>" + staff_grade + "</td>";
				table += "</tr>";
				
			}
			
			
			
			//$(this).children("#client-table").append(table);
			$("#client-table"+chartNo).append(table);
			$("#client-table"+chartNo).show();
			 
			
		 }).fail(function(){
			alert("문제가 발생했습니다.");
		}); 
		 
		 
	});
});

//검색 enter
$(function(){
	$("#pet_search").on("keyup",function(key){
		if(key.keyCode==13){
			$("#search_btn").click();
		}
		
	});
	
	$("#pet_search2").on("keyup",function(key2){
		if(key2.keyCode==13){
			$("#search_btn2").click();
		}
	})
});

//파라미터 없는 petinfo 화면 설정
$(function(){
	$(document).ready(function(){
	var params = window.location.search
	//alert(params)
 	if(params == ''){			
		$("#pet_search").focus();
		$("#pet_search").addClass("is-invalid");
	} 
	});
});
</script>
<script type="text/javascript" src="../js/client/petinfo_search.js"></script>
<style type="text/css">
.s20{
	font-size: 20px;
	cursor:pointer;
}

.vac{
	margin : 0;
	padding : 0;
	line-height: 430px;
	text-align: center;
}
.chart_none{
	text-align: center;
}
.table-center{
	text-align: center;
}
.text-left{
	text-align: left;
}
.text-right{
	text-align: right;
}

.imgSet{
	width: 320px;
	height: 320px;
	border-radius: 12px;
	border:outset;
	border-width: 3px;
	border-color: #9ec5fe;
}

.infoSet{
	margin-left: -20px;
	margin-top: 10px;
}
</style>
</head>

<body id="page-top">

	<!-- Page Wrapper -->
	<div id="wrapper">

		<!-- 사이드 바 메뉴 -->
		<%@ include file="../bar/sideBar.jsp"%>

		<!-- Content Wrapper -->
		<div id="content-wrapper" class="d-flex flex-column">



			<!-- Main Content -->
			<div id="content">
				<%@ include file="../bar/topBar.jsp"%>



				
				
				

				<!-- Begin Page Content -->
				<div class="container-fluid">
				
				
				
			
				<div class="row">
				 
				 <!-- Page Heading -->
					<div class="mb-1 col-7" style="line-height: 50px; font-size: 13px;">
						<a href="/index" style="text-decoration: none;"
							class="text-gray-600"><i class="fa-solid fa-house-chimney"></i></a>&nbsp;&nbsp;<i
							class="fa-sharp fa-solid fa-chevron-right"></i>&nbsp; <a
							href="/petinfo" style="text-decoration: none;"
							class="text-gray-700">이전 진료 내역</a>
					</div>		
				 
				<!-- 검색 -->
				 
					<div class="d-none d-inline-block form-inline mb-3 navbar-search float-right col-5">
						<div class="input-group d-flex justify-content-end">
							<input type="text"
								class="form-control border-gray col-12 pet_search"
								placeholder="차트를 확인할 반려견 정보를 입력해주세요." aria-label="Search"
								aria-describedby="basic-addon2" id="pet_search" name="pet_search">
							<div class="input-group-append">
								<button class="btn btn-primary shadow-sm" id="search_btn"
									type="button">
									<i class="fas fa-search fa-sm"></i>
								</button>
							</div>
						</div>
					</div>
					
					
				 </div>
				
				
			
				
				<div class="row align-top">	
				  <!-- pet 정보 -->
				  
				   <div class="col-7">	
					<div class="card shadow mb-4">
						<div class="card-header py-3">
							<h6 class="m-0 font-weight-bold text-primary">반려견 Info</h6>
						</div>
						<div class="card-body">
							<div style="height: 430px;" class="row">

							<c:forEach items="${petInfo }" var="pi">
							<div class="col-5">
							<c:choose>
								<c:when test="${fn:length(pi.filename) gt 0}">
									<img src="../resources/static/upFile/${pi.filename }" class="img-thumbnail imgSet">								
								</c:when>
								<c:otherwise>
									<img src="../img/logoda.png" class="rounded img-thumbnail imgSet">
								</c:otherwise>
							</c:choose>
							</div>
							<div class="col-7 infoSet">
								<div class="list-group list-group-flush">
  								 <div class="list-group-item row">
  									<div class="col-3 font-weight-bold float-left">이름</div>
  									<div class="col-9 float-left">${pi.pet_name }</div>
  								 </div>	
  								 <div class="list-group-item row">
  									<div class="col-3 font-weight-bold float-left">견종</div>
  									<div class="col-9 float-left">${pi.type_name }</div>
  								 </div>	
  								 <div class="list-group-item row">
  									<div class="col-3 font-weight-bold float-left">생일</div>
  									<div class="col-9 float-left">${pi.pet_birth } (${pi.pet_Ym })</div>
  								 </div>	
  								 <div class="list-group-item row">
  									<div class="col-3 font-weight-bold float-left">성별</div>
  									<div class="col-9 float-left">${pi.pet_gender }</div>
  								 </div>	
  								 <div class="list-group-item row">
  									<div class="col-3 font-weight-bold float-left">몸무게</div>
  									<div class="col-9 float-left">${pi.pet_weight }kg</div>
  								 </div>	
  								 <div class="list-group-item row">
  									<div class="col-3 font-weight-bold float-left">특이사항</div>
  									<div class="col-9 float-left">${pi.pet_memo }</div>
  								 </div>	
								</div>
							</div>
								</c:forEach>
							</div>
						</div>
					</div>
				  </div>

					<!-- 접종 내역 / vac_name=신종플루, vacdata_date=2023-03-02 -->
					<div class="col-5">
					<div class="card shadow mb-4">
						<div class="card-header py-3">
							<h6 class="m-0 font-weight-bold text-primary">
							접종
							<i class="fa-regular fa-file-excel float-right s20" id="excel-down" title="excel 다운로드"></i>
							</h6>
						</div>
						<div class="card-body">
							<div style="height: 430px;">
						<c:choose>
						<c:when test="${fn:length(petVaccine) gt 0}">
								<div class="list-group list-group-flush">
								<c:forEach items="${petVaccine }" var="v">	
  								 <div class="list-group-item row">
  									<div class="col-6 font-weight-bold float-left">${v.medical_name }</div>
  									<div class="col-6 float-left">${v.chart_date }</div>
  								 </div>	
								</c:forEach>
								</div>
						</c:when>
						<c:otherwise>
							<div class="vac">접종 내역이 없습니다.</div>
						</c:otherwise>
						</c:choose>
							</div>
						</div>
						
					</div>
					</div>
				</div>
				  
				
				<!-- 이전 진료 내역 part -->
					<div class="card shadow mb-4 align-bottom">
						<div class="card-header py-3">
							<h6 class="m-0 font-weight-bold text-primary">이전 진료 내역</h6>
						</div>
						<div class="card-body">
							<!-- <div style="height: 400px; overflow: auto;"> -->
							
							
							
								
								<!-- 진료 내역 -->
							<c:choose>
							  <c:when test="${fn:length(petChart) gt 0}">
									<div class="accordion" id="accordionExample">
								 <c:forEach items="${petChart }" var="ch" varStatus="status">
									<div class="accordion-item">
										<h2 class="accordion-header" id="${ch.chart_date }">
								
											<button class="accordion-button collapsed pastChart" type="button"
												data-toggle="collapse" data-target="#A${ch.chart_no }" 
												aria-expanded="${status.index eq 0 ? 'true':'false'}" aria-controls="A${ch.chart_no }" value="${ch.chart_no }">
												<div class="font-weight-bold">차트번호 :</div>
												<div class="ml-2 font-weith">${ch.chart_no }</div>
												<div class="ml-5 font-weight-bold">담당의 :</div>
												<div class="ml-2">${ch.staff_name }</div>
												<div class="ml-5 font-weight-bold">진료날짜 :</div>
												<div class="ml-2">${ch.chart_date }</div>
												</button>
										</h2>
										<div id="A${ch.chart_no }" class="${status.index eq 0 ? 'accordion-collapse collapse':'accordion-collapse collapse'}"
											aria-labelledby="${ch.chart_date }" data-parent="#accordionExample">
											<div class="accordion-body">
												<!-- 의사 소견 -->
												<div class="mb-4">
													<div class="card h-100 py-2">
														<div class="card-body">
															<div class="row no-gutters align-items-center">
																<div class="col mr-2">
																	<div
																		class="text-sm font-weight-bold text-info text-uppercase mb-1">의사소견
																	</div>
																<div class="row no-gutters align-items-center">
																${ch.chart_memo }
																</div>
																
																</div>
																
															</div>
														</div>
													</div>
												</div>
												
												<!-- 처방내역 테이블 -->
												<div class="card mb-4">
													<div class="card-body">
													<div class="d-flex justify-content-center">
													<div class="text-sm font-weight-bold text-info text-uppercase mb-3 ">
														처방 상세 내역
													</div>
													</div>
														<div class="table-responsive">
															<div id="clientScroll">
																<table class="table table-center table-sm table-bordered"
																	id="dataTable" width="100%" cellspacing="0">
																	<thead>
																		<tr>
																			<th class="col-md-1">구분</th>
																			<th class="col-md-1">분류</th>
																			<th class="col-md-4">처방명</th>
																			<th class="col-md-2">수량</th>
																			<th class="col-sm-2">담당자</th>
																			<th class="col-sm-2">직급</th>
																		</tr>
																	</thead>

																	<tbody id="client-table${ch.chart_no }" data-spy="scroll"
																		data-target="#list-example" data-offset="0"
																		class="scrollspy-example">
																		
																		<tr class="chartList${ch.chart_no }">
																			<td>(카테고리)</td>
																			<td>(상세 카테고리)</td>
																			<td class="text-left">(처방내역)</td>
																			<td>(담당자)</td>
																			<td>(직급)</td>
																			<td>(수량)</td>
																	</tbody>
																</table>
															</div>
														</div>
													</div>
												</div>
												
											</div>
											<!-- 아코디언 바디 끝 -->
								
										</div>
									</div>
<!-- 								</div> -->

							</c:forEach>
							</div>
							</c:when>
							<c:otherwise>
								<div class="chart_none">진료 내역이 없습니다.</div>
							</c:otherwise>
							</c:choose>
						</div>
					</div>


				</div>
				<!-- /.container-fluid -->

			</div>
			<!-- End of Main Content -->
			
			      <%@ include file="../bar/footer.jsp" %>
         		  <%@ include file="../bar/logoutModal.jsp" %>
         		  <%@ include file="./petinfo_modal.jsp"%>
			

	<!-- Bootstrap core JavaScript-->
	<script src="vendor/jquery/jquery.min.js"></script>
	<script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

	<!-- Core plugin JavaScript-->
	<script src="vendor/jquery-easing/jquery.easing.min.js"></script>
	

	<!-- Custom scripts for all pages-->
	<script src="js/sb-admin-2.min.js"></script>
	<!-- JavaScript Bundle with Popper -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>

</body>

</html>
