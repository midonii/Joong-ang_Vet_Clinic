var today = new Date();
var todayYear = today.getFullYear();
var todayMonth = ('0' + (today.getMonth() + 1)).slice(-2);
var todayDate = ('0' + today.getDate()).slice(-2);
var reservationdateday = todayYear + '-' + todayMonth + '-' + todayDate;

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
		$("#petSearchModal").modal("hide");
		let result = data.result;
		let result1 = data.result1;
		for (var i = 0; i < result1.length; i++) {
			let disabled_time = result1[i].reserv_time;
			let time = $("input[name='reserv_time'][value='" + disabled_time + "']").siblings('label').text();
			if (disabled_time == time) {
				$("input[name='reserv_time'][value='" + disabled_time + "']").attr("disabled", true);
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
		alert('성공');
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
			var reservationdate = ($('#reservation_date_day').val() + ' ' + reservation_date_time + ':00');
			$('#reservation_date').val(reservationdate);
		}
		let petNo = $(this).attr("value");
		if ($('input:radio[name="reserv_time"]:checked').length < 1) {
			alert('예약 시간을 선택해주세요');
			return false;
		}
		var reservation_memo = $('#reservation_memo').val();
		var reservation_date = $('#reservation_date').val();
		//선택된 radio값 구별
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
	}
	alert("예약이 등록 되었습니다.");
	location.reload();
});

//예약창 닫았을때 text값 초기화
$('#dialog').on('hidden.bs.modal', function(e) {
	if ($(this).find('form').length > 0) {
		$(this).find('form')[0].reset();
		var inputValue = $(this).find('select:eq(0) option:eq(0)');
	}
	$('.accordion-collapse').collapse('hide');
});

//예약취소 버튼
$(".reserv_cancel").click(function() {
	let delete_reservation_no = $(this).attr("value"); //reservation_no
	if (confirm("예약을 취소 하시겠습니까?")) {
		location.href = "reservDelete?delete_reservation_no=" + delete_reservation_no;
	}
});