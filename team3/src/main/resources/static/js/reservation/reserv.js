
$(function() {
	
	
	
	
	
	
	//전역변수
	//예약날짜(today)
	var today = new Date();
	var todayYear = today.getFullYear();
	var todayMonth = ('0' + (today.getMonth() + 1)).slice(-2);
	var todayDate = ('0' + today.getDate()).slice(-2);
	var reservationdateday = todayYear + '-' + todayMonth + '-' + todayDate;


	//검색
	$('#search_btn').click(function() {
		var searchValue = $("#search_value").val();
		if (searchValue == "" || searchValue.length < 2) {
			alert("검색어를 입력하세요.\n2글자 이상입력하세요.");
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
				//alert("통신에 성공했습니다. "); //ok
				let result = data.result; //result: result안에 pet_birth, owner_name등 정보가 다 있음. 
				$("#researchTable").empty();
				//alert("result:" + result);
				let table = '';
				if (result == "") {

					table += "<tr class='text-center'> <td colspan='4'>존재하지 않습니다.<br><br>";
					table += "<button class='btn btn-sm btn-primary' id='reg_btn'>신규등록</button></td></tr>";

				} else {
					var today = new Date();
					//$('#researchTable').empty(); //리스트 초기화
					//검색 리스트 띄우기
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
						table += '<input type="hidden" id="search_ownerNo" value="' + result[i].owner_no + '">';
						table += '<td style="text-align: right;"><span></span><br><br><span>';
						table += '<button type="button" class="btn btn-sm reserv_btn" value="' + result[i].pet_no + '" style="border: 1px solid #0d6efd; color: #0d6efd;">예약</button>';
						table += '<button type="button" id="search_receipt_btn" class="btn btn-primary btn-sm search_receipt_btn" value="' + result[i].pet_no + '" data-value="'+result[i].owner_no+'" style="margin-left:5px; border: none;">접수</button></span></td></tr>';
					}
					$("#researchTable").append(table);
					$("#researchTable").show();
				}
			}).fail(function(jqXHR, textStatus, errorThrown) {
				alert("POST request failed: " + errorThrown);
			});
		}

	});
					
	
				//검색에서 접수버튼
					$(document).on("click", ".search_receipt_btn", function() {
					//$('.search_receipt_btn').change(function() {
					//$(document).off("click", "#search_receipt_btn").on("click", "#search_receipt_btn", function() {
					if (confirm("접수 하시겠습니까?")) {
						//alert("검색에서 접수버튼");
						var search_petNo = $(this).attr("value");
						//alert("search_petNo값 : " + search_petNo); //ok
						var search_ownerNo = $(this).attr("data-value");
						//var search_ownerNo = $('input[name=search_ownerNo]').val();
						//alert($('#search_ownerNo').val());//안옴
						alert(search_ownerNo);//안옴
						
						//백으로 보내서 삽입
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
							//alert("통신성공");
						}).fail(function() {
							alert("통신실패 : " + data.result);
						});
						//alert(petNo); //ok
						alert("접수 등록이 되었습니다.");
						location.reload(); //모달창 hide + 부모창새로고침
					}
				});

	

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
			$("#exampleModal").modal('show')
			let result = data.result;
			let result1 = data.result1;

			for (var i = 0; i < result1.length; i++) {
				let disabled_time = result1[i].reserv_time;
				//alert(disabled_time);
				let time = $("input[name='reserv_time'][value='" + disabled_time + "']").siblings('label').text();
				//alert(reservation_date_day+"날짜의 "+"disabled_time:"+disabled_time); //예약된 시간 다 조회
				//alert("time:"+time); //ok
				if (disabled_time == time) {
					//alert("일치");
					$("input[name='reserv_time'][value='" + disabled_time + "']").attr("disabled", true);
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
				let time = $("input[name='reserv_time'][value='" + disabled_time + "']").siblings('label').text();
				//alert(reservation_date_day+"날짜의 "+"disabled_time:"+disabled_time); //예약된 시간 다 조회
				//alert("time:"+time); //ok
				if (disabled_time == time) {
					//alert("disabled_time일치:"+disabled_time);
					$("input[name='reserv_time'][value='" + disabled_time + "']").attr("disabled", true);
				}
			}
		});
	});

	// 수정모달_날짜변경시 
	$('#update_reservation_date_day').change(function() {
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
				let time = $("input[name='reserv_time'][value='" + disabled_time + "']").siblings('label').text();
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
		//accordion창 접기
		$('.accordion-collapse').collapse('hide');
	});












	//예약수정
	$(document).on("click", ".reservUpdate", function(e) {
		$('#reservation_date_day').val(reservationdateday);

		let reservation_no = $(this).attr("value"); //reservation_no정보 (button의 value값)
		//alert(reservation_no + " : reservation_no"); //ok

		var reservation_date_day_input = $('#reservation_date_day').val();
		var reservation_date_day_parts = reservation_date_day_input.split('-');
		var reservation_date_day = reservation_date_day_parts[0] + '-' + reservation_date_day_parts[1] + '-' + reservation_date_day_parts[2];

		//이제 이걸 post로 /reservAjax 컨트롤러로 전송
		$.ajax({
			url: "/reservUpdate",
			type: "POST",
			data: { "reservation_no": reservation_no, "reservation_date_day": reservation_date_day }, //button클릭하면 받아오는 pet_no정보를 컨트롤러(서버)에 보냄 //search_no기준으로 나머지 정보가져옴
			dataType: "json",
			cache: false
		}).done(function(data) { //data: 서버가 전송한 데이터(html의 태그안에 박혀있는 값들 넣기). {"search_no": search_no}가 아님!
			let result = data.result; //result: html의 태그안에 박혀있는 값들 넣기
			let result1 = data.result1; //날짜막기
			//alert("result[0].reserv_time:"+result[0].reserv_time);

			for (var i = 0; i < result1.length; i++) {
				let disabled_time = result1[i].reserv_time;
				//alert(disabled_time);
				let time = $("input[name='reserv_time'][value='" + disabled_time + "']").siblings('label').text();
				//alert(reservation_date_day+"날짜의 "+"disabled_time:"+disabled_time); //예약된 시간 다 조회
				//alert("time:"+time); //ok
				if (disabled_time == time) {
					//alert("일치");
					$("input[name='reserv_time'][value='" + disabled_time + "']").attr("disabled", true);
				}
			}



			var update_reservation_date_time = result[0].reserv_time; //디폴트 시간
			//alert("update_reservation_date_time : " + update_reservation_date_time);  //ok
			$("#updateModal").modal('show')
			//alert('성공'); //ok
			//alert("result[0].reservation_no:" + result[0].reservation_no) //null
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

			$('.timeoption').appendTo('.updatetimeset'); //시간html 추가
		})
			.fail(function(jqXHR, textStatus, errorThrown) {
				alert("get request failed: " + errorThrown);
			});


	});
	//수정완료 버튼
	$("#update_ok-button").click(function() {
		if (confirm("수정 하시겠습니까?")) {
			let update_reservation_no = $(this).attr("value"); //reservation_no
			//alert("update_reservation_no:" + update_reservation_no); //ok

			var update_reservation_date_time = $("input[name='reserv_time']:checked").siblings('label').text();
			//alert("update_reservation_date_time:"+update_reservation_date_time); //ok
			//최종날짜+최종시간
			//alert("$('#update_reservation_date_day').val():"+$('#update_reservation_date_day').val());//ok
			var updatereservationdate = ($('#update_reservation_date_day').val() + ' ' + update_reservation_date_time + ':00');
			//alert(updatereservationdate); //ok
			$('#update_reservation_date').val(updatereservationdate); //최종날짜시간 value에 삽입
			//alert("$('#update_reservation_date').val():"+$('#update_reservation_date').val());//undefined

			var update_reservation_memo = $('#update_reservation_memo').val();
			var update_reservation_date = updatereservationdate
			alert(update_reservation_date);

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
				location.reload(); //모달창 hide + 부모창새로고침
			}).fail(function() {
				alert("통신실패 : " + data.result);
			});
		}
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
	$(".reserv_cancel").click(function() {
		let delete_reservation_no = $(this).attr("value"); //reservation_no
		//alert("delete_reservation_no:" + delete_reservation_no);

		if (confirm("예약을 취소 하시겠습니까?")) {
			location.href = "reservDelete?delete_reservation_no=" + delete_reservation_no;
		}
	});


	//접수 버튼 -> 접수테이블에 데이터 넣기
	$(".receipt_btn").click(function() {
		//alert("접수버튼");
		if (confirm("접수 하시겠습니까?")) {
			let reservNo = $(this).attr("value"); //reservation_no
			//alert("reservNo값 : " + reservNo); //ok
			var receive_petNo = $('#petNo').val();
			var receive_ownerNo = $('#ownerNo').val();
			//alert(receive_petNo);
			//alert(receive_ownerNo);
			//백으로 보내서 삽입
			$.post({
				url: "/receiveAdd",
				data: {
					"reservNo": reservNo,
					"receive_petNo": receive_petNo,
					"receive_ownerNo": receive_ownerNo
				},
				dataType: "json"
			}).done(function(data) {
				//alert("통신성공");
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
		}
	});

	//접수취소 버튼
	$(".receipt_cancel").click(function() {
		let delete_receive_no = $(this).attr("value"); //receive_no
		//alert("delete_receive_no:" + delete_receive_no); //ok

		if (confirm("접수를 취소 하시겠습니까?")) { //ok
			location.href = "receiveDelete?delete_receive_no=" + delete_receive_no;
		}
	});





});


