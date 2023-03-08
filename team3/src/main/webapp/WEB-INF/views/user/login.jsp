<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>중앙동물병원</title>

    <!-- Custom fonts for this template-->
    <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="css/sb-admin-2.min.css" rel="stylesheet">
<style>

.imgdiv{
	position: relative;
	height: 520px;
}

.logoimg{
	position: absolute;
	height: 400px;
	top: 12%;
	left: 10%
}

</style> 
    
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>

<script type="text/javascript">

// 엔터키 미완성......
function enterkey(){
	if(window.event.keyCode == 13){
		document.getElementById("login").click();
	}
}

$(function(){
	
	$("#email").hide();
	// email로그인 체크시
	$("#emailLogin").click(function(){
		$("#email").show();
		$("#id").val("");
		$("#pw").val("");
		$("#id").hide();
	});
	// id로그인 체크시
	$("#idLogin").click(function(){
		$("#id").show();
		$("#email").val("");
		$("#pw").val("");
		$("#email").hide();
	});

	// Login버튼 클릭시
	$("#login").click(function(){
		
		let id = $("#id").val();
		let pw = $("#pw").val();
		let email = $("#email").val();
		
		if( $("#idLogin").is(":checked") ) {
			if($("#id").val() == ""){
				alert("아이디를 입력하세요.");
				$("#id").focus();
				return false;
			}
		} else if ( $("#emailLogin").is(":checked") ) {
			// 정규식검사 https://velog.io/@fall031/%EC%A0%95%EA%B7%9C%ED%91%9C%ED%98%84%EC%8B%9D
			let regex = new RegExp('[a-z0-9]+@[a-z]+\.[a-z]{2,3}');
			// alert(regex.test($("#email").val()));
			if($("#email").val() == ""){
				alert("이메일을 입력하세요.");
				$("#email").focus();
				return false;
			} else if(  !(regex.test($("#email").val())  )){
				alert("올바른 이메일을 입력하세요.");
				$("#email").focus();
				return false;
			}
		}
		if($("#pw").val() == ""){
			alert("비밀번호를 입력하세요.");
			$("#pw").focus();
			return false;
		}
		
		$.post({
			url : "/login",
			data : {"id" : id, "email" : email, "pw" : pw},
			dataType : "json"
		}).done(function(data){
			if(data.result == "0"){
				alert("확인되지 않는 사용자입니다. 다시 로그인하세요.");
				$("#id").val("");
				$("#email").val("");
				$("#pw").val("");
				return false;
			} else {
 				location.href = "/index";
			}
		}).fail(function(xhr){
			alert("실패");
		});
		
	});
});




</script>

</head>

<body class="bg-gradient-primary" >

    <div class="container" style="margin-top:100px;">

        <!-- Outer Row -->
        <div class="row justify-content-center">

            <div class="col-xl-10 col-lg-12 col-md-9">

                <div class="card o-hidden border-0 shadow-lg my-5">
                    <div class="card-body p-0">
                        <!-- Nested Row within Card Body -->
                        <div class="row">
							<div class="col-lg-6 d-none d-lg-block imgdiv">
								<img src="img/logoda.png" class="logoimg">
                            </div>
                            <div class="col-lg-6">
                                <div class="p-5">
                                    <div class="text-center mb-4 mt-4">
                                        <h1 class="h1 text-gray-900">로그인</h1>
                                    </div>
									<div class="p-2 row">
										<div class="form-check col-6">
											<input class="form-control-input" type="radio" name="flexRadioDefault" id="idLogin" checked> 
											<label class="custom-check-label" for="idLogin"> 아이디로 로그인 </label>
										</div>
										<div class="form-check col-6">
											<input class="form-control-input" type="radio" name="flexRadioDefault" id="emailLogin"> 
											<label class="custom-check-label" for="emailLogin"> 이메일로 로그인 </label>
										</div>
									</div>
									<form class="user">
                                        <div>
                                            <input type="text " class="form-control form-control-user"
                                                id="id" name="id" placeholder="아이디">
                                        </div>
                                        <div>
                                            <input type="email"  class="form-control form-control-user"
                                                id="email" name="email" placeholder="이메일">
                                        </div>
                                        <div class="form-group mt-3">
                                            <input type="password" class="form-control form-control-user"
                                                id="pw" name="pw" placeholder="비밀번호">
                                        </div>
										<div class="form-group ">
											<div class="custom-control custom-checkbox small ">
												<input type="checkbox" class="custom-control-input" id="customCheck"> 
												<label class="custom-control-label" for="customCheck">아이디 저장</label>
											</div>
										</div>
                                        <button type="button" class="btn btn-primary btn-user btn-block" id="login" name="login" onkeyup="enterkey()">
                                            로그인
										</button>
                                    </form>
                                    <hr>
                                    <div class="row">
                                    <div class="text-center col-6">
                                        <a class="small" href="#" onclick="location.href='/findPW'">비밀번호 찾기</a>
                                    </div>
                                    <div class="text-center col-6">
                                        <a class="small" href="#" onclick="location.href='/join'">가입하기</a>
                                    </div>
                                    </div>
                                </div>
                            </div>
                        </div>
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