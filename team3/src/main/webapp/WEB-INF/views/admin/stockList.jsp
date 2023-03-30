<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<%
if (session.getAttribute("id") != null) {
	if (!session.getAttribute("staff_grade").equals("admin")) {
		response.sendRedirect("/index?error=1234");
	}
} else {
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
<link rel="shortcut icon" type="image/x-icon" href="../img/favicon.png" />

<!-- datepicker -->
	<link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
	<!-- 안됨ㅡㅡ <link rel="stylesheet" href="/resources/demos/style.css">  -->
	<link rel="stylesheet" href="css/stock/jquery-ui.css">

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

<!-- Custom styles for this page -->
<link href="vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">

<style type="text/css">

.row-margin0{
	margin:0;
}

.border-radius{
	border: 1px solid #e3e6f0;
	border-radius: 0.35rem;
}

.search_criteria{
/* 	min-width:150px;  */
	height:35px; 
	text-align:center; 
	line-height:35px;
	margin: 0 0 5px 0;
	background-color: #f8f9fc;
	font-weight: bold;
	font-size:15px;
}
.cursor{
	cursor:pointer;
}
.radio-div{
	width: auto; 
	height:40px; 
	margin:0 15px;
	line-height:35px;
}
.radio{
	margin-top:10px;
	border-color: #f8f9fc;
}
.editInputCSS{
	width:99%;
	font-size:13px;
	text-align:center;
}

.list_table thead {
  display: table; /* to take the same width as tr */
  width: calc(100% - 17px); /* - 17px because of the scrollbar width */
}

.list_table tbody {
  width:100%;
  display: block; /* to enable vertical scrolling */
  max-height: 467px; /* 스크롤시466px / 페이징 427px */
  overflow-y: scroll; /* keeps the scrollbar even if it doesn't need it; display purpose */
}


.list_tr {
  display: table; /* display purpose; th's border */
  width: 100%;
  box-sizing: border-box; /* because of the border (Chrome needs this line, but not FF) */
}

.list_tr td {
	width:100%;
  text-align: center;
  border-bottom: none;
  border-left: none;
} 


</style>
</head>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script type="text/javascript">
$(function(){
	
// ---- 처방기간조회 날짜 오늘로 설정 -----	
 	let date = new Date();
    let month = date.getMonth() + 1;
    let day = date.getDate();
    
    if(month < 10){
    	month = "0" + month;
    }
    if(day < 10){
    	day = "0" + day;
    }
    
    let today = date.getFullYear() +'-' + month + '-' + day;
 	
// ----- datepicker -------
	$( ".datepicker" ).datepicker({
		dateFormat: 'yy-mm-dd',
		setDate: date,
	  	  prevText: '이전 달',
	  	  nextText: '다음 달',
	  	  monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
	  	  monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
	  	  dayNames: ['일', '월', '화', '수', '목', '금', '토'],
	  	  dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
	  	  dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
	  	  showMonthAfterYear: true,
	  	  changeMonth: true,
	  	  changeYear: true,
	  	  yearSuffix: '년',
	  	  beforeShowDay: noSundays,                                                                                                                                                                               
	  	  
 		  minDate: new Date('2023-01-01'),
		  maxDate: 0,
		  onClose: function( selectedDate ) {    
			  //alert(selectedDate);
              $(".datepicker2").datepicker( "option", "minDate", selectedDate );
              // 시작일(sDatepicker) datepicker가 닫힐때
              // 종료일(eDatepicker)의 선택할수있는 최소 날짜(minDate)를 선택한 시작일로 지정
          }                	
	});
	
	// 일요일 선택 막기
	function noSundays(date) {
		return [date.getDay() != 0, ''];
	}
	
	$(".datepicker2").datepicker({
		dateFormat: 'yy-mm-dd',
	  	  prevText: '이전 달',
	  	  nextText: '다음 달',
	  	  monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
	  	  monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
	  	  dayNames: ['일', '월', '화', '수', '목', '금', '토'],
	  	  dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
	  	  dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
	  	  showMonthAfterYear: true,
	  	  changeMonth: true,
	  	  changeYear: true,
	  	  yearSuffix: '년',
	  	  beforeShowDay: noSundays,                                                                                                                                                                               
		  maxDate: 0,
	});
	
	
// ----- 초기화버튼 --------
	$("#reset").click(function(){
		location.href="/stockList";
	});
	
	
// -- 구매처명 직접입력 아닐때 텍스트박스 비활성화 --
	$("#purchasingOfficeSelect").change(function(){
		
		var purchasingOfficeOption = $("#purchasingOfficeSelect option:selected").text();
		
		if(purchasingOfficeOption != "직접입력"){
			$("#purchasingOffice").attr("readonly",true);
		} else {
			$("#purchasingOffice").attr("readonly",false);
		}
	});
	
// -- 처방기간조회 삭제 (x버튼) --
	$("#fromDateDel").click(function(){
		$("#fromDate").val("");
	});
	$("#toDateDel").click(function(){
		$("#toDate").val("");
	});

//-------- 조회버튼 클릭 --------------
	$("#select").click(function(){
		
	// 카테고리 - 라디오버튼
		var radioValue = $("input[name='stock_radio']:checked").val();
		//alert(radioValue);
		
	// 약명
		var medicineName = $.trim($("#medicineName").val());
		//alert(medicineName);
		$("#medicineName").val(medicineName);
		
	// 구매처명
		var purchasingOfficeOption = $("#purchasingOfficeSelect option:selected").text();
		var purchasingOffice = $.trim($("#purchasingOffice").val());
		//alert(purchasingOfficeOption + purchasingOffice);
		$("#purchasingOffice").val(purchasingOffice);
		
	// 처방기간조회
		var fromDate = $("#fromDate").val();
	 	var toDate = $("#toDate").val();
	  	//alert(fromDate + " / " + toDate);
	
	 	if(fromDate != "" && toDate != ""){
			$("#th_today").text("처방수량(개)");
		} else if (fromDate == "" && toDate == ""){
			$("#th_today").text("당일처방수량(개)");
		}
	 	
	 	if((fromDate != "" && toDate == "") || (fromDate == "" && toDate != "")){
	 		alert("정확한 기간을 입력해주세요.");
	 		return false;
	 	}
	  	
	// 조회 후 리스트 출력
		$.post({
			url : "/stockSelect",
			data : {
				"radioValue" : radioValue,
				"medicineName" : medicineName,
				"purchasingOfficeOption" : purchasingOfficeOption,
				"purchasingOffice" : purchasingOffice,
				"fromDate" : fromDate,
				"toDate" : toDate
			},
			dataType : "json"
		}).done(function(data){
			//alert("성공");
			
 			//alert(data.searchList[0].medical_stock);
			$("tbody").empty();
			
			
			var searchList = data.searchList ;
			//alert(searchList.length);
			
			if(searchList.length == '0'){
				$(".tbody1").append("<br><br>검색내용에 해당하는 약품이 없습니다.<br><br><br>");
			} else {
	 			for(let i = 1 ; i <= searchList.length; i++){
					
					let medical_subcate = data.searchList[i-1].medical_subcate;
					let medical_name = data.searchList[i-1].medical_name;
					
					let medical_company = data.searchList[i-1].medical_company;
					let medical_buying = data.searchList[i-1].medical_buying;
	 				let medical_price = data.searchList[i-1].medical_price;
	 				let medicaldata_sum = data.searchList[i-1].medicaldata_sum;
	 				let medical_stock = data.searchList[i-1].medical_stock;
	 				
	 				if(medicaldata_sum == undefined){
	 					medicaldata_sum = "-";
	 				} 
	 				
	 				if(medical_company == undefined || medical_buying == undefined || medical_price == undefined ){
	 					medical_company = "-";
	 					medical_buying = "-";
	 					medical_price = "-";
	 					medical_stock = "-";
	 				} else {
						medical_buying = medical_buying.toLocaleString();
	 					medical_price = medical_price.toLocaleString();
	 				}
					
					var tr = "<tr class='list_tr'>"
								+"<td style='width: 3%'>"+i+"</td>"
								+"<td style='width: 5%'>"+medical_subcate+"</td>"
								+"<td id='td_company' style='width: 10%'>"+medical_company+"</td>"
								+"<td id='td_medicineName' style='width: 15%'>"+medical_name+"</td>"
								+"<td id='td_buyingPrice' style='width: 7%'>"+medical_buying+"</td>"
								+"<td id='td_presPrice' style='width: 7%'>"+medical_price+"</td>"
								+"<td id='td_stock' style='width: 5%'>"+medical_stock+"</td>"
								+"<td style='width: 5%'>"+medicaldata_sum+"</td>"
								+"<td style='width: 3%'><i class='xi-border-color cursor editbtn' style='color: #4E73DF;'></i></td>";
							+"</tr>"
							
					$(".tbody1").append(tr);
				}
			}
			
		}).fail(function(xhr){
			alert("실패");
			
		});
	});
	
// ----- 약품 수정(구매처, 가격) -----
	$(document).on("click", ".editbtn", function(){
		
		//--- 구매처, 매입가, 처방가, 아이콘 td 선언
		let td_company = $(this).parent().siblings("#td_company");
		let td_buyingPrice = $(this).parent().siblings("#td_buyingPrice");
		let td_presPrice = $(this).parent().siblings("#td_presPrice");
		let td_stock = $(this).parent().siblings("#td_stock");
		let td_icon = $(this).parent();
		
		//--- 구매처, 매입가, 처방가 text 받아오기(수정시 input창에 해당 값 표시)
		let company = td_company.text();
		let buyingPrice = (td_buyingPrice.text()).replace(",","");
		let presPrice = (td_presPrice.text()).replace(",","");
		let stock = td_stock.text();
		//alert(company + " / " + buyingPrice  + " / " + presPrice + " / " + stock);
		
		//--- td 하위요소 지우기
		td_company.empty();
		td_buyingPrice.empty();
		td_stock.empty();
		td_presPrice.empty();
		td_icon.empty();
		
		//--- 수정 input 코드 선언 및 td 안에 추가
		let InputCompany = "<input type='text' id='editCompany' class='form-control-sm form-control editInputCSS' value='"+company+"'>";
		let InputBuyingPrice = "<input type='text' id='editBuyingPrice' class='form-control-sm form-control editInputCSS'  value='"+buyingPrice+"'>";
		let InputPresPrice = "<input type='text' id='editPresPrice' class='form-control-sm form-control editInputCSS'  value='"+presPrice+"'>";
		let InputStock = "<input type='text' id='editStock' class='form-control-sm form-control editInputCSS'  value='"+stock+"'>";
		let saveIcon = "<i class='xi-save xi-x cursor savebtn' style='color: #4E73DF;'></i>";
		
		td_company.append(InputCompany);
		td_buyingPrice.append(InputBuyingPrice);
		td_stock.append(InputStock);
		td_presPrice.append(InputPresPrice);
 		td_icon.append(saveIcon);
 		
		
	});
	
	//--- 매입가, 처방가 문자입력막기
	$(document).on('keyup', "#editBuyingPrice, #editPresPrice, #editStock", function(){
		$(this).val($(this).val().replace(/[^0-9]/g, ""));
	});
	
	// --- 수정하고 저장버튼 누르면 db수정
	$(document).on("click",".savebtn",function(){
		let medicineName = $(this).parent().siblings("#td_medicineName").text();
		
		let td_company = $(this).parent().siblings("#td_company") ;
		let td_buyingPrice = $(this).parent().siblings("#td_buyingPrice") ;
		let td_presPrice = $(this).parent().siblings("#td_presPrice");
		let td_stock = $(this).parent().siblings("#td_stock") ;
		let td_icon = $(this).parent();
		
		let editCompany = td_company.children("#editCompany").val() ;
		let editBuyingPrice = td_buyingPrice.children("#editBuyingPrice").val() ;
		let editPresPrice = td_presPrice.children("#editPresPrice").val() ;
		let editStock = td_stock.children("#editStock").val() ;
		//alert(medicineName + " / " + editCompany + " / " + editBuyingPrice + " / " + editPresPrice + " / " + editStock);
		
		$.post({
			url : "/edit",
			data : {
				"medicineName" : medicineName,
				"editCompany" : editCompany,
				"editBuyingPrice" : editBuyingPrice,
				"editStock" : editStock,
				"editPresPrice" : editPresPrice
			},
			dataType : "json"
		}).done(function(data){
			if(data.result == '1'){
				alert("변경사항이 저장되었습니다.");
				
				td_company.empty();
				td_buyingPrice.empty();
				td_stock.empty();
				td_presPrice.empty();
				td_icon.empty();
				
				editBuyingPrice = (parseInt(editBuyingPrice).toLocaleString());
				editPresPrice = (parseInt(editPresPrice)).toLocaleString();
				editStock = (parseInt(editStock)).toLocaleString();
				
				td_company.text(editCompany);
				td_buyingPrice.text(editBuyingPrice);
				td_presPrice.text(editPresPrice);
				td_stock.text(editStock);
				td_icon.append("<i class='xi-border-color cursor editbtn' style='color: #4E73DF;'></i>");
				
			} else {
				alert("변경사항 저장에 실패했습니다.");
			}
			
		}).fail(function(xhr){
			alert("통신실패");
		});
		
	});
	
// ---- 페이지번호누르기 ----
/*
	$(".pagenum").click(function(){
		
		let contentnum = 14;
		let pagenum = $(this).text();
		alert("클릭한페이지번호:" + pagenum);
		
		$.post({
			url : "/paging",
			data : {
				"pagenum" : pagenum,
				"contentnum" : contentnum
			},
			dataType : "json"			
		}).done(function(data){
			alert("성공");
			
		}).fail(function(xhr){
			alert("실패");
		});
		
	});
*/	
	
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
					<div class="mb-1"
						style="font-size: 13px; margin-top: -10px; padding-left: 8px;">
						<a href="/index" style="text-decoration: none;"
							class="text-gray-600"> <i class="fa-solid fa-house-chimney"></i>
						</a>&nbsp;&nbsp; <i class="fa-sharp fa-solid fa-chevron-right"></i>&nbsp;
						<a href="/stockList" style="text-decoration: none;"
							class="text-gray-700">관리자(약품 재고 관리)</a>
					</div>
					<!-- card -->
					<div class="card shadow">
						<div class="card-body row row-margin0">
							<!----- 검색조회칸 ----->
							<div class="card"
								style="width: 100%; height: 155px; margin: 10px; padding: 15px; font-size: 15px;">
								<!----- 검색첫째줄 ----->
								<div class=" row row-margin0 "
									style="width: 100%; height: 40px;">
									<div class="card search_criteria" style="width: 10%;">
										카테고리</div>
									<div class="row row-margin0 align-middle"
										style="vertical-align: middle; padding-left: 10px;">
										<div class="form-check radio-div" style="margin: 0 10px 0 0;">
											<input class="form-check-input radio" type="radio"
												name="stock_radio" id="stock_radio0" checked value="전체보기"> <label
												class="form-check-label cursor" for="stock_radio0">
												전체보기 </label>
										</div>
										<c:forEach items="${m_subcate }" var="ms" varStatus="cate_no">
											<div class="form-check radio-div">
												<input class="form-check-input radio" type="radio"
													name="stock_radio" id="stock_radio${cate_no.count }" value="${ms }"> 
												<label class="form-check-label cursor" for="stock_radio${cate_no.count }">${ms } </label>
											</div>
										</c:forEach>
									</div>
								</div>
								<!----- 검색둘째줄 ----->
								<div class="row row-margin0" style="width: 100%; height: 40px;">
									<!-- 구매처 -->
									<div class="row row-margin0"
										style="width: 33%; ">
										<div class="card search_criteria" style="width: 30.3%;">구매처명</div>
										<!-- 구매처선택 -->
										<div class=""
											style="width: 30%; height: 35px; margin: 0 0 5px 10px;">
											<select class="form-control form-select" id="purchasingOfficeSelect" style="height: 35px; font-size: 14px;">
												<option selected value="0">직접입력</option>
												<c:forEach items="${m_company }" var="mc">
													<option>${mc }</option>
												</c:forEach>
											</select>
										</div>
										<!-- 구매처 직접입력 id="purchasingOffice" -->
										<div class="card"
											style="width: 33%; height: 35px; margin: 0 0 5px 10px;">
											<input type="text" class="form-control" id="purchasingOffice" style="height: 33px; border: 0; font-size:14px;">
										</div>
									</div>
									<!-- 약 -->
									<div class="row row-margin0 "
										style="width: 25%; margin-right: 10px;">
										<div class="card search_criteria" style="width: 39%;">약&nbsp;&nbsp;품&nbsp;&nbsp;명</div>
										<!-- 약명 입력 id="medicineName" -->
										<div class="card" style="width: 57%; height: 35px; margin: 0 0 5px 10px;">
											<input type="text" class="form-control" id="medicineName" style="height: 33px; border: 0; font-size:14px;">
										</div>
									</div>
									<!-- 기간조회 -->
									<div class="row row-margin0"
										style="flex-grow: 1; line-height: 35px;">
										<div class="card search_criteria" style="width: 28%;">처방수량 기간조회</div>
										<div class="row row-margin0" style="width: 70%;">
											<div class="card row" style="width: 45%; height: 35px; margin: 0 10px 5px 10px;">
												<input class="form-control datepicker cursor" id="fromDate" readOnly 
													style="width: 85%; height: 33px; border: 0; background-color:white; text-align:center;">
												<i class="fa-solid fa-circle-xmark" id="fromDateDel" style="margin-top:8px; cursor:pointer;"></i>
											</div>
											~
											<div class="card row"
												style="width: 45%; height: 35px; margin: 0 0 5px 10px;">
												<input class="form-control datepicker2 cursor" id="toDate" readOnly
													style="width: 85%; height: 33px; border: 0; background-color:white; text-align:center;">
												<i class="fa-solid fa-circle-xmark" id="toDateDel" style="margin-top:8px; cursor:pointer;"></i>
											</div>
										</div>
									</div>
								</div>

								<!-- 조회/수정버튼 -->
								<div class="row row-margin0 d-flex justify-content-end mt-2"
									style="width: 100%; height: 35px;">
									<button type="button" class="btn btn-primary" name="select" id="select"
										style="width: 100px; height: 35px; margin-right: 10px;">조회</button>
									<button type="button" class="btn btn-outline-primary" name="reset" id="reset"
										style="width: 100px; height: 35px; margin-right: 10px;">초기화</button>
								</div>
							</div>

							<!----- 검색리스트 출력 ----->
							<div class="card"
								style="width: 100%; height: 505px; margin: 10px;"><!-- 스크롤시 height:505px / 페이징 height:477px; -->
								<div class="border-radius" style="width: 100%">
									<table class="list_table table-sm table-bordered "
										style="width: 100%; text-align: center; font-size: 14px;">
										<thead>
											<tr class="list_tr" style="background-color: #f8f9fc;">
												<th style="width: 3%;">번호</th>
												<th style="width: 5%;">분류</th>
												<th style="width: 10%;">구매처</th>
												<th style="width: 15%;">약품명</th>
												<th style="width: 7%;">매입가격(원)</th>
												<th style="width: 7%;">처방가격(원)</th>
												<th style="width: 5%;">재고현황(개)</th>
												<th id="th_today" style="width: 5%;">당일처방수량(개)</th>
												<th style="width: 3%;">수정/저장</th>
											</tr>
										</thead>
										<tbody class="tbody1"  style="width:100%;">
											<c:forEach items="${stockList }" var="sL" varStatus="status">
												<tr class="list_tr">
													<td style="width: 3%;">${status.count }</td>
													<td style="width: 5%;">${sL.medical_subcate }</td>
													<td id="td_company" style="width: 10%;">${sL.medical_company } </td>
													<td id="td_medicineName" style="width: 15%;">${sL.medical_name }</td>
													<td id="td_buyingPrice" style="width: 7%;"><fmt:formatNumber value="${sL.medical_buying}" pattern="#,###" /></td>
													<td id="td_presPrice" style="width: 7%;"><fmt:formatNumber value="${sL.medical_price}" pattern="#,###" /></td>
													<td id="td_stock" style="width: 5%;">${sL.medical_stock }</td>
													<c:choose>
														<c:when test="${sL.medicaldata_today eq 0 }">
															<td id="td_prescriptionEA" style="width: 5%;">-</td>
														</c:when>
														<c:otherwise>
															<td id="td_prescriptionEA" style="width: 5%;">${sL.medicaldata_today }</td>
														</c:otherwise>
													</c:choose>
													<td class="aa" id="td_editIcon" style="width: 3%;">
														<i class="xi-border-color cursor editbtn" style="color: #4E73DF;"></i>
													</td>
												</tr>
											</c:forEach>
										</tbody>
									</table>
								</div>
							</div>
							
		<!-- ------------------ 페이징 ------------------- -->
							<%--  <div class="  " style="width: 100%; height: 40px; margin: 5px 0 -10px 0;">
								<div class="row row-margin0 d-flex justify-content-center">
								<ul class="pagination pagination-sm">
									<!-- <li class="page-item"><a class="page-link" href="#">이전</a></li> -->
									<c:forEach begin="${page.getStartPageInBlock() }" end="${page.getLastPage() }" var="idx">
										<li class="page-item cursor "><a class="page-link pagenum" id="">${idx }</a></li>
									</c:forEach>
									<!-- <li class="page-item"><a class="page-link" href="#">다음</a></li> -->
								</ul>
								</div>
							</div>  --%>
							
							
						</div>
						<!-- card-body -->
					</div>
					<!-- card -->
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

				<!-- Page level plugins -->
				<!-- <script src="vendor/datatables/jquery.dataTables.min.js"></script>
				<script src="vendor/datatables/dataTables.bootstrap4.min.js"></script> -->

				<!-- Page level custom scripts -->
			<!-- 	<script src="js/demo/datatables-demo.js"></script> -->


				<!-- datepicker -->
				<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
				<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
				<script type="text/javascript" src="../js/stock/jquery-ui.min.js"></script>
				
</body>

</html>
