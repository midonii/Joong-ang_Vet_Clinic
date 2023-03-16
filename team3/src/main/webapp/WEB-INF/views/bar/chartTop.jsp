<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- Topbar -->
<nav
	class="navbar navbar-expand navbar-light bg-white topbar static-top shadow">

	<!-- Sidebar Toggle (Topbar) -->
	<button id="sidebarToggleTop"
		class="btn btn-link d-md-none rounded-circle mr-3">
		<i class="fa fa-bars"></i>
	</button>


	<!-- Topbar Navbar -->
	<ul class="navbar-nav ml-auto">
		<li class="d-none d-inline-block form-inline mt-3 navbar-search">
			<div class="input-group d-flex justify-content-end "> 
				<input type="text" class="form-control col-9 bg-light border-0 small shadow-sm pet_search"
					placeholder="검색어를 입력하세요" aria-label="Search"
					aria-describedby="basic-addon2" id="pet_search" name="pet_search">
				<div class="input-group-append">
					<button class="btn btn-primary shadow-sm" id="search_btn" type="button">
						<i class="fas fa-search fa-sm"></i>
					</button>
				</div>
			</div>
		</li>


		<div class="topbar-divider d-none d-sm-block"></div>

		<!-- Nav Item - User Information -->
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
				<a class="dropdown-item" href="/editProfile"> <i
					class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i> 프로필 수정
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


