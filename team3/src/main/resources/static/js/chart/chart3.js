/* 예지 */
$(function() {

	$("#chartAdd").click(function() {
		var trlength = $(".saveTable1 > tr").length;
		var objArr = [];

		for (i = 0; i < trlength; i++) {
			objArr.push({ medical_no: $("[name='mediNum" + i + "']").attr('id'), medical_ea: $("[name='mediNum" + i + "']").val() });
		}

		var arr = new Array();
		var arr2 = new Array();
		for (let obj of objArr) {
			arr.push(obj.medical_ea);
			arr2.push(obj.medical_no);
		}

		var pet_no = $("#pet_no").val();
		var receive_no = $("#receive_no").val();
		var chart_memo = $("#chart_memo").val().replace(/\n/g, "<br>");
		var totalprice = $(".totalPrice").attr("id");

		if (pet_no == "") {
			alert("동물을 선택해주세요.");
		} else {
			if (confirm("차트를 저장하시겠습니까?")) {
				$.post({
					url: "/chartAdd",
					data: {
						"pet_no": pet_no,
						"chart_memo": chart_memo,
						"receive_no": receive_no,
						"totalPrice": totalprice,
						"arr": arr,
						"arr2": arr2
					},
					dataType: "json"
				}).done(function(data) {
					if (data.result == 1 && data.stateUpdate == 1 && data.payAdd == 1) {
						alert("차트가 저장되었습니다.");
						location.href = "/chart";

					} else {
						alert("권한이 없습니다.");
					}
				}).fail(function() {
					alert("문제발생");
				});
			}
		}


	});

});

$(function() {
	$("#search_btn")
		.click(
			function() {
				var pet_search = $.trim($("#pet_search").val());
	
				if (pet_search == "") {
					alert("검색어를 입력하세요");
					$("#pet_search").focus();
					return false;
				} else {
					$("#petSearchModal").modal("show");
					$
						.ajax({
							url: '/petSearchAjax',
							type: 'POST',
							data: {
								"pet_search": pet_search
							},
							success: function(data) {
								let pet = data.pet;
								$("#pet_search").val(pet_search);
								$("#pet_search2").val(pet_search);
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
										var owner_tel = pet[i].s_Tel;
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
										table += "<td class='col-2'><button type='button' class='btn btn-primary btn-sm chartUpdate' value='" + pet_no + "'>열기</button></td>";
										table += "</tr>";

									}

								}
								$(".petTable").append(table);
							},
							error: function(e) {
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

				var pet_search = $.trim($("#pet_search2").val());

				if (pet_search == "") {
					alert("검색어를 입력하세요");
					$("#pet_search").focus();
					return false;
				} else {
					$
						.ajax({
							url: '/petSearchAjax',
							type: 'POST',
							data: {
								"pet_search": pet_search
							},
							success: function(data) {
								let pet = data.pet;
								$("#pet_search2").val(pet_search);
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
										var owner_tel = pet[i].s_Tel;
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
										table += "<td class='col-2'><button type='button' class='btn btn-primary btn-sm chartUpdate' value='" + pet_no + "'>열기</button></td>";
										table += "</tr>";

									}

								}
								$(".petTable").append(table);
							},
							error: function(e) {
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
