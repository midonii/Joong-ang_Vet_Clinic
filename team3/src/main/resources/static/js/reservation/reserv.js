
$(function() {

	//검색
	$('#search_btn').click(function() {
		var searchValue = $("#search_value").val();
		if (searchValue == "") {
			alert("검색어를 입력하세요");
			return false;
		}
		else if (searchValue.length < 1) {
			alert("2글자 이상 입력하세요"); //ok
			return false;
		} else {
			$.ajax({
				url: "/reservsearch",
				type: "GET",
				data: {
					"searchValue": searchValue
				}, //key, value
				dataType: "json",
				cache: false
			}).done(function(data) { //controller다녀온후 mapper조회값으로 done실행
				alert("통신에 성공했습니다. "); //ok
				let result = data.result; //result: result안에 pet_birth, owner_name등 정보가 다 있음. 
				// 				alert("pet_birth: "+result[0].pet_birth);//ok
				//alert("data.result.length: "+data.result.length);//ok


				if (data.result.length == 0) {
					alert("검색 결과가 없습니다.");
				} else if (data.result.length > 0) {
					var today = new Date();
					$('#researchTable').empty(); //리스트 초기화
					//검색 리스트 띄우기
					let table = '';
					for (let i = 0; i < result.length; i++) {
						var birthday = new Date(result[i].pet_birth);
						var age = today.getFullYear() - birthday.getFullYear();
						$('#age').val(age);
						//alert(result[i].pet_no); //ok
						table += '<tr class="search_result" style="border-bottom: 1px solid gray; padding-bottom: 5px;">';
						table += '<td style="font-size: 14px; ">';
						table += '<div><a href="#" style="text-decoration: none;">';
						table += '<b style="font-size: 25px; color: black">' + result[i].pet_name + '</b></a>&nbsp;&nbsp;&nbsp;' + result[i].owner_name + '</div><br>';
						table += '<span>' + result[i].type_name + ' | ' + result[i].pet_gender + '<br>';
						table += result[i].pet_birth + '</span><br></td>';
						table += '<input type="hidden" id="search_petNo" value="' + result[i].pet_no + '">';
						// 					    table += '<input type="hidden" id="age" value="'+age+'">';
						table += '<td style="text-align: right;"><span></span><br><br><span>';
						table += '<button type="button" class="btn btn-sm reserv_btn" value="' + result[i].pet_no + '" style="border: 1px solid #0d6efd; color: #0d6efd;">예약</button>';
						table += '<button type="button" id="receipt_btn" class="btn btn-primary btn-sm" style="margin-left:5px; border: none;">접수</button></span></td></tr>';
					}
					$("#researchTable").append(table);
					//alert($('#search_petNo').val()); //ok
					$("#researchTable").show();
				}
			}).fail(function(jqXHR, textStatus, errorThrown) {
				alert("POST request failed: " + errorThrown);
			});
		}
	});

	//예약모달창
	$(document).on("click", ".reserv_btn", function() { //.reserv_btn 클래스를 가진 버튼이 클릭되었을 때 함수를 실행
		//필수(모달띄우기 위함), owner_no로 하면 안됨!!!!
		//controller에서 owner_no에 값을 넣어주기때문(owner_no관련 정보 전체다 출력됨.)reservDTO.setDetail_no(request.getParameter("detail_no"));
		let detail_no = $(this).attr("value"); //pet_no정보 (button의 value값)
		alert(detail_no + " : pet_no"); //ok

		//이제 이걸 post로 /reservAjax 컨트롤러로 전송
		$.ajax({
			url: "/reservAjax",
			type: "POST",
			data: { "detail_no": detail_no }, //button클릭하면 받아오는 pet_no정보를 컨트롤러(서버)에 보냄 //search_no기준으로 나머지 정보가져옴
			dataType: "json",
			cache: false
		}).done(function(data) { //data: 서버가 전송한 데이터(html의 태그안에 박혀있는 값들 넣기). {"search_no": search_no}가 아님!
			alert('성공'); //ok
			$("#exampleModal").modal('show')
			let result = data.result; //result: html의 태그안에 박혀있는 값들 넣기
			// 				    컨트롤러에 result 선언함. json.put("result", searchDetail);
			// 				    data: 서버에서 반환되는 데이터(JSON 형식)
			// 				    data.result: 서버에서 반환된 JSON 데이터 객체의 result 프로퍼티 값(0 or 1)
			$('#owner_name').val(result[0].owner_name);
			$('#owner_tel').val(result[0].owner_tel);
			$('#pet_name').val(result[0].pet_name);
			$('#pet_gender').val(result[0].pet_gender);
			$('#pet_birth').val(result[0].pet_birth);
			$('#petNo').val(result[0].pet_no);
			alert("petNo : " + result[0].pet_no); //ok
		})
			.fail(function(jqXHR, textStatus, errorThrown) {
				alert("get request failed: " + errorThrown);
			});
	}); //예약버튼 끝

	//예약날짜(today)
	var today = new Date();
	var todayYear = today.getFullYear();
	var todayMonth = ('0' + (today.getMonth() + 1)).slice(-2);
	var todayDate = ('0' + today.getDate()).slice(-2);
	var reservationdateday = todayYear + '-' + todayMonth + '-' + todayDate;
	$('#reservation_date_day').val(reservationdateday);

	// (디폴트값에서)예약날짜 변경 시 final_date 변수에 저장
	$('#reservation_date_day').change(function() {
		var reservation_date_day_input = $(this).val();
		//변경된 날짜를 '-'기준으로 자르기' (yyyy,mm,dd)
		var reservation_date_day_parts = reservation_date_day_input.split('-');
		//(yy-mm-dd) 형식으로 바꾸기
		var reservation_date_day = reservation_date_day_parts[0] + '-' + reservation_date_day_parts[1] + '-' + reservation_date_day_parts[2];
		alert("reservation_date_day : " + reservation_date_day); //최종 날짜
		$('#reservation_date_day').val(reservation_date_day);
	});

	//예약시간
	var reservation_date = ''; //최종 날짜+시간
	//예약완료 버튼
	$("#ok-button").click(function(){
		var reservation_date_time = $("input[name='reserv_time']:checked").val(); //시간
		// 				if (reservation_date_day !== '' && $('input:radio[name="reserv_time"]:checked').length > 0) {{
		if (reservation_date_day !== '' && ('input:radio[name="reserv_time"]:checked').length > 0) {
			//최종날짜+최종시간
			var reservationdate = ($('#reservation_date_day').val() + ' ' + reservation_date_time + ':00');
			$('#reservation_date').val(reservationdate);
		}
		$("#ok-button").val($("#petNo").val()); //ok
		let petNo = $(this).attr("value"); //button안의 pet_no값 //ok
		alert("ok-button value값 : " + $("#ok-button").val()); //ok

		if ($('input:radio[name="reserv_time"]:checked').length < 1) {
			alert('예약 시간을 선택해주세요');
			return false;
		}
		var reservation_memo = $('#reservation_memo').val();
		var reservation_date = $('#reservation_date').val();
		alert(reservation_date);
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

			alert("통신성공?");
		}).fail(function() {
			alert("통신실패 : " + data.result);
		});
		//alert(petNo); //ok
		alert("예약이 등록 되었습니다.");
		location.reload(); //모달창 hide + 부모창새로고침
	});

	//예약창 닫았을때 text값 초기화
	$('#exampleModal').on('hidden.bs.modal', function(e) {
		if ($(this).find('form').length > 0) {
			$(this).find('form')[0].reset();
			var inputValue = $(this).find('select:eq(0) option:eq(0)');
		}
		//accordion창 접기
		$('.accordion-collapse').collapse('hide');
	});

	//예약수정
	$(document).on("click", ".reservUpdate", function(e) {
		let reservation_no = $(this).attr("value"); //reservation_no정보 (button의 value값)
		alert(reservation_no + " : reservation_no"); //ok

		//이제 이걸 post로 /reservAjax 컨트롤러로 전송
		$.ajax({
			url: "/reservUpdate",
			type: "POST",
			data: { "reservation_no": reservation_no }, //button클릭하면 받아오는 pet_no정보를 컨트롤러(서버)에 보냄 //search_no기준으로 나머지 정보가져옴
			dataType: "json",
			cache: false
		}).done(function(data) { //data: 서버가 전송한 데이터(html의 태그안에 박혀있는 값들 넣기). {"search_no": search_no}가 아님!
			let result = data.result; //result: html의 태그안에 박혀있는 값들 넣기
			//alert("result[0].reserv_time:"+result[0].reserv_time);
			var update_reservation_date_time = result[0].reserv_time; //디폴트 시간
			alert("update_reservation_date_time : " + update_reservation_date_time);  //ok
			$("#updateModal").modal('show')
			alert('성공'); //ok
			alert("result[0].reservation_no:" + result[0].reservation_no) //null
			$("input[type=radio][value='" + result[0].reserv_time + "']").prop("checked", true);
			$('#update_pet_name').val(result[0].pet_name);
			$('#update_owner_name').val(result[0].owner_name);
			$('#update_owner_tel').val(result[0].owner_tel);
			$('#update_pet_gender').val(result[0].pet_gender);
			$('#update_pet_birth').val(result[0].pet_birth);
			$('#update_reservation_date_day').val(result[0].reserv_date); //ok
			$('#update_reservation_date_time').val(update_reservation_date_time);
			$('#update_reservation_memo').val(result[0].reservation_memo);
			//reservation_no 값을 수정완료 버튼 value에 넣기
			$('#update_ok-button').val(result[0].reservation_no); //dto에 값넣기
		})
			.fail(function(jqXHR, textStatus, errorThrown) {
				alert("get request failed: " + errorThrown);
			});
	});
	//수정완료 버튼
	$("#update_ok-button").click(function() {
		let update_reservation_no = $(this).attr("value"); //reservation_no
		alert("update_reservation_no:" + update_reservation_no); //ok

		var update_reservation_date_time = $("input[name='update_reserv_time']:checked").val();
		alert(update_reservation_date_time); //ok
		//최종날짜+최종시간
		var updatereservationdate = ($('#update_reservation_date_day').val() + ' ' + update_reservation_date_time + ':00');
		$('#update_reservation_date').val(updatereservationdate); //최종날짜시간 value에 삽입
		//alert("최종(hidden) reservation_date : " + reservationdate); //ok //2023-03-13 12:00:00
		alert(updatereservationdate);//ok

		var update_reservation_memo = $('#update_reservation_memo').val();
		var update_reservation_date = $('#update_reservation_date').val();
		alert(update_reservation_no); //

		$.post({ //안됨
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
			location.reload(); //모달창 hide + 부모창새로고침
		}).fail(function() {
			alert("통신실패 : " + data.result);
		});
	});



	//수정창 닫았을때 text값 초기화
	$('#updateModal').on('hidden.bs.modal', function(e) {
		//     if($(this).find('form').length >0){
		$(this).find('form')[0].reset();
		var inputValue = $(this).find('select:eq(0) option:eq(0)');
		//     }
		//accordion창 접기
		$('.accordion-collapse').collapse('hide');
	});

	//예약취소 버튼
	$("#reserv_cancel").click(function() {
		let delete_reservation_no = $(this).attr("value"); //reservation_no
		alert("delete_reservation_no:" + delete_reservation_no);

		if (confirm("예약을 취소 하시겠습니까?")) {
			location.href = "reservDelete?delete_reservation_no=" + delete_reservation_no;
		}
	});


	//접수 버튼
	$("#receipt_btn").click(function(){
		
		let reservNo = $(this).attr("value"); //reservation_no
		alert("reservNo값 : " + reservNo); //

		//백으로 보내서 삽입
		$.post({
			url: "/receiveAdd",
			data: {
				"reservNo": reservNo
			},
			dataType: "json"
		}).done(function(data) {

			alert("통신성공");
			//let result = data.result;
			//if (data.result == 1) {
			//    alert("저장성공");
			//    console.log("저장성공");
			//} else {
			//    alert("저장실패");
			//}
		}).fail(function() {
			alert("통신실패 : " + data.result);
		});
		//alert(petNo); //ok
		alert("접수 등록이 되었습니다.");
		location.reload(); //모달창 hide + 부모창새로고침
	});





});

