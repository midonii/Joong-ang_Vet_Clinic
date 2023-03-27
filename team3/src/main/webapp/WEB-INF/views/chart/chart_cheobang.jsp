<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<!-- 처방내역 -->
<div class="card-body" style="height: 329px;">

 
<div class="card-body" style="height: 329px; padding:0;">
	<div class="table-responsive" style="min-height: 300px; float:left;"> 
	<div class="table-responsive" style="max-height: 300px; float:left;">
		<table class="table table-bordered table-sm" width="100%"
			cellspacing="0"
			style="text-align: center; overflow: auto; max-height: 280px;">
			<thead>
				<tr class="bg-gray-100" style="float: center;">
					<th class="col-2">구분</th>
					<th class="col-5">이름</th>
					<th class="col-2">수량</th>
					<th class="col-4">합계</th>
				</tr>
			</thead>
			<tbody class="saveTable1">
			</tbody>
		</table>
	</div>
	</div>
	<div style="width:100%; border-top:1px solid #ccc; float:left; height:40px;">
	<div style="float:left; width:calc(100% - 150px); text-align:right; "> 총 합계 : </div>
	<div class="totalPrice"style="float:left; width:130px; text-align:right; margin-right: 10px; "></div>
		 
	</div> 
</div>