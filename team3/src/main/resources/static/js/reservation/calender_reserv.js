	//예약창
	
	//전역변수
	//예약날짜(today)
	var today = new Date();
	var todayYear = today.getFullYear();
	var todayMonth = ('0' + (today.getMonth() + 1)).slice(-2);
	var todayDate = ('0' + today.getDate()).slice(-2);
	var reservationdateday = todayYear + '-' + todayMonth + '-' + todayDate;
	
	
	//예약모달창 + 시간막기 구현
	$(document).on("click", ".reserv_btn", function() {
		$('#reservation_date_day').val(reservationdateday);
		//필수(모달띄우기 위함), owner_no로 하면 안됨!!!!
		//controller에서 owner_no에 값을 넣어주기때문(owner_no관련 정보 전체다 출력됨.)reservDTO.setDetail_no(request.getParameter("detail_no"));
		let detail_no = $(this).attr("value"); //pet_no정보 (button의 value값)
		//alert(detail_no + " : pet_no"); //ok

		var reservation_date_day_input = $('#reservation_date_day').val();
		var reservation_date_day_parts = reservation_date_day_input.split('-');
		var reservation_date_day = reservation_date_day_parts[0] + '-' + reservation_date_day_parts[1] + '-' + reservation_date_day_parts[2];

		$.ajax({
			url: "/reservAjax",
			type: "POST",
			data: { "detail_no": detail_no, "reservation_date_day": reservation_date_day }, //button클릭하면 받아오는 pet_no정보를 컨트롤러(서버)에 보냄 //search_no기준으로 나머지 정보가져옴
			dataType: "json",
			cache: false
		}).done(function(data) {
			//alert('성공'); //ok
			//$("#exampleModal").modal('show')
			$("#petSearchModal").modal("hide");
			let result = data.result;
			let result1 = data.result1;

			for (var i = 0; i < result1.length; i++) {
				let disabled_time = result1[i].reserv_time;
				//alert(disabled_time);
				let time = $("input[name='reserv_time'][value='" + disabled_time +"']").siblings('label').text();
				//alert(reservation_date_day+"날짜의 "+"disabled_time:"+disabled_time); //예약된 시간 다 조회
				//alert("time:"+time); //ok
				if (disabled_time == time) {
					//alert("일치");
					$("input[name='reserv_time'][value='"+disabled_time + "']").attr("disabled", true);
				}
			}
			// 				    컨트롤러에 result 선언함. json.put("result", searchDetail);
			// 				    data: 서버에서 반환되는 데이터(JSON 형식)
			// 				    data.result: 서버에서 반환된 JSON 데이터 객체의 result 프로퍼티 값(0 or 1)
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
		$("input[name='reserv_time']").attr("disabled", false); //다른 날짜 선택했을때 disabled초기화
		var reservation_date_day_input = $(this).val();

		//변경된 날짜를 '-'기준으로 자르기' (yyyy,mm,dd)
		var reservation_date_day_parts = reservation_date_day_input.split('-');
		//(yy-mm-dd) 형식으로 바꾸기
		var reservation_date_day = reservation_date_day_parts[0] + '-' + reservation_date_day_parts[1] + '-' + reservation_date_day_parts[2];
		//alert("reservation_date_day : " + reservation_date_day); //ok
		$('#reservation_date_day').val(reservation_date_day);
		reservation_date_day = $('#reservation_date_day').val();
		//alert("reservation_date_day:" + reservation_date_day );
		$.ajax({
			url: "/reservAjax",
			type: "POST",
			data: { "reservation_date_day": reservation_date_day }, //button클릭하면 받아오는 pet_no정보를 컨트롤러(서버)에 보냄 //search_no기준으로 나머지 정보가져옴
			dataType: "json",
			cache: false
		}).done(function(data) {
			alert('성공'); //ok
			let result1 = data.result1;

			for (var i = 0; i < result1.length; i++) {
				let disabled_time = result1[i].reserv_time;
				//alert(disabled_time);
				let time = $("input[name='reserv_time'][value='" + disabled_time+"']").siblings('label').text();
				//alert(reservation_date_day+"날짜의 "+"disabled_time:"+disabled_time); //예약된 시간 다 조회
				//alert("time:"+time); //ok
				if (disabled_time == time) {
					//alert("disabled_time일치:"+disabled_time);
					$("input[name='reserv_time'][value='" + disabled_time + "']").attr("disabled", true);
				}
			}
		});
	});
	
	//예약시간
	//var reservation_date = ''; //최종 날짜+시간
	//예약완료 버튼
	$("#ok-button").click(function() {
		if (confirm("예약 하시겠습니까?")) {
		var reservation_date_time = $("input[name='reserv_time']:checked").siblings('label').text(); //시간
		//alert("reservation_date_time:" + reservation_date_time);
		if (reservation_date_day !== '' && ('input:radio[name="reserv_time"]:checked').length > 0) {
			//최종날짜+최종시간
			var reservationdate = ($('#reservation_date_day').val() + ' ' + reservation_date_time + ':00');
			$('#reservation_date').val(reservationdate);
		}
		let petNo = $(this).attr("value"); //button안의 pet_no값 //ok
		if ($('input:radio[name="reserv_time"]:checked').length < 1) {
			alert('예약 시간을 선택해주세요');
			return false;
		}
		var reservation_memo = $('#reservation_memo').val();
		var reservation_date = $('#reservation_date').val();

		//선택된 radio값 구별
		var reservation_date1 = new Date($('#reservation_date').val());
		let reserv_time = reservation_date1.getHours() + ':' + reservation_date1.getMinutes();


		//alert(reservation_date);
		//백으로 보내서 삽입
		$.post({
			url: "/reservAdd",
			data: {
				"petNo": petNo,
				"reservation_memo": reservation_memo,
				"reservation_date": reservation_date
			},
			dataType: "json"
		}).done(function(data) {

			//alert("통신성공?"); //ok
			//alert("reserv_time:" + reserv_time); //ok
			//if (reservation_date_time == reserv_time) {
			//$($("input[name='reserv_time']:checked")).attr("disabled", true);

			//}
		}).fail(function() {
			alert("통신실패 : " + data.result);
		});
		}
		//		

		alert("예약이 등록 되었습니다.");
		location.reload(); //모달창 hide + 부모창새로고침
	});

	//예약창 닫았을때 text값 초기화
	$('#dialog').on('hidden.bs.modal', function(e) {
		if ($(this).find('form').length > 0) {
			$(this).find('form')[0].reset();
			var inputValue = $(this).find('select:eq(0) option:eq(0)');
		}
		//accordion창 접기
		$('.accordion-collapse').collapse('hide');
	});
	
		//예약취소 버튼
	$(".reserv_cancel").click(function() {
		let delete_reservation_no = $(this).attr("value"); //reservation_no
		//alert("delete_reservation_no:" + delete_reservation_no);

		if (confirm("예약을 취소 하시겠습니까?")) {
			location.href = "reservDelete?delete_reservation_no=" + delete_reservation_no;
		}
	});