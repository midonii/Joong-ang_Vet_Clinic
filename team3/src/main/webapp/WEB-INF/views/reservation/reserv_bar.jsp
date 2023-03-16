<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<!-- 메뉴2 -->
<ul class="nav" id="menu2">
	<li class="nav-item"><a class="nav-link" aria-current="page"
		href="#"><span style="color: gray;">예약</span> <span><b>${fn:length(reservlist)}&nbsp;&nbsp;</b></span></a></li>
	<li class="nav-item"><a class="nav-link" href="#"><span
			style="color: gray;">접수대기</span> <span><b>${fn:length(receplist)}&nbsp;&nbsp;</b></span></a></li>
	<li class="nav-item"><a class="nav-link" href="#"><span
			style="color: gray;">진료중</span> <span><b>5&nbsp;&nbsp;</b></span></a></li>
</ul>