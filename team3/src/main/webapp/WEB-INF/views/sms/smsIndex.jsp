<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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

<title>중앙동물병원</title>
<link rel="stylesheet"
	href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css">
<link rel="shortcut icon" type="image/x-icon" href="../img/favicon.png" />
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
	width: 370px;
}

.smsTo2 {
	margin: 0 auto;
	width: 380px;
	border: 1px solid #e3e6f0;
	border-radius: 0.35rem;
}

.memberlist{
	margin: 0 auto;
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

.smsFormWrite {
	display: inline;
	margin: 0 auto;
	width: 230px;
	height: 300px;
	border-width: 2px;
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

.smsforms {
	float: left;
	width: 300px;
	height: 280px;
}

.smsformsdiv {
	width: 900px;
}

.margin {
	margin: 15px;
}

.padding {
	padding: 15px;
	padding-left:18px;
	margin:0 auto;
}

.btn-margin {
	width: 100px;
	margin: 5px;
}

.sms_content{
	position: relative;
}

.newnum{
	background-color: #fefdf1;
}
thead {
  display: table; /* to take the same width as tr */
  width: calc(100% - 17px); /* - 17px because of the scrollbar width */
}

tbody {
  display: block; /* to enable vertical scrolling */
  max-height: 515px; /* e.g. */
  overflow-y: scroll; /* keeps the scrollbar even if it doesn't need it; display purpose */
}
.tbody1 {
	max-height: 420px;
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
$(function() {
	
	
	
// 문자양식가져오기 -> 1,2,3,4,5,6 코드 줄이기 가능?
 	$("#sms_form1, #sms_form2, #sms_form3, #sms_form4, #sms_form5, #sms_form6").click(function(){
		
 		
 		
		let smsform_no = $(this).val();
		$("#sms_hidden").val(smsform_no);	// 양식저장,삭제를 위해 hidden에 val값 지정
		
		$.get({
			url: "/smsform",
			data : {smsform_no : smsform_no},
			dataType: "json"
		}).done(function(data){
			
			//alert(data.smsform.smsForm_title + " / " +data.smsform.smsForm_content);
			
			let sms_title = data.smsform.smsForm_title;
	 		let sms_content = (data.smsform.smsForm_content).replaceAll("<br>","\r\n");
			
			//alert(sms_title + " / " + sms_content);
			
			$("#sms_title").val(sms_title);
	  		$("#sms_content").val(sms_content);
	  		
	  		var content = $("#sms_content").val();
	 		$('#sms_count span').text(content.length);
	  		
		}).fail(function(xhr){
			alert("실패");
		});
		
	});
 	
 // 양식저장. 가상form
 	$("#sms_formset").click(function(){
 		
 		if($("#sms_hidden").val() == ''){
 			alert("저장하려는 양식 번호를 누른 후 내용을 수정하고 다시 '양식저장' 버튼을 클릭하세요.");
 		} else {
 			
 			let sms_hidden = $("#sms_hidden").val();
 			let sms_title = $("#sms_title").val();
 			let sms_content = $("#sms_content").val();
 			
 			//alert(sms_hidden + " / " + sms_title + " / " + sms_content);
 			
 			if(confirm("< 양식" + sms_hidden + " > 양식을 변경하시겠습니까?") == true){
 				
 				var form = $("<form></form>");
 				form.attr("action", "/smsform_setdel");
 				form.attr("method", "post");
 				form.appendTo("body");
 				form.append($("<input>",{type: 'hidden', name: 'sms_hidden', value: sms_hidden}));
 				form.append($("<input>",{type: 'hidden', name: 'sms_title', value: sms_title}));
 				form.append($("<input>",{type: 'hidden', name: 'sms_content', value: sms_content}));
 				form.submit();
 				
 			} 
 		}
 	});
 	
 // 양식삭제. 가상form
 	$("#sms_formdel").click(function(){
 		
 		if($("#sms_hidden").val() == ''){
 			alert("삭제하려는 양식 번호를 누른 후 다시 '양식삭제' 버튼을 클릭하세요.");
 		} else {
 			
 			let sms_hidden = $("#sms_hidden").val();
 			$("#sms_title").val("양식"+sms_hidden);
 			let sms_title = $("#sms_title").val();
 			$("#sms_content").val("");
 			let sms_content = $("#sms_content").val();
 			
 			alert(sms_hidden + " / " + sms_title + " / " + sms_content);
 			
 			if(confirm("< 양식" + sms_hidden + " > 양식을 삭제하시겠습니까?") == true){
 				
 				var form = $("<form></form>");
 				form.attr("action", "/smsform_setdel");
 				form.attr("method", "post");
 				form.appendTo("body");
 				form.append($("<input>",{type: 'hidden', name: 'sms_hidden', value: sms_hidden}));
 				form.append($("<input>",{type: 'hidden', name: 'sms_title', value: sms_title}));
 				form.append($("<input>",{type: 'hidden', name: 'sms_content', value: sms_content}));
 				form.submit();
 		
 			} 
 		}
 	});
 	
 // 초기화버튼
 	$("#reset").click(function(){
 		
 		$("#sms_hidden").val("");
 		$("#sms_title").val("");
 		$("#sms_content").val("");
 		
 	});
	
	
// 번호추가시 받는사람으로
 	$(document).on("click", ".sms_numplus", function(){
 		let pet_name = $.trim($("#sms_newdog").val());
 		let owner_name = $.trim($("#sms_newowner").val());
 		let owner_tel = $.trim($("#sms_newnum").val());
 		//alert(pet_name + " / " + owner_name + " / " + owner_tel);
 		
 		if(owner_tel == ""){
 			alert("전화번호를 입력해주세요.");
 			$("#sms_newnum").focus();
 		} else {
	 		
	 		var tr = "<tr class='newnum' id='receive_tr'>"
	 					+"<td class='col-3' id='pet_name'>"+pet_name+"</td>"
	 					+"<td class='col-3' id='owner_name'>"+owner_name+"</td>"
	 					+"<td class='col-4' id='owner_tel'>"+owner_tel+" </td>" /* 공백지우면안됨!! */
	 					+"<td class='col-2'><i class='minusbtn xi-minus-circle xi-x' style='color:#4e73df; cursor:pointer;'></i></td>"
	 					+"</tr>" ;
	 		
	 		$(".tbody1").append(tr);
	 		
	 		$("#sms_newdog").val("");
	 		$("#sms_newowner").val("");
	 		$("#sms_newnum").val("");
	 		
 		}
 	});
 	
	
// 1) 고객목록 > 받는사람으로
	$(".plusbtn").click(function(){
		let pet_name = $(this).parent().siblings("#pet_name").text();
		let owner_name = $(this).parent().siblings("#owner_name").text();
		let owner_tel = $(this).parent().siblings("#owner_tel").text();
		//alert(pet_name + " / " + owner_name + " / " + owner_tel);
		
		$(this).parents("#client_tr").remove();
		
		var tr = "<tr id='receive_tr'>"
					+"<td class='col-3' id='pet_name'>"+pet_name+"</td>"
					+"<td class='col-3' id='owner_name'>"+owner_name+"</td>"
					+"<td class='col-4' id='owner_tel'>"+owner_tel+" </td>" /* 공백지우면안됨!! */
					+"<td class='col-2'><i class='minusbtn xi-minus-circle xi-x' style='color:#4e73df; cursor:pointer;'></i></td>"
					+"</tr>" ;
		
		$(".tbody1").append(tr);
		
	});

// 2) 받는사람 > 고객목록으로
	$(document).on("click", ".minusbtn", function(){
		let pet_name = $(this).parent().siblings("#pet_name").text();
		let owner_name = $(this).parent().siblings("#owner_name").text();
		let owner_tel = $(this).parent().siblings("#owner_tel").text();
		//alert(pet_name + " / " + owner_name + " / " + owner_tel);
		
		if($(this).parents("#receive_tr").hasClass("newnum") == true){
			$(this).parents("#receive_tr").remove();
		} else {
			$(this).parents("#receive_tr").remove();
			var tr = "<tr id='client_tr'>"
						+"<td class='col-3' id='pet_name'>"+pet_name+"</td>"
						+"<td class='col-3' id='owner_name'>"+owner_name+"</td>"
						+"<td class='col-4' id='owner_tel'>"+owner_tel+"</td>"
						+"<td class='col-2'><i class='replusbtn xi-plus-circle-o xi-x' style='color:#4e73df; cursor:pointer;'></i></td>"
						+"</tr>";
			
			$(".tbody2").append(tr);
		}
		
	});
	
	
// 3) 받는사람에서 고객목록로 돌아온사람 > 받는사람으로
	$(document).on("click",".replusbtn", function(){
		let pet_name = $(this).parent().siblings("#pet_name").text();
		let owner_name = $(this).parent().siblings("#owner_name").text();
		let owner_tel = $(this).parent().siblings("#owner_tel").text();
		//alert(pet_name + " / " + owner_name + " / " + owner_tel);
		$(this).parents("#client_tr").remove();
		
		var tr = "<tr id='receive_tr'>"
					+"<td class='col-3' id='pet_name'>"+pet_name+"</td>"
					+"<td class='col-3' id='owner_name'>"+owner_name+"</td>"
					+"<td class='col-4' id='owner_tel'>"+owner_tel+" </td>" /* 공백지우면안됨!! */
					+"<td class='col-2'><i class='minusbtn xi-minus-circle xi-x' style='color:#4e73df; cursor:pointer;'></i></td>"
					+"</tr>" ;
		
		$(".tbody1").append(tr);
		
	});
	
	
// 전체선택, 해제 버튼

	$("#plusAll").click(function(){
		$("#plusAll").attr("id", "replusAll")
		$(".plusbtn").attr("class","minusbtn xi-minus-circle xi-x");
		$("tr").attr("id","receive_tr");
		
		var clientList = $(".tbody2").children();
		
  		$(".tbody2").children().remove();
 		$(".tbody1").append(clientList);
	});

	$(document).on("click","#minusAll", function(){
		
		
 		$(".newnum").remove();
		
		$(".minusbtn").attr("class","replusbtn xi-plus-circle-o xi-x");
 		$(".minusbtn").removeClass("plusbtn");
		$("tr").attr("id","client_tr");
		$("td .pet_name").val("${cl.pet_name} ");
			
		var receiverToClient = $(".tbody1").children();
			
	  	$(".tbody1").children().remove();
		$(".tbody2").append(receiverToClient);
		
		
	});
	
	$(document).on("click","#replusAll", function(){
		
		
		$(".replusbtn").attr("class","minusbtn xi-minus-circle xi-x");
		$("tr").attr("id","receive_tr");
		
		var clientList = $(".tbody2").children();
		
  		$(".tbody2").children().remove();
 		$(".tbody1").append(clientList);
	});
	
	
	
	
// 문자내용글자수
	$('#sms_content').keyup(function(){
		  var content = $(this).val();
		  $('#sms_count span').html(content.length);
		  if (content.length > 40){
		    alert("최대 40자까지 입력 가능합니다.");
		    $(this).val(content.substring(0, 40));
		    $('#sms_count span').text(40);
		  }
	});
	
	
// 문자전송버튼
	$("#sendSms").click(function(){
		
		var receiver = $(".smsTo2 #owner_tel").text();
		var sms_content = $("#sms_content").val();
		var sms_title = $("#sms_title").val();
		
		if(receiver == ""){
			alert("받는사람을 추가하세요.");
		} else if(sms_content == ""){
			alert("전송할 문자 내용을 입력하세요.");
		} else {
			alert(receiver);
			
			if(confirm("다음과 같이 문자를 발송합니다. \n 받는사람 : " + receiver +"\n 내용 : \n "+sms_content )){
				//alert("!");
				
				var form = $("<form></form>");
 				form.attr("action", "/sendSms");
 				form.attr("method", "post");
 				form.appendTo("body");
 				form.append($("<input>",{type: 'hidden', name: 'receiver', value: receiver}));
 				form.append($("<input>",{type: 'hidden', name: 'title', value: sms_title}));
 				form.append($("<input>",{type: 'hidden', name: 'content', value: sms_content}));
 				form.submit();
				
			}
			
		}
	});
	
// 고객검색 & 검색해서 추가한 사람은 재검색시 출력안되게
	$("#search_btn").click(function(){
		
		let search_client = $.trim($("#search_client").val());
		let pet_names = $(".smsTo2 #pet_name").text();
		//alert(pet_names);
		$("#search_client").val(search_client);
		
		
		$.post({
			url : "/sms_search_client",
			data : {"search_client" : search_client, "pet_names" : pet_names},
			dataType :"json"
		}).done(function(data){
			$(".tbody2").children().remove();
			
			let searchClient = data.search_client;
			
			for(let i = 0; i < searchClient.length; i++){
				
				let pet_name = searchClient[i].pet_name;
				let owner_name = searchClient[i].owner_name;
				let owner_tel = searchClient[i].owner_tel;
				
				var search_client = "<tr id='client_tr'>"
									+"<td class='col-3' id='pet_name'>"+pet_name+" </td>" /* 공백지우면안됨!! */
									+"<td class='col-3' id='owner_name'>"+owner_name+"</td>"
									+"<td class='col-4 owner_tel' id='owner_tel'>"+owner_tel+" </td>" /* 공백지우면안됨!! */
									+"<td class='col-2'><i class='replusbtn xi-plus-circle-o xi-x' style='color: #4e73df; cursor: pointer;'></i></td>"
									+"</tr>"
				$(".tbody2").append(search_client);
			
			}
			
		}).fail(function(xhr){
			alert("통신실패");
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
				
				 
					<!-- card-header -->
					<div class="card shadow">
				
						<div class="card-header py-2">
							<ul class="nav nav-pills">
								<li class="nav-item"><a class="nav-link"
									aria-current="page" href="#" >일반문자</a></li>
								<!-- 
								<li class="nav-item"><a class="nav-link" href="#">예약문자</a></li>
								<li class="nav-item"><a class="nav-link" href="#">전송내역</a></li>
								 -->
								 
							</ul>
						</div>
				 
						<div class="card-body row">
							<!-- 문자보내기  -->
							<div class="row smsform"
								style="width: 265px; margin: 0 10px 0 15px;">
								<div class="mt-2 mb-2 font-weight-bold text-primary"
									style="width: 260px; height: 30px; text-align: center; line-height: 30px;">
									문자보내기</div>
								<div class=" smsFormWrite" style="">
									<input type="hidden" id="sms_hidden"> <input
										type="text" id="sms_title" name="sms_title"
										class="form-control" style="width: 100%; height: 40px;"
										placeholder="제목">
									<textarea class="form-control sms_content" id="sms_content"
										name="sms_content"
										style="width: 100%; height: 240px; border: 1; margin-top: 2px; position: relative;"
										placeholder="내용" maxlength="40"></textarea>
									<div id="sms_count"
										style="position: absolute; font-size: 15px;">
										<span>0</span>/40자
									</div>
								</div>
								<div class="padding" style="width: 100%">
									<button type="button" id="sms_form1" name="sms_form1"
										class="btn btn-sm btn-outline-secondary btn-margin" value="1">${smsFormName[0] }</button>
									<button type="button" id="sms_form2" name="sms_form2"
										class="btn btn-sm btn-outline-secondary btn-margin" value="2">${smsFormName[1] }</button>
									<button type="button" id="sms_form3" name="sms_form3"
										class="btn btn-sm btn-outline-secondary btn-margin" value="3">${smsFormName[2] }</button>
									<button type="button" id="sms_form4" name="sms_form4"
										class="btn btn-sm btn-outline-secondary btn-margin" value="4">${smsFormName[3] }</button>
									<button type="button" id="sms_form5" name="sms_form5"
										class="btn btn-sm btn-outline-secondary btn-margin" value="5">${smsFormName[4] }</button>
									<button type="button" id="sms_form6" name="sms_form6"
										class="btn btn-sm btn-outline-secondary btn-margin" value="6">${smsFormName[5] }</button>
									<input type="button" id="sms_formset" name="sms_formset"
										class="btn btn-sm btn-outline-secondary btn-margin"
										value="양식저장" href="/smsform_set"> <input type="button"
										id="sms_formdel" name="sms_formdel"
										class="btn btn-sm btn-outline-secondary btn-margin"
										value="양식삭제">
								</div>
								<div class="mb-2 justify-content-md-center"
									style="width: 100%; padding: 0 20px 0 20px;">
									<input type="button" id="sendSms" class="btn btn-primary"
										value="전송" style="width: 99%">
								</div>
								<div class="justify-content-md-center"
									style="width: 100%; padding: 0 20px 0 20px;">
									<input type="button" id="reset" class="btn btn-outline-primary"
										value="초기화" style="width: 99%">
								</div>
							</div>

							<!-- 번호추가 + 받는사람 -->
							<div style="margin: 0 10px 0 10px;">
								<div class="card smsform" style="width: 400px;">

									<!-- 번호추가 -->
									<div class="row smsTo mb-2">
										<div class="mt-2 mb-2 font-weight-bold text-primary"
											style="width: 100%; height: 30px; text-align: center; line-height: 30px;">
											번호추가</div>
										<div class="row smsTo" style="">
											<input type="hidden" id="sms_hidden_num"> <input
												type="text" id="sms_newdog" name="sms_newdog"
												class="col-3 form-control-sm form-control"
												style="height: 40px; margin-right: 5px;" placeholder="동물명">
											<input type="text" id="sms_newowner" name=""
												sms_newowner""
												class="col-3 form-control-sm form-control"
												style="height: 40px; margin-right: 5px;" placeholder="보호자명">
											<input type="text" id="sms_newnum" name="sms_newnum"
												class="col-4 form-control-sm form-control"
												style="height: 40px; margin-right: 5px;" placeholder="전화번호"
												maxlength="11"
												onKeyup="this.value=this.value.replace(/[^-0-9]/g,'');">
											<input type="button"
												class="btn btn-sm btn-outline-primary sms_numplus"
												value="추가">
										</div>
									</div>

									<!-- 받는사람 -->
									<div class="mt-2 mb-2 font-weight-bold text-primary"
										style="width: 100%; height: 30px; text-align: center; line-height: 30px;">
										받는사람</div>
									<div style="height: 452px;">
										<div class="row smsTo2" style="width: 370px;">
											<table class="border table-sm table-bordered"
												style="width: 100%; text-align: center;">
												<thead>
													<tr style="background-color: #f8f9fc;">
														<th class="col-3">동물명</th>
														<th class="col-3">보호자명</th>
														<th class="col-4">전화번호</th>
														<th class="col-2">삭제</th>
													</tr>
												</thead>
												<tbody class="tbody1">
											</table>
										</div>
									</div>
									<div class="mt-3 d-grid gap-2 d-md-flex justify-content-md-end"
										style="width: 100%; height: 40px; padding: 0 30px 10px 30px; margin: 5px 0 0 0;">

										<input type="button" id="minusAll"
											class="btn btn-sm btn-outline-secondary" value="전체해제">
									</div>

								</div>
							</div>

							<!-- 회원정보 -->
							<div class="card smsform"
								style="width: 413px; margin: 0 10px 0 10px;">
								<div class="row mt-2 mb-2 font-weight-bold text-primary" style="width: 100%; height: 30px; line-height: 30px;">
									<div class="col-6" style="margin-left:27px; text-align:center;">
									병원고객목록
									</div>
									<input type="text" class="form-control form-control-sm border-gray col-md-4"
												name="search_client" id="search_client"
												placeholder="검색">
									<div class="input-group-append">
										<button class="btn btn-sm btn-primary" type="button" id="search_btn">
											<i class="fas fa-search"></i>
										</button>
									</div>
								</div>
								<div style="height: 546px;">
									<div class="row memberlist mb-2"
										style="width: 370px; margin: 0 20px 0 20px;">
										<table class="border table-sm table-bordered"
											style="width: 100%; text-align: center;">
											<thead>
												<tr style="background-color: #f8f9fc;">
													<th class="col-3">동물명</th>
													<th class="col-3">보호자명</th>
													<th class="col-4">전화번호</th>
													<th class="col-2">추가</th>
												</tr>
											</thead>
											<tbody class="tbody2">
												<c:forEach items="${clientList }" var="cl">
													<tr class="client" id="client_tr">
														<td class="col-3" id="pet_name">${cl.pet_name } </td>
														<td class="col-3" id="owner_name">${cl.owner_name }</td>
														<td class="col-4 owner_tel" id="owner_tel" value="1">${cl.owner_tel } </td>
														<td class="col-2"><i
															class="plusbtn xi-plus-circle-o xi-x"
															style="color: #4e73df; cursor: pointer;"></i></td>
													</tr>
												</c:forEach>
											</tbody>
										</table>
									</div>
								</div>
								<div class="mt-3 d-grid gap-2 d-md-flex justify-content-md-end"
									style="width: 100%; height: 40px; padding: 0 30px 10px 30px; margin: 5px 0 0 0; font-size:12px;">
								* SMS수신동의한 고객만 표시됩니다.
									<input type="button" id="plusAll"
										class="btn btn-sm btn-outline-secondary" value="전체선택" style="margin-left:40px;">
								</div>
							</div>
							
							<!-- 전송내역 -->
							<div class="smsform"
								style="flex-grow:1; margin: 0 10px 0 10px;">
								<div class="mt-2 mb-2 font-weight-bold text-primary"
									style="width: 100%; height: 30px; text-align: center; line-height: 30px;">
									문자전송내역
								</div>
								<div style="height: 546px;">
									<div class="row memberlist mb-2"
										style="width: 93%; margin: 0 10px 0 20px;">
										<table class="border table-sm table-bordered"
											style="width: 100%; text-align: center;">
											<thead>
												<tr style="background-color: #f8f9fc;">
													<th class="col-4">전송일시</th>
													<th class="col-2">결과</th>
													<th class="col-3">수신번호</th>
													<th class="col-3">제목</th>
												</tr>
											</thead>
											<tbody>
												<c:forEach items="${smsDetail }" var="s" >
												<tr>
													<td class="col-4">${s.smsData_date }</td>
													<td class="col-2">
														<c:if test="${s.smsData_status eq 'success'}">
															전송완료
														</c:if>
														<c:if test="${s.smsData_status eq 'fail'}">
															전송실패
														</c:if>
													</td>
													<td class="col-3">${s.smsData_receiver }</td>
													<td class="col-3">${s.smsData_title }</td>
												</tr>
												</c:forEach>
											</tbody>
										</table>
									</div>
								</div>
								
								
							</div>

						</div> <!-- card-body -->
					</div>
				</div>
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
