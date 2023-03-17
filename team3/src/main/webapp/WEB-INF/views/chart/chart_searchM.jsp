<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 검색모달  -->
<div class="modal fade" id="petSearchModal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">
					<b>전체 검색</b>
				</h5>
				<button class="close" type="button" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">×</span>
				</button>
			</div>
			<div class="modal-body">

				<form action="/petType" name="searchForm" onsubmit="return false"
					method="get">
					<div class="input-group mt-2 mb-3">
						<input type="text"
							class="form-control border-gray col-md-12 pet_search2"
							placeholder="검색어을 입력하세요" name="pet_search2" id="pet_search2">
						<div class="input-group-append">
							<button class="btn btn-primary" type="button" id="search_btn2">
								<i class="fas fa-search"></i>
							</button>
						</div>
					</div>
				</form>
				<div class="table-responsive">
					<table class="table table-sm table-bordered text-center"
						id="dataTable" width="100%" cellspacing="0"
						style="overflow: auto;">
						<thead>
							<tr class="bg-gray-200" style="line-height: 30px;">
								<th class="col-1">번호</th>
								<th class="col-2">보호자명</th>
								<th class="col-2">동물명</th>
								<th class="col-1">성별</th>
								<th class="col-4">전화번호</th>
								<th class="col-2"></th>
							</tr>
						</thead>

						<tbody class="petTable">


						</tbody>
					</table>
				</div>





			</div>
			<!-- <div class="modal-footer"></div> -->
		</div>
	</div>
</div>