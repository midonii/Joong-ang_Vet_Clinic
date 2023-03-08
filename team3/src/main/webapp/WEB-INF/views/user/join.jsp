<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<% if(session.getAttribute("id") != null){
	response.sendRedirect("/index");
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

<!-- Custom fonts for this template-->
<link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet"
	type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">

<!-- Custom styles for this template-->
<link href="css/sb-admin-2.min.css" rel="stylesheet">
<style type="text/css">

form.user .custom-checkbox.small label {
  line-height: 1.5rem;
}

form.user .form-control-user {
  font-size: 0.8rem;
  border-radius: 10rem;
  padding: 1.5rem 1rem;
}

form.user .btn-user {
  font-size: 0.8rem;
  border-radius: 10rem;
  padding: 0.75rem 1rem;
}

.imgdiv{
	position: relative;
	height: 820px;
}

.logoimg{
	position: absolute;
	height: 400px;
	top: 25%;
	left: 10%
}

</style>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script> <!-- 주소api -->
<script>

//뒤로가기 막기
window.history.forward(); 
function noBack(){
	window.history.forward();
} 

const autoHyphen1 = (target) => {
	 target.value = target.value
	   .replace(/[^0-9]/g, '')
	  .replace(/^(\d{0,4})(\d{0,2})(\d{0,2})$/g, "$1-$2-$3").replace(/(\-{1,2})$/g, "");
	}

// 주소찾기API
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
                    document.getElementById("sample6_extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("sample6_extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById("sample6_postcode").value = data.zonecode;
                document.getElementById("sample6_address").value = addr + ' ';
                
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("sample6_detailAddress").focus();
            }
        }).open();
    }


$(function(){
	
	$("#idCheck").click(function(){
		let id = $("#id").val();
		$.post({
			url : "/idCheck",
			data : {"id" : id },
			dataType : "json"
		}).done(function(data){
			if(data.result == "0"){
				alert("사용가능한 아이디입니다.");
				$("#id").attr("disabled", true);
			} else {
				alert("이미 존재하는 아이디입니다. 다시 입력해주세요.");
				$("#id").val('');
				$("#id").focus();
			}
		}).fail(function(){
			alert("아이디확인실패");
		});
	});
	
	$("input[name='pw'], input[name='repw']").change(function(){
		if(!$("input[name='id']").attr("disabled")){
			alert("아이디 중복확인을 해주세요.");
			$("#pw").val("");
			$("#id").focus();
		} else {
			let pw = $("#pw").val();
			let repw = $("#repw").val();
			
			if(pw.length > 0 && pw != repw){
				$("#pwCheck").text("비밀번호가 일치하지 않습니다.");
				$("#pwCheck").css("color", "red");
				return false;
			} else if(pw.length > 0 && pw == repw){
				$("#pwCheck").text("비밀번호가 일치합니다.");
				$("#pwCheck").css("color", "green");
			}
		}
	});
	
	$("#emailCheck").click(function(){
		let email = $("#email").val();
		$.post({
			url : "/emailCheck",
			data : {"email": email },
			dataType : "json"
		}).done(function(data){
			if(data.result == "0"){
				alert("사용가능한 이메일입니다.");
				$("#email").attr("disabled", true);
			} else {
				alert("이미 존재하는 이메일입니다. 다시 입력해주세요.");
				$("#id").val('');
				$("#id").focus();
			}
		}).fail(function(){
			alert("이메일확인실패");
		});
	});
		
	$(".joinbtn").click(function(){
		
		let id = $("#id").val();
		let pw = $("#pw").val();
		let name = $("#name").val();
		let birth = $("#birth").val();
		let tel = $("#tel").val();
		let email = $("#email").val();
		let address = $("#sample6_address").val();
		let detailAddr = $("#sample6_detailAddress").val();
		let extraAddr = $("#sample6_extraAddress").val();
		let grade = $("#grade option:selected").val();
		//alert(id+" / "+pw+" / "+name+" / "+birth+" / "+tel+" / "+email+" / "+grade);
		
		if(pw == "" || name == "" || birth == "" || tel == "" || email == "" || address == ""){
			alert("필수 입력사항을 모두 입력하세요.");
			return false;
		} else{
	   	 	$.post({
	   		 	url : "/join",
		   	 	data : {"id" : id, "pw" : pw, "name" : name, 
		   	 			"birth" : birth, "tel" : tel, "email" : email, "grade" : grade,
		   	 			"address":address, "detailAddr":detailAddr, "extraAddr":extraAddr},
		   	 	dataType : "json"
	   		}).done(function(data){
	   			if(data.joinresult == "1"){
	   				alert("회원가입이 완료되었습니다. 다시 로그인해 주세요.");
	   				location.href="/login";
	   			}
	    	}).fail(function(xhr){
	    		alert("실패");
	    	});
		}
	});
});

</script>

</head>

<body class="bg-gradient-primary" onload="noBack();" onpageshow="if(event.persisted) noBack();" onunload="">

	<div class="container" style="margin-top: 50px;">

		<!-- Outer Row -->
		<div class="row justify-content-center">

			<div class="col-xl-10 col-lg-12 col-md-9">

				<div class="card o-hidden border-0 shadow-lg my-5">
					<div class="card-body p-0">
						<!-- Nested Row within Card Body -->
						<div class="row">
							<div class="col-lg-6 d-none d-lg-block imgdiv" >
                            	<img class="logoimg" src="img/logoda.png">
                            </div>
<!-- 							<div class="col-lg-5 d-none d-lg-block bg-register-image"></div> -->
							<div class="col-lg-6">
								<div class="p-5">
									<div class="text-center">
										<h1 class="h4 text-gray-900 mb-4">회원가입</h1>
									</div>
									
									<form class="user">
										<div class="form-group row">
											<input type="text" id="id" name="id" class="col-sm-8 form-control form-control-user"  placeholder="아이디">
											<input type="button" id="idCheck" name="idCheck" class="col-4 btn btn-primary btn-user btn-block" value="중복확인">
										</div>
										<div class="form-group row">
											<input type="password" id="pw" name="pw" class="pw col-sm-6 form-control form-control-user"  placeholder="비밀번호">
											<input type="password" id="repw" name="repw" class="col-sm-6 form-control form-control-user"  placeholder="비밀번호 확인">
										</div>
										<div class="form-group row">
											<p class="col-sm" id="pwCheck" style="font-size:12px; text-align:1rem; margin-top:-10px; margin-bottom:-10px;"></p>
										</div>
										<div class="form-group row" style="marging-top:-30px;">
											<input type="text" id="name" name="name"  class="col-sm-6 form-control form-control-user" placeholder="이름">
											<input type="text" id="birth" name="birth" onKeyup="this.value=this.value.replace(/[^-0-9]/g,'');" class="col-sm-6 form-control form-control-user"  required minlength="8" maxlength="8" placeholder="생년월일(ex.19001230)">
										</div>
										<div class="form-group row">
											<input type="text" id="tel" name="tel" onKeyup="this.value=this.value.replace(/[^-0-9]/g,'');" class="col-sm-12 form-control form-control-user"  required minlength="11" maxlength="11" placeholder="전화번호(ex.01012345678)">
										</div>
										<div class="form-group row">
											<input type="email" id="email" name="email" class="col-sm-8 form-control form-control-user"  placeholder="이메일">
											<input type="button" id="emailCheck" class="col-4 btn btn-primary btn-user btn-block" value="중복확인">
										</div>
										<div class="form-group row">
											<input type="text"  id="sample6_postcode" name="postcode" class="col-sm-4 form-control form-control-user" disabled placeholder="우편번호">
											<input type="button" class="col-3 btn btn-primary btn-user btn-block" onclick="sample6_execDaumPostcode()" value="주소찾기">
										</div>
										<div class="form-group row">
											<input type="text" id="sample6_address" name="addr" class="col-sm-12 form-control form-control-user"  disabled placeholder="도로명주소">
										</div>
										<div class="form-group row">
											<input type="text" id="sample6_detailAddress" name="detailAddr" class="col-sm-6 form-control form-control-user"   placeholder="상세주소">
											<input type="text" id="sample6_extraAddress" name="extraAddr" class="col-sm-6 form-control form-control-user"  disabled placeholder="참고항목">
										</div>
										<hr>
										<div class="form-group row ">
											<div class="col-sm-6 " style="text-align:center; margin-top:4px;">
											직책
											</div>
											<div class="col-sm-6">
												<select id="grade" name="grade" class="form-select-sm form-control form-control-sm" aria-label="Default select example">
<!-- 													<option selected>직책선택</option> -->
													<option value="doctor" >의사</option>
													<option value="technician" >테크니션</option>
												</select>
											</div>
										</div>
										<hr>
										<button class="btn btn-primary btn-user btn-block joinbtn"> 등록 </a>
<!-- 										<button a href="login.html" class="btn btn-primary btn-user btn-block"> 등록 </a> -->
									</form>
									
								</div>
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