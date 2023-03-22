<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<!-- 보호자 상세보기 Modal -->
<div class="modal fade" id="detailModal" tabindex="-1"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header"
				style="background-color: #ECF2FF; color: #5B5B5B">
				<h5 class="modal-title font-weight-bold col-3" id="viewModalLabel">(이름)데이터가
					없습니다.</h5>
				<h5 class="modal-title font-weight-bold col-9"
					style="position: absolute; margin-left: 67px">보호자님</h5>
			</div>
			<div class="modal-body" style="margin-left: 15px;">
				<div class="row"
					style="height: 40px; padding-bottom: 30px; line-height: 40px;">
					<div class="col-2">
						<div>전화번호</div>
					</div>
					<div class="col-8">
						<div id="client_tel">(전화번호)데이터가 없습니다.</div>
					</div>
				</div>
				<div class="row"
					style="height: 30px; padding-top: 1rem; padding-bottom: 40px;">
					<div class="col-2">
						<div>주소</div>
					</div>
					<div class="col-8">
						<div id="client_addr">(주소)데이터가 없습니다.</div>
					</div>
				</div>
				<div class="row"
					style="height: 30px; padding-top: 1rem; padding-bottom: 40px;">
					<div class="col-2">
						<div>email</div>
					</div>
					<div class="col-8">
						<div id="client_email">(email)데이터가 없습니다.</div>
					</div>
				</div>
				<div class="row"
					style="height: 30px; padding-top: 1rem; padding-bottom: 40px;">
					<div class="col-2">
						<div>SMS 수신여부</div>
					</div>
					<div class="col-8">
						<div id="client_sms">(sms 수신여부)데이터가 없습니다.</div>
					</div>
				</div>
				<div class="row"
					style="height: 30px; padding-top: 1rem; padding-bottom: 1rem">
					<div class="col-2">
						<div>특이사항</div>
					</div>
					<div class="col-8">
						<div id="client_memo">(특이사항)데이터가 없습니다.</div>
					</div>
				</div>
				<div class="row"
					style="height: 30px; padding-top: 1rem; padding-bottom: 50px; border-bottom: 1px #dee2e6 solid;">
					<div class="col">
						<span
							style="display: inline-block; float: right; margin-right: 10px;">
							<button type="button" class="btn btn-primary btn-sm detailUpdate">수정</button>
							<button type="button" class="btn btn-danger btn-sm detailDelete">삭제</button>
						</span>
					</div>
				</div>
				<!-- 보호자 상세보기 Modal 끝 -->


				<!-- 보호자 상세보기 Modal 반려견 확인 부분 -->
				<div class="row"
					style="padding-top: 10px; min-height: auto; overflow-y: auto;">
					<div class="col" id="n_content">
						<div class="card shadow mb-4">
							<div class="card-header py-3">
								<h6 class="m-0 font-weight-bold text-primary">반려견</h6>
							</div>
							<div class="card-body">
								<div class="table-responsive">
									<div style="height: 250px; overflow: auto">
										<table class="table table-bordered table-hover" id="dataTable"
											width="100%" cellspacing="0">
											<thead>
												<tr>
													<th class="col-md-1">번호</th>
													<th class="col-md-2">이름</th>
													<th class="col-md-2">견종</th>
													<th class="col-md-1">성별</th>
													<th class="col-md-2">생년월일</th>
													<th class="col-md-4">특이사항</th>
												</tr>
											</thead>

											<c:forEach items="${petList }" var="pl">
												<tbody id="ajaxModalTable" value="${pl.pet_no }">
													<tr class="petListModal" value="${pl.pet_no }">
														<td class="petNo" id="petNo">${pl.pet_no }</td>
														<td class="petName" id="petName">${pl.pet_name }</td>
														<td class="typeName">${pl.type_name }</td>
														<td class="petGender">${pl.pet_gender }</td>
														<td class="petBirth">${pl.pet_birth }</td>
														<td class="petMemo">${pl.pet_memo }</td>
													</tr>
											</c:forEach>
											</tbody>
										</table>
									</div>
									<div class="row"
										style="height: 30px; width: 100%; padding-top: 1rem; padding-bottom: 50px; border-bottom: 1px #dee2e6 solid;">
										<div class="col">
											<span
												style="display: inline-block; float: right; margin-right: 10px;">
												<button class="btn btn-success btn-sm petAdd">반려견 추가</button>
												<button type="button"
													class="btn btn-primary btn-sm cm_petUpdate">수정</button>
												<button type="button"
													class="btn btn-danger btn-sm petDelete">삭제</button>
											</span>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>


			<div class="modal-footer">
				<button type="button" class="btn btn-secondary updateClose"
					data-bs-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>
<!-- 보호자의 반려견 확인 부분 끝 -->


<!-- 보호자 추가 Modal -->
<div class="modal fade" id="clientAddModal" data-bs-backdrop="static"
	tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<form>
		<div class="modal-dialog modal-lg modal-dialog-centered"
			style="width: 600px;">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">보호자 등록</h5>
					<button type="button" class="btn-close" id="clientAddModalClose"
						data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<div class="row g-1 mb-3">
						<div class="col-4">
							<div class="form-floating">
								<input type="text" class="form-control"
									name="floatingClientName" id="floatingClientName"
									placeholder="name" maxlength="6"> <label for="floatingInput">이름</label>
							</div>
						</div>
						<div class="col-8">
							<div class="form-floating">
								<input type="email" class="form-control"
									name="floatingClientEmail" id="floatingClientEmail"
									placeholder="name@example.com"> <label
									for="floatingEmail">이메일</label>
							</div>
						</div>
					</div>
					<div class="form-floating mb-3">
						<input type="text" class="form-control" name="floatingClientTel"
							id="floatingClientTel" placeholder="01012345678" maxlength="12"> <label
							for="floatingTel">전화번호</label>
					</div>
					<div class="form-floating mb-3">
						<input type="text" class="form-control" name="floatingClientAddr"
							id="floatingClientAddr" placeholder="address"> <label
							for="floatingAddr">주소</label>
					</div>
					<div class="row">
						<div class="form-check col-6">
							<input class="form-control-input" type="radio" name="smsAgree"
								value="Y" id="smsAgree" checked> <label
								class="custom-check-label" for="smsAgree"> SMS수신 동의 </label>
						</div>
						<div class="form-check col-6">
							<input class="form-control-input" type="radio" name="smsAgree"
								value="N" id="smsDisagree"> <label
								class="custom-check-label" for="smsDisagree"> SMS수신 미동의
							</label>
						</div>
					</div>
					<div class="mt-1">
						<div class="form-floating">
							<textarea class="form-control" placeholder="Leave a comment here"
								name="floatingClientComments" id="floatingClientComments"
								style="height: 150px"></textarea>
							<label for="floatingClientComments">Comments</label>
						</div>
					</div>
					<div class="mt-3 float-right">
						<button type="button" class="btn btn-warning" id="clientAddSave">저장</button>
					</div>
				</div>
			</div>
		</div>
	</form>
</div>
<!-- 보호자 추가 Modal끝 -->

<!-- 보호자 정보 수정 Modal -->
<div class="modal fade" id="clientUpdateModal" data-bs-backdrop="static"
	tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<form>
		<div class="modal-dialog modal-lg modal-dialog-centered"
			style="width: 600px;">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">보호자 정보 수정</h5>
					<button type="button" class="btn-close" id="clientUpdateModalClose"
						data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<div class="row g-1 mb-3">
						<div class="col-4">
							<div class="form-floating">
								<input type="text" class="form-control" name="updateClientName"
									id="updateClientName" placeholder="name" maxlength="6"> <label
									for="updateClientName">이름</label>
							</div>
						</div>
						<div class="col-8">
							<div class="form-floating">
								<input type="email" class="form-control"
									name="updateClientEmail" id="updateClientEmail"
									placeholder="name@example.com"> <label
									for="updateClientEmail">이메일</label>
							</div>
						</div>
					</div>
					<div class="form-floating mb-3">
						<input type="text" class="form-control" name="updateClientTel"
							id="updateClientTel" placeholder="01012345678" maxlength="12"> <label
							for="updateClientTel">전화번호</label>
					</div>
					<div class="form-floating mb-3">
						<input type="text" class="form-control" name="updateClientAddr"
							id="updateClientAddr" placeholder="address"> <label
							for="updateClientAddr">주소</label>
					</div>
					<div class="row">
						<div class="form-check col-6">
							<input class="form-control-input" type="radio"
								name="updateSmsAgree" value="Y" id="updateSmsAgree" checked>
							<label class="custom-check-label" for="updateSmsAgree">
								SMS수신 동의 </label>
						</div>
						<div class="form-check col-6">
							<input class="form-control-input" type="radio"
								name="updateSmsAgree" value="N" id="updateSmsDisagree">
							<label class="custom-check-label" for="updateSmsAgree">
								SMS수신 미동의 </label>
						</div>
					</div>
					<div class="mt-1">
						<div class="form-floating">
							<textarea class="form-control" placeholder="Leave a comment here"
								name="updateClientComments" id="updateClientComments"
								style="height: 150px"></textarea>
							<label for="updateClientComments">Comments</label>
						</div>
					</div>
					<div class="mt-3 float-right">
						<button type="button" class="btn btn-warning"
							id="clientUpdateSave">저장</button>
					</div>
				</div>
			</div>
		</div>
	</form>
</div>


<!-- 반려견 등록 Modal -->
<div class="modal fade" id="petAddModal" data-bs-backdrop="static"
	tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<form action="/petAdd" name="petAdd" method="post"
		enctype="multipart/form-data">
		<div class="modal-dialog modal-lg modal-dialog-centered"
			style="width: 700px;">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">반려견 등록</h5>
					<button type="button" class="btn-close" id="petAddModalClose"
						data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<div class="row g-1">
						<div class="col-4">
							<div id="petImgArea">
							<img src="../img/logoda.png" id="petProfileImg" class="img-thumbnail mb-3" onerror="imgAreaError()"
								alt="이미지를 불러올 수 없습니다." style="width: 200px; height: 200px;">
							</div>
							<div class="mb-3">
								<label for="petImg" class="form-label">반려견 img file</label>
								<input class="form-control form-control-sm" accept="image/*"
									id="petImg" name="petImg" onchange="previewImage(this,'View_area')" onclick="dataSubmit();" multiple type="file" style="width: 200px;">
							</div>
						</div>
						<div class="col-8">
							<div class="row g-1 mb-3">
								<div class="col-8">
									<div class="form-floating">
										<input type="text" class="form-control" name="petAddName"
											id="petAddName" placeholder="pet name"> <label
											for="petAddName">반려견 이름</label>
									</div>
								</div>
								<div class="col-4">
									<div class="form-floating">
										<input type="text" class="form-control" name="petAddWeight"
											id="petAddWeight" placeholder="kg" maxlength="5"> <label
											for="petAddWeight">몸무게(kg)</label>
									</div>
								</div>
							</div>
							<div class="row g-1 mb-3">
								<div class="col-6" style="height: 32px;">
									<input type="hidden" id="owner_noPAdd" name="owner_noPAdd">
									<input type="hidden" id="owner_nameAdd" name="owner_nameAdd">
									<select name="petAddType" id="petAddType"
										class="form-control form-control-sm">
										<option>견종을 선택하세요</option>
										<c:forEach items="${petTypeList }" var="pt">
											<option value="${pt.type_no }" name="${pt.type_no }">${pt.type_name }</option>
										</c:forEach>
									</select>
								</div>
								<div class="col-6" style="height: 32px;">
									<select name="petSex" id="petSex"
										class="form-control form-control-sm">
										<option>성별을 선택하세요</option>
										<option value="S/F">S/F</option>
										<option value="I/F">I/F</option>
										<option value="N/M">N/M</option>
										<option value="I/M">I/M</option>
									</select>
								</div>
							</div>
							<div class="mb-3 w-100" style="height: 32px;">
								<select class="form-control form-control-sm col-md-3" title="년도"
									aria-label="Default select example" name="petBirthYear"
									id="petBirthYear" style="float: left;"></select>
								<div class="col-sm-1" style="float: left; line-height: 31px;">년</div>
								<select class="form-control form-control-sm col-md-3" title="월"
									aria-label="Default select example" name="petBirthMonth"
									id="petBirthMonth" style="float: left;"></select>
								<div class="col-sm-1" style="float: left; line-height: 31px;">월</div>
								<select class="form-control form-control-sm col-md-3" title="일"
									aria-label="Default select example" name="petBirthDay"
									id="petBirthDay" style="float: left;"></select>
								<div class="col-sm-1" style="float: left; line-height: 31px;">일</div>
							</div>
							<div class="mt-1">
								<div class="form-floating">
									<textarea class="form-control"
										placeholder="Leave a comment here" name="petAddComments"
										id="petAddComments" style="height: 110px"></textarea>
									<label for="petAddComments">Comments</label>
								</div>
							</div>
						</div>
					</div>
					<div class="mt-3 float-right">
						<button type="button" class="btn btn-warning" id="petAddSave">저장</button>
					</div>
				</div>
			</div>
		</div>
	</form>
</div>
<!-- 반려견 Modal끝 -->

<!-- 반려견 수정 Modal -->
<div class="modal fade" id="petUpdateModal" data-bs-backdrop="static"
	tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<form>
		<div class="modal-dialog modal-lg modal-dialog-centered"
			style="width: 700px;">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="petUpdateModalLabel">반려견 정보 수정</h5>
					<button type="button" class="btn-close" id="petUpdateModalClose"
						data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<div class="row g-1">
						<div class="col-4">
							<img src="../img/logoda.png" class="img-thumbnail mb-3"
								alt="이미지를 불러올 수 없습니다." style="width: 200px; height: 200px;">
							<div class="mb-3">
								<label for="formFileSm" class="form-label">반려견 img file</label>
								<input class="form-control form-control-sm" accept="image/*"
									id="petImg" type="file" style="width: 200px;">
							</div>
						</div>
						<div class="col-8">
							<div class="row g-1 mb-3">
								<div class="col-8">
									<div class="form-floating">
										<input type="text" class="form-control" name="petUpdateName"
											id="petUpdateName" placeholder="pet name"> <label
											for="petUpdateName">반려견 이름</label>
									</div>
								</div>
								<div class="col-4">
									<div class="form-floating">
										<input type="text" class="form-control" name="petUpdateWeight"
											id="petUpdateWeight" placeholder="kg" maxlength="5"> <label
											for="petUpdateWeight">몸무게(kg)</label>
									</div>
								</div>
							</div>
							<div class="row g-1 mb-3">
								<div class="col-6" style="height: 32px;">
									<input type="hidden" id="owner_noPUp" name="owner_noPUp">
									<input type="hidden" id="owner_nameUpdate"
										name="owner_nameUpdate"> <select name="petUpdateType"
										id="petUpdateType" class="form-control form-control-sm">
										<option>견종을 선택하세요</option>
										<c:forEach items="${petTypeList }" var="pt">
											<option value="${pt.type_no }" name="${pt.type_no }">${pt.type_name }</option>
										</c:forEach>
									</select>
								</div>
								<div class="col-6" style="height: 32px;">
									<select name="petUpdateSex" id="petUpdateSex"
										class="form-control form-control-sm">
										<option>성별을 선택하세요</option>
										<option value="S/F">S/F</option>
										<option value="I/F">I/F</option>
										<option value="N/M">N/M</option>
										<option value="I/M">I/M</option>
									</select>
								</div>
							</div>
							<label for="petUpdateBirth" class="form-label">생년월일 : <span id="petBirth">데이터가 없습니다.</span></label>
							<div class="mb-3 w-100" id="petUpdateBirth"  style="height: 32px;">
								<select class="form-control form-control-sm col-md-3" title="년도"
									aria-label="Default select example" name="petUpdateBirthYear"
									id="petUpdateBirthYear" style="float: left;"></select>
								<div class="col-sm-1" style="float: left; line-height: 31px;">년</div>
								<select class="form-control form-control-sm col-md-3" title="월"
									aria-label="Default select example" name="petUpdateBirthMonth"
									id="petUpdateBirthMonth" style="float: left;"></select>
								<div class="col-sm-1" style="float: left; line-height: 31px;">월</div>
								<select class="form-control form-control-sm col-md-3" title="일"
									aria-label="Default select example" name="petUpdateBirthDay"
									id="petUpdateBirthDay" style="float: left;"></select>
								<div class="col-sm-1" style="float: left; line-height: 31px;">일</div>
							</div>
							<div class="mt-1 mb-3">
								<div class="form-floating">
									<textarea class="form-control"
										placeholder="Leave a comment here" name="petUpdateComments"
										id="petUpdateComments" style="height: 110px"></textarea>
									<label for="petUpdateComments">Comments</label>
								</div>
							</div>
							<div class="form-floating">
								<input type="text" class="form-control" name="petDeath"
									id="petDeath" placeholder="pet name"> <label
									for="petDeath">반려견 사망일</label>
							</div>
						</div>
					</div>
					<div class="mt-3 float-right">
						<button type="button" class="btn btn-warning" id="petUpdateSave">저장</button>
						<button type="button" class="btn btn-danger" id="petUpdateDel">삭제</button>
					</div>
				</div>
			</div>
		</div>
	</form>
</div>
<!-- 반려견 수정 Modal끝 -->
