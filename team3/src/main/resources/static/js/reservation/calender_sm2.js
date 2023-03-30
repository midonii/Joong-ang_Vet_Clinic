//달력초기화면 오늘날짜로 설정
$(document).ready(function() {
	var date = new Date(); //date : Wed Mar 01 2023 16:45:51 GMT+0900 (한국 표준시)
	var today = date.getDate();
	$(".right-button").click({ date: date }, next_year);
	$(".left-button").click({ date: date }, prev_year);
	$(".month").click({ date: date }, month_click);
	$(".months-row").children().eq(date.getMonth()).addClass("active-month");
	init_calendar(date);
});

function days_in_month(month, year) {
	var monthStart = new Date(year, month, 1);
	var monthEnd = new Date(year, month + 1, 1);
	return (monthEnd - monthStart) / (1000 * 60 * 60 * 24);
}

function month_click(event) {
	$("#dialog").hide(250);
	var date = event.data.date;
	$(".active-month").removeClass("active-month");
	$(this).addClass("active-month");
	var new_month = $(".month").index(this);
	date.setMonth(new_month);
	init_calendar(date);
	show_events(month, day, year, strday);
}

function next_year(event) {
	$("#dialog").hide(250);
	var date = event.data.date;
	var new_year = date.getFullYear() + 1;
	$("year").html(new_year);
	date.setFullYear(new_year);
	init_calendar(date);
	show_events(month, day, year, strday);
}

function prev_year(event) {
	$("#dialog").hide(250);
	var date = event.data.date;
	var new_year = date.getFullYear() - 1;
	$("year").html(new_year);
	date.setFullYear(new_year);
	init_calendar(date);
	show_events(month, day, year, strday);

}

//캘린더 첫화면
function init_calendar(date) { //date:오늘 날짜
	$(".tbody").empty();
	$(".events-container").empty();

	var calendar_days = $(".tbody");
	var month = date.getMonth();
	var year = date.getFullYear();
	var day_count = days_in_month(month, year);
	var row = $("<tr class='table-row'></tr>");
	var today = date.getDate();
	var strday = date.getDay();
	date.setDate(1);

	var first_day = date.getDay();
	for (var i = 0; i < 35 + first_day; i++) {
		var day = i - first_day + 1;

		//일욜이면 새로운 row생성
		if (i % 7 === 0) {
			calendar_days.append(row);
			row = $("<tr class='table-row'></tr>");
		}
		if (i < first_day || day > day_count) {
			var curr_date = $("<td class='table-date nil'>" + "</td>");
			row.append(curr_date);
		}
		else {
			var curr_date = $("<td class='table-date'>" + day + "</td>");
			//오늘 날짜인 경우 && .active-date가 없는 경우
			if (today === day && $(".active-date").length === 0) {
				curr_date.addClass("active-date");
				show_events(months[month], day, year);
			}
			curr_date.click({ month: months[month], day: day, year: year, strday: strday }, date_click); //events:events
			row.append(curr_date);
		}
	}
	calendar_days.append(row);
	$(".year").text(year);
}
//전역변수
var today = new Date();
var todayYear = today.getFullYear();
var todayMonth = ('0' + (today.getMonth() + 1)).slice(-2);
var todayDate = ('0' + today.getDate()).slice(-2);
var todayDate_f = todayYear + '-' + todayMonth + '-' + todayDate;

var hours = ('0' + today.getHours()).slice(-2);
var minutes = ('0' + today.getMinutes()).slice(-2);
var timeString = hours + ':' + minutes;

//날짜 클릭했을때의 이벤트핸들러
function date_click(event) {
	$("#dialog").hide(250);
	$(".active-date").removeClass("active-date");
	$(this).addClass("active-date");
	show_events(event.data.month, event.data.day, event.data.year);
};

function show_events(month, day, year) {
	var fulldate = "";
	fulldate = year + "-" + month + "-" + day.toString().padStart(2, '0');
	$(".date").empty();
	$("#dialog2").show(250);
	var reservationdateday = fulldate;

	//에약리스트
	var fulldate = "";
	fulldate = year + "-" + month + "-" + day.toString().padStart(2, '0');

	$.ajax({
		url: "/calender_reserv_ajax",
		type: "GET",
		data: {
			"fulldate": fulldate
		},
		dataType: "json",
		cache: false
	}).done(function(data) {
		let result = data.result;
		$("#reservTable").empty();
		let table = '';
		if (result == "noReserv") {
			table += "<tr class='text-center'> <td colspan='4'>예약내역이 존재하지 않습니다.</td></tr>";
		} else {
			//예약 리스트 띄우기
			for (let i = 0; i < result.length; i++) {
				table += '<tr style="border-bottom: 1px solid gray; padding-bottom: 5px;">';
				table += '<td style="font-size: 14px;">';
				table += '<div style="">';
				table += '<a style="text-decoration: none;">';
				table += '<b style="font-size: 25px; color: black">' + result[i].pet_name + '</b></a>&nbsp;&nbsp;&nbsp;' + result[i].owner_name + '&nbsp;';
				table += '<a class="reservUpdate" value="' + result[i].reservation_no + '" style="text-decoration: none;">';

				if (todayDate_f <= fulldate) {  //오늘날짜 이후라면
					table += '<i class="xi-file-text-o"></i>';
				}
				table += '</a>';
				table += '</div><br>';
				table += '<div>';
				table += '<span>' + result[i].type_name + ' | ' + result[i].pet_birth + ' | ' + result[i].pet_gender + '</span>';
				table += '</div><span>' + result[i].reservation_memo + '</span>';
				table += '</td>';
				table += '<td style="text-align: right;">';
				table += '<span><b><h5>' + result[i].reserv_time + '</h5></b></span><br>';
				table += '<input type="hidden" id="petNo" value="' + result[i].pet_no + '">';
				table += '<input type="hidden" id="ownerNo" value="' + result[i].owner_no + '">';
				table += '<input type="hidden" id="reservation_Yn" value="' + result[i].reservation_yn + '">';
				table += '<span>';
				if (todayDate_f <= fulldate) { //오늘날짜 이후라면
					table += '<button type="button" class="btn btn-secondary btn-sm reserv_cancel" style="margin-right:5px;" id="" value="' + result[i].reservation_no + '" style="background-color: #7f8c8d; border: none;">취소</button>';
				}
				table += '</span></td>';
				table += '</tr>';
			}
		}
		$("#reservTable").append(table);
		$("#reservTable").show();
	}).fail(function(jqXHR, textStatus, errorThrown) {
		alert("POST request failed: " + errorThrown);
	}); //예약리스트 끝


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
					table += '<b style="font-size: 25px; color: black">' + result[i].pet_name + '</b></a>&nbsp;&nbsp;&nbsp;' + result[i].owner_name + '</div><br>';
					table += '<span>' + result[i].type_name + ' | ' + result[i].pet_gender + '<br>';
					table += result[i].pet_birth + '</span><br></td>';
					table += '<input type="hidden" id="search_petNo" value="' + result[i].pet_no + '">';
					table += '<input type="hidden" id="search_ownerNo" value="' + result[i].owner_no + '">';
					table += '<td style="text-align: right;"><span></span><br><br><span>';
					table += '<button type="button" class="btn btn-sm reserv_btn" value="' + result[i].pet_no + '" style="border: 1px solid #0d6efd; color: #0d6efd;">예약</button>';
				}
			}
			$("#researchTable").append(table);
			$("#researchTable").show();
		}).fail(function(jqXHR, textStatus, errorThrown) {
			alert("POST request failed: " + errorThrown);
		});

	}); //검색끝

	//검색에서 예약버튼
	$(document).off().on("click", ".reserv_btn", function() {
		if (reservationdateday < todayDate_f) {
			$('#reservation_date_day').val(todayDate_f);
		}
		else {
			$('#reservation_date_day').val(reservationdateday);
		}
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
			for (var i = 1; i <= $("input[name='reserv_time']").length; i++) {
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
	}); //예약버튼 


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
			//시간막기
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
	$("#ok-button").off().click(function() {
		var reservationdateday = $('#reservation_date_day').val();

		if (confirm("예약 하시겠습니까?")) {
			var reservation_date_time = $("input[name='reserv_time']:checked").siblings('label').text();
			if (reservationdateday !== '' && ('input:radio[name="reserv_time"]:checked').length > 0) {
				var reservation_date = (reservationdateday + ' ' + reservation_date_time + ':00');
			}
			let petNo = $(this).attr("value");
			if ($('input:radio[name="reserv_time"]:checked').length < 1) {
				alert('예약 시간을 선택해주세요');
				return false;
			}
			var reservation_memo = $('#reservation_memo').val();

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
				alert("예약이 등록 되었습니다.");
				location.reload();
			}).fail(function() {
				alert("통신실패 : " + data.result);
			});
		}

	});

	// 수정모달_날짜변경시 
	$('#update_reservation_date_day').change(function() {
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
		alert(reservation_date_day);

		$.ajax({
			url: "/reservUpdate",
			type: "POST",
			data: { "reservation_no": reservation_no, "reservation_date_day": reservation_date_day }, //button클릭하면 받아오는 pet_no정보를 컨트롤러(서버)에 보냄 //search_no기준으로 나머지 정보가져옴
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

			//오늘인 경우에만 현재시간 이전시간 막기
			if (todayDate_f == reservation_date_day) {
				for (var i = 1; i <= $("input[name='reserv_time']").length; i++) {
					var timevalue = $(".t" + i).val();
					if ($(".t" + i).val() < timeString) {
						$("input[name='reserv_time'][value='" + timevalue + "']").attr("disabled", true);
					}
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
	$(document).on("click", "#update_ok-button", function() {
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

				if (result == 1) {
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

	//수정창 닫았을때 text값 초기화  (ok)
	$('#updateModal').on('hidden.bs.modal', function(e) {
		$(this).find('form')[0].reset();
		var inputValue = $(this).find('select:eq(0) option:eq(0)');
		$('.accordion-collapse').collapse('hide');
	});

	//예약취소 버튼
	$(document).on("click", ".reserv_cancel", function() {
		let delete_reservation_no = $(this).attr("value");
		if (confirm("예약을 취소 하시겠습니까?")) {
			location.href = "calender_reservDelete?delete_reservation_no=" + delete_reservation_no;
			alert("예약이 취소되었습니다.");
		}
	});

	//예약에서 접수 버튼 -> 접수테이블에 데이터 넣기
	$(".receipt_btn").click(function() {
		if (confirm("접수 하시겠습니까?")) {
			let reservNo = $(this).attr("value");
			var receive_petNo = $('#petNo').val();
			var receive_ownerNo = $('#ownerNo').val();
			$.post({
				url: "/receiveAdd",
				data: {
					"reservNo": reservNo,
					"receive_petNo": receive_petNo,
					"receive_ownerNo": receive_ownerNo
				},
				cache: false,
				dataType: "json"
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

}

const months = [
	"01",
	"02",
	"03",
	"04",
	"05",
	"06",
	"07",
	"08",
	"09",
	"10",
	"11",
	"12"
];