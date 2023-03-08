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

<title>중앙동물병원</title>
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
textarea {
	resize: none;
}

.smsform {
	width: 400px;
	height: 650px;
	position: relative;
	display: flex;
	flex-direction: column;
	min-width: 0;
	word-wrap: break-word;
	background-color: #fff;
	background-clip: border-box;
	border: 1px solid #e3e6f0;
	border-radius: 0.35rem;
}

.smsTo {
	margin: 0 auto;
	width: 380px;
	margin-top: 5px;
}

.smsTo2 {
	margin: 0 auto;
	width: 380px;
	margin-top: 5px;
	border: 1px solid #e3e6f0;
	border-radius: 0.35rem;
}

.smsContent {
	display: inline;
	margin: 0 auto;
	width: 370px;
	height: 100%;
}

.border {
	border: 1px solid #e3e6f0;
	border-radius: 0.35rem;
	font-size: 13px;
}

.smsBottom {
	margin-top: -5px;
	height: 100px;
	position: relative;
}

.bottombtn {
	height: 40px;
	margin: 10px;
}

.smsforms{
	float:left;
	width: 300px;
	height: 280px;
}
.smsformsdiv{
	width:900px;
}
</style>
</head>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script type="text/javascript">
$(function() {

	$(".serachbtn").click(function(){
		
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
					<h1 class="h3 mb-4 text-gray-800">SMS 발송</h1>

					<div class="card shadow">
						<div class="card-header py-3">
							<ul class="nav nav-pills">
								<li class="nav-item"><a class="nav-link active"
									aria-current="page" href="#">일반문자</a></li>
								<li class="nav-item"><a class="nav-link" href="#">예약문자</a></li>
								<li class="nav-item"><a class="nav-link" href="#">대량문자</a></li>
							</ul>
						</div>
						<div class="card-body row justify-content-md-center">

							<!-- 문자발송form -->
							<div style="width: 400px; margin: 0 30px 0 0 ;">
								<div class="card smsform" style=" padding:5px 0 0 0 ;">
									<div class="row smsTo" style="margin-bottom: -4px;">
										<div class="font-weight-bold text-primary" style="width: 80px; height: 30px; line-height: 30px; text-align: center;">
											받는사람
										</div>
										<button class="btn btn-primary btn-sm serachbtn" type="button" style="margin-left: 5px;">
											<i class="fas fas-sm fa-search"></i>
										</button>
									</div>
									<div>
										<div class="row smsTo2 mt-2" style="width: 370px;">
											<table class="border table-sm table-bordered"
												style="width: 100%; text-align: center;">
												<tr>
													<th class="col-3">견명</th>
													<th class="col-3">견주명</th>
													<th class="col-6">전화번호</th>
												</tr>
												<tr>
													<td>흰둥이</td>
													<td>짱구</td>
													<td>01011111111</td>
												</tr>
											</table>
										</div>
									</div>

									<hr>
									<div class="card smsContent">
										<textarea class="form-control"
											style="width: 100%; height: 100%; border: 0;"></textarea>
									</div>
									<hr>
									<div class="smsBottom row justify-content-md-center">
										<input type="button" class="bottombtn btn btn-primary"
											value="전송"> <input type="reset"
											class="bottombtn btn btn-outline-primary" value="초기화">
									</div>
								</div>
							</div>





							<!-- 오른쪽 표 -->
							<div class="col-8">
								<div class="card shadow" style="height: 650px;">
									<div class="card-header py-3">
										<h6 class="m-0 font-weight-bold text-primary">SMS 양식</h6>
									</div>
									<div class="card-body">
										<div class="table-responsive">
											<!-- 
											<div>
											<div class="smsforms" style="background-color:red;"></div>
											<div class="smsforms" style="background-color:orange;"></div>
											<div class="smsforms" style="background-color:yellow;"></div>
											<div class="smsforms" style="background-color:green;"></div>
											<div class="smsforms" style="background-color:skyblue;"></div>
											<div class="smsforms" style="background-color:pink;"></div>
											</div>
											 -->
											
											<table class="table table-bordered" id="dataTable"
												width="100%" height="550px;" cellspacing="0">
												<tr style="height: 50%;">
													<td class="col-3">
													<span>
														<div class="mb-3" style="height: 200px;">
															<textarea class="form-control" style="height: 100%;" id="smsForm1" name="smsForm1"></textarea>
														</div>
														<div class=" row justify-content-md-center">
															<input type="button"class="btn btn-sm btn-outline-secondary" value="저장">
															&nbsp; 
															<input type="button" class="btn btn-sm btn-outline-secondary" value="사용">
															&nbsp; 
															<input type="button" class="btn btn-sm btn-outline-secondary" value="삭제">
														</div>
													</span>
													</td>
													<td class="col-3">
													<span>
														<div class="mb-3" style="height: 200px;">
															<textarea class="form-control" style="height: 100%;" id="smsForm2" name="smsForm2"></textarea>
														</div>
														<div class=" row justify-content-md-center">
															<input type="button"class="btn btn-sm btn-outline-secondary" value="저장">
															&nbsp; 
															<input type="button" class="btn btn-sm btn-outline-secondary" value="사용">
															&nbsp; 
															<input type="button" class="btn btn-sm btn-outline-secondary" value="삭제">
														</div>
													</span>
													<td class="col-3">
													<span>
														<div class="mb-3" style="height: 200px;">
															<textarea class="form-control" style="height: 100%;" id="smsForm3" name="smsForm3"></textarea>
														</div>
														<div class=" row justify-content-md-center">
															<input type="button"class="btn btn-sm btn-outline-secondary" value="저장">
															&nbsp; 
															<input type="button" class="btn btn-sm btn-outline-secondary" value="사용">
															&nbsp; 
															<input type="button" class="btn btn-sm btn-outline-secondary" value="삭제">
														</div>
													</span>
													</td>
													
													<!-- <td class="col-3">
														<span>
															<div class="mb-3" style="height:200px;">
																<textarea class="form-control" style="height:100%;" id="smsForm4" name="smsForm4"></textarea>
															</div>
															<div class=" row justify-content-md-center">
																<input type="button" class="btn btn-sm btn-outline-secondary" value="저장">
																&nbsp;
																<input type="button" class="btn btn-sm btn-outline-secondary" value="사용">
																&nbsp;
																<input type="button" class="btn btn-sm btn-outline-secondary" value="삭제">
															</div>
														</span>
													</td> -->
													
												</tr>

												<tr style="height: 50%;">
													<td>
														<div>
															<div class="mb-3" style="height: 200px;">
																<textarea class="form-control" style="height: 100%;"
																	id="smsForm5" name="smsForm"5></textarea>
															</div>
															<div class=" row justify-content-md-center">
																<input type="button"
																	class="btn btn-sm btn-outline-secondary" value="저장">
																&nbsp; <input type="button"
																	class="btn btn-sm btn-outline-secondary" value="사용">
																&nbsp; <input type="button"
																	class="btn btn-sm btn-outline-secondary" value="삭제">
															</div>
														</div>
													</td>
													<td>
														<div>
															<div class="mb-3" style="height: 200px;">
																<textarea class="form-control" style="height: 100%;"
																	id="smsForm6" name="smsForm6"></textarea>
															</div>
															<div class=" row justify-content-md-center">
																<input type="button"
																	class="btn btn-sm btn-outline-secondary" value="저장">
																&nbsp; <input type="button"
																	class="btn btn-sm btn-outline-secondary" value="사용">
																&nbsp; <input type="button"
																	class="btn btn-sm btn-outline-secondary" value="삭제">
															</div>
														</div>
													</td>
													<td>
														<div>
															<div class="mb-3" style="height: 200px;">
																<textarea class="form-control" style="height: 100%;"
																	id="smsForm" 7 name="smsForm7"></textarea>
															</div>
															<div class=" row justify-content-md-center">
																<input type="button"
																	class="btn btn-sm btn-outline-secondary" value="저장">
																&nbsp; <input type="button"
																	class="btn btn-sm btn-outline-secondary" value="사용">
																&nbsp; <input type="button"
																	class="btn btn-sm btn-outline-secondary" value="삭제">
															</div>
														</div>
													</td>
													 
													<!-- <td>
														<div>
															<div class="mb-3" style="height:200px;">
																<textarea class="form-control" style="height:100%;" id="smsForm8" name="smsForm8"></textarea>
															</div>
															<div class=" row justify-content-md-center">
																<input type="button" class="btn btn-sm btn-outline-secondary" value="저장">
																&nbsp;
																<input type="button" class="btn btn-sm btn-outline-secondary" value="사용">
																&nbsp;
																<input type="button" class="btn btn-sm btn-outline-secondary" value="삭제">
															</div>
														</div>
													</td> -->
													
												</tr>

											</table>
										
									</div>
								</div>
							</div>
							</div>
						</div>
					</div>
				</div>
				<!-- /.container-fluid -->
			</div>
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
