<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<% if(session.getAttribute("id") == null){
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
<!-- <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" -->
<!-- 	type="text/css"> -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css">
<!-- <link rel="stylesheet" href="https://kit.fontawesome.com/a31e2023c3.css" crossorigin="anonymous"> -->
<script src="https://kit.fontawesome.com/a31e2023c3.js" crossorigin="anonymous"></script>
<link
	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">

<!-- Custom styles for this template-->
<link href="css/sb-admin-2.min.css" rel="stylesheet">
<style type="text/css">
h6{
	margin-bottom:0;
}

.photo{
	position: absolute;
	display: inline-block;
	margin-left:70%;
	margin-top: 35px;
}

</style>
</head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
<script type="text/javascript">

$(function(){
	
	$(".edit").click(function(){
		$("#pwCheckModal").modal("show");
	});
	
	$(".close").click(function(){
		$("#pwCheck").val('');
	});
	
	$(".checkbtn").click(function(){
		let pwCheck = $("#pwCheck").val();
		$.post({
			url : "/profilePwCheck",
			data : {"pw" : pwCheck},
			dataType : "json"
		}).done(function(data){
			if(data.result == "1"){
				location.href="/editProfile";
			} else {
				alert("비밀번호가 올바르지 않습니다. 다시 입력해주세요.");
				$("#pwCheck").val('');
				$("#pwCheck").focus();
			}
		}).fail(function(){
			alert("비밀번호확인실패")
		});
	});
	
});

</script>

<body id="page-top" >

	<!-- Page Wrapper -->
	<div id="wrapper">

		<%@ include file="../bar/sideBar.jsp"%>

		<!-- Content Wrapper -->
		<div id="content-wrapper" class="d-flex flex-column">

			<!-- Main Content -->
			<div id="content">

				<%@ include file="../bar/topBar.jsp"%>


				<!-- Begin Page Content -->
				<div class=" container-fluid ">

					<h1 class="h3 mt-5 mb-4 text-gray-800 text-center">
						프로필 &nbsp; <i class="xi-pen-o edit" style="cursor:pointer;"></i>
					</h1>
					<div class="mainbox card shadow mb-4" style="width:40%; margin-left:30%;">
						<div class="card-body row mt-4">	
							<div class="col-3 font-weight-bold text-primary" style="text-align:center;">아이디</div>
							<div class="col-7">${profile.staff_id }</div>
						</div>
						<div class="card-body row">	
							<div class="col-3 font-weight-bold text-primary" style="text-align:center;">이름</div>
							<div class="col-7">${profile.staff_name }</div>
						</div>
						<div class="card-body row">	
							<div class="col-3 font-weight-bold text-primary" style="text-align:center;">생년월일</div>
							<div class="col-7">${profile.staff_birth }</div>
						</div>
						<div class="card-body row">	
							<div class="col-3 font-weight-bold text-primary" style="text-align:center;">전화번호</div>
							<div class="col-7">${profile.staff_tel }</div>
						</div>
						<div class="card-body row">	
							<div class="col-3 font-weight-bold text-primary" style="text-align:center;">이메일</div>
							<div class="col-7">${profile.staff_email }</div>
						</div>
						<div class="card-body row">	
							<div class="col-3 font-weight-bold text-primary" style="text-align:center;">주소</div>
							<div class="col-7">${profile.staff_addr }</div>
						</div>
						<div class="card-body row mb-4">	
							<div class="col-3 font-weight-bold text-primary"  style="text-align:center;">직책</div>
							<div class="col-7">
								<c:choose>
									<c:when test="${profile.staff_grade eq 'admin' }" >
										관리자
									</c:when> 
									<c:when test="${profile.staff_grade eq 'doctor' }" >
										의사
									</c:when> 
									<c:otherwise>
										테크니션
									</c:otherwise>
								</c:choose>
							</div>
						</div>
					<div class="photo card " style="width:150px; height:200px;"></div>
					</div>

				</div>
				<!-- /.container-fluid -->

			</div>
			<!-- End of Main Content -->
			

<!-- 비밀번호 입력 모달 -->
		<div class="modal fade" id="pwCheckModal" data-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="staticBackdropLabel" ">프로필 수정 권한 확인</h5>
						<button class="close" type="button" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">×</span>
						</button>
					</div>
					<div class="modal-body" style="text-align: center;">
						<br>비밀번호를 입력하세요.<br><br>
						<div class="mt-3 mb-1 row">
							<label for="inputPassword" class="col-sm-4 col-form-label" style="text-align: center;">비밀번호</label>
							<div class="col-sm-8">
								<input type="password" class="form-control" id="pwCheck">
							</div>
						</div>
					</div>
					<div class="modal-footer">
						<button class="btn btn-primary sm checkbtn">확인</button>
					</div>
				</div>
			</div>
		</div>



	<%@ include file="../bar/footer.jsp" %>

	<!-- Bootstrap core JavaScript-->
	<script src="vendor/jquery/jquery.min.js"></script>
	<script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

	<!-- Core plugin JavaScript-->
	<script src="vendor/jquery-easing/jquery.easing.min.js"></script>

	<!-- Custom scripts for all pages-->
	<script src="js/sb-admin-2.min.js"></script>

</body>

</html>
