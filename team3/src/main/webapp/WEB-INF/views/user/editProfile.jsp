<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
<script src="https://kit.fontawesome.com/a31e2023c3.js"
	crossorigin="anonymous"></script>
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
	margin-left:73%;
	margin-top: 35px;
}

.none{
	display: inline-block;
}


</style>
</head>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script> <!-- 주소api -->
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script type="text/javascript">
 /*
 뒤로가기막기
function CheckSession() {
	if (sessionStorage.getItem("id") == null) {
		window.location = "login";
	}
}

setInterval(CheckSession(), 100);



 */
 

document.cookie = "safeCookie1=foo; SameSite=Lax"; 
document.cookie = "safeCookie2=foo"; 
document.cookie = "crossCookie=bar; SameSite=None; Secure";

//주소찾기API
function sample6_execDaumPostcode() {
	
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var addr = ''; // 주소 변수
            var extraAddr = ''; // 참고항목 변수

            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
            }

            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
            if(data.userSelectedType === 'R'){
                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraAddr !== ''){
                    extraAddr = ' (' + extraAddr + ')';
                }
                // 조합된 참고항목을 해당 필드에 넣는다.
                //document.getElementById("address").value = extraAddr;
                //document.getElementById("sample6_extraAddress").value = extraAddr;
            
            }
            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            //document.getElementById("sample6_postcode").value = data.zonecode;
            //document.getElementById("sample6_address").value = addr + ' ';
            document.getElementById("address").value = addr + ' ' + extraAddr + ' ';
            
            // 커서를 상세주소 필드로 이동한다.
            document.getElementById("detailAddr").focus();
            //document.getElementById("sample6_detailAddress").focus();
        }
    }).open();
}


$(function(){
	
	$("input[name='pw'], input[name='pw2']").change(function(){
		
		let pw = $("#pw").val();
		let pw2 = $("#pw2").val();
			$("#pwCheck").text("비밀번호가 일치하지 않습니다.");
			$("#pwCheck").css("color", "red");
			
		if(pw.length > 0 && pw != pw2){
			return false;
		} else if(pw.length > 0 && pw == pw2){
			$("#pwCheck").text("비밀번호가 일치합니다.");
			$("#pwCheck").css("color", "green");
		}
		
	});
	
	$(".editbtn").click(function(){
		
		let pw = $("#pw").val();
		let pw2 = $("#pw2").val();
		let name = $("#name").val();
		
		let tel1 = $("#tel1").val();
		let tel2 = $("#tel2").val();
		let tel3 = $("#tel3").val();
		let tel = tel1 + tel2 + tel3 ;
		
		let address = $("#address").val();
		let detailAddr = $("#detailAddr").val();
		let addr = address + detailAddr;
		
		$.post({
			url : "/editProfile",
			data : {"pw" : pw, "name" : name, "tel" : tel, "addr" : addr},
			dataType : "json"
		}).done(function(data){
			alert("수정완료");
			location.href="/profile="+'${sessionScope.id }';
		}).fail(function(xhr){
			alert("저장실패");
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

					<!-- Page Heading -->
					<h1 class="h3 mt-5 mb-4 text-gray-800 text-center">
						프로필 수정
					</h1>
					<div class="mainbox card shadow mb-4" style="width:45%; margin-left:28%;">
						<div class="card-body row mt-4">	
							<div class="col-3 font-weight-bold text-primary" style="text-align:center;">아이디</div>
							<div class="col-5">${profile.staff_id }</div>
						</div>
						<div class="card-body row">	
							<div class="col-3 font-weight-bold text-primary" style="text-align:center;">비밀번호</div>
							<div class="col-5">
								<input type="password" id="pw" name="pw" class="form-control form-control-sm mb-2" placeholder="비밀번호" style="margin-left:-5px;">
								<input type="password" id="pw2" name="pw2" class=" form-control form-control-sm mb-1" placeholder="비밀번호 확인" style="margin-left:-5px;">
								<p class="sm" id="pwCheck" style="font-size:12px; text-align:1rem; margin-bottom:-10px;"></p>
							</div>
						</div>
						<div class="card-body row">	
							<div class="col-3 font-weight-bold text-primary" style="text-align:center;">이름</div>
							<div class="col-5">
								<input type="text" id="name" name="name" class="form-control form-control-sm" value="${profile.staff_name }" style="margin-left:-5px;">
							</div>
						</div>
						<div class="card-body row">	
							<div class="col-3 font-weight-bold text-primary" style="text-align:center;">생년월일</div>
							<div class="col-5">${profile.staff_birth }</div>
						</div>
						<div class="card-body row">	
							<div class="col-3 font-weight-bold text-primary" style="text-align:center;">전화번호</div>
							<div class="col-5" style="margin-left:-5px;" >
									<input type="text" id="tel1" name="tel1" class="col-3 form-control none form-control-sm" value="${fn:substring(profile.staff_tel,'0','3')}" maxlength="3" >
									 - <input type="text" id="tel2" name="tel2" class="col-3 form-control none form-control-sm" value="${fn:substring(profile.staff_tel,'3','7')}" maxlength="4">
									 - <input type="text" id="tel3" name="tel3" class="col-3 form-control none form-control-sm" value="${fn:substring(profile.staff_tel,'7','11')}" maxlength="4">
							</div>
						</div>
						<div class="card-body row">	
							<div class="col-3 font-weight-bold text-primary" style="text-align:center;">이메일</div>
							<div class="col-5">${profile.staff_email }</div>
						</div>
						<div class="card-body row">	
							<div class="col-3 font-weight-bold text-primary" style="text-align:center;">주소</div>
							<div class="col-sm-7">
								<input type="text" id="address" name="address" class="form-control form-control-sm" value="${profile.staff_addr }" readOnly style="margin-left:-5px;">
								<input type="text" id="detailAddr" name="detailAddr" class="form-control form-control-sm mt-2" placeholder="상세주소" style="margin-left:-5px;">
							</div>
							<div class="col-sm-1">
								<input type="button" class="btn btn-sm btn-primary mt-4" value="주소찾기" onclick="sample6_execDaumPostcode()" style="margin-left:-10px;">
							</div>
						</div>
						<div class="card-body row mb-2">	
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
						<div class="card-body row mb-3 justify-content-md-center">
							<button class="btn btn-primary editbtn">저장하기</button>
						</div>
					<div class="photo card " style="width:150px; height:200px;"></div>
					</div>

				</div>
				<!-- /.container-fluid -->

			</div>
			<!-- End of Main Content -->
			
			<%@ include file="../bar/footer.jsp" %>
<%-- 			<%@ include file="bar/logoutModal.jsp" %> --%>




	<!-- Bootstrap core JavaScript-->
	<script src="vendor/jquery/jquery.min.js"></script>
	<script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

	<!-- Core plugin JavaScript-->
	<script src="vendor/jquery-easing/jquery.easing.min.js"></script>

	<!-- Custom scripts for all pages-->
	<script src="js/sb-admin-2.min.js"></script>

</body>

</html>
