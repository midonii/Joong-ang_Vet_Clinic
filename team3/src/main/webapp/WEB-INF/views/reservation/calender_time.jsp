<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>



        <form action="/calender" method="post">
<!--           <div class="card-body p-3 p-sm-5"> -->
            <div class="row text-center mx-0">
              <div class="col-md-3 col-4 my-1 px-2"><div class="cell py-1">9:00</div></div>
              <div class="col-md-3 col-4 my-1 px-2"><div class="cell py-1">9:30</div></div>
              <div class="col-md-3 col-4 my-1 px-2"><div class="cell py-1">10:00</div></div>
              <div class="col-md-3 col-4 my-1 px-2"><div class="cell py-1">10:30</div></div>
            </div>
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
              <div class="col-md-3 col-4 my-1 px-2"><div class="cell py-1" >16:00</div></div>
              <div class="col-md-3 col-4 my-1 px-2"><div class="cell py-1">16:30</div></div>
              <div class="col-md-3 col-4 my-1 px-2"><div class="cell py-1">17:00</div></div>
              <div class="col-md-3 col-4 my-1 px-2"><div class="cell py-1">17:00</div></div>
            </div>
<!--           </div> -->
        </form>
<style type="text/css">


</style>
<script type="text/javascript">
$(document).ready(function(){

	$('.cell').click(function(){
	    $('.cell').removeClass('select');
	    $(this).addClass('select');
	});

	});
</script>