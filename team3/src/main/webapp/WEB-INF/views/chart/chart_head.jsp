<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 차트 헤드 -->
<div class="card-header py-2 d-flex flex-row align-items-center">

	<div class="col-9">

		<table border="0" cellspacing="0"
			style="font-size: 14px; margin-left: -10px;">

			<tr>
				<input type="hidden" id="pet_no" name="pet_no">
				<input type="hidden" id="receive_no" name="receive_no">
				<input type="hidden" id="receive_state" name="receive_state">
				<td>보호자명 :&nbsp; <b class="text-gray-800"><span class="ownername"></span></b>&nbsp;&nbsp;
				</td>
				<td>동물명</b> :&nbsp; <b class="text-gray-800"><span class="petname"></span></b>&nbsp;&nbsp;
				</td>
				<td>견종 :&nbsp;<span class="pettype"> </span>&nbsp;&nbsp;</td>
				<td>성별 :&nbsp;<span class="petgender"></span>&nbsp;&nbsp;</td>
				<td>생년월일 :&nbsp;<span class="petbirth"> </span>&nbsp;&nbsp;</td>
				<td>체중 :&nbsp;<span class="petweight"> </span>kg&nbsp;&nbsp;</td>
				<td>담당의 :&nbsp; <span>${sessionScope.username }</span>&nbsp;&nbsp;</td>

			</tr>


		</table>

	</div>
	<div class="col-3 d-flex justify-content-end">
		<button type="button" class=" btn btn-primary btn-sm disabled" id="chartAdd">저장</button>
	</div>
</div>