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

						});
		$(document)
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

						});

		$(document).on("click", ".chartUpdate", function() {
			$("#petSearchModal").modal("hide");
			var pet_no = $(this).attr("value");
			location.href = "/chartUpdate?pet_no=" + pet_no;
		});
		
	});