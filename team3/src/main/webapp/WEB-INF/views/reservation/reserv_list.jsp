<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 예약리스트 -->
						<div class="col-xl-4" style="z-index:2;">
							<div class="card shadow mb-4">
								<!-- title -->
								<div class="card-header py-3">
									<h6 class="m-0 font-weight-bold text-primary">예약</h6>
								</div>
								<div class="card-body p-3"
									style="height: 660px; overflow: auto;">

									<table class="table table-borderless"
										style="color: gray; background-color: white;">

										<c:forEach items="${reservlist}" var="l">
											<input type="hidden" id="age">
											<tr
												style="border-bottom: 1px solid gray; padding-bottom: 5px;">
												<td style="font-size: 14px;">
													<div style="">
														<a style="text-decoration: none;"><b
															style="font-size: 25px; color: black"> ${l.pet_name}</b></a>&nbsp;&nbsp;&nbsp;${l.owner_name}&nbsp;
														<a class="reservUpdate" value="${l.reservation_no}"
															style="text-decoration: none;"> <i
															class="xi-file-text-o"></i>
														</a>${l.pet_no}


													</div> <br>
													<div>
														<span>${l.type_name} | ${l.pet_birth} |
															${l.pet_gender}</span>
													</div> <span> ${l.reservation_memo} </span>
												<td style="text-align: right;"><span><b><h5>${l.reserv_time}</h5></b></span><br>
													<input type="hidden" id="petNo" value="${l.pet_no}">
													<input type="hidden" id="ownerNo" value="${l.owner_no}">
													<input type="hidden" id="reservation_Yn"
													value="${l.reservation_yn}"> <span>
														<button type="button"
															class="btn btn-secondary btn-sm reserv_cancel" id=""
															value="${l.reservation_no}"
															style="background-color: #7f8c8d; border: none;">취소</button>
														<button type="button"
															class="btn btn-primary btn-sm receipt_btn"
															value="${l.reservation_no}" style="border: none;">접수</button>
												</span></td>



											</tr>
										</c:forEach>
									</table>

								</div>
							</div>
						</div>