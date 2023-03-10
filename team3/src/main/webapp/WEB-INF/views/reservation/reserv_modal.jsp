<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">

<div class="dialog" id="dialog" style="overflow:auto;">

	<!-- 검색기능 -->
	 <div style="width::50px; margin-top:10px; border-bottom:3px solid #9e9e9e;">
	  <form class="form-inline search_form" name="searchForm" action="/calender" method="get">
	    <input class="form-control ml-auto" style="width: 230px; margin-right:7px;" value="" type="text" name="search_value" id="search_value" placeholder="검색어를 입력하세요" aria-label="검색">
	    <button class="btn btn-outline-success my-2 my-sm-0 bi bi-search" id="search_btn">검색</button>
	  </form> 
	</div>
	
	
	
	
	
	<form class="row g-4 form" name="reservForm" action="/calender" method="post" style="margin-top:7px;">
	  <div class="col-md-6">  
	    <label class="form-label marginTop5" for="owner_name">보호자 이름</label>
	    <input type="text" class="form-control" id="owner_name">
	  </div>
	  <div class="col-md-6">
	    <label class="form-label marginTop5"  for="owner_tel">전화번호</label>
	    <input type="text" class="form-control" id="owner_tel" placeholder="01012345678">
	  </div>
	  <div class="col-md-6">
	    <label class="form-label marginTop5" for="pet_name">반려견 이름</label>
	    <input type="text" class="form-control" id="pet_name">
	  </div>
	  <div class="col-md-6">
	    <label class="form-label marginTop5"  for="pet_type">견종</label>
	    <input type="text" class="form-control" id="pet_type">
	  </div>
	  <!-- 시간설정 -->
	  <div class="col-md-6" style="width:auto;">
		<label for="inputAddress" class="form-label" for="owner_addr">시간선택</label>
		 <div class="accordion" id="accordionExample">
		  <div class="accordion-item">
		      <button class="accordion-button collapsed" style="width:470px; height:38px;" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne" aria-expanded="false" aria-controls="collapseOne">
		        시간선택
		      </button>
			    <div id="collapseOne" class="accordion-collapse collapse" aria-labelledby="headingOne" data-bs-parent="#accordionExample">
			      <div class="accordion-body">


								            <div class="row text-center mx-0">
								              <div class="col-md-3 col-4 my-1 px-2"><div class="cell py-1">11:00</div></div>
								              <div class="col-md-3 col-4 my-1 px-2"><div class="cell py-1">11:30</div></div>
								              <div class="col-md-3 col-4 my-1 px-2"><div class="cell py-1">12:00</div></div>
								              <div class="col-md-3 col-4 my-1 px-2"><div class="cell py-1">12:30</div></div>
								            </div>
								            <div class="row text-center mx-0">
								              <div class="col-md-3 col-4 my-1 px-2"><div class="cell py-1">13:00</div></div>
								              <div class="col-md-3 col-4 my-1 px-2"><div class="cell py-1">14:30</div></div>
								              <div class="col-md-3 col-4 my-1 px-2"><div class="cell py-1">15:00</div></div>
								              <div class="col-md-3 col-4 my-1 px-2"><div class="cell py-1">15:30</div></div>
								            </div>
								            <div class="row text-center mx-0">
								              <div class="col-md-3 col-4 my-1 px-2"><div class="cell py-1">16:00</div></div>
								              <div class="col-md-3 col-4 my-1 px-2"><div class="cell py-1">16:30</div></div>
								              <div class="col-md-3 col-4 my-1 px-2"><div class="cell py-1">17:00</div></div>
								              <div class="col-md-3 col-4 my-1 px-2"><div class="cell py-1">17:00</div></div>
								            </div>

			      </div>
			    </div>
		    </div>
		  </div>
	  </div>
	  <div class="col-md-6" style="right:5px;">
	    <label class="form-label" for="reserv_memo">예약메모</label>
	    <textarea class="form-control" id="reserv_memo" style="height:100px; width:460px;"></textarea>
	  </div>
	  
	  
	  <div class="buttons">
           <input type="button" value="예약하기" class="button btn-reserv" id="ok-button">
           <input type="button" value="취소하기" class="button btn-cancle" id="cancel-button">
	  </div>
	</form>
	
</div>
</div>