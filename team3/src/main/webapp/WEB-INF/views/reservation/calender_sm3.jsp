<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html lang="ko">
%>
<head>

<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>캘린더</title>
<link rel="stylesheet"
	href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<!-- <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" -->
<!-- 	type="text/css"> -->
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
<!-- <link rel="stylesheet" href="style.css"> -->
<link rel="stylesheet" href="css/reservation/calender_sm.css">
<script type="text/javascript"
	src="../js/reservation/calender_search.js"></script>
<script type="text/javascript">
//주간 시작 날짜 선택

changeWeekSdateoption = function(selectedDate){

var tempD = Date.parse(selectedDate);

var selectedD = tempD;

if(tempD.getDay()!=1){

selectedD = tempD.previous().monday();

}

selectedD=selectedD.toString('yyyy-MM-dd');

$( "#sdate" ).attr("value", selectedD);

}

 

// 주간 끝 날짜 선택

changeWeekEdateoption = function(selectedDate){

 

var tempD = Date.parse(selectedDate);

 

var selectedD = tempD;

if(tempD.getDay()!=1){

selectedD = tempD.previous().monday();

}

selectedD=selectedD.toString('yyyy-MM-dd');

$( "#edate" ).attr("value", selectedD);

}
</script>
<style type="text/css">
.xans-calendar-weekpackage {}
.xans-calendar-weekpackage .tab { position:relative; margin:20px 0 30px; height:34px; border-bottom:1px solid #d6d6d6; }
.xans-calendar-weekpackage .tab ul { border:1px solid #cbcdce; border-bottom-color:#292929; height:38px; border-left:0; background:#f0f2f2; *zoom:1; }
.xans-calendar-weekpackage .tab ul:after { content:""; display:block; clear:both; }
.xans-calendar-weekpackage .tab li { float:left; }
.xans-calendar-weekpackage .tab li a { display:block; min-width:168px; height:38px; padding:0 15px; border-right:1px solid #cbcdce; border-left:1px solid #cbcdce; color:#757575; line-height:38px; text-decoration:none; text-align:center; background:#f0f2f2; }
.xans-calendar-weekpackage .tab li:first-child a { margin:0 -1px 0 0; }
.xans-calendar-weekpackage .tab li:last-child a { margin:0 0 0 -1px; }
.xans-calendar-weekpackage .tab li.selected a { position:relative; top:-1px; margin:0 0 -1px; border:1px solid #292929; color:#fff; font-weight:bold; background:#4a5164; }
.xans-calendar-weekpackage .tab p.addType { position:absolute; top:8px; right:10px; }
.xans-calendar-headweek { position:relative; height:70px; text-align:center; }
.xans-calendar-headweek .date { display:inline; color:#d9bca0; font-size:30px; letter-spacing:-1px; font-family:Lucida Sans, sans-serif; }
.xans-calendar-headweek .date img { vertical-align:middle; }
.xans-calendar-headweek .btn { position:absolute; right:0; top:0px; }
.xans-calendar-category { padding:0 0 20px; }
.xans-calendar-listweekhead th { border-top:1px solid #d9bca0; font-size:11px; color:#d9bca0; background:url("http://img.echosting.cafe24.com/skin/base_ko_KR/calendar/bg_thead.gif") right 0 no-repeat; }
.xans-calendar-listweekhead th span { display:block; padding:8px 0; }
.xans-calendar-listweekhead th.time span { background:url("http://img.echosting.cafe24.com/skin/base_ko_KR/calendar/bg_thead.gif") 0 0 no-repeat; }
.xans-calendar-listweekhead th.sun span { color:#e5541e; }
.xans-calendar-listweekhead th.sat span { color:#7cbed7; }
.xans-calendar-listweek th { padding:8px 3px; text-align:center; color:#8f8f8f; font-weight:normal; border:1px solid #fff; background:#f1f4e6; font-size:11px; }
.xans-calendar-listweek td { padding:8px 3px; border:1px solid #fff; background:#f1f4e6; font-size:11px; }
.xans-calendar-listweek .week_today { background:#d1e7b9; }
.xans-calendar-listweek td li { }
.xans-calendar-listweek td li a,
.xans-calendar-listweek td li a:hover { line-height:18px; color:#96aa4b; }
.xans-calendar-listweek td li span { display:block; }
</style>
</head>
<body id="page-top">
	<!-- Page Wrapper -->
	<div id="wrapper">
		<%@ include file="../bar/sideBar.jsp"%>
		<!-- Content Wrapper -->
		<div id="content-wrapper" class="d-flex flex-column">
			<!-- Main Content -->
			<div id="content">
				<%@ include file="../bar/topBar.jsp"%>
				<!-- Begin Page Content -->
				<div class="container-fluid">



					
					
					
		<table border="1" summary="">
        <caption>カレンダー週間</caption>
        <colgroup>
            <col style="width:12%;" />
            <col style="width:13%;" />
            <col style="width:12%;" />
            <col style="width:13%;" />
            <col style="width:12%;" />
            <col style="width:13%;" />
            <col style="width:12%;" />
            <col style="width:13%;" />
        </colgroup>
        <thead module="Calendar_ListWeekhead">
            <tr>
                <th scope="col" class="time"><span>time</span></th>
                <th scope="col"><span>{$calendar_day_1} (MON)</span></th>
                <th scope="col"><span>{$calendar_day_2} (TUE)</span></th>
                <th scope="col"><span>{$calendar_day_3} (WED)</span></th>
                <th scope="col"><span>{$calendar_day_4} (THU)</span></th>
                <th scope="col"><span>{$calendar_day_5} (FRI)</span></th>
                <th scope="col" class="sat"><span>{$calendar_day_6} (SAT)</span></th>
                <th scope="col" class="sun"><span>{$calendar_day_7} (SUN)</span></th>
            </tr>
        </thead>
        <tbody module="Calendar_ListWeek">
            <!--
                $login_page_url = /member/login.html
                $calendar_view_url = calendar_view.html
             -->
            <tr>
                <th scope="row">{$calendar_time}:00</th>
                <td class="todo {$today1.class}">
                    <ol module="Calendar_List1">
                        <li><a href="#none" onclick="{$action_list_view}">[{$calendar_start_hour}:{$calendar_start_minute}]<span>{$calendar_title}</span></a></li>
                        <li><a href="#none" onclick="{$action_list_view}">[{$calendar_start_hour}:{$calendar_start_minute}]<span>{$calendar_title}</span></a></li>
                    </ol>
                </td>
                <td class="todo {$today2.class}">
                    <ol module="Calendar_List2">
                        <li><a href="#none" onclick="{$action_list_view}">[{$calendar_start_hour}:{$calendar_start_minute}]<span>{$calendar_title}</span></a></li>
                        <li><a href="#none" onclick="{$action_list_view}">[{$calendar_start_hour}:{$calendar_start_minute}]<span>{$calendar_title}</span></a></li>
                    </ol>
                </td>
                <td class="todo {$today3.class}">
                    <ol module="Calendar_List3">
                        <li><a href="#none" onclick="{$action_list_view}">[{$calendar_start_hour}:{$calendar_start_minute}]<span>{$calendar_title}</span></a></li>
                        <li><a href="#none" onclick="{$action_list_view}">[{$calendar_start_hour}:{$calendar_start_minute}]<span>{$calendar_title}</span></a></li>
                    </ol>
                </td>
                <td class="todo {$today4.class}">
                    <ol module="Calendar_List4">
                        <li><a href="#none" onclick="{$action_list_view}">[{$calendar_start_hour}:{$calendar_start_minute}]<span>{$calendar_title}</span></a></li>
                        <li><a href="#none" onclick="{$action_list_view}">[{$calendar_start_hour}:{$calendar_start_minute}]<span>{$calendar_title}</span></a></li>
                    </ol>
                </td>
                <td class="todo {$today5.class}">
                    <ol module="Calendar_List5">
                        <li><a href="#none" onclick="{$action_list_view}">[{$calendar_start_hour}:{$calendar_start_minute}]<span>{$calendar_title}</span></a></li>
                        <li><a href="#none" onclick="{$action_list_view}">[{$calendar_start_hour}:{$calendar_start_minute}]<span>{$calendar_title}</span></a></li>
                    </ol>
                </td>
                <td class="todo {$today6.class}">
                    <ol module="Calendar_List6">
                        <li><a href="#none" onclick="{$action_list_view}">[{$calendar_start_hour}:{$calendar_start_minute}]<span>{$calendar_title}</span></a></li>
                        <li><a href="#none" onclick="{$action_list_view}">[{$calendar_start_hour}:{$calendar_start_minute}]<span>{$calendar_title}</span></a></li>
                    </ol>
                </td>
                <td class="todo {$today7.class}">
                    <ol module="Calendar_List7">
                        <li><a href="#none" onclick="{$action_list_view}">[{$calendar_start_hour}:{$calendar_start_minute}]<span>{$calendar_title}</span></a></li>
                        <li><a href="#none" onclick="{$action_list_view}">[{$calendar_start_hour}:{$calendar_start_minute}]<span>{$calendar_title}</span></a></li>
                    </ol>
                </td>
            </tr>
            <tr>
                <th scope="row">{$calendar_time}:00</th>
                <td class="todo {$today1.class}">
                    <ol module="Calendar_List1">
                        <li><a href="#none" onclick="{$action_list_view}">[{$calendar_start_hour}:{$calendar_start_minute}]<span>{$calendar_title}</span></a></li>
                        <li><a href="#none" onclick="{$action_list_view}">[{$calendar_start_hour}:{$calendar_start_minute}]<span>{$calendar_title}</span></a></li>
                    </ol>
                </td>
                <td class="todo {$today2.class}">
                    <ol module="Calendar_List2">
                        <li><a href="#none" onclick="{$action_list_view}">[{$calendar_start_hour}:{$calendar_start_minute}]<span>{$calendar_title}</span></a></li>
                        <li><a href="#none" onclick="{$action_list_view}">[{$calendar_start_hour}:{$calendar_start_minute}]<span>{$calendar_title}</span></a></li>
                    </ol>
                </td>
                <td class="todo {$today3.class}">
                    <ol module="Calendar_List3">
                        <li><a href="#none" onclick="{$action_list_view}">[{$calendar_start_hour}:{$calendar_start_minute}]<span>{$calendar_title}</span></a></li>
                        <li><a href="#none" onclick="{$action_list_view}">[{$calendar_start_hour}:{$calendar_start_minute}]<span>{$calendar_title}</span></a></li>
                    </ol>
                </td>
                <td class="todo {$today4.class}">
                    <ol module="Calendar_List4">
                        <li><a href="#none" onclick="{$action_list_view}">[{$calendar_start_hour}:{$calendar_start_minute}]<span>{$calendar_title}</span></a></li>
                        <li><a href="#none" onclick="{$action_list_view}">[{$calendar_start_hour}:{$calendar_start_minute}]<span>{$calendar_title}</span></a></li>
                    </ol>
                </td>
                <td class="todo {$today5.class}">
                    <ol module="Calendar_List5">
                        <li><a href="#none" onclick="{$action_list_view}">[{$calendar_start_hour}:{$calendar_start_minute}]<span>{$calendar_title}</span></a></li>
                        <li><a href="#none" onclick="{$action_list_view}">[{$calendar_start_hour}:{$calendar_start_minute}]<span>{$calendar_title}</span></a></li>
                    </ol>
                </td>
                <td class="todo {$today6.class}">
                    <ol module="Calendar_List6">
                        <li><a href="#none" onclick="{$action_list_view}">[{$calendar_start_hour}:{$calendar_start_minute}]<span>{$calendar_title}</span></a></li>
                        <li><a href="#none" onclick="{$action_list_view}">[{$calendar_start_hour}:{$calendar_start_minute}]<span>{$calendar_title}</span></a></li>
                    </ol>
                </td>
                <td class="todo {$today7.class}">
                    <ol module="Calendar_List7">
                        <li><a href="#none" onclick="{$action_list_view}">[{$calendar_start_hour}:{$calendar_start_minute}]<span>{$calendar_title}</span></a></li>
                        <li><a href="#none" onclick="{$action_list_view}">[{$calendar_start_hour}:{$calendar_start_minute}]<span>{$calendar_title}</span></a></li>
                    </ol>
                </td>
            </tr>
        </tbody>
    </table>
					
					
					
					
					
					
					
					
					
				</div>
</div>

<%@ include file="../bar/footer.jsp"%>
<%@ include file="../bar/logoutModal.jsp"%>

</div></div>


				<!-- Bootstrap core JavaScript-->
				<script src="vendor/jquery/jquery.min.js"></script>
				<script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

				<!-- Core plugin JavaScript-->
				<script src="vendor/jquery-easing/jquery.easing.min.js"></script>

				<!-- Custom scripts for all pages-->
				<script src="js/sb-admin-2.min.js"></script>

				<!-- bootstrap -->
				<script
					src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>


</html>
<!-- Dialog Box-->
<script src="js/reservation/calender_sm.js"></script>
<script src="js/reservation/calender_reserv.js"></script>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"
	integrity="sha256-hwg4gsxgFZhOsEEamdOYGBf13FyQuiTwlAQgxVSNgt4="
	crossorigin="anonymous">
  </script>
<script src="app.js"></script>