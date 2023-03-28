$(function() {
	// sidebar 접어서 창 열기
	$(".sidebar").addClass("toggled");

	var pet_no = $("#pet_no").val();

	$
		.post({
			url: "/receiveboard",
			dataType: "json"
		})
		.done(
			function(data) {
				let receiveboard = data.receiveboard;

				var table = "<table class='table table-sm text-center' style='margin-top:-8px;'>";

				for (let i = 0; i < receiveboard.length; i++) {
					var bno = receiveboard[i].bno;
					var pet_name = receiveboard[i].pet_name;
					var type_name = receiveboard[i].type_name;
					var pet_no = receiveboard[i].pet_no;
					var owner_name = receiveboard[i].owner_name;
					var receive_time = receiveboard[i].receive_time;
					var receive_no = receiveboard[i].receive_no;
					var receive_state = receiveboard[i].receive_state;
					var reservation_date = receiveboard[i].reservation_date;
					var type_name = receiveboard[i].type_name;

					table += "<tr>";
					table += "<td class='col-1' style='vertical-align: middle' >"
						+ bno + "</td>";
					if (reservation_date != null) {
						table += "<td class='col-2'><span class=' badge  rounded-pill bgtime1 '>접</span>&nbsp;"
							+ receive_time;
						table += "<br><span class=' badge  rounded-pill bgtime2 '>예</span>&nbsp;"
							+ reservation_date + "</td>";
					} else {
						table += "<td class='col-2' style='vertical-align : middle;'><span class=' badge  rounded-pill bgtime1'>접</span>&nbsp;"
							+ receive_time;
					}
					table += "<td class='col-5'><a  style='text-decoration: none;' id='pet_name' value='" + receive_no + "' >";
					table += "<b class='text-primary' style='cursor:pointer;'>"
						+ pet_name
						+ "&nbsp;("
						+ type_name
						+ ")"
						+ "</b></a><br>"
						+ owner_name
						+ "</td>";
					if (receive_state == 1) {
						table += "<td style='vertical-align: middle'><span class='badge text-bg-primary'>진료대기</span></td>";
					} else if (receive_state == 2) {
						table += "<td style='vertical-align: middle'><span class='badge text-bg-danger'>진료중</span></td>";

					} else if (receive_state == 3) {
						table += "<td style='vertical-align: middle'><span class='badge text-bg-secondary'>진료완료</span></td>";

					}
					table += "<td class='col-3'><button class='btn btn-sm btn-primary recbtn disabled'>호출</button></td>";

					table += "</tr>";

				}
				$("#receiveboard").append(table);

			}).fail(function() {
				alert("문제가 발생했습니다.");
			});

	$
		.post({
			url: "/petVacAjax",
			cache: false,
			data: {
				"pet_no": pet_no
			},
			dataType: "json"
		})
		.done(
			function(data) {
				let pet = data.pet;
				$("#vac").empty();
				var div = "";
				if (pet == "") {
					div += "<div style='height:300px;line-height: 300px;text-align: center;'>접종 내역이 없습니다.</div>";
				} else {
					for (let i = 0; i < pet.length; i++) {
						var vac_name = pet[i].medical_name;
						var vacdata_date = pet[i].chart_date;
						div += "<div class='list-group-item row'><div class='col-7 font-weight-bold float-left text-center'>"
							+ vac_name
							+ "</div><div class='col-5 float-left text-center'>"
							+ vacdata_date + "</div></div>";
					}
				}
				$("#vac").append(div);
			}).fail(function(xhr, status, errorThrown) {
				alert("실패");
			});
});

$(function() {
	var pet_no = $("#pet_no").val();
	$
		.post({
			url: "/chartAjax",
			cache: false,
			data: {
				"pet_no": pet_no
			},
			dataType: "json"
		})
		.done(
			function(data) {
				let chart = data.chart;
				$("#chart").empty();
				var chartdiv = "<div class='accordion ' id='accordionExample' style='height:700px;' >"
				if (data.chart == "") {
					chartdiv += "<div class='text-center' style='height:705px; line-height:705px;'>진료 내역이 없습니다.</div>";
				} else {
					for (let i = 0; i < chart.length; i++) {
						var receieve_no = chart[i].receieve_no;
						var pet_no = chart[i].pet_no;
						var pet_name = chart[i].pet_name;
						var chart_no = chart[i].chart_no;
						var chart_memo = chart[i].chart_memo;
						var chart_date = chart[i].chart_date;
						var staff_no = chart[i].staff_no;
						var staff_name = chart[i].staff_name;
						var staff_grade = chart[i].staff_grade;
						$("#chart_no").val(chart[i].chart_no);

						chartdiv += "<div class='accordion-item' ><h2 class='accordion-header' id='" + chart_date + "'>"
						chartdiv += "<button class='accordion-button collapsed pastChart ' type='button' data-toggle='collapse' data-target='#A"
							+ chart_no + "' "
						chartdiv += "aria-expanded='";
						chartdiv += i == 0 ? true : false + "'";
						chartdiv += " aria-controls='A" + chart_no
							+ "' value='" + chart_no + "'>";
						chartdiv += "	<div class='font-weight-bold'>차트번호 :</div>";
						chartdiv += "	<div class='ml-2 font-weith'>"
							+ chart_no + "</div>";
						chartdiv += "	<div class='ml-5 font-weight-bold'>진료날짜 :</div>";
						chartdiv += "	<div class='ml-2'>"
							+ chart_date + "</div>";
						chartdiv += "	</button></h2>";
						chartdiv += "<div id='A" + chart_no + "' class='accordion-collapse collapse' aria-labelledby='" + chart_date + "' data-parent='#accordionExample'>";
						chartdiv += "<div class='accordion-body' >"
						chartdiv += "<div class='d-flex justify-content-end'><span>담당의 : </span><span class='font-weight-bold'>&nbsp;"
							+ staff_name + "</span></div>";

						chartdiv += "<div class='mb-4'> <div class='card h-100 py-2'> <div class='card-body'>";
						chartdiv += "<div class='row no-gutters align-items-center'> <div class='col mr-2'>";
						chartdiv += "<div class='text-sm font-weight-bold text-info text-uppercase mb-1'>의사소견 </div>";
						chartdiv += "<div class='row no-gutters align-items-center'>"
							+ chart_memo
							+ "</div></div></div></div></div></div>";

						chartdiv += "<div class='card mb-4'><div class='card-body'><div class='d-flex justify-content-center'>";
						chartdiv += "<div class='text-sm font-weight-bold text-info text-uppercase mb-3 '>처방 상세 내역</div></div><div class='table-responsive' style='height:200px; overflow: auto;'><div id='clientScroll'>";
						chartdiv += "<table class='table table-center table-sm table-bordered text-center'  id='dataTable' width='100%' cellspacing='0'>";
						chartdiv += "<thead><tr>";
						chartdiv += "<th class='col-md-2'>구분</th>";
						chartdiv += "<th class='col-md-2'>분류</th>";
						chartdiv += "<th class='col-md-4'>처방명</th>";
						chartdiv += "<th class='col-md-2'>수량</th>";
						chartdiv += "<th class='col-sm-2'>담당자</th></tr></thead>";

						chartdiv += "<tbody id='client-table" + chart_no + "' data-spy='scroll' data-target='#list-example' data-offset='0' class='scrollspy-example'>";

						chartdiv += "<tr class='chartList" + chart_no + "'>";
						chartdiv += "<td>(카테고리)</td>";
						chartdiv += "<td>(상세 카테고리)</td>";
						chartdiv += "<td class='text-left'>(처방내역)</td>";
						chartdiv += "<td>(수량)</td>";
						chartdiv += "<td>(담당자)</td>";
						chartdiv += "</tbody></table></div></div></div></div></div></div></div>";

					}
				}

				$("#chart").append(chartdiv);

				$(document)
					.on(
						"click",
						".pastChart",
						function() {
							var chartNo = $(this).attr(
								"value");
							$("#chart_no").val(chartNo);
							$("#memo").val("");

							$.post({
								url: "/CDetailAjax",
								data: {
									"chart_no": chartNo,
									"pet_no": pet_no
								},
								dataType: "json"
							}).done(
								function(data) {

									let petChart = data.chart;
									$("#memo").val(petChart[0].chart_memo);

									$(".CBTable").empty();
									let petMedicalData = data.petMedicalData;
									var totalPrice = 0;
									let table2 = "";
									for (let i = 0; petMedicalData.length > i; i++) {
										var medical_category = petMedicalData[i].medical_category;
										var medical_name = petMedicalData[i].medical_name;
										var medicaldata_ea = petMedicalData[i].medicaldata_ea;
										var price = petMedicalData[i].medical_price;
										let medino = petMedicalData[i].medical_no;
										table2 += "<tr style='float:center;'>";
										table2 += "<td class='col-2'>"
											+ medical_category
											+ "</td>";
										table2 += "<td class='col-5'>"
											+ medical_name
											+ "</td>";
										table2 += "<td class='col-2 priceTd' ><input type='number' class='mediNum form-control form-control-sm' id='" + medino + "'name='mediNum" + i + "' style=' text-align:right;' value='" + medicaldata_ea + "' min='1' max='100'></td>";
										table2 += "<td class='col-4 calPrice' id='" + price + "'>"
											+ price * medicaldata_ea
											+ "원</td>";
										table2 += "</tr>";

										totalPrice += price * medicaldata_ea;

									}
									$(".totalPrice").attr("id", totalPrice);
									$(".CBTable").append(table2);
									$(".totalPrice").empty();
									var totalPriceAddc = totalPrice.toLocaleString(); //가격에 , 붙이기
									$(".totalPrice").append(totalPriceAddc + "원");

									/*수량을 변경할때*/
									$(document).on("change", ".mediNum", function() {
										var eachmediNum = $(this).val(); // 수량 
										var eachmediId = $(this).attr("id"); //수정된 체크박스의 id(medical_no)

										var ckInput = $("tbody.CBTable").find("#" + eachmediId); //수정된 체크박스의 id와 일치하는 인풋넘버태그찾기
										var priceTd = ckInput.closest(".priceTd"); //인풋넘버태그 바로위 부모태그 td
										var calprice = priceTd.siblings(".calPrice"); //아래 td (각 가격부분)
										var priceId = calprice.attr("id"); // 가격의 id(1개의 단가);
										var b = priceId * eachmediNum; //단가*변경된수량
										//var changeTotal =b.toLocaleString(); //가격에 ,붙이기
										calprice.text(b + "원");


										var price12 = $(".calPrice").text();
										var priceCut = price12.split("원"); //원으로 나누기
										var prices = new Array(); //배열생성 
										prices = priceCut; //배열에 넣어주기

										var totalSum = 0;
										for (let l = 0; l < (prices.length - 1); l++) {
											var pr = parseInt(prices[l]);
											totalSum += pr;
										}

										$(".totalPrice").attr("id", totalSum);
										var changeTotalPrice = totalSum.toLocaleString(); //가격에 , 붙이기
										$(".totalPrice").empty(); //1개 단가의 총합계를 지운다 0
										$(".totalPrice").append(changeTotalPrice + "원"); //총 합계

									});




								})
								.fail(
									function() {
										alert("문제가 발생했습니다.");
									});

							$
								.post(
									{
										url: "/preAjax",
										data: {
											"chart_no": chartNo,
											"pet_no": pet_no
										},
										dataType: "json"
									})
								.done(
									function(data) {
										let petMedicalData = data.petMedicalData;
										var table = "";
										$(
											'.chartList'
											+ chartNo)
											.hide();
										$(
											"#client-table"
											+ chartNo)
											.empty();
										// -- 검사
										for (let i = 0; petMedicalData.length > i; i++) {
											var medical_category = petMedicalData[i].medical_category;
											var medical_subcate = "";
											if (petMedicalData[i].medical_subcate != undefined) {
												medical_subcate = petMedicalData[i].medical_subcate;
											}
											var medical_name = petMedicalData[i].medical_name;
											var staff_name = petMedicalData[i].staff_name;
											var staff_grade = petMedicalData[i].staff_grade;
											var medicaldata_ea = petMedicalData[i].medicaldata_ea;
											var price = petMedicalData[i].medicaldata_ea;
											table += "<tr class='chartList" + chartNo + "'>";
											table += "<td>"
												+ medical_category
												+ "</td>";
											table += "<td>"
												+ medical_subcate
												+ "</td>";
											table += "<td class='text-left'>"
												+ medical_name
												+ "</td>";
											table += "<td>"
												+ medicaldata_ea
												+ "</td>";
											table += "<td>"
												+ staff_name
												+ "</td>";
											table += "</tr>";

										}
										$(
											"#client-table"
											+ chartNo)
											.append(
												table);
										$(
											"#client-table"
											+ chartNo)
											.show();

									})
								.fail(
									function() {
										alert("문제가 발생했습니다.");
									});

						});
			}).fail(function(xhr, status, errorThrown) {
				alert("실패");
			});



	$("#chartUpdate").click(function() {
		
		var chart_no = $("#chart_no").val();
		var chart_memo = $("#memo").val();
		var totalprice = $(".totalPrice").attr("id");
		var trlength = $(".CBTable > tr").length;
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
		$.post({
			url: "/chartUpdate",
			data: {
				"chart_no": chart_no,
				"chart_memo": chart_memo,
				"arr": arr,
				"arr2": arr2,
				"pet_no": pet_no
			},
			dataType: "json"
		}).done(function(data) {
			if (confirm("차트를 수정하시겠습니까?")) {
				if (data.result == 1) {
					alert("차트가 수정되었습니다.");
					location.href = "/chartUpdate?pet_no=" + pet_no;
				} else {
					alert("권한이 없습니다.");
				}
			}
		}).fail(function() {
			alert("문제발생");
		});
	});
});


$(function() {
	/*처방내역 리스트(모달로) 불러오기*/
	$("#presc").click(function() {
		var searchValue = $("#search_value").val();
		var searchName = $("#search_name").val();
		let receiveno = $(this).attr("value");
		$("#prescModal").modal("show");
		$(".precTable").empty();

		/*우 리스트-체크박스 id 배열로 만들기*/
		var size = $("input[name=right_check]").length;
		var rightno = new Array(size);
		for (var i = 0; i < size; i++) {
			rightno[i] = $("input[name=right_check]").eq(i).attr("id");
		}

		$.ajax({
			url: '/prescAjax',
			type: 'GET',
			data: {
				"search_value": searchValue,
				"search_name": searchName
			},
			success: function(data) {

				let prescList = data.prescList;
				let searchList = data.searchList;
				let table = "<tr class='left_list'>";

				for (let i = 0; i < prescList.length; i++) {
					let mcategory = prescList[i].medical_category;
					let mname = prescList[i].medical_name;
					let mprice = prescList[i].medical_price;
					let mno = prescList[i].medical_no;

					table += "<td class='col-1'><input type='checkbox' class='list_check' name='list_check' id='" + mno + "'></td>";
					table += "<td class='col-2' id='cate'>" + mcategory + "</td>";
					table += "<td class='col-6' id='mediname'><label for='" + mno + "' style='margin :0;'>" + mname + "</label></td>";
					table += "<td class='col-3' id='mediprice'>" + mprice + "원</td></tr>";

				}

				$(".precTable").append(table);

				/*우 리스트 배열 풀어서 동일한 id의 좌 리스트에 체크하기((rightno)-위의 배열변수명)*/
				var list_size = rightno.length;
				for (var i = 0; i < list_size; i++) {
					var id_no = $(rightno).get(i);
					var left_chk = $("table.first_table").find("#" + id_no);
					left_chk.prop("checked", true);
				}

			}, error: function(xhr, status, errorThrown) {
				alert("문제가 발생했습니다.");
			}


		});


	}); //처방추가클릭
	//처방 모달내의 검색버튼 클릭시	
	$(document).on("click", "#modal_search", function() {
		var searchValue = $("#search_value").val();
		var searchName = $("#search_name").val();
		let receiveno = $(this).attr("value");
		$("#prescModal").modal("show");

		/*우 리스트-체크박스 id 배열로 만들기*/
		var size = $("input[name=right_check]").length;
		var rightno = new Array(size);
		for (var i = 0; i < size; i++) {
			rightno[i] = $("input[name=right_check]").eq(i).attr("id");
		}

		$.ajax({
			url: '/prescAjax',
			type: 'GET',
			data: {
				"search_value": searchValue,
				"search_name": searchName,
			},
			success: function(data) {
				let prescList = data.prescList;
				var table = "<tr class='left_list'>";

				$(".precTable").empty();


				for (let i = 0; i < prescList.length; i++) {
					let mcategory = prescList[i].medical_category;
					let mname = prescList[i].medical_name;
					let mprice = prescList[i].medical_price;
					let mno = prescList[i].medical_no;

					table += "<td class='col-1'><input type='checkbox' class='list_check' name='list_check' id='" + mno + "'></td>";
					table += "<td class='col-2' id='cate'>" + mcategory + "</td>";
					table += "<td class='col-6' id='mediname'><label for='" + mno + "'style='margin :0;'>" + mname + "</label></td>";
					table += "<td class='col-3' id='mediprice'>" + mprice + "원</td></tr>";
				}

				$(".precTable").append(table);
				//오른쪽 번호를 쪼개 > 그 쪼갠값과 검색된 리스트 아이디와 비교  체크되게
				//검색후에 전체리스트를 불러도 다시 읽어오니

				/*우 리스트 배열 풀어서 동일한 id의 좌 리스트에 체크하기((rightno)-위의 배열변수명)*/
				var list_size = rightno.length;
				for (var i = 0; i < list_size; i++) {
					var id_no = $(rightno).get(i);
					var left_chk = $("table.first_table").find("#" + id_no);
					left_chk.prop("checked", true);
				}


			}, error: function(xhr, status, errorThrown) {
				alert("문제가 발생했습니다.");
			}


		});

	}); //검색버튼 클릭


	/*리스트에서 선택(좌 -> 우)*/
	$(document).on("change", ".list_check", function() {

		if ($(this).is(':checked')) {
			var mno = $(this).attr("id");
			var mediname = $(this).parent().siblings("#mediname").text();
			var cate = $(this).parent().siblings("#cate").text();
			var mediprice = $(this).parent().siblings("#mediprice").text();
			var chtable = "<tr style='float:center;' class='trSelected'id='" + mno + "'>";
			chtable += "<td class='col-1'><input type='checkbox' class='right_check' name='right_check' checked='checked' id='" + mno + "'></td>";
			chtable += "<td class='col-2' id=''>" + cate + "</td>";
			chtable += "<td class='col-6 mediname1' ><label for='" + mno + "'style='margin :0;'>" + mediname + "</label></td>";
			chtable += "<td class='col-3' id=''>" + mediprice + "</td></tr>";

			$(".checkedTable").append(chtable);
		}
		else { //체크 해제될때

			var left_id = $(this).attr("id");
			var right_chk = $("table.second_table").find("#" + left_id);
			var right_tr = right_chk.closest(".trSelected");
			right_tr.remove();
		}
	});

	//우 리스트 클릭(좌측 체크 없애기)
	$(document).on("change", ".right_check", function() {
		var right_id = $(this).attr("id");
		var left_chk = $("table.first_table").find("#" + right_id);
		left_chk.prop("checked", false);
		$(this).parents(".trSelected").remove();

	}); //리스트에서 클릭


	/*초기화 버튼(좌리스트 -체크해제, 우리스트 -삭제)*/
	$(document).on("click", ".reset_btn", function() {
		$("table.first_table").find(".list_check").prop("checked", false);
		$("table.second_table").find(".trSelected").remove();

	}); //초기화버튼 클릭


	/*모달 내 저장버튼*/
	$(".save_btn").click(function() {
		/*우 리스트 id 배열로 받아오기*/
		var size = $("input[name=right_check]").length;
		var rightno = new Array(size);
		for (var i = 0; i < size; i++) {
			rightno[i] = $("input[name=right_check]").eq(i).attr("id");
		}
		$("#prescModal").modal("hide");
		$.ajax({
			url: '/prescSaveAjax',
			type: 'POST',
			data: { "rightno": rightno, },
			success: function(data) {
				$(".CBTable").empty();
				var saveList = data.saveList;
				let table = "<tr style='float:center;'>";
				var totalPrice = 0;
				for (let i = 0; i < saveList.length; i++) {
					let cate = saveList[i].medical_category;
					var price = saveList[i].medical_price;
					var priceAddc = price.toLocaleString(); //가격에 , 붙이기 ---> 잠시보류
					let mname = saveList[i].medical_name;
					let medino = saveList[i].medical_no;
					table += "<td class='col-2'>" + cate + "</td>";
					table += "<td class='col-5'>" + mname + "</td>";
					table += "<td class='col-2 priceTd' ><input type='number' class='mediNum form-control form-control-sm' id='" + medino + "'name='mediNum" + i + "' style=' text-align:right;' value='1' min='1' max='100'></td>";
					table += "<td class='col-4 calPrice' id='" + price + "'>" + price + "원</td>";
					table += "</tr>";

					totalPrice += price;


				}
				$(".totalPrice").attr("id", totalPrice);
				$(".CBTable").append(table);
				$(".totalPrice").empty();
				var totalPriceAddc = totalPrice.toLocaleString(); //가격에 , 붙이기
				$(".totalPrice").append(totalPriceAddc + "원"); //총 합계


				/*수량을 변경할때*/
				$(document).on("change", ".mediNum", function() {
					var eachmediNum = $(this).val(); // 수량 
					var eachmediId = $(this).attr("id"); //수정된 체크박스의 id(medical_no)

					var ckInput = $("tbody.CBTable").find("#" + eachmediId); //수정된 체크박스의 id와 일치하는 인풋넘버태그찾기
					var priceTd = ckInput.closest(".priceTd"); //인풋넘버태그 바로위 부모태그 td
					var calprice = priceTd.siblings(".calPrice"); //아래 td (각 가격부분)
					var priceId = calprice.attr("id"); // 가격의 id(1개의 단가);
					var b = priceId * eachmediNum; //단가*변경된수량
					//var changeTotal =b.toLocaleString(); //가격에 ,붙이기
					calprice.text(b + "원");


					var price12 = $(".calPrice").text();
					var priceCut = price12.split("원"); //원으로 나누기
					var prices = new Array(); //배열생성 
					prices = priceCut; //배열에 넣어주기

					var totalSum = 0;
					for (let l = 0; l < (prices.length - 1); l++) {
						var pr = parseInt(prices[l]);
						totalSum += pr;
					}

					$(".totalPrice").attr("id", totalSum);
					var changeTotalPrice = totalSum.toLocaleString(); //가격에 , 붙이기
					$(".totalPrice").empty(); //1개 단가의 총합계를 지운다 0
					$(".totalPrice").append(changeTotalPrice + "원"); //총 합계

				});

			}, error: function(xhr, status, errorThrown) {
				alert("문제가 발생했습니다.");

			}
		});

	});//저장버튼
});