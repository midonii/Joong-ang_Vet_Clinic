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

$(function(){
	
	//반려견 등록 버튼 숨기기
	$('#plus-btn').hide();
	
	$(".owner-tr").off().click(function(){
			
		$(this).css("background-color", "#f4f4f4");

		$("#client-table tr").not(this).each(function() {
					$(this).css('background-color', '');
				});

		$('#plus-btn').show();
		
		//보호자 행 한번 클릭시 동작
		let clientNo = $(this).attr("value");
		let detailNo = $(this).attr("value");
			
		//보호자 정보 삭제하기(그 아래의 반려견도 모두 삭제)
		 $(".clientDelete").off().click(function(){
			 alert("클릭한 부분의 clientNo : " + clientNo);
			 if(confirm("삭제하시겠습니까?")){
 				location.href="clientDelete?clientNo="+clientNo;
 			}
		 });
		
		//보호자 정보 수정하기
		$(".clientUpdate").off().click(function(){
			//alert(clientNo);
			
			//$("#updateClientName").val($("#viewModalLabel").text()); // 제목란에 원래 가지고 있던 title을 가져온다.
			
			$.post({
				url : "/clientDetailAjax",
				cache : false,
				data : {"detailNo" : detailNo},
				dataType : "json"
			}).done(function(data){
				let result = data.result
				alert(result[0].owner_name);
				
				var owner_name = result[0].owner_name
				var owner_addr = result[0].owner_addr
				var owner_tel = result[0].owner_tel
				var owner_email = result[0].owner_email
				var owner_sms= result[0].owner_sms
				var owner_memo= result[0].owner_memo

				
				$("#updateClientName").val(owner_name);
				$("#updateClientEmail").val(owner_email);
				$("#updateClientTel").val(owner_tel);
				$("#updateClientAddr").val(owner_addr);
				/* $("#updateClientName").val(result[0].owner_name); */
				if(owner_sms =='Y'){
					$("#updateSmsAgree").prop('checked',true);
				}
				if(owner_sms == 'N'){
					$("#updateSmsDisagree").prop('checked',true);
				}
				$("#updateClientComments").val(owner_memo);

				$("#clientUpdateModal").modal("show");
				
			}).fail(function(xhr, status,errorThrown){
				alert("문제가 발생했습니다.");
			});
			
			//보호자 수정 정보 저장하기
			$("#clientUpdateSave").off().click(function(){
				//alert(clientNo);
				let updateOwnerName = $("#updateClientName").val();
				let updateOwnerEmail = $("#updateClientEmail").val();
				let updateOwnerTel = $("#updateClientTel").val();
				let updateOwnerAddr = $("#updateClientAddr").val();
				if($("#updateSmsAgree").is(":checked") == true){
				var updateOwnerSms = "Y";			
				}
				else if($("#updateSmsDisagree").is(":checked") == true){
				var updateOwnerSms = "N";				
				}
				let updateOwnerMemo = $("#updateClientComments").val();
				
				//alert("SMS : " + owner_sms);
				
				//백으로 보내서 수정하게 하기,
    			$.post({
    				url : "/clientUpdate",
    				data : {"clientNo" : clientNo,
    						"updateOwnerName" : updateOwnerName,
	    					"updateOwnerEmail" : updateOwnerEmail,
	    					"updateOwnerTel" : updateOwnerTel,
	    					"updateOwnerAddr" : updateOwnerAddr,
	    					"updateOwnerSms" : updateOwnerSms,
	    					"updateOwnerMemo" : updateOwnerMemo
    						},
    				dataType : "json"
    			}).done(function(data){
    				//alert("정상소통" + data.result);
    				if(data.result == 1){
    					alert("수정이 완료되었습니다.");
    					location.href = "/profile";
    						
    				 } else {
    					alert("문제가 발생했습니다. \n다시 시도해주세요.");
    				}
    			}).fail(function(){
    				alert("문제가 발생했습니다.");
    			});
				
			});
			
		});

		//반려견 추가 Modal
		$("#plus-btn").off().click(function(){
			alert(clientNo);
			$("#owner_noPAdd").val(clientNo);
			var now = new Date();
			var now_year = now.getFullYear();
			
			$("#petBirthYear").append("<option value=''>생년</option>");
			
			// 올해로 부터 -30년 까지
			for(var i = now_year; i >= (now_year - 30); i--){
			$("#petBirthYear").append("<option value='"+ i +"'>"+ i +"</option>");
			}
			
			$("#petBirthMonth").append("<option value=''>월</option>");
			// 월 (1~12월)
			for (var i = 1; i < 13; i++) {
            $('#petBirthMonth').append('<option value="' + i + '">' + i + '</option>');
       		 }
			
			$("#petBirthDay").append("<option value=''>일</option>");
			// 일 (1~31)
			 for (var i = 1; i < 32; i++) {
             $('#petBirthDay').append('<option value="' + i + '">' + i + '</option>');
       		 }
			
			
			
			$("#petAddModal").modal("show");
		});
		
		//몸무게 문자 제한 + 반려견 추가 정보 보내기
		$("#petAddSave").click(function(){
			//숫자와 .만 체크하는 정규식
			var NumberExp = /[^0123456789.]/g;
			$("#owner_noPAdd").val(clientNo);
			if((NumberExp.test($("#petAddWeight").val()) )){
				alert("몸무게는 숫자와 소수점(.)만 입력 가능합니다.");
				$("#petAddWeight").focus();
				return false; 
			}
			
			if($("#petAddName").val() == "" || $("#petAddName").val().length < 1){
				alert("이름을 1글자 이상 입력해주세요.");
				$("#petAddName").focus();
				return false; 
			}
			
			/* if($("#petAddType").val() == ""){
				alert("견종을 선택해 주세요.");
				$("#petAddType").focus();
				return false; 
			} */
			
			/* if($("#petAddName").val() == "" || $("#petAddName").val().length < 1){
				alert("이름을 1글자 이상 입력해주세요.");
				$("#petAddName").focus();
				return false; 
			}
			
			if($("#petAddName").val() == "" || $("#petAddName").val().length < 1){
				alert("이름을 1글자 이상 입력해주세요.");
				$("#petAddName").focus();
				return false; 
			} */
			
			if(confirm("반려견을 등록 하시겠습니까?")){
				//let v = $("#petBirthMonth").val();
				//alert(v);
				petAdd.submit();			
			}
			
		});
				
		
		$('#petAddModal').on('hidden.bs.modal', function(e) {

		    // 텍스트 인풋 초기화
		    if($(this).find('form').length >0){
		    	$(this).find('form')[0].reset();
		   		var inputValue = $(this).find('select:eq(0) option:eq(0)');
		    }

		    // 셀렉트 초기화
		    //$('.select2').val(0).trigger('change.select2');
		});
		
		 
	});
	
	//보호자 수정 모달 close 누르면 입력했던 정보 초기화
	$('#clientUpdateModal').on('hidden.bs.modal', function(e) {

	    // 텍스트 인풋 초기화
	    if($(this).find('form').length >0){
	    	$(this).find('form')[0].reset();
	   		var inputValue = $(this).find('select:eq(0) option:eq(0)');
	    }

	    // 셀렉트 초기화
	    //$('.select2').val(0).trigger('change.select2');
	});
	
	
	$(".owner-tr").dblclick (function (){
		//보호자 행 더블 클릭시 해당 보호자의 반려견 띄우기
		let clientNno = $(this).attr("value");
		
		 $.post({
			url : "/profileMap",
			cache : false,
			data : {"clientNno" : clientNno},
			dataType : "json"
		}).done(function(data){
			//alert("성공했습니다.");
			let result = data.result;
			//alert(result.length); //클릭한 부분의 값의 길이
			
			var table = "";
			$('.petList').hide();
			for(let i = 0; result.length > i; i++){
				var pet_no = result[i].pet_no;
				var pet_name = result[i].pet_name;
				var type_name = result[i].type_name
				var pet_gender = result[i].pet_gender;
				var pet_birth = result[i].pet_birth;
				var pet_memo = result[i].pet_memo;
				table += "<tr class='petList' value="+pet_no+">";
				table += "<td>"+pet_no+"</td>";
				table += "<td>"+pet_name+"</td>";
				table += "<td>"+type_name+"</td>";
				table += "<td>"+pet_gender+"</td>";
				table += "<td>"+pet_birth+"</td>";
				table += "<td>"+pet_memo+"</td>";
				table += "</tr>";
			}
			
			$("#ajaxTable").append(table);
			$("#ajaxTable").show();
			
			//변경된 반려견 테이블의 반려견 삭제 기능
			$(".petList").click(function(){
				//alert("!");
				let petNo = $(this).attr("value");
				//alert(petNo);
				$(this).css("background-color", "#f4f4f4");
				
				$(".petList").not(this).each(function() {
					$(this).css('background-color', '');
				});
				
				$(".petDelete").click(function(){
					//반려견 행 클릭 후 삭제 버튼 누를 경우 삭제되게
					//alert(petNo);
					 if(confirm("삭제하시겠습니까?")){
			 				location.href="petDelete?petNo="+petNo;
			 			}
					
				});
			});
			
			$(this).css("background-color", "#f4f4f4");
		}).fail(function(xhr, status,errorThrown){
			alert("문제가 발생했습니다.");
			
		});
		
		
	});
	
	$(".petList").off().click(function(){
		//반려견 테이블 행 클릭시 동작
		let petNo = $(this).attr("value");
		//alert("petNo : " + petNo);		
		
		$(this).css("background-color", "#f4f4f4");

		$(".petList").not(this).each(function() {
					$(this).css('background-color', '');
				});
		
		//alert("petNo : " + petNo);
		$(".petDelete").off().click(function(){
			//반려견 행 클릭 후 삭제 버튼 누를 경우 삭제되게
			//alert(petNo);
			 if(confirm("삭제하시겠습니까?")){
	 				location.href="petDelete?petNo="+petNo;
	 			}
			
		});
		
	});
	
	
	//보호자 상세보기 모달
	 $(".detail-btn").off().click(function(){
		 let detailNo = $(this).attr("value");
		 //lert(detailNo + " : 버튼을 클릭했습니다.");
		 let clientNo = $(this).attr("value");
		
		$.post({
				url : "/clientDetailAjax",
				cache : false, //캐쉬 쓰지말고 새로운 값을 가져오라는 의미
				data : {"detailNo" : detailNo},
				dataType : "json"
			}).done(function(data){
				let result = data.result
				//alert(result[0].owner_name);
				
				$("#viewModalLabel").text(result[0].owner_name);
				$("#client_tel").text(result[0].owner_tel);
				$("#client_addr").text(result[0].owner_addr);
				$("#client_email").text(result[0].owner_email);
				$("#client_sms").text(result[0].owner_sms);
				$("#client_memo").text(result[0].owner_memo);
				
				
				var table = "";
				$('.petListModal').hide();
				//상세보기 클릭 시 이전 기록 reset
				$("#ajaxModalTable").empty();
				for(let i = 0; result.length > i; i++){
					var pet_no = result[i].pet_no;
					var pet_name = result[i].pet_name;
					var type_name = result[i].type_name
					var pet_gender = result[i].pet_gender;
					var pet_birth = result[i].pet_birth;
					var pet_memo = result[i].pet_memo;
					table += "<tr class='petList' value="+pet_no+">";
					table += "<td>"+pet_no+"</td>";
					table += "<td>"+pet_name+"</td>";
					table += "<td>"+type_name+"</td>";
					table += "<td>"+pet_gender+"</td>";
					table += "<td>"+pet_birth+"</td>";
					table += "<td>"+pet_memo+"</td>";
					table += "</tr>";
				}
				
				$("#ajaxModalTable").append(table);
				$("#ajaxModalTable").show();
				
				//변경된 반려견 테이블의 반려견 삭제 기능
				$(".petList").off().click(function(){
					let petNo = $(this).attr("value");
					//alert(petNo);
					$(this).css("background-color", "#f4f4f4");
					
					$(".petList").not(this).each(function() {
						$(this).css('background-color', '');
					});
					
					$(".petDelete").off().click(function(){
						//반려견 행 클릭 후 삭제 버튼 누를 경우 삭제되게
						alert(petNo);
						 if(confirm("삭제하시겠습니까?")){
				 				location.href="petDelete?petNo="+petNo;
				 			}
						
					});
				})
				
				$(this).css("background-color", "#f4f4f4");
				
				$("#detailModal").modal("show");
				
				

			}).fail(function(xhr, status,errorThrown){
				alert("문제가 발생했습니다.");
			});
		
			//보호자 Modal에서 보호자 정보 삭제하기(그 아래의 반려견도 모두 삭제)
			 $(".detailDelete").off().click(function(){
				 //alert("클릭한 부분의 detailNo : " + detailNo);
				 if(confirm("삭제하시겠습니까?")){
					location.href="clientDelete?clientNo="+detailNo;
				}
		 	});
			
			//보호자 상세보기 Modal에서 보호자 정보 수정하기
			//정보 불러오기
			$(".detailUpdate").off().click(function(){
					//alert(detailNo);
					
					var m_owner_name = $("#viewModalLabel").text();
					var m_owner_tel = $("#client_tel").text();
					var m_owner_addr = $("#client_addr").text();
					var m_owner_email = $("#client_email").text();
					var m_owner_sms = $("#client_sms").text();
					var m_owner_memo = $("#client_memo").text();
				
					
					$("#detailModal").modal("hide");
					$("#updateClientName").val(m_owner_name); // 제목란에 원래 가지고 있던 title을 가져온다.
					$("#updateClientEmail").val(m_owner_email);
					$("#updateClientTel").val(m_owner_tel);
					$("#updateClientAddr").val(m_owner_addr);
					if(m_owner_sms =='Y'){
						$("#updateSmsAgree").prop('checked',true);
					}
					if(m_owner_sms == 'N'){
						$("#updateSmsDisagree").prop('checked',true);
					}
					$("#updateClientComments").val(m_owner_memo);
					
					$("#clientUpdateModal").modal("show");
				

			});
			
			//보호자 상세보기 Modal에서 수정 정보 저장하기
			$("#clientUpdateSave").off().click(function(){
				//alert(detailNo);
				let updateOwnerName = $("#updateClientName").val();
				let updateOwnerEmail = $("#updateClientEmail").val();
				let updateOwnerTel = $("#updateClientTel").val();
				let updateOwnerAddr = $("#updateClientAddr").val();
				if($("#updateSmsAgree").is(":checked") == true){
				var updateOwnerSms = "Y";			
				}
				else if($("#updateSmsDisagree").is(":checked") == true){
				var updateOwnerSms = "N";				
				}
				let updateOwnerMemo = $("#updateClientComments").val();
				
				//alert("SMS : " + updateOwnerSms);
				
				//백으로 보내서 수정하게 하기,
    			$.post({
    				url : "/clientUpdate",
    				data : {"clientNo" : clientNo,
    						"updateOwnerName" : updateOwnerName,
	    					"updateOwnerEmail" : updateOwnerEmail,
	    					"updateOwnerTel" : updateOwnerTel,
	    					"updateOwnerAddr" : updateOwnerAddr,
	    					"updateOwnerSms" : updateOwnerSms,
	    					"updateOwnerMemo" : updateOwnerMemo
    						},
    				dataType : "json"
    			}).done(function(data){
    				//alert("정상소통" + data.result);
    				if(data.result == 1){
    					alert("수정이 완료되었습니다.");
    					$("#clientUpdateModal").modal("hide");
    					
    					$("#viewModalLabel").text(updateOwnerName);
    					$("#client_tel").text(updateOwnerTel);
    					$("#client_addr").text(updateOwnerAddr);
    					$("#client_email").text(updateOwnerEmail);
    					$("#client_sms").text(updateOwnerSms);
    					$("#client_memo").text(updateOwnerMemo);
    					
						
    					$("#detailModal").modal("show");
    						
    				 } else {
    					alert("문제가 발생했습니다. \n다시 시도해주세요.");
    				}
    			}).fail(function(){
    				alert("문제가 발생했습니다.");
    			});
				
			});
			
	 });
	
		
	
	//보호자 추가 버튼 모달
		$(".client-add").off().click(function(){
			//alert("클릭한 부분의 clientNo : " + clientNo);
			$("#clientAddModal").modal("show");
		});
	
		//모달 창 닫을 경우 남아있는 값 삭제
		$('#clientAddModal').on('hidden.bs.modal', function(e) {

		    // 텍스트 인풋 초기화
		    if($(this).find('form').length >0){
		    	$(this).find('form')[0].reset();
		   		var inputValue = $(this).find('select:eq(0) option:eq(0)');
		    }

		    // 셀렉트 초기화
		    //$('.select2').val(0).trigger('change.select2');
		});
	
	 $("#clientAddSave").off().click(function(){
			//정규식 검사(email형식이 맞는지)
			var filter = /^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
			//특수문자 검사 정규식(전화번호에 - 들어가는 거 방지)
			var RegExp = /[`~!@#$%^&*()_|+\-=?;:'",.<>\{\}\[\]\\\/ ]/gim;
			 
			if($("#floatingClientName").val() == "" || $("#floatingClientName").val().length < 1){
				alert("이름은 1글자 이상 입력해주세요");
				$("#floatingClientName").focus();
				return false;
			}
			
			if(! (filter.test($("#floatingClientEmail").val()) )){
				alert("올바른 email형식을 입력하세요.");
				$("#email").focus();
				return false;
			}
			
			if($("#floatingClientTel").val() == "" || $("#floatingClientTel").val().length < 9 || 
				RegExp.test($("#floatingClientTel").val())	){
				alert("전화번호는 숫자만 입력해 주세요.");
				$("#floatingClientTel").focus();
				return false;
			}
			
			if($("#floatingClientAddr").val() == "" || $("#floatingClientAddr").val().length < 1){
				alert("올바른 주소를 입력해 주세요.");
				$("#floatingClientAddr").focus();
				return false;
			}
			
			//통과했다면
			if(confirm("보호자를 신규등록 하시겠습니까?")){
			 clientAdd.submit();			
			}
	 });
	 
	
});
	
</script>

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
                            <div style="height: 250px; overflow: auto">
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
                                            <td>${cl.owner_name }</td>
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
								<a class="btn btn-info btn-icon-split float-right"> <span
									class="icon text-white-50"> <i
										class="fas fa-info-circle"></i>
								</span>
								<span class="text">수정</span>
								</a>
								</div>
                            </div>
                        </div>
                    </div>



					<!-- 보호자 상세보기 Modal -->
					<div class="modal fade" id="detailModal" tabindex="-1"
						aria-labelledby="exampleModalLabel" aria-hidden="true">
						<div class="modal-dialog modal-lg modal-dialog-centered">
							<div class="modal-content">
								<div class="modal-header" style="background-color:#ECF2FF; color:#5B5B5B">
									<h5 class="modal-title font-weight-bold col-3"
										id="viewModalLabel">(이름)데이터가 없습니다.</h5>
									<h5 class="modal-title font-weight-bold col-9"
										style="position: absolute; margin-left: 67px">보호자님</h5>
								</div>
								<div class="modal-body" style="margin-left: 15px;">
									<div class="row" style="height: 40px; padding-bottom: 30px; line-height: 40px;">
										<div class="col-2">
											<div>전화번호</div>
										</div>
										<div class="col-8">
											<div id="client_tel">(전화번호)데이터가 없습니다.</div>
										</div>
									</div>
									<div class="row"
										style="height: 30px; padding-top: 1rem; padding-bottom: 40px;">
										<div class="col-2">
											<div>주소</div>
										</div>
										<div class="col-8">
											<div id="client_addr">(주소)데이터가 없습니다.</div>
										</div>
									</div>
									<div class="row"
										style="height: 30px; padding-top: 1rem; padding-bottom: 40px;">
										<div class="col-2">
											<div>email</div>
										</div>
										<div class="col-8">
											<div id="client_email">(email)데이터가 없습니다.</div>
										</div>
									</div>
									<div class="row"
										style="height: 30px; padding-top: 1rem; padding-bottom: 40px;">
										<div class="col-2">
											<div>SMS 수신여부</div>
										</div>
										<div class="col-8">
											<div id="client_sms">(sms 수신여부)데이터가 없습니다.</div>
										</div>
									</div>
									<div class="row"
										style="height: 30px; padding-top: 1rem; padding-bottom: 1rem">
										<div class="col-2">
											<div>특이사항</div>
										</div>
										<div class="col-8">
											<div id="client_memo">(특이사항)데이터가 없습니다.</div>
										</div>
									</div>
									<div class="row" style="height: 30px; padding-top: 1rem; padding-bottom: 50px; border-bottom: 1px #dee2e6 solid;">
										<div class="col">
											<span style="display: inline-block; float: right; margin-right: 10px;">
												<button type="button" class="btn btn-primary btn-sm detailUpdate">수정</button>
												<button type="button" class="btn btn-danger btn-sm detailDelete">삭제</button>
											</span>
										</div>
									</div>
									<!-- 보호자 상세보기 Modal 끝 -->


									<!-- 보호자의 반려견 확인 부분 -->
									<div class="row"
										style="padding-top: 10px; min-height: auto; overflow-y: auto;">
										<div class="col" id="n_content">
											<div class="card shadow mb-4">
												<div class="card-header py-3">
													<h6 class="m-0 font-weight-bold text-primary">반려견</h6>
												</div>
												<div class="card-body">
													<div class="table-responsive">
																<div style="height: 250px; overflow: auto">
																	<table class="table table-bordered table-hover"
																		id="dataTable" width="100%" cellspacing="0">
																		<thead>
																			<tr>
																				<th class="col-md-1">번호</th>
																				<th class="col-md-2">이름</th>
																				<th class="col-md-2">견종</th>
																				<th class="col-md-1">성별</th>
																				<th class="col-md-2">생년월일</th>
																				<th class="col-md-4">특이사항</th>
																			</tr>
																		</thead>

																			<c:forEach items="${petList }" var="pl">
																		<tbody id="ajaxModalTable" value="${pl.pet_no }">
																				<tr class="petListModal" value="${pl.pet_no }">
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
																		<div class="row"
																		style="height: 30px; width:100%; padding-top: 1rem; padding-bottom: 50px; border-bottom: 1px #dee2e6 solid;">
																		<div class="col">
																			<span
																				style="display: inline-block; float: right; margin-right: 10px;">
																				<button class="btn btn-success btn-sm">반려견
																					추가</button>
																				<button type="button"
																					class="btn btn-primary btn-sm detailUpdate">수정</button>
																				<button type="button" class="btn btn-danger btn-sm petDelete">삭제</button>
																			</span>
																	</div>
																</div>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>


								<div class="modal-footer">
									<button type="button" class="btn btn-secondary updateClose"
										data-bs-dismiss="modal">닫기</button>
								</div>
							</div>
						</div>
					</div>
					<!-- 보호자의 반려견 확인 부분 끝 -->


					<!-- 보호자 추가 Modal -->
					<div class="modal fade" id="clientAddModal" data-bs-backdrop="static" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
					<form action="/clientAdd" name="clientAdd" method="post">
						<div class="modal-dialog modal-lg modal-dialog-centered" style="width: 600px;">
							<div class="modal-content">
								<div class="modal-header">
									<h5 class="modal-title" id="exampleModalLabel">보호자 등록</h5>
									<button type="button" class="btn-close" id="clientAddModalClose" data-bs-dismiss="modal" aria-label="Close"></button>
								</div>
								<div class="modal-body">
								 <div class="row g-1 mb-3">
								  <div class="col-4">
									<div class="form-floating">
										 <input type="text" class="form-control" name="floatingClientName" id="floatingClientName" placeholder="name">
										 <label for="floatingInput">이름</label>
									</div>
								  </div>
								  <div class="col-8">	
 									<div class="form-floating">
										<input type="email" class="form-control" name="floatingClientEmail" id="floatingClientEmail" placeholder="name@example.com"> 
										<label for="floatingEmail">이메일</label>
									</div>
								  </div>
								 </div>	
									<div class="form-floating mb-3">
										<input type="text" class="form-control" name="floatingClientTel" id="floatingClientTel" placeholder="01012345678"> 
										<label for="floatingTel">전화번호</label>
									</div>
									<div class="form-floating mb-3">
										<input type="text" class="form-control" name="floatingClientAddr" id="floatingClientAddr" placeholder="address"> 
										<label for="floatingAddr">주소</label>
									</div>
									<div class="row">
										<div class="form-check col-6">
											<input class="form-control-input" type="radio" name="smsAgree" value="Y" id="smsAgree" checked> 
											<label class="custom-check-label" for="smsAgree"> SMS수신 동의 </label>
										</div>
										<div class="form-check col-6">
											<input class="form-control-input" type="radio" name="smsAgree" value="N" id="smsDisagree"> 
											<label class="custom-check-label" for="smsDisagree"> SMS수신 미동의 </label>
										</div>
									</div>
									<div class="mt-1">
										<div class="form-floating">
											<textarea class="form-control" placeholder="Leave a comment here" name="floatingClientComments" id="floatingClientComments" style="height: 150px"></textarea>
											<label for="floatingClientComments">Comments</label>
										</div>
									</div>
									<div class="mt-3 float-right">
									<button type="button" class="btn btn-warning" id="clientAddSave">저장</button>
									</div>
								</div>
							</div>
						</div>
					</form>
					</div>
					<!-- 보호자 추가 Modal끝 -->

					<!-- 보호자 정보 수정 Modal -->
					<div class="modal fade" id="clientUpdateModal" data-bs-backdrop="static" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
					<form>
						<div class="modal-dialog modal-lg modal-dialog-centered" style="width: 600px;">
							<div class="modal-content">
								<div class="modal-header">
									<h5 class="modal-title" id="exampleModalLabel">보호자 정보 수정</h5>
									<button type="button" class="btn-close" id="clientUpdateModalClose" data-bs-dismiss="modal" aria-label="Close"></button>
								</div>
								<div class="modal-body">
								 <div class="row g-1 mb-3">
								  <div class="col-4">
									<div class="form-floating">
										 <input type="text" class="form-control" name="updateClientName" id="updateClientName" placeholder="name">
										 <label for="updateClientName">이름</label>
									</div>
								  </div>
								  <div class="col-8">	
 									<div class="form-floating">
										<input type="email" class="form-control" name="updateClientEmail" id="updateClientEmail" placeholder="name@example.com"> 
										<label for="updateClientEmail">이메일</label>
									</div>
								  </div>
								 </div>	
									<div class="form-floating mb-3">
										<input type="text" class="form-control" name="updateClientTel" id="updateClientTel" placeholder="01012345678"> 
										<label for="updateClientTel">전화번호</label>
									</div>
									<div class="form-floating mb-3">
										<input type="text" class="form-control" name="updateClientAddr" id="updateClientAddr" placeholder="address"> 
										<label for="updateClientAddr">주소</label>
									</div>
									<div class="row">
										<div class="form-check col-6">
											<input class="form-control-input" type="radio" name="updateSmsAgree" value="Y" id="updateSmsAgree" checked> 
											<label class="custom-check-label" for="updateSmsAgree"> SMS수신 동의 </label>
										</div>
										<div class="form-check col-6">
											<input class="form-control-input" type="radio" name="updateSmsAgree" value="N" id="updateSmsDisagree"> 
											<label class="custom-check-label" for="updateSmsAgree"> SMS수신 미동의 </label>
										</div>
									</div>
									<div class="mt-1">
										<div class="form-floating">
											<textarea class="form-control" placeholder="Leave a comment here" name="updateClientComments" id="updateClientComments" style="height: 150px"></textarea>
											<label for="updateClientComments">Comments</label>
										</div>
									</div>
									<div class="mt-3 float-right">
									<button type="button" class="btn btn-warning" id="clientUpdateSave">저장</button>
									</div>
								</div>
							</div>
						</div>
					</form>
					</div>
					
					
					<!-- 반려견 등록 Modal -->
					<div class="modal fade" id="petAddModal" data-bs-backdrop="static" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
					<form action="/petAdd" name="petAdd" method="post" enctype="multipart/form-data">
						<div class="modal-dialog modal-lg modal-dialog-centered" style="width: 700px;">
							<div class="modal-content">
								<div class="modal-header">
									<h5 class="modal-title" id="exampleModalLabel">반려견 등록</h5>
									<button type="button" class="btn-close" id="petAddModalClose" data-bs-dismiss="modal" aria-label="Close"></button>
								</div>
								<div class="modal-body">
								 <div class="row g-1">
								  <div class="col-4">
									<img src="../img/logoda.png" class="img-thumbnail mb-3" alt="이미지를 불러올 수 없습니다." style="width: 200px; height: 200px;">
									<div class="mb-3">
										<label for="formFileSm" class="form-label">반려견 img file</label>
										<input class="form-control form-control-sm" accept="image/*" id="petImg" type="file" style="width: 200px;">
									</div>
								  </div>
								  <div class="col-8">
								  	<div class="row g-1 mb-3">
								  		<div class="col-8">
											<div class="form-floating">
												 <input type="text" class="form-control" name="petAddName" id="petAddName" placeholder="pet name">
												 <label for="petAddName">반려견 이름</label>
											</div>
										</div>
										<div class="col-4">	
											<div class="form-floating">
												 <input type="text" class="form-control" name="petAddWeight" id="petAddWeight" placeholder="kg">
												 <label for="petAddWeight">몸무게(kg)</label>
											</div>
										</div>
									</div>
									<div class="row g-1 mb-3">
											<div class="col-6" style="height: 32px;">
											<input type="hidden" id="owner_noPAdd" name="owner_noPAdd">
												<select name="petAddType" id="petAddType" class="form-control form-control-sm">
													<option>견종을 선택하세요</option>
										<c:forEach items="${petTypeList }" var="pt">
													<option value="${pt.type_no }" name="${pt.type_no }">${pt.type_name }</option>
										</c:forEach>
												</select>
											</div> 
											<div class="col-6" style="height: 32px;">
												<select name="petSex" id="petSex" class="form-control form-control-sm">
													<option>성별을 선택하세요</option>
													<option value="S/F">S/F</option>
													<option value="I/F">I/F</option>
													<option value="N/M">N/M</option>
													<option value="I/M">I/M</option>
												</select>
											</div> 
									 </div>		
											<div class="mb-3 w-100" style="height: 32px;">
													<select class="form-control form-control-sm col-md-3" title="년도" aria-label="Default select example" name="petBirthYear" id="petBirthYear" style="float: left;"></select>
													<div class="col-sm-1" style="float: left; line-height: 31px;">년</div>
													<select class="form-control form-control-sm col-md-3" title="월" aria-label="Default select example" name="petBirthMonth" id="petBirthMonth" style="float: left;"></select>
													<div class="col-sm-1" style="float: left;line-height: 31px;">월</div>
													<select class="form-control form-control-sm col-md-3" title="일" aria-label="Default select example" name="petBirthDay" id="petBirthDay" style="float: left; "></select>
													<div class="col-sm-1" style="float: left;line-height: 31px;">일</div>
											</div>
											<div class="mt-1">
												<div class="form-floating">
													<textarea class="form-control" placeholder="Leave a comment here" name="petAddComments" id="petAddComments" style="height: 110px"></textarea>
													<label for="petAddComments">Comments</label>
												</div>
											</div>
								 </div>
								</div>	
										<div class="mt-3 float-right">
											<button type="button" class="btn btn-warning" id="petAddSave">저장</button>
										</div>
							 </div>
							</div>
						</div>
					</form>
					</div>
					<!-- 반려견 Modal끝 -->
					


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
