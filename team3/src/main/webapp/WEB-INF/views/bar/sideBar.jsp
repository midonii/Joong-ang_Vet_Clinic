<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- Sidebar -->
<ul
	class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion"
	id="accordionSidebar">

	<!-- Sidebar - Brand -->
	<a
		class="sidebar-brand d-flex align-items-center justify-content-center"
		href="/index">
		<div class="sidebar-brand-icon rotate-n-15">
			<i class="fas fa-solid fa-paw"></i>
		</div>
		<div class="sidebar-brand-text mx-3">
			중앙 동물병원 <sup><i class="fas fa-solid fa-comment-medical"></i></sup>
		</div>
	</a>

	<!-- Divider -->
	<hr class="sidebar-divider my-0">

	<li class="nav-item active"><a class="nav-link" href="/index">
			<i class="fa-solid fa-house-chimney"></i> <span>INDEX</span>
	</a></li>
	<!-- Divider -->
	<hr class="sidebar-divider">

	<!-- Heading -->
	<div class="sidebar-heading">Main Menu</div>

	<!-- Nav Item - Pages Collapse Menu -->
	<li class="nav-item active"><a class="nav-link collapsed" href="#"
		data-toggle="collapse" data-target="#collapseReserv"
		aria-expanded="true" aria-controls="collapseReserv"><i
			class="fas fa-solid fa-receipt"></i> <span>예약/접수</span> </a>
		<div id="collapseReserv" class="collapse" aria-labelledby="headingTwo"
			data-parent="#accordionSidebar">
			<div class="bg-white py-2 collapse-inner rounded">
				<a class="collapse-item" href="#.html">예약/접수 현황</a> <a
					class="collapse-item" href="#.html">Calendar</a>
			</div>
		</div></li>



	<li class="nav-item active"><a class="nav-link" href="index.html">
			<i class="fas fa-sharp fa-solid fa-comments-dollar"></i> <span>수납</span>
	</a></li>
	<li class="nav-item active"><a class="nav-link" href="index.html">
			<i class="fas fa-solid fa-stethoscope"></i> <span>진료</span>
	</a></li>

	<!-- Nav Item - Pages Collapse Menu -->
	<li class="nav-item active"><a class="nav-link collapsed" href="#"
		data-toggle="collapse" data-target="#collapseClient"
		aria-expanded="true" aria-controls="collapseClient"><i
			class="fas fa-regular fa-users"></i> <span>회원관리</span> </a>
		<div id="collapseClient" class="collapse" aria-labelledby="headingTwo"
			data-parent="#accordionSidebar">
			<div class="bg-white py-2 collapse-inner rounded">
				<a class="collapse-item" href="buttons.html">회원 정보</a> <a
					class="collapse-item" href="buttons.html">이전 진료 내역</a>
			</div>
		</div></li>



	<li class="nav-item active"><a class="nav-link" href="index.html">
			<i class="fas fa-solid fa-comment-sms"></i> <span>SMS 발송</span>
	</a></li>
	<li class="nav-item active"><a class="nav-link" href="/notice">
			<i class="fas fa-regular fa-clipboard"></i> <span>공지사항</span>
	</a></li>


<c:if test="${sessionScope.staff_grade eq 'admin' }">
	<!-- Divider -->
	<hr class="sidebar-divider">

	<!-- Heading -->
	<div class="sidebar-heading">ADMIN</div>

	<!-- Nav Item - Pages Collapse Menu -->
	<li class="nav-item"><a class="nav-link collapsed" href="#"
		data-toggle="collapse" data-target="#collapseAdmin"
		aria-expanded="true" aria-controls="collapseAdmin"> <i
			class="fas fa-sharp fa-solid fa-toolbox"></i> <span>관리자</span>
	</a>
		<div id="collapseAdmin" class="collapse" aria-labelledby="headingTwo"
			data-parent="#accordionSidebar">
			<div class="bg-white py-2 collapse-inner rounded">
				<h6 class="collapse-header">관리</h6>
				<a class="collapse-item" href="/medicine">데이터 관리</a> <a
					class="collapse-item" href="/staffList">직원 관리</a> <a
					class="collapse-item" href="cards.html">매출 관리</a> <a
					class="collapse-item" href="cards.html">재고 관리</a>
			</div>
		</div></li>
</c:if>




	<!-- Divider -->
	<hr class="sidebar-divider d-none d-md-block">

	<!-- Sidebar Toggler (Sidebar) -->
	<div class="text-center d-none d-md-inline">
		<button class="rounded-circle border-0" id="sidebarToggle"></button>
	</div>



</ul>
<!-- End of Sidebar -->