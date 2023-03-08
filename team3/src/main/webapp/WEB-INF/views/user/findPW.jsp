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
    
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
    
<style type="text/css">

  .form-control-user {
    font-size: 0.8rem;
    border-radius: 10rem;
    padding: 1.5rem 1rem;
  }
  
  .btn-user {
    font-size: 0.8rem;
    border-radius: 10rem;
    padding: 0.75rem 1rem;
  }
  
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

<script type="text/javascript">

// 뒤로가기 막기
window.history.forward(); 
function noBack(){
	window.history.forward();
} 

$(function(){
	
	// 인증번호전송 클릭시
	$("#sendpw").click(function(){
		let email = $("#email").val();
		
		if(email == ""){
			alert("이메일을 입력하세요.");
			return false;
		}
		
		alert("입력하신 이메일은 [ " + email + " ] 입니다.");
		
		$.post({
			url : "/findPW",
			data : {"email" : email},
			dataType : "json"
			}).done(function(data) {
				if(data.result == "1"){
					$("#checkpwModal").modal("show");
					$("#fixEmail").val(email);
				} else {
					alert("확인되지 않는 이메일입니다. 다시 시도하여 주세요.");
				}
				
			}).fail(function(xhr){
				alert("통신실패");
			});
	});		
	
	// 인증번호 입력 후 확인누를시
	$(".checkbtn").click(function(){
		let fixEmail = $("#fixEmail").val();
		let userTempnum = $("#userTempnum").val();
				
		if(userTempnum == ""){
			alert("인증번호를 입력하세요.");
			return false;
		}
		
		// 사용자가 입력한 인증번호 controller로 보내기
		// DB에 저장된 인증번호와 동일한지 확인
		$.post({
			url : "/checkTempnum",
			data : {"userTempnum" : userTempnum, "fixEmail" : fixEmail},
			dataType : "json"
		}).done(function(data){
			if(data.result == "1"){
				$("#checkpwModal").modal("hide");
				$("#newpwModal").modal("show");
				
			} else {
				alert("인증번호가 올바르지 않습니다. 다시 확인하여 주세요.");
			}
		}).fail(function(xhr){
			alert("실패");
		});
		
	});
	
	// 새 비밀번호 입력후 확인 누를시
	$(".newpwbtn").click(function(){
		
		let fixEmail = $("#fixEmail").val();
		let newPw = $("#newPw").val();
		let newPw2 = $("#newPw2").val();
		
		if(newPw == ""){
			alert("비밀번호를 입력하여 주세요.");
			return false;
		} else if (newPw != newPw2) {
			alert("비밀번호가 일치하지 않습니다. 다시 입력하여 주세요.");
			$("newPw").val("");
			$("newPw2").val("");
			return false;
		}
		
		// 사용자가 비밀번호를 정확히 입력시 controller 보내기
		$.post({
			url : "/newpwSet",
			data : {"newPw" : newPw, "fixEmail" : fixEmail },
			dataType : "json"
		}).done(function(data){
			if(data.result == 1){
				alert("비밀번호 변경 완료. 다시 로그인하여 주세요.");
				$("#newpwModal").modal("hide");
				location.href="/login";
			}
		}).fail(function(xhr){
			alert("실패");
			location.href="/login";
		});
	});
});

</script>

</head>

<body class="bg-gradient-primary" onload="noBack();" onpageshow="if(event.persisted) noBack();" onunload="">

	<div class="container" style="margin-top: 100px;">

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
										<h1 class="h1 text-gray-900">비밀번호찾기</h1>
									</div>
									<div class="p-2 row">
										<div class="form-group col-12 mb-4" style="text-align:center;" >
											입력하신 이메일로 인증번호를 보냅니다.
										</div>
										<div class="user col-12 mb-5">
											<input type="email" class="form-control form-control-user mb-3 " id="email" name="email" placeholder="이메일" required="required">
											<button type="button" class="btn-user btn btn-primary  btn-block" id="sendpw">인증번호 전송</button>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

<!-- 인증번호발송 모달 -->
<div class="modal fade" id="checkpwModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
					<h3 class="modal-title fs-4" id="staticBackdropLabel" style="font-weight:bold;">인증번호 확인</h3>
					<button class="close" type="button" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">×</span>
					</button>
			</div>
			<div class="modal-body" style="text-align:center;">
					<br>
					<b>입력하신 이메일로 인증번호를 전송하였습니다.<br> 인증번호를 입력하여주세요.</b>
					<br>
					<br>
					<div class="mb-1 row">
						<label for="staticEmail" class="col-sm-3 col-form-label" style="text-align:center;">Email</label>
						<div class="col-sm-9">
							<input type="text" readonly class="form-control-plaintext" id="fixEmail" >
						</div>
					</div>
					<div class="mb-1 row">
						<label for="inputPassword" class="col-sm-3 col-form-label" style="text-align:center;">인증번호</label>
						<div class="col-sm-9">
							<input type="text" class="form-control" id="userTempnum">
						</div>
					</div>
			</div>
			<div class="modal-footer">
				<button class="btn btn-primary sm checkbtn" >확인</button>
			</div>
		</div>
	</div>
</div>

<!-- 새 비밀번호 모달 -->
		<div class="modal fade" id="newpwModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
			aria-labelledby="staticBackdropLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h3 class="modal-title fs-5" id="staticBackdropLabel" style="font-weight: bold;">새로운 비밀번호 설정</h3>
						<button class="close" type="button" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">×</span>
						</button>
					</div>
					<div class="modal-body" style="text-align: center;">
						<br> <b>변경하실 비밀번호를 입력하세요.</b> <br> <br>
						<div class="mt-3 mb-1 row">
							<label for="inputPassword" class="col-sm-4 col-form-label" style="text-align: center;">새 비밀번호</label>
							<div class="col-sm-8">
								<input type="password" class="form-control" id="newPw">
							</div>
						</div>
						<div class="mb-1 row">
							<label for="inputPassword" class="col-sm-4" col-form-label" style="text-align: center;">비밀번호 확인</label>
							<div class="col-sm-8">
								<input type="password" class="form-control" id="newPw2">
							</div>
						</div>
					</div>
					<div class="modal-footer">
						<button class="btn btn-primary sm newpwbtn">확인</button>
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