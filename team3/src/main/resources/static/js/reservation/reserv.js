
$(function() {
	//전역변수
	var today = new Date();
	var todayYear = today.getFullYear();
	var todayMonth = ('0' + (today.getMonth() + 1)).slice(-2);
	var todayDate = ('0' + today.getDate()).slice(-2);
	var reservationdateday = todayYear + '-' + todayMonth + '-' + todayDate;
	var hours = ('0' + today.getHours()).slice(-2);
	var minutes = ('0' + today.getMinutes()).slice(-2);
	var timeString = hours + ':' + minutes;
	var todayDate_f = todayYear + '-' + todayMonth + '-' + todayDate;

	//검색
	$('#search_btn').click(function() {
		var searchValue = $.trim($("#search_value").val());
		$.ajax({
			url: "/reservsearch",
			type: "GET",
			data: {
				"searchValue": searchValue
			},
			dataType: "json",
			cache: false
		}).done(function(data) {
			let result = data.result;
			$("#researchTable").empty();
			let table = '';
			if (result == "") {
				table += "<tr class='text-center'> <td colspan='4'>존재하지 않는 회원입니다.<br><br>";
				table += "<button class='btn btn-sm btn-primary' id='reg_btn'>신규등록</button></td></tr>";

				$(document).on("click", "#reg_btn", function() {
					location.href = "/client";
				});
			} else {
				var today = new Date();
				//검색 리스트 띄우기
				for (let i = 0; i < result.length; i++) {
					var birthday = new Date(result[i].pet_birth);
					var age = today.getFullYear() - birthday.getFullYear();
					$('#age').val(age);
					table += '<tr class="search_result" style="border-bottom: 1px solid gray; padding-bottom: 5px;">';
					table += '<td style="font-size: 14px; ">';
					table += '<div><a href="#" style="text-decoration: none;">';
					table += '<b style="font-size: 25px; color: black; cursor:default;">' + result[i].pet_name + '</b></a>&nbsp;&nbsp;&nbsp;' + result[i].owner_name + '</div><br>';
					table += '<span>' + result[i].type_name + ' | ' + result[i].pet_gender + '<br>';
					table += result[i].pet_birth + '</span><br></td>';
					table += '<input type="hidden" id="search_petNo" value="' + result[i].pet_no + '">';
					table += '<input type="hidden" id="search_ownerNo" value="' + result[i].owner_no + '">';
					table += '<td style="text-align: right;"><span></span><br><br><span>';
					table += '<button type="button" class="btn btn-sm reserv_btn" value="' + result[i].pet_no + '" style="border: 1px solid #0d6efd; color: #0d6efd;">예약</button>';
					table += '<button type="button" id="search_receipt_btn" class="btn btn-primary btn-sm search_receipt_btn" value="' + result[i].pet_no + '" data-value="' + result[i].owner_no + '" style="margin-left:5px; border: none;">접수</button></span></td></tr>';
				}
			}
			$("#researchTable").append(table);
			$("#researchTable").show();
		}).fail(function(jqXHR, textStatus, errorThrown) {
			alert("POST request failed: " + errorThrown);
		});
	});
	//검색에서 접수버튼
	$(document).on("click", ".search_receipt_btn", function() {
		if (confirm("접수 하시겠습니까?")) {
			var search_petNo = $(this).attr("value");
			var search_ownerNo = $(this).attr("data-value");
			$.ajax({
				url: "/search_receiveAdd",
				type: "POST",
				data: {
					"search_petNo": search_petNo,
					"search_ownerNo": search_ownerNo
				},
				dataType: "json",
				cache: false
			}).done(function(data) {
				if (data.result == "exist") {
					alert("이미 접수중 입니다.");
				} else {
					alert("접수 등록이 되었습니다.");
					location.reload();
				}
			}).fail(function() {
				alert("통신실패 : " + data.result);
			});
		}
	});

	//예약모달창 + 시간막기 구현
	$(document).on("click", ".reserv_btn", function() {
		$('#reservation_date_day').val(reservationdateday);
		let detail_no = $(this).attr("value"); //pet_no
		var reservation_date_day_input = $('#reservation_date_day').val();
		var reservation_date_day_parts = reservation_date_day_input.split('-');
		var reservation_date_day = reservation_date_day_parts[0] + '-' + reservation_date_day_parts[1] + '-' + reservation_date_day_parts[2];
		$.ajax({
			url: "/reservAjax",
			type: "POST",
			data: { "detail_no": detail_no, "reservation_date_day": reservation_date_day },
			dataType: "json",
			cache: false
		}).done(function(data) {
			$("#exampleModal").modal('show')
			let result = data.result;
			let result1 = data.result1;

			for (var i = 0; i < result1.length; i++) {
				let disabled_time = result1[i].reserv_time;
				let time = $("input[name='reserv_time'][value='" + disabled_time + "']").siblings('label').text();
				if (disabled_time == time) {
					$("input[name='reserv_time'][value='" + disabled_time + "']").attr("disabled", true);
				}
			}
			//현재시간 이전시간막기 
			for (var i = 1; i <= $("input[name='reserv_time']").length; i++) {//16
				var timevalue = $(".t" + i).val();
				if ($(".t" + i).val() < timeString) {
					$("input[name='reserv_time'][value='" + timevalue + "']").attr("disabled", true);
				}
			}

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

	// 예약모달_날짜변경시 
	$('#reservation_date_day').change(function() {
		$("input[name='reserv_time']").attr("disabled", false);
		var reservation_date_day_input = $(this).val();

		//변경된 날짜를 '-'기준으로 자르기' (yyyy,mm,dd)
		var reservation_date_day_parts = reservation_date_day_input.split('-');
		//(yy-mm-dd) 형식으로 바꾸기
		var reservation_date_day = reservation_date_day_parts[0] + '-' + reservation_date_day_parts[1] + '-' + reservation_date_day_parts[2];
		$('#reservation_date_day').val(reservation_date_day);
		reservation_date_day = $('#reservation_date_day').val();
		$.ajax({
			url: "/reservAjax",
			type: "POST",
			data: { "reservation_date_day": reservation_date_day },
			dataType: "json",
			cache: false
		}).done(function(data) {
//			let result1 = data.result1;
//			for (var i = 0; i < result1.length; i++) {
//				let disabled_time = result1[i].reserv_time;
//				let time = $("input[name='reserv_time'][value='" + disabled_time + "']").siblings('label').text();
//				if (disabled_time == time) {
//					$("input[name='reserv_time'][value='" + disabled_time + "']").attr("disabled", true);
//				}
//			}
			
			
			if (todayDate_f == reservation_date_day) {
			for (var i = 1; i <= $("input[name='reserv_time']").length; i++) {
				var timevalue = $(".t" + i).val();

				if ($(".t" + i).val() < timeString) {
					$("input[name='reserv_time'][value='" + timevalue + "']").attr("disabled", true);
				}
			}
			}
			
			
			
			
		});
	});

	// 수정모달_날짜변경시 
	$('#update_reservation_date_day').change(function() {
		$("input[name='reserv_time']").attr("disabled", false); //다른 날짜 선택했을때 disabled초기화
		var reservation_date_day_input = $(this).val();

		var reservation_date_day_parts = reservation_date_day_input.split('-');
		var reservation_date_day = reservation_date_day_parts[0] + '-' + reservation_date_day_parts[1] + '-' + reservation_date_day_parts[2];
		$('#reservation_date_day').val(reservation_date_day);
		reservation_date_day = $('#reservation_date_day').val();
		$.ajax({
			url: "/reservAjax",
			type: "POST",
			data: { "reservation_date_day": reservation_date_day },
			dataType: "json",
			cache: false
		}).done(function(data) {
			let result1 = data.result1;
			for (var i = 0; i < result1.length; i++) {
				let disabled_time = result1[i].reserv_time;
				let time = $("input[name='reserv_time'][value='" + disabled_time + "']").siblings('label').text();
				if (disabled_time == time) {
					$("input[name='reserv_time'][value='" + disabled_time + "']").attr("disabled", true);
				}
			}
		});
	});

	//예약완료 버튼
	$("#ok-button").click(function() {
		if (confirm("예약 하시겠습니까?")) {
			var reservation_date_time = $("input[name='reserv_time']:checked").siblings('label').text();
			if (reservation_date_day !== '' && ('input:radio[name="reserv_time"]:checked').length > 0) {
				//최종날짜+최종시간
				var reservationdate = ($('#reservation_date_day').val() + ' ' + reservation_date_time + ':00');
				$('#reservation_date').val(reservationdate);
			}
			let petNo = $(this).attr("value"); //button안의 pet_no
			if ($('input:radio[name="reserv_time"]:checked').length < 1) {
				alert('예약 시간을 선택해주세요');
				return false;
			}
			var reservation_memo = $('#reservation_memo').val();
			var reservation_date = $('#reservation_date').val();

			var reservation_date1 = new Date($('#reservation_date').val());
			let reserv_time = reservation_date1.getHours() + ':' + reservation_date1.getMinutes();

			$.post({
				url: "/reservAdd",
				data: {
					"petNo": petNo,
					"reservation_memo": reservation_memo,
					"reservation_date": reservation_date
				},
				dataType: "json"
			}).done(function(data) {
			}).fail(function() {
				alert("통신실패 : " + data.result);
			});
			alert("예약이 등록 되었습니다.");
			location.reload(); //모달창 hide + 부모창새로고침
		}

	});

	//예약창 닫았을때 text값 초기화
	$('#exampleModal').on('hidden.bs.modal', function(e) {
		if ($(this).find('form').length > 0) {
			$(this).find('form')[0].reset();
			var inputValue = $(this).find('select:eq(0) option:eq(0)');
		}
		//시간막은거 풀기
		$("input[name='reserv_time']").attr("disabled", false);
		$('.accordion-collapse').collapse('hide');
	});

	//예약수정
	$(document).on("click", ".reservUpdate", function(e) {
		$('#reservation_date_day').val(reservationdateday);
		let reservation_no = $(this).attr("value"); //reservation_no
		var reservation_date_day_input = $('#reservation_date_day').val();
		var reservation_date_day_parts = reservation_date_day_input.split('-');
		var reservation_date_day = reservation_date_day_parts[0] + '-' + reservation_date_day_parts[1] + '-' + reservation_date_day_parts[2];

		$.ajax({
			url: "/reservUpdate",
			type: "POST",
			data: { "reservation_no": reservation_no, "reservation_date_day": reservation_date_day },
			dataType: "json",
			cache: false
		}).done(function(data) {
			let result = data.result;
			let result1 = data.result1; //날짜막기
			for (var i = 0; i < result1.length; i++) {
				let disabled_time = result1[i].reserv_time;
				let time = $("input[name='reserv_time'][value='" + disabled_time + "']").siblings('label').text();
				if (disabled_time == time) {
					$("input[name='reserv_time'][value='" + disabled_time + "']").attr("disabled", true);
				}
			}
			//현재시간 이전시간막기 
			for (var i = 1; i <= $("input[name='reserv_time']").length; i++) {
				var timevalue = $(".t" + i).val();
				if ($(".t" + i).val() < timeString) {
					$("input[name='reserv_time'][value='" + timevalue + "']").attr("disabled", true);
				}
			}
			var update_reservation_date_time = result[0].reserv_time; //디폴트 시간
			$("#updateModal").modal('show')
			$("input[type=radio][value='" + result[0].reserv_time + "']").prop("checked", true);
			$('#update_pet_name').val(result[0].pet_name);
			$('#update_owner_name').val(result[0].owner_name);
			$('#update_owner_tel').val(result[0].owner_tel);
			$('#update_pet_gender').val(result[0].pet_gender);
			$('#update_pet_birth').val(result[0].pet_birth);
			$('#update_reservation_date_day').val(result[0].reserv_date);
			$('#update_reservation_date_time').val(update_reservation_date_time);
			$('#update_reservation_memo').val(result[0].reservation_memo);
			$('#update_ok-button').val(result[0].reservation_no);
			$('.timeoption').appendTo('.updatetimeset');
		})
			.fail(function(jqXHR, textStatus, errorThrown) {
				alert("get request failed: " + errorThrown);
			});
	});

	//수정완료 버튼
	$("#update_ok-button").click(function() {
		if (confirm("수정 하시겠습니까?")) {
			let update_reservation_no = $(this).attr("value"); //reservation_no
			var update_reservation_date_time = $("input[name='reserv_time']:checked").siblings('label').text();
			//최종날짜+최종시간
			var updatereservationdate = ($('#update_reservation_date_day').val() + ' ' + update_reservation_date_time + ':00');
			$('#update_reservation_date').val(updatereservationdate);
			var update_reservation_memo = $('#update_reservation_memo').val();
			var update_reservation_date = updatereservationdate

			$.post({
				url: "/reservUpdateSaved",
				data: {
					"update_reservation_no": update_reservation_no,
					"update_reservation_memo": update_reservation_memo,
					"update_reservation_date": update_reservation_date
				},
				dataType: "json"
			}).done(function(data) {
				let result = data.result;
				if (data.result == 1) {
					alert("수정이 완료되었습니다.");
				} else {
					alert("문제가 발생했습니다. \n다시 시도해주세요.");
				}
				location.reload();
			}).fail(function() {
				alert("통신실패 : " + data.result);
			});
		}
	});

	//수정창 닫았을때 text값 초기화
	$('#updateModal').on('hidden.bs.modal', function(e) {
		$(this).find('form')[0].reset();
		var inputValue = $(this).find('select:eq(0) option:eq(0)');
		$('.accordion-collapse').collapse('hide');
	});

	//예약취소 버튼
	$(".reserv_cancel").click(function() {
		let delete_reservation_no = $(this).attr("value"); //reservation_no
		if (confirm("예약을 취소 하시겠습니까?")) {
			location.href = "reservDelete?delete_reservation_no=" + delete_reservation_no;
			alert("예약이 취소되었습니다.");
		}
	});

	//접수 버튼 -> 접수테이블에 데이터 넣기
	$(".receipt_btn").click(function() {
		if (confirm("접수 하시겠습니까?")) {
			let reservNo = $(this).attr("value"); //reservation_no
			var receive_petNo = $('#petNo').val();
			var receive_ownerNo = $('#ownerNo').val();
			$.post({
				url: "/receiveAdd",
				data: {
					"reservNo": reservNo,
					"receive_petNo": receive_petNo,
					"receive_ownerNo": receive_ownerNo
				},
				dataType: "json"
			}).done(function(data) {
			}).fail(function() {
				alert("통신실패 : " + data.result);
			});
			alert("접수가 등록 되었습니다.");
			location.reload();
		}
	});

	//접수취소 버튼
	$(".receipt_cancel").click(function() {
		let delete_receive_no = $(this).attr("value"); //receive_no
		if (confirm("접수를 취소 하시겠습니까?")) {
			location.href = "receiveDelete?delete_receive_no=" + delete_receive_no;
			alert("접수가 취소되었습니다.");
		}
	});
});