<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>캘린더</title>
<link rel="stylesheet"
	href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css">
<link rel="stylesheet" href="https://kit.fontawesome.com/a31e2023c3.css"
	crossorigin="anonymous">
<script src="https://kit.fontawesome.com/a31e2023c3.js"
	crossorigin="anonymous"></script>
<link
	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">
<!-- Custom styles for this template-->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65"
	crossorigin="anonymous">
<link href="css/sb-admin-2.min.css" rel="stylesheet">
<link href="css/reservation/reserv.css" rel="stylesheet">
<!-- Favicon-->
<link rel="icon" type="image/x-icon"
	href="/resources/assets/favicon.ico" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
<!-- bootstrap -->



  <!-- jquery CDN -->
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <!-- fullcalendar CDN -->
  <link href='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/main.min.css' rel='stylesheet' />
  <script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/main.min.js'></script>
  <script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/locales-all.min.js'></script>
  
   <link href='css/reservation/fullcalendar/main.css' rel='stylesheet' />
   <link href='css/reservation/fullcalendar/main.min.css' rel='stylesheet' />
    <script src='js/reservation/fullcalendar/main.js'></script>
    <script src='js/reservation/fullcalendar/main.min.js'></script>
    <script src='js/reservation/fullcalendar/local-all.js'></script>
    <script src='js/reservation/fullcalendar/local-all.min.js'></script>
    
<script>
document.addEventListener('DOMContentLoaded', function() {
	
	// calendar element 취득
	var calendarEl = document.getElementById('calendar');
    var calendar = new FullCalendar.Calendar(calendarEl, {
        // Tool Bar 목록 document : https://fullcalendar.io/docs/toolbar
        headerToolbar: {
            left: 'prevYear,prev,next,nextYear today',
            center: 'title',
            right: 'dayGridMonth,dayGridWeek,dayGridDay'
        },

        selectable: true,
        selectMirror: true,

        navLinks: true, // can click day/week names to navigate views
        editable: true,
        // Create new event
        select: function (arg) {
            Swal.fire({
                html: "<div class='mb-7'>Create new event?</div><div class='fw-bold mb-5'>Event Name:</div><input type='text' class='form-control' name='event_name' />",
                icon: "info",
                showCancelButton: true,
                buttonsStyling: false,
                confirmButtonText: "Yes, create it!",
                cancelButtonText: "No, return",
                customClass: {
                    confirmButton: "btn btn-primary",
                    cancelButton: "btn btn-active-light"
                }
            }).then(function (result) {
                if (result.value) {
                    var title = document.querySelector("input[name=;event_name']").value;
                    if (title) {
                        calendar.addEvent({
                            title: title,
                            start: arg.start,
                            end: arg.end,
                            allDay: arg.allDay
                        })
                    }
                    calendar.unselect()
                } else if (result.dismiss === "cancel") {
                    Swal.fire({
                        text: "Event creation was declined!.",
                        icon: "error",
                        buttonsStyling: false,
                        confirmButtonText: "Ok, got it!",
                        customClass: {
                            confirmButton: "btn btn-primary",
                        }
                    });
                }
            });
        },

        // Delete event
        eventClick: function (arg) {
            Swal.fire({
                text: "Are you sure you want to delete this event?",
                icon: "warning",
                showCancelButton: true,
                buttonsStyling: false,
                confirmButtonText: "Yes, delete it!",
                cancelButtonText: "No, return",
                customClass: {
                    confirmButton: "btn btn-primary",
                    cancelButton: "btn btn-active-light"
                }
            }).then(function (result) {
                if (result.value) {
                    arg.event.remove()
                } else if (result.dismiss === "cancel") {
                    Swal.fire({
                        text: "Event was not deleted!.",
                        icon: "error",
                        buttonsStyling: false,
                        confirmButtonText: "Ok, got it!",
                        customClass: {
                            confirmButton: "btn btn-primary",
                        }
                    });
                }
            });
        },
        dayMaxEvents: true, // allow "more" link when too many events
        // 이벤트 객체 필드 document : https://fullcalendar.io/docs/event-object
        events: [
            {
            title: 'All Day Event',
            start: '2022-07-01'
            },
            {
            title: 'Long Event',
            start: '2022-07-07',
            end: '2022-07-10'
            },
            {
            groupId: 999,
            title: 'Repeating Event',
            start: '2022-07-09T16:00:00'
            },
            {
            groupId: 999,
            title: 'Repeating Event',
            start: '2022-07-16T16:00:00'
            },
            {
            title: 'Conference',
            start: '2022-07-11',
            end: '2022-07-13'
            },
            {
            title: 'Meeting',
            start: '2022-07-12T10:30:00',
            end: '2022-07-12T12:30:00'
            },
            {
            title: 'Lunch',
            start: '2022-07-12T12:00:00'
            },
            {
            title: 'Meeting',
            start: '2022-07-12T14:30:00'
            },
            {
            title: 'Happy Hour',
            start: '2022-07-12T17:30:00'
            },
            {
            title: 'Dinner',
            start: '2022-07-12T20:00:00'
            },
            {
            title: 'Birthday Party',
            start: '2022-07-13T07:00:00'
            },
            {
            title: 'Click for Google',
            url: 'http://google.com/',
            start: '2022-07-28'
            }
        ]
    });

    calendar.render();
});




    </script>
    <style>
body {
line-height:14px;
}
 
 
#calendar {
  max-width: 1100px;
  margin: 0 auto;
}
 
 
#form-div {
  background-color: '';
  padding:5px 5px 5px;
  width: 100%;    
  margin-top:5px;
  -moz-border-radius: 7px;
  -webkit-border-radius: 7px;
}
 
.feedback-input {
  color:#3c3c3c;
  font-family: Helvetica, Arial, sans-serif;
  font-weight:400;
  font-size: 11px;
  border-radius: 0;
  line-height: 22px;
  background-color: #ffffff;
  padding: 3px 3px 3px 6px;
  margin-bottom: 10px;
  width:100%;
  -webkit-box-sizing: border-box;
  -moz-box-sizing: border-box;
  -ms-box-sizing: border-box;
  box-sizing: border-box;
  border: 3px solid rgba(0,0,0,0);
}
 
.feedback-input:focus{
  background: #fff;
  box-shadow: 0;
  /*border: 3px solid #3498db;*/
  border-color: #3498db;
  color: #3498db;
  outline: none;
  /*padding: 13px 13px 13px 54px;*/
}
 
.focused {
  color:#30aed6;
  border:#30aed6 solid 3px;
}
 
/* Icons */
#name{
  background-image: url(http://rexkirby.com/kirbyandson/images/name.svg);
  background-size: 30px 30px;
  background-position: 11px 8px;
  background-repeat: no-repeat;
}
 
#email{
  background-image: url(http://rexkirby.com/kirbyandson/images/email.svg);
  background-size: 30px 30px;
  background-position: 11px 8px;
  background-repeat: no-repeat;
}
 
#comment{
  background-image: url(http://rexkirby.com/kirbyandson/images/comment.svg);
  background-size: 30px 30px;
  background-position: 11px 8px;
  background-repeat: no-repeat;
}
 
textarea {
  width: 100%;
  height: 150px;
  line-height: 150%;
  resize:vertical;
}
 
input:hover, textarea:hover,
input:focus, textarea:focus {
  background-color:white;
}
 
#button-blue{
  font-family: 'Montserrat', Arial, Helvetica, sans-serif;
  float:left; /* 플롯 중요(::after 가상요소 이용)*/
  width: 100%;
  border: #fbfbfb solid 4px;
  cursor:pointer;
  background-color: #3498db;
  color:white;
  font-size:24px;
  padding-top:22px;
  padding-bottom:22px;
  -webkit-transition: all 0.3s;
  -moz-transition: all 0.3s;
  transition: all 0.3s;
  margin-top:-4px;
  font-weight:700;
}
 
#button-blue:hover{
  background-color: rgba(0,0,0,0);
  color: #0493bd;
}
 
.ease {
  width: 0;
  height: 74px;
  background-color: #fbfbfb;
  -webkit-transition: .3s ease;
  -moz-transition: .3s ease;
  -o-transition: .3s ease;
  -ms-transition: .3s ease;
  transition: .3s ease;
}
 
.submit:hover .ease{
  width:100%;
  background-color:white;
}
</style>
  </head>
  <body>
  <div id="contents">
<div id="dialog" title="일정 관리" style="display:none;">
    <div id="form-div">
        <form class="diaForm" id="diaForm" >
              <input type="hidden" name="actType" value="C" /> <!-- C:등록 U:수정 D:삭제 -->
            <input type="hidden" name="id" value="" />
            <input type="hidden" name="start" value="" />
            <input type="hidden" name="end" value="" />
            
            <p class="name">
                <input name="title" type="text" class="validate[required,custom[onlyLetter],length[0,100]] feedback-input" placeholder="일정타이틀" id="name" />
            </p>
            
            <p class="email">
                <input name="xdate" type="text" readonly="readonly" class="validate[required,custom[email]] feedback-input"  placeholder="선택된날짜 및 시간" />
            </p>
            
            <p class="text">
                <textarea name="xcontent" class="validate[required,length[6,300]] feedback-input" id="comment" placeholder="일정내용"></textarea>
            </p>        
        </form>
    </div>
</div>

<br/>
    <div id='calendar'></div>
    </div>
  </body>
</html>