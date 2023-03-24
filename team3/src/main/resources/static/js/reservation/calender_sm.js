//달력초기화면 오늘날짜로 설정
// Setup the calendar with the current date
$(document).ready(function(){
    var date = new Date();
    var today = date.getDate();
    // Set click handlers for DOM elements
    $(".right-button").click({date: date}, next_year);
    $(".left-button").click({date: date}, prev_year);
    $(".month").click({date: date}, month_click);
    $("#add-button").click({date: date}, new_event);
    // Set current month as active
    $(".months-row").children().eq(date.getMonth()).addClass("active-month");
    init_calendar(date);
    var events = check_events(today, date.getMonth()+1, date.getFullYear());
    //show_events(events, months[date.getMonth()], today); 


	//주간리스트
	
});

// Initialize the calendar by appending the HTML dates
//HTML로 데이트를 추가하면서 캘린더 초기화
function init_calendar(date) {
    $(".tbody").empty(); //tbody 클래스를 가진 HTML 요소의 내용지우기
    $(".events-container").empty(); 
    var calendar_days = $(".tbody");
    var month = date.getMonth();
    var year = date.getFullYear();
    var day_count = days_in_month(month, year);
    var row = $("<tr class='table-row'></tr>");
    var today = date.getDate();
	//월의 첫번째 날을 찾기위해 date를 1로 설정
    // Set date to 1 to find the first day of the month
    date.setDate(1);
    var first_day = date.getDay();
    // 35+firstDay is the number of date elements to be added to the dates table
    // 35 is from (7 days in a week) * (up to 5 rows of dates in a month)
    for(var i=0; i<35+first_day; i++) {
        // Since some of the elements will be blank, 
        // need to calculate actual date from index
        var day = i-first_day+1;
		//일욜이면 새로운 row생성
        // If it is a sunday, make a new row
        if(i%7===0) {
            calendar_days.append(row);
            row = $("<tr class='table-row'></tr>");
        }
        // if current index isn't a day in this month, make it blank
        if(i < first_day || day > day_count) {
            var curr_date = $("<td class='table-date nil'>"+"</td>");
            row.append(curr_date);
        }   
        else {
            var curr_date = $("<td class='table-date'>"+day+"</td>");
            var events = check_events(day, month+1, year);
            if(today===day && $(".active-date").length===0) {
                curr_date.addClass("active-date");
                show_events(events, months[month], day);
            }
            // If this date has any events, style it with .event-date
            if(events.length!==0) {
                curr_date.addClass("event-date");
            }
            // Set onClick handler for clicking a date
            curr_date.click({events: events, month: months[month], day:day}, date_click);
            row.append(curr_date);
        }
    }
    // Append the last row and set the current year
    calendar_days.append(row);
    $(".year").text(year);
}

// Get the number of days in a given month/year
function days_in_month(month, year) {
    var monthStart = new Date(year, month, 1);
    var monthEnd = new Date(year, month + 1, 1);
    return (monthEnd - monthStart) / (1000 * 60 * 60 * 24);    
}

//날짜 클릭했을때의 이벤트핸들러
// Event handler for when a date is clicked
function date_click(event) {
//    $(".events-container").show(250);
    //$("#dialog2").show(250);
    $("#dialog").hide(250);
    $(".active-date").removeClass("active-date");
    $(this).addClass("active-date");
    show_events(event.data.events, event.data.month, event.data.day);
};
//월 클릭했을때 이벤트핸들러
// Event handler for when a month is clicked
function month_click(event) {
    $(".events-container").show(250);
    $("#dialog").hide(250);
    var date = event.data.date;
    $(".active-month").removeClass("active-month");
    $(this).addClass("active-month");
    var new_month = $(".month").index(this);
    date.setMonth(new_month);
    init_calendar(date);
}
//년 클릭했을때 이벤트핸들러
// Event handler for when the year right-button is clicked
function next_year(event) {
    $("#dialog").hide(250);
    var date = event.data.date;
    var new_year = date.getFullYear()+1;
    $("year").html(new_year);
    date.setFullYear(new_year);
    init_calendar(date);
	show_events();
}

// Event handler for when the year left-button is clicked
function prev_year(event) {
    $("#dialog").hide(250);
    var date = event.data.date;
    var new_year = date.getFullYear()-1;
    $("year").html(new_year);
    date.setFullYear(new_year);
    init_calendar(date);
	show_events();
}


//예약추가 버튼
//Event handler for clicking the new event button
function new_event(event) {
	//시간체크 풀기
	$("#dialog2").hide();
	$("input:radio[name='reserv_time']").each(function(i) { this.checked = false; });
	$("input:radio[name='reserv_time']").attr('disabled', false);
	var date = event.data.date;
	var day = parseInt($(".active-date").html()); //선택된 날짜를 숫자로 변환
	var fulldate = date.getFullYear() + "-" + ((date.getMonth()+1).toString().padStart(2,'0')) + "-" + day.toString().padStart(2,'0');
	//alert(fulldate); //전체날짜
		
    // if a date isn't selected then do nothing
    if($(".active-date").length===0)
        return;
    // remove red error input on click
    $("input").click(function(){
        $(this).removeClass("error-input");
    });

	
	//input내용 초기화
    // empty inputs and hide events
//	$("input:radio[name='reserv_time']").each(function(i) { this.checked = false; }); //왜 여기에 두면 안먹힐까? 제일 상단에 놔야먹힘
	$('.accordion-collapse').collapse('hide');
	$('#s_reservation_date_day').val(fulldate);
	
    $("#dialog input[type=text]").val(''); //ok
    $("#dialog #reservation_memo").val('');
//    $("#dialog #reservation_date_day").val(''); //
    //$("#dialog input[name=reserv_time]").val(''); //ok
	$('.timeoption').appendTo('.timeset');
    $(".events-container").hide(250);
    //$("#dialog input[type=number]").val('');


	//날짜막기
	var reservation_date_day = $("#s_reservation_date_day").val(); //날짜
	//alert(reservation_date_day);//ok
	
	$.ajax({
		url: "/reservAjax",
		type: "POST",
		data: { "reservation_date_day": reservation_date_day }, 
		dataType: "json",
		cache: false
	}).done(function(data) {
		//alert('성공'); //ok
		let result1 = data.result1;

		for (var i = 0; i < result1.length; i++) {
			let disabled_time = result1[i].reserv_time;
			//alert("disabled_time: "+disabled_time);
			//alert(reservation_date_day+"날짜의 disabled_time:"+disabled_time); //예약된 시간 다 조회
			let time = $("input[name='reserv_time'][value='" + disabled_time + "']").val();
			//alert("없앨 time:"+time); //ok
			if (disabled_time == time) {
				//alert("일치");
				$("input[name='reserv_time'][value='" + disabled_time + "']").attr("disabled", true);
			}
		}
   		 $("#dialog").show(250);

		}).fail(function(jqXHR, textStatus, errorThrown) {
				alert("get request failed: " + errorThrown);
		});


	//취소버튼 클릭
    // Event handler for cancel button
    $("#cancel-button").click(function() {
		$("input:radio[name='reserv_time']").each(function(i) { this.checked = false; });
        $("#name").removeClass("error-input");
        $("#count").removeClass("error-input");
		$('.accordion-button').collapse('hide');
        $("#dialog").hide(250);
        $(".events-container").show(250);
    });

	//예약창 닫았을때 text값 초기화
//	$('#dialog').on('hide', function(e) {
//		alert("닫힘");
//		if ($(this).find('form').length > 0) {
//			$(this).find('form')[0].reset();
//			var inputValue = $(this).find('select:eq(0) option:eq(0)');
//		}
//		//accordion창 접기
//		$('.accordion-collapse').collapse('hide');
//	});
	

    // 예약완료 버튼 눌렀을때
    $("#s_ok-button").click(function() { 
//    $("#ok-button").unbind().click({date: event.data.date}, function() { 
	if (confirm("예약 하시겠습니까?")) {
        var date = event.data.date;
        var owner_name = $("#owner_name").val();
        var pet_name = $("#pet__name").val();
        var owner_tel = parseInt($("#owner_tel").val());
        var owner_addr = $("#owner_addr").val();
		var reservation_date_time = $("input[name='reserv_time']:checked").siblings('label').text(); //시간
//		alert("reservation_date_time: "+reservation_date_time);
//		alert("reservation_date_day: "+reservation_date_day );
		if (reservation_date_day !== '' && ('input:radio[name="reserv_time"]:checked').length > 0) {
			//최종날짜+최종시간
			var reservation_date = (reservation_date_day + ' ' + reservation_date_time + ':00');//날짜+시간
			$('#reservation_date').val(reservation_date);
		}
		if ($('input:radio[name="reserv_time"]:checked').length < 1) {
				alert('예약 시간을 선택해주세요');
				return false;
			}
		var petNo = $("#petNo").val();
        var reservation_memo = $("#reservation_memo").val();	
//		var reservation_date = $('#reservation_date').val();	
		//예약추가할때 petNo을 가져올수없음. 펫선택 하기전 이어서.(date정보만 가져옴)
		//검색->선택 눌렀을때 가져오기
//		alert("petNo:"+petNo); //ok
//		alert(reservation_memo); //ok
//		alert(reservation_date); //undefined 09:00:00


		$.post({
				url: "/reservAdd",
				data: {
					"petNo": petNo,
					"reservation_memo": reservation_memo,
					"reservation_date": reservation_date
				},
				dataType: "json"
			}).done(function(data) {
				
				alert("저장성공"); //
				}).fail(function() {
				alert("통신실패 : " + data.result);
			});
			alert("예약이 등록 되었습니다.");
			location.reload(); //모달창 hide + 부모창새로고침
		}

		

        var time = $("#collapseOne").val();
		var day = parseInt($(".active-date").html()); //선택된 날짜를 숫자로 변환
        //var count = parseInt($("#count").val().trim());
            $("#dialog").hide(250);
            console.log("new event");
            new_event_json(owner_name, pet_name, owner_tel, owner_addr, time, reservation_memo, date, day);
            date.setDate(day);
            init_calendar(date);
//        }
    });
} //new_event 끝




//해당 날짜 예약리스트 모두 띄우기
// Display all events of the selected date in card views
function show_events(events, month, day) {
	$(".date").empty();
	$("#dialog2").show(250);   
	
	//왜 이건 안되고 아래는 되지?
//	var date=""
//	date += $("<p class='date-num'> "+$(day)+"</p>");
//	date += $("<p class='date-day1' id='date-day1'> "+day+"</p>"); //요일
//	$(".date").append(date);
	
	for(var i=0; i<5; i++){
		//alert(".day"+i);
		var num = day+i;
		var	date = $("<p class='date-num'>"+num+"</p>");
			$(".day"+i).append(date);
		}
	
	
	
	
//	alert(month); //ok
//	alert(day); //ok
	                                                              
	//date 컨테이너 비우기
    // Clear the dates container
    //$(".events-container").empty();
    //$(".events-container").show(250);



    //console.log(event_data["events"]);
	//일정이 없습니다. 란
//    if(events.length===0) {
        //var event_card = $("<div class='event-card'></div>");
//        var event_name = $("<div class='event-name'> "+month+" "+day+" 의 일정이 없습니다</div>");
        //$(event_card).css({ "border-left": "10px solid #FF1744" });
        //$(event_card).append(event_name);
//		$('.dialog2').appendTo(event_card);
//      $(event_card).append(".dialog2");
		
//		$("#dialog2").show(250);
        //$(".events-container").append("#dialog2");



//    }
//    else {
		//예약완료 버튼 눌렀을때, event컨테이너에 예약카드 생성 (하지만 오류남)
        // Go through and add each event as a card to the events container
//      for(var i=0; i<events.length; i++) {
//            var event_card = $("<div class='event-card'></div>");
//            var event_name = $("<div class='event-name'>"+events[i]["owner_name"]+":</div>");
//            //var event_count = $("<div class='event-count'>"+events[i]["invited_count"]+" Invited</div>");
//            if(events[i]["cancelled"]===true) {
//                $(event_card).css({
//                    "border-left": "10px solid #FF1744"
//                });
//                event_count = $("<div class='event-cancelled'>Cancelled</div>");
//            }
//            $(event_card).append(event_name).append(event_count);
//            $(".events-container").append(event_card);
//        }
//    }
}


function new_event_json(owner_name, pet_name, owner_tel, owner_addr, time, reservation_memo, date, day) {
    var event = {
        "owner_name": owner_name,
        "pet_name": pet_name,
        "owner_tel": owner_tel,
        "owner_addr": owner_addr,
        "time": time,
        "reservation_memo": reservation_memo,
        "year": date.getFullYear(),
        "month": date.getMonth()+1,
        "day": day
    };
    event_data["events"].push(event);
}


//해당 날짜에 예약있는지 확인
// Checks if a specific date has any events
function check_events(day, month, year) {
    var events = [];
    for(var i=0; i<event_data["events"].length; i++) {
        var event = event_data["events"][i];
        if(event["day"]===day &&
            event["month"]===month &&
            event["year"]===year) {
                events.push(event);
            }
    }
    return events;
}

//예약 정보(json포맷)
// Given data for events in JSON format
var event_data = {
    "events": [
    {
        "occasion": " Repeated Test Event ",
        "invited_count": 120,
        "year": 2017,
        "month": 5,
        "day": 10,
        "cancelled": true
    },
    {
        "occasion": " Repeated Test Event ",
        "invited_count": 120,
        "year": 2017,
        "month": 5,
        "day": 10,
        "cancelled": true
    },
        {
        "occasion": " Repeated Test Event ",
        "invited_count": 120,
        "year": 2017,
        "month": 5,
        "day": 10,
        "cancelled": true
    },
    {
        "occasion": " Repeated Test Event ",
        "invited_count": 120,
        "year": 2017,
        "month": 5,
        "day": 10
    },
        {
        "occasion": " Repeated Test Event ",
        "invited_count": 120,
        "year": 2017,
        "month": 5,
        "day": 10,
        "cancelled": true
    },
    {
        "occasion": " Repeated Test Event ",
        "invited_count": 120,
        "year": 2017,
        "month": 5,
        "day": 10
    },
        {
        "occasion": " Repeated Test Event ",
        "invited_count": 120,
        "year": 2017,
        "month": 5,
        "day": 10,
        "cancelled": true
    },
    {
        "occasion": " Repeated Test Event ",
        "invited_count": 120,
        "year": 2017,
        "month": 5,
        "day": 10
    },
        {
        "occasion": " Repeated Test Event ",
        "invited_count": 120,
        "year": 2017,
        "month": 5,
        "day": 10,
        "cancelled": true
    },
    {
        "occasion": " Repeated Test Event ",
        "invited_count": 120,
        "year": 2017,
        "month": 5,
        "day": 10
    },
    {
        "occasion": " Test Event",
        "invited_count": 120,
        "year": 2017,
        "month": 5,
        "day": 11
    }
    ]
};

const months = [ 
    "January", 
    "February", 
    "March", 
    "April", 
    "May", 
    "June", 
    "July", 
    "August", 
    "September", 
    "October", 
    "November", 
    "December" 
];