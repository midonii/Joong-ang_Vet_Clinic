/* 예지 */
	$(function() {
		$("#search_btn")
				.click(
						function() {
							var pet_search = $("#pet_search").val();

							if (pet_search == "") {
								alert("검색어를 입력하세요");
								$("#pet_search").focus();
								return false;
							} else {
								$("#petSearchModal").modal("show");
								$
										.ajax({
											url : '/petSearchAjax',
											type : 'POST',
											data : {
												"pet_search" : pet_search
											},
											success : function(data) {
												let pet = data.pet;
												$(".petTable").empty();
												var table = "";
												if (pet == "") {
													table += "<tr class='text-center'> <td colspan='6'>존재하지 않습니다.<br><br>";
												} else {
													for (let i = 0; pet.length > i; i++) {
														var pno = pet[i].pno;
														var pet_no = pet[i].pet_no;
														var pet_name = pet[i].pet_name;
														var owner_name = pet[i].owner_name;
														var owner_tel = pet[i].owner_tel;
														var pet_gender = pet[i].pet_gender;

														table += "<tr class='text-center' >";
														table += "<td class='col-1'>"
																+ pno + "</td>";
														table += "<td class='col-2'>"
																+ pet_name
																+ "</td>";
														table += "<td class='col-2'>"
																+ owner_name
																+ "</td>";
														table += "<td class='col-1'>"
																+ pet_gender
																+ "</td>";
														table += "<td class='col-4'>"
																+ owner_tel
																+ "</td>";
														table += "<td class='col-2'><button type='button' class='btn btn-sm search_reserv_btn' style='border: 1px solid #0d6efd; color: #0d6efd;' value='"+pet_no+"'>선택</button></td> ";
														table += "</tr>";

													}

												}
												$(".petTable").append(table);
											},
											error : function(e) {
												alert("실패");
											}
										});
							}

						});
						
	//검색후 선택 버튼
	$(document).on("click", ".search_reserv_btn", function() {
		let detail_no = $(this).attr("value"); //pet_no정보 (button의 value값)
		alert(detail_no + " : pet_no"); //ok

//		var reservation_date_day = $("#s_reservation_date_day").val(); //날짜
//		alert(reservation_date_day);//ok

		$.ajax({
			url: "/reservAjax",
			type: "POST",
			data: { "detail_no": detail_no
//			, "reservation_date_day": reservation_date_day 
			}, //button클릭하면 받아오는 pet_no정보를 컨트롤러(서버)에 보냄 //search_no기준으로 나머지 정보가져옴
			dataType: "json",
			cache: false
		}).done(function(data) {
			//alert('성공'); //ok
			let result = data.result;
//			let result1 = data.result1; //시간막기

//			for (var i = 0; i < result1.length; i++) {
//				let disabled_time = result1[i].reserv_time;
//				alert(disabled_time);
//				alert(reservation_date_day+"날짜의 disabled_time:"+disabled_time); //예약된 시간 다 조회
//				let time = $("input[name='reserv_time'][value='" + disabled_time + "']").siblings('label').text();
//				alert("time:"+time); // null
//				if (disabled_time == time) {
//					alert("일치");
//					$("input[name='reserv_time'][value='" + disabled_time + "']").attr("disabled", true);
//				}
//			}
			
			$("#petSearchModal").modal("hide");
			$('#owner_name').val(result[0].owner_name);
			$('#owner_tel').val(result[0].owner_tel);
			$('#pet_name').val(result[0].pet_name);
			$('#pet_gender').val(result[0].pet_gender);
			$('#pet_birth').val(result[0].pet_birth);
			$('#petNo').val(result[0].pet_no);
			$('#ok-button').val(result[0].pet_no);
			$('.timeoption').appendTo('.timeset');
			
		})
			.fail(function(jqXHR, textStatus, errorThrown) {
				alert("get request failed: " + errorThrown);
			});
	}); //예약버튼 끝
						
						
						
						
					});
		/*$(document)
				.on(
						"click",
						"#search_btn2",
						function() {

							console.log("search_btn2 클릭");
							var pet_search = $("#pet_search2").val();

							if (pet_search == "") {
								alert("검색어를 입력하세요");
								$("#pet_search").focus();
								return false;
							} else {
								$
										.ajax({
											url : '/petSearchAjax',
											type : 'POST',
											data : {
												"pet_search" : pet_search
											},
											success : function(data) {
												let pet = data.pet;
												$(".petTable").empty();
												var table = "";
												if (pet == "") {
													table += "<tr class='text-center'> <td colspan='6' >존재하지 않습니다.<br><br>";
												} else {
													for (let i = 0; pet.length > i; i++) {
														var pno = pet[i].pno;
														var pet_no = pet[i].pet_no;
														var pet_name = pet[i].pet_name;
														var owner_name = pet[i].owner_name;
														var owner_tel = pet[i].owner_tel;
														var pet_gender = pet[i].pet_gender;

														table += "<tr class='text-center' >";
														table += "<td class='col-1'>"
																+ pno + "</td>";
														table += "<td class='col-2'>"
																+ pet_name
																+ "</td>";
														table += "<td class='col-2'>"
																+ owner_name
																+ "</td>";
														table += "<td class='col-1'>"
																+ pet_gender
																+ "</td>";
														table += "<td class='col-4'>"
																+ owner_tel
																+ "</td>";
														table += "<td class='col-2'><button type='button' class='btn btn-primary btn-sm chartUpdate' value='"+pet_no+"'>열기</button></td>";
														table += "</tr>";

													}

												}
												$(".petTable").append(table);
											},
											error : function(e) {
												alert("실패");
											}
										});
							}

						});*/

/*		$(document).on("click", ".chartUpdate", function() {
			$("#petSearchModal").modal("hide");
			var pet_no = $(this).attr("value");
			location.href = "/chartUpdate?pet_no=" + pet_no;
		});
		
	}); */