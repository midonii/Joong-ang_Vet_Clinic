//달력초기화면 오늘날짜로 설정
// Setup the calendar with the current date
$(document).ready(function(){
    var date = new Date(); //date : Wed Mar 01 2023 16:45:51 GMT+0900 (한국 표준시)
    var today = date.getDate();
//	var strday = date.getDay(); //요일
    // Set click handlers for DOM elements

    $(".right-button").click({date: date}, next_year); //{date: date} = date속성에 "var date = new Date()"넣기
    $(".left-button").click({date: date}, prev_year);
    $(".month").click({date: date}, month_click);
    $("#add-button").click({date: date}, new_event);
    // Set current month as active
    $(".months-row").children().eq(date.getMonth()).addClass("active-month");
    init_calendar(date);
    //var events = check_events(today, date.getMonth()+1, date.getFullYear(), date.getDay());
//	var strday = date.getDay();

    //show_events(months[date.getMonth()], today, date.getFullYear(), date.getDay());  //생략가능?

//    show_events(events, months[date.getMonth()], today, strday);  //생략가능?
	//alert("기본: "+date.getDay()); //3?

	
});

// Initialize the calendar by appending the HTML dates
//HTML로 데이트를 추가하면서 캘린더 초기화
//캘린더 첫화면
function init_calendar(date) { //date:오늘 날짜
    $(".tbody").empty(); //tbody 클래스를 가진 HTML 요소의 내용지우기
    $(".events-container").empty();
	 
    var calendar_days = $(".tbody");
    var month = date.getMonth();
    var year = date.getFullYear();
    var day_count = days_in_month(month, year);
    var row = $("<tr class='table-row'></tr>");
    var today = date.getDate();
	var strday = date.getDay();
	//alert(year);//ok
	//월의 첫번째 날을 찾기위해 date를 1로 설정
    // Set date to 1 to find the first day of the month
    date.setDate(1);
    var first_day = date.getDay(); //1일의 요일
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
            //var events = check_events(day, month+1, year, strday);
	
			//오늘 날짜인 경우 && .active-date가 없는 경우
            if(today===day && $(".active-date").length===0) { 
                curr_date.addClass("active-date");
//				date.setDate(day);
//				var strday = date.getDay(); //클릭한 날짜의 요일
 				
				//alert("strday: "+strday);//ok 
                show_events(months[month], day, year, strday);
				//show_events(events, months[date.getMonth()], today, strday);
            }
			//아무예약 없을때 .event-date 추가
            // If this date has any events, style it with .event-date
//            if(events.length!==0) {
//                curr_date.addClass("event-date");
//            }
			//날짜 클릭시 date_click함수 실행 (events, month, day, year 인자값으로)
            // Set onClick handler for clicking a date
            curr_date.click({month: months[month], day:day, year:year, strday:strday}, date_click); //events:events
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
function date_click(event) { //event: 클릭된 날짜 셀의 정보
//    $(".events-container").show(250);
    //$("#dialog2").show(250);
	//var strday = event.date.getDay(); //요일
//	var date1 = event.data.day.toString().padStart(2,'0');
    $("#dialog").hide(250);
    $(".active-date").removeClass("active-date");
    $(this).addClass("active-date");

//	var strday = event.date.getDay();
//	var day = parseInt($(".active-date").html());
//	date.setDate(day);
//	var strday = new Date(year, month, day).getDay();
    show_events(event.data.month, event.data.day, event.data.year, event.data.strday);
};


//월 클릭했을때 이벤트핸들러
// Event handler for when a month is clicked
function month_click(event) {
//    $(".events-container").show(250);
    $("#dialog").hide(250);
    var date = event.data.date;
    $(".active-month").removeClass("active-month");
    $(this).addClass("active-month");
    var new_month = $(".month").index(this);
    date.setMonth(new_month);
    init_calendar(date);
	show_events(month, day, year, strday);
//	show_events();
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
	show_events(month, day, year, strday);
//	show_events();
}

// Event handler for when the year left-button is clicked
function prev_year(event) {
    $("#dialog").hide(250);
    var date = event.data.date;
    var new_year = date.getFullYear()-1;
    $("year").html(new_year);
    date.setFullYear(new_year);
    init_calendar(date);
	show_events(month, day, year, strday);
	//	show_events();
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



//주간리스트 띄우기
//해당 날짜 예약리스트 모두 띄우기(events -> 이걸로 안띄울거라 이 매개변수 안씀)
// Display all events of the selected date in card views
function show_events(month, day, year) { //매개변수: init_calendar 함수에서 date_click 함수를 호출할 때 전달됨

	// 달의 마지막 날짜
	var lastDate = new Date(year, month, 0).getDate();
	// 그렇지 않으면 다음 달의 시작 날짜를 출력합니다.
	var startDate = day <= lastDate ? day : 1;

	var fulldate = year + "-" + month + "-" + day.toString().padStart(2,'0'); //2023-03-25
	
	//요일구하기..
	var date_clicked = new Date(year, month-1, day); // -1을 해주어야 정확한 월(month) 값이 됩니다.
	var strday = date_clicked.getDay();
	var dayName = strdays[0][strday];//클릭한날의 요일
	alert("dayName:"+dayName); //ok
	
	
	$(".date").empty();
	$("#dialog2").show(250); //주간리스트
	
	//누른날짜 기준으로 5일치 띄우기
	for(var i=0; i<5; i++){
		//var num = day+i;
		var num = startDate + i; //startDate: 오늘날짜(day)이거나 1이거나
		var date;
		
		//fulldate, strday 값넣은 날짜 5개 찍기
		//날짜가 마지막날짜보다 작거나 같으면
		if(num <= lastDate) {
        date = $("<p class='date-num' data-date='"+fulldate+"' data-strday='"+strday+"'>"+num+"</p>");
	    } 
		//마지막 날짜를 초과하면 다음달 찍기
		//다음 달의 날짜 계산
		else {
		var nextMonthDate = new Date(year, month-1, lastDate+1);
//		var fulldate = date.getFullyear() + "-" + date.getmonth() + "-" + date.getdate();
	 	var nextMonthStrday = nextMonthDate.getDay();	
		var yearStr = nextMonthDate.getFullYear();
		var monthStr = (nextMonthDate.getMonth() + 1).toString().padStart(2, '0');
		var dateStr = nextMonthDate.getDate().toString().padStart(2, '0');
		var dateString = yearStr + "-" + monthStr + "-" + dateStr;
        date = $("<p class='date-num' data-date='"+dateString+"' data-strday='"+nextMonthStrday+"'>"+(num-lastDate)+"</p>");
	    }
		
		//요일찍기
		dayName = strdays[0][(strday+i) % 7]
	   	var dayEl = $("<p class='date-day'>" + dayName + "</p>");
	    $(".day"+i).append(date);
	    $(".day"+i).append(dayEl);


//		$(".date-num").each(function() { //15-16번 실행됨
//		  var date1 = $(this).data("date"); //date: date-num클래스의 data-date의 밸류
//		  var events = getEvents(date1); // 이 함수는 해당 날짜에 있는 이벤트를 반환하는 함수입니다.
//		  // 이벤트가 있다면 이벤트를 표시합니다.
//		  if (events.length > 0) {
//			alert("event있음:"+events.length);
//		    var eventDiv = $("<div class='events'></div>");
//		    
//		    for (var i = 0; i < events.length; i++) {
//		      var event = events[i];
//		      var eventTime = event.time;
//		      var eventTitle = event.title;
//		      
//		      var eventEl = $("<div class='event'></div>");
//		      eventEl.append("<p class='time'>" + eventTime + "</p>");
//		      eventEl.append("<p class='title'>" + eventTitle + "</p>");
//		      
//		      eventDiv.append(eventEl);
//		    }
//		    
//		    $(this).append(eventDiv);
//		  }
//		});
		
		}
	
}
function getEvents(date1) {
//  var events = [];
  $.ajax({
    url: "/reservlist_calender",
    data: { "date1": date1 },
    type: "get",
    dataType: "json"
	}).done(function(data){
		let result = data.result;
		for (var i = 0; i < result.length; i++) {
			alert(result1[i].reserv_time);
			}
		
	}).fail(function() {
			alert("통신실패 : " + data.result);
		});
//  return events;
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

//new_event_json("지혜","까미"..)으로 값이 들어오면 
//event = {"owner_name": "지혜", "pet_name": "까미"}로 값이 들어감

//function new_event_json(owner_name, pet_name, owner_tel, owner_addr, time, reservation_memo, year, month, day, strday) {
//    var event = {
//        "owner_name": owner_name,
//        "pet_name": pet_name,
//        "owner_tel": owner_tel,
//        "owner_addr": owner_addr,
//        "time": time,
//        "reservation_memo": reservation_memo,
//        "year": date.getFullYear(),
//        "month": date.getMonth()+1,
//        "day": day,
//		"strday": date.getDay()
//    };
//    event_data["events"].push(event); //event_data 객체의 events 속성에 event 객체를 추가하는 것(제일 하단에 있음)
//}


//해당 날짜에 예약있는지 확인
// Checks if a specific date has any events
//function check_events(day, month, year) {
//    var events = [];
//    for(var i=0; i<event_data["events"].length; i++) {
//        var event = event_data["events"][i];
//        if(event["day"]===day &&
//            event["month"]===month &&
//            event["year"]===year) {
//                events.push(event);
//            }
//    }
//    return events;
//}

//예약 정보(json포맷)
// Given data for events in JSON format
//var event_data = {
//    "events": [
//    {
//        "occasion": " Repeated Test Event ",
//        "invited_count": 120,
//        "year": 2017,
//        "month": 5,
//        "day": 10,
//        "cancelled": true
//    },
//    {
//        "occasion": " Repeated Test Event ",
//        "invited_count": 120,
//        "year": 2017,
//        "month": 5,
//        "day": 10,
//        "cancelled": true
//    },
//        {
//        "occasion": " Repeated Test Event ",
//        "invited_count": 120,
//        "year": 2017,
//        "month": 5,
//        "day": 10,
//        "cancelled": true
//    },
//    {
//        "occasion": " Repeated Test Event ",
//        "invited_count": 120,
//        "year": 2017,
//        "month": 5,
//        "day": 10
//    },
//        {
//        "occasion": " Repeated Test Event ",
//        "invited_count": 120,
//        "year": 2017,
//        "month": 5,
//        "day": 10,
//        "cancelled": true
//    },
//    {
//        "occasion": " Repeated Test Event ",
//        "invited_count": 120,
//        "year": 2017,
//        "month": 5,
//        "day": 10
//    },
//        {
//        "occasion": " Repeated Test Event ",
//        "invited_count": 120,
//        "year": 2017,
//        "month": 5,
//        "day": 10,
//        "cancelled": true
//    },
//    {
//        "occasion": " Repeated Test Event ",
//        "invited_count": 120,
//        "year": 2017,
//        "month": 5,
//        "day": 10
//    },
//        {
//        "occasion": " Repeated Test Event ",
//        "invited_count": 120,
//        "year": 2017,
//        "month": 5,
//        "day": 10,
//        "cancelled": true
//    },
//    {
//        "occasion": " Repeated Test Event ",
//        "invited_count": 120,
//        "year": 2017,
//        "month": 5,
//        "day": 10
//    },
//    {
//        "occasion": " Test Event",
//        "invited_count": 120,
//        "year": 2017,
//        "month": 5,
//        "day": 11
//    }
//    ]
//};
const strdays = [
	{
	0:"일", 
    1:"월", 
    2:"화", 
    3:"수", 
    4:"목", 
    5:"금", 
    6:"토" 
	}
	
];
const months = [ 
//    "January", 
//    "February", 
//    "March", 
//    "April", 
//    "May", 
//    "June", 
//    "July", 
//    "August", 
//    "September", 
//    "October", 
//    "November", 
//    "December" 
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