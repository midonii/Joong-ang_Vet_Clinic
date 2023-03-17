<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- 메뉴1 -->
<ul class="nav" id="menu1">
	<li class="nav-item"><a class="nav-link" aria-current="page"
		href="reserv" style="color: gray;">예약/접수</a></li>
	<li class="nav-item"><a class="nav-link" href="calender"
		style="color: gray;">캘린더</a></li>
	<li class="nav-item1"><a class="nav-link" href="#"></a></li>
	<li class="nav-item">
		<button type="button" class="btn btn-success">신규등록</button>
	</li>
</ul>
<!-- 메뉴2 -->
<ul class="nav" id="menu2">
	<li class="nav-item"><a class="nav-link" aria-current="page"
		href="#"><span style="color: gray;">예약</span> <span><b>${fn:length(reservlist)}&nbsp;&nbsp;</b></span></a></li>
	<li class="nav-item"><a class="nav-link" href="#"><span
			style="color: gray;">접수대기</span> <span><b>${fn:length(receplist)}&nbsp;&nbsp;</b></span></a></li>
	<li class="nav-item"><a class="nav-link" href="#"><span
			style="color: gray;">진료중</span> <span><b>5&nbsp;&nbsp;</b></span></a></li>
</ul>