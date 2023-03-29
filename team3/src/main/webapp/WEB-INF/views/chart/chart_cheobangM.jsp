<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 처방모달  -->
<div class="modal fade" id="prescModal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true" data-backdrop="static">
	<div class="modal-dialog modal-xl" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">
					<b>처방</b>
				</h5>
				<button class="close" type="button" data-dismiss="modal" id="closebtn"
					aria-label="Close">
					<span aria-hidden="true">×</span>
				</button>
			</div>
			<div class="modal-body">

				<!-- 좌우 전체 -->
				<div class="row justify-content-center">
					<!-- 왼쪽 리스트+검색 시작  -->
					<div class="border-right col-6 col-md-6" style="padding: 10px;">
						<!-- 검색 시작  -->
									<div class="mb-3">
										<div class="input-group">
											<select class="form-control form-control-sm col-md-3"
												name="search_name" id="search_name" style="border-radius: 3px 0 0 3px;">
												<option value="all">전체</option>
												<option value="drug">약품</option>
												<option value="exam">진료</option>
												<option value="vac">접종</option>
											</select> 
											<input type="text"
												class="form-control form-control-sm border-gray col-md-9"
												placeholder="검색어를 입력하세요" name="search_value" id="search_value">
											<div class="input-group-append">
												<button class="btn btn-primary btn-sm" type="submit" id="modal_search">
													<i class="fas fa-search"></i>
												</button>
											</div>
										</div>
									</div>
						<!--리스트테이블 시작  -->
						<div class="table-responsive " style="height : 600px;">
						
							<table class="table table-bordered table-sm first_table" width="100%"
								cellspacing="0" style="text-align: center; overflow: auto;">
								<thead>
									<tr class="bg-gray-100">
										<th class="col-1"></th>
										<th class="col-2">구분</th>
										<th class="col-6">이름</th>
										<th class="col-3">단가</th>
									</tr>
								</thead>
								<tbody class="precTable" > 
								
								
								</tbody>
							</table>
						</div>
					</div>
					<!-- 우측 시작 -->
					<div class="col-6 col-md-6"
						style=" padding: 10px;  ">
						<div class="table-responsive" style="max-height : 648px;">
						<table class="table table-bordered table-sm second_table" width="100%"
								cellspacing="0" style="text-align: center; overflow: auto; max-height: 648px;">
								<thead>
									<tr class="bg-gray-100" style="float:center;">
										<th class="col-1"></th>
										<th class="col-2">구분</th>
										<th class="col-6">이름</th>
										<th class="col-3">단가</th>
									</tr>
								</thead>
								<tbody class="checkedTable">
								</tbody>
							</table>
					</div>
				</div>						

				</div><!--좌우전체 끝-->

				<div class="modal-footer">
						<button class="btn btn-primary btn-sm  reset_btn" type="button" style="float: right;">초기화</button>
						<button class="btn btn-primary btn-sm  save_btn" disabled="" type="button" style="float: right;">저장</button>
				</div>
			</div>
		</div>
	</div>
</div>





