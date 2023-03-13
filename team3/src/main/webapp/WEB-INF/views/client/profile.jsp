<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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

<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js" integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js" integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>

<script type="text/javascript">
$(function(){
	//selec 옵션 글자 전환
	$('#searchdropdown a').click (function () {
		$('#dropdownMenuButton').text($(this).text());
	});
	
});
</script>
<script src="js/client/client_add.js"></script>
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

					<!-- 회원 검색 -->
					<!-- <div class="dropdown input-group mb-3">
						<button class="btn btn-outline-secondary dropdown-toggle" id="searchdropdown" type="button" data-bs-toggle="dropdown" aria-expanded="false">선택</button>
						<ul class="dropdown-menu">
							<li><a class="dropdown-item">전체선택</a></li>
							<li><hr class="dropdown-divider"></li>
							<li><a class="dropdown-item">보호자</a></li>
							<li><a class="dropdown-item">반려견</a></li>
						</ul>
						 <input type="text" class="form-control" placeholder="Search" aria-label="Recipient's username" aria-describedby="button-addon2">
  						 <button class="btn btn-outline-secondary" type="button" id="button-addon2">Search</button>
					</div> -->

					<nav class="navbar navbar-expand-lg navbar-light bg-light">
						<div class="container-fluid">
							<div class="collapse navbar-collapse" id="navbarSupportedContent" style="margin-left: -35px; margin-bottom: -15px; margin-top: -30px">
								<div class="dropdown mb-4 pt-4">
										<!-- 드롭다운 -->
                                        <button class="btn btn-outline-primary dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                            옵션선택
                                        </button>
                                        <div class="dropdown-menu animated--fade-in" id="searchdropdown" aria-labelledby="dropdownMenuButton">
                                            <a class="dropdown-item">전체검색</a>
                                            <a class="dropdown-item">보호자</a>
                                            <a class="dropdown-item">반려견</a>
                                        </div>
                                    </div>
								<form class="d-flex">
									<input class="form-control me-2 ml-3" type="search" placeholder="Search" aria-label="Search">
									<button class="btn btn-outline-primary ml-2" type="submit">Search</button>
								</form>
							</div>
						</div>
					</nav>


					<!-- 보호자 테이블 -->
					<div class="card shadow mb-4">
                        <div class="card-header py-3">
                            <h6 class="m-0 font-weight-bold text-primary">보호자</h6>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                            <div id="clientScroll" style="height: 250px; overflow: auto">
                            <!--  <form name="clientInfo" action="profile" method="get"> -->
                                <table class="table-sm table-bordered table-hover" id="dataTable" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <th class="col-md-1">번호</th>
                                            <th class="col-md-2">이름</th>
                                            <th class="col-md-3">전화번호</th>
                                            <th class="col-md-4">주소</th>
                                            <th class="col-md-2">상세보기</th>
                                        </tr>
                                    </thead>
                                 
                                    <tbody id="client-table" data-spy="scroll" data-target="#list-example" data-offset="0" class="scrollspy-example" style="height: 300px;">
                                    <c:forEach items="${clientList }" var="cl">
                                        <tr id="client-info" class="owner-tr" value="${cl.owner_no }">
                                            <td>${cl.owner_no }</td>
                                            <td id="client-name" value="${cl.owner_name }">${cl.owner_name }</td>
                                            <td>${cl.owner_tel }</td>
                                            <td>${cl.owner_addr }</td>
                                            <td>
                                            	<button type="submit" class="btn btn-outline-primary btn-sm detail-btn" name="${cl.owner_no }" value="${cl.owner_no }">상세보기</button>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    
                                    
                                    
                                    </tbody>
                                </table>
                               <!-- </form> -->
                                </div>
                                
                                <!-- 버튼 -->
                                <div class="mt-4">
                                <a class="btn btn-danger btn-icon-split float-right ml-2"> <span
									class="icon text-white-50"> <i class="fas fa-trash"></i>
								</span> <span class="text clientDelete">삭제</span>
								</a>
								<a class="btn btn-info btn-icon-split float-right ml-2 clientUpdate"> <span
									class="icon text-white-50"> <i
										class="fas fa-info-circle"></i>
								</span>
								<span class="text">수정</span>
								</a>
                                <a class="btn btn-primary btn-icon-split float-right ml-2 client-add"> <span
									class="icon text-white-50"> <i class="fas fa-flag"></i>
								</span> <span class="text">추가</span></a> <a class="btn btn-success btn-icon-split  float-right" id="plus-btn"> <span
									class="icon text-white-50"> <i class="fas fa-check"></i>
								</span> <span class="text">반려견 추가</span>
								</a>
								</div>
							</div>
                        </div>
                    </div>
                    
                    <!-- 반려견 테이블 -->
					<div class="card shadow mb-4">
                        <div class="card-header py-3">
                            <h6 class="m-0 font-weight-bold text-primary">반려견</h6>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
										<div style="height: 250px; overflow: auto;">
											<table class="table-sm table-bordered table-hover"
												id="dataTable" width="100%" cellspacing="0">
												<thead>
													<tr>
														<th class="col-md-1">번호</th>
														<th class="col-md-1">이름</th>
														<th class="col-md-2">견종</th>
														<th class="col-md-1">성별</th>
														<th class="col-md-2">생년월일</th>
														<th class="col-md-5">특이사항</th>
													</tr>
												</thead>
												
												
												<c:forEach items="${petList }" var="pl">
												<tbody id="ajaxTable" value="${pl.pet_no }">
														<tr class="petList" value="${pl.pet_no }">
															<td class="petNo">${pl.pet_no }</td>
															<td class="petName">${pl.pet_name }</td>
															<td class="typeName">${pl.type_name }</td>
															<td class="petGender">${pl.pet_gender }</td>
															<td class="petBirth">${pl.pet_birth }</td>
															<td class="petMemo">${pl.pet_memo }</td>
														</tr>
													</c:forEach>
												</tbody>
											</table>
										</div>
								<!-- 반려견 버튼 -->
                                <div class="mt-4">
                                <a class="btn btn-danger btn-icon-split float-right ml-2 petDelete"> <span
									class="icon text-white-50"> <i class="fas fa-trash"></i>
								</span> <span class="text">삭제</span>
								</a>
								<a class="btn btn-info btn-icon-split float-right petUpdate"> <span
									class="icon text-white-50"> <i
										class="fas fa-info-circle"></i>
								</span>
								<span class="text">수정</span>
								</a>
								</div>
                            </div>
                        </div>
                    </div>



			<%@ include file="./client_modal.jsp"%>
					


				</div>
				<!-- /.container-fluid -->

			</div>
			<!-- End of Main Content -->
			
         </div>
        </div>
			      <%@ include file="../bar/footer.jsp" %>
         		  <%@ include file="../bar/logoutModal.jsp" %>
			

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
