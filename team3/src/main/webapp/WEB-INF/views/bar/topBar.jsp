<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript" src="js/index.js"></script>
<script type="text/javascript" src="../js/datetime.js"></script>
<!-- Topbar -->
<nav
	class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">

	<!-- Sidebar Toggle (Topbar) -->
	<button id="sidebarToggleTop"
		class="btn btn-link d-md-none rounded-circle mr-3">
		<i class="fa fa-bars"></i>
	</button>

	<div
		class="d-none d-sm-inline-block form-inline mr-auto ml-md-3 my-2 my-md-0 mw-100 navbar-search">
		<div class="row">
			<div class="col-3 align-items-center p-0"  ><span style="margin-left: 45px;">예약  <b style="color:#4e73df; font-size: 18px;" id="reservCount" ></b> </span></div>
			<div class="col-2 align-items-center p-0" "><span style="margin-left: 10px;">접수  <b style="color:#1cc88a; font-size: 18px;" id="recepCount"></b></span></div>
			<div class="col-3 align-items-center p-0 "><span style="margin-left: 10px;">진료 <b style="color:#e74a3b; font-size: 18px;" id="diagCount"></b></span></div>
		</div>
	</div>
	<!-- Topbar Navbar -->
	<ul class="navbar-nav ml-auto">
		<li
			class="d-flex justify-content-end mt-3 mr-2 text-gray-800 font-weight-bold">
			<div id="date" class="text-center"
				style="font-family: Nunito; font-size: 17px; margin-top: 6px;"></div>
		</li>
		<li
			class="d-flex justify-content-end mt-3 mr-3 text-gray-800 font-weight-bold">
			<div id="time" class="text-center"
				style="font-family: Nunito; font-size: 17px; margin-top: 6px;"></div>
		</li>
		<div class="topbar-divider d-none d-sm-block"></div>
		<li class="nav-item dropdown no-arrow"><a
			class="nav-link dropdown-toggle" href="#" id="userDropdown"
			role="button" data-toggle="dropdown" aria-haspopup="true"
			aria-expanded="false"> <span
				class="mr-2 d-none d-lg-inline text-gray-600 ">${username }&nbsp;님</span>
				<img class="img-profile rounded-circle" src="img/undraw_profile.svg">
		</a> <!-- Dropdown - User Information -->
			<div
				class="dropdown-menu dropdown-menu-right shadow animated--grow-in"
				aria-labelledby="userDropdown">
				<a class="dropdown-item" href="/userProfile=${sessionScope.id }"> <i
					class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i> 프로필
				</a>
				<!-- 
				<a class="dropdown-item" href="#"> <i
					class="fas fa-cogs fa-sm fa-fw mr-2 text-gray-400"></i> Settings
				</a> 
				<a class="dropdown-item" href="#"> <i
					class="fas fa-list fa-sm fa-fw mr-2 text-gray-400"></i> Activity
					Log
				</a>
				 -->
				<div class="dropdown-divider"></div>
				<!-- 				<a class="dropdown-item" href="#" data-toggle="modal" data-target="#logoutModal">  -->
				<a class="dropdown-item" href="/logout"> <i
					class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
					로그아웃
				</a>
			</div></li>
	</ul>
</nav>
<!-- End of Topbar -->