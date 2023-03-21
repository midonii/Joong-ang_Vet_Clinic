/**
 * 시라
 */

$(function() {
	/*접수현황*/
	$.post({
		url: "/receiveboard",
		dataType: "json"
	}).done(function(data) {
		let receiveboard = data.receiveboard;
	
		var table = "<table class='table table-sm text-center' style='margin-top:-8px;'>";

		for (let i = 0; i < receiveboard.length; i++) {
			var bno = receiveboard[i].bno;
			var pet_name = receiveboard[i].pet_name;
			var type_name = receiveboard[i].type_name;
			var pet_no = receiveboard[i].pet_no;
			var owner_name = receiveboard[i].owner_name;
			var receive_time = receiveboard[i].receive_time;
			var receive_no = receiveboard[i].receive_no;
			var receive_state = receiveboard[i].receive_state;
			var reservation_date = receiveboard[i].reservation_date;
			var type_name = receiveboard[i].type_name;


			table += "<tr>";
			table += "<td class='col-1' style='vertical-align: middle' >" + bno + "</td>";
			if (reservation_date != null) {
				table += "<td class='col-2'><span class=' badge  rounded-pill bgtime1 '>접</span>&nbsp;" + receive_time;
				table += "<br><span class=' badge  rounded-pill bgtime2 '>예</span>&nbsp;" + reservation_date + "</td>";
			} else {
				table += "<td class='col-2' style='vertical-align : middle;'><span class=' badge  rounded-pill bgtime1'>접</span>&nbsp;" + receive_time;
			}
			table += "<td class='col-5'><a  style='text-decoration: none;' id='pet_name' value='" + receive_no + "' >";
			table += "<b class='text-primary' style='cursor:pointer;'>" + pet_name + "&nbsp;(" + type_name + ")" + "</b></a><br>" + owner_name + "</td>";
			if (receive_state == 1) {
				table += "<td style='vertical-align: middle'><span class='badge text-bg-primary'>진료대기</span></td>";
			} else {
				table += "<td style='vertical-align: middle'><span class='badge text-bg-danger'>진료중</span></td>";

			}
			table += "<td class='col-3'><button class='btn btn-sm btn-primary recbtn'>호출</button></td>";

			table += "</tr>";


		}
		$("#receiveboard").append(table);

	}).fail(function(){
		alert("문제가 발생했습니다.");
	});

	
	/*펫네임 클릭시*/
   $(document).on("click", "#pet_name", function() {
      let receiveno = $(this).attr("value");
      $.get({
         url: "/petdetailAjax",
         cache: false,
         data: { "receiveno": receiveno },
         dateType: "json"
      }).done(function(data) {
         let result = data.result;

         $(".ownername").text(result.owner_name);
         $(".petname").text(result.pet_name);
         $(".pettype").text(result.type_name);
         $(".petgender").text(result.pet_gender);
         $(".petbirth").text(result.pet_birth);
         $(".petweight").text(result.pet_weight);
         $("#pet_no").val(result.pet_no);

      var pet_no = $("#pet_no").val();
      alert(pet_no);
      $.post({
         url: "/petVacAjax",
         cache: false,
         data: {
            "pet_no": pet_no
         },
         dataType: "json"
      })
         .done(
            function(data) {
               let pet = data.pet;
               $("#vac").empty();
               var div = "";
               if (pet == "") {
                  div += "<div class='list-group-item'><div style='line-height: 250px;text-align: center;'>접종 내역이 없습니다.</div></div>";
               } else {
                  for (let i = 0; i < pet.length; i++) {
                     var vac_name = pet[i].vac_name;
                     var vacdata_date = pet[i].vacdata_date;
                     div += "<div class='list-group-item row'><div class='col-5 font-weight-bold float-left'>"
                        + vac_name
                        + "</div><div class='col-7 float-left'>"
                        + vacdata_date + "</div></div>";
                  }
               }
               $("#vac").append(div);
            }).fail(function(xhr, status, errorThrown) {
               alert("실패");
            });


      }).fail(function(xhr, status, errorThrown) {
         alert("문제가 발생했습니다.");

      });

   });


	/*처방내역*/
	$("#presc").click(function(){
		let receiveno = $(this).attr("value");
		$("#prescModal").modal("show");
		$.ajax({
			url : '/prescAjax',
			type : 'GET',
			success : function(data){
				let prescList = data.prescList;
				let table = "<tr>";
				
				for(let i=0; i<prescList.length; i++){
					let mcategory = prescList[i].medical_category;
					let mname = prescList[i].medical_name;
					let mprice = prescList[i].medical_price;
					
					table += "<td class='col-1'><input type='checkbox' class='list_check'></td>";
					table += "<td class='col-2' id='cate'>"+mcategory+"</td>";
					table += "<td class='col-6' id='mediname'>"+mname+"</td>";
					table += "<td class='col-3' id='mediprice'>"+mprice+ "원</td></tr>";
				}
				
				let prescVacList = data.prescVacList;
				let table2 = "<tr>";
				
				for(let i=0; i<prescVacList.length; i++){
					let vname = prescVacList[i].vac_name;
					let vprice = prescVacList[i].vac_price;
					
					
					table2 += "<td class='col-1'><input type='checkbox' class='list_check'></td>";
					table2 += "<td class='col-2' id='cate'>접종</td>";
					table2 += "<td class='col-6' id='mediname'>"+vname+"</td>";
					table2 += "<td class='col-3' id='mediprice'>"+vprice+ "원</td></tr>";
				}
				
				
				$(".precTable").append(table);
				$(".precTable").append(table2);
			}, error : function(xhr, status, errorThrown){
				alert("문제가 발생했습니다.");
			}
		})
	
	}); //처방추가클릭
	
	/*리스트에서 선택*/
	$(document).on("click", ".list_check", function(){
	let cate = $(this).parent().siblings("#cate").text();
	let mediname = $(this).parent().siblings("#mediname").text();
	let mediprice = $(this).parent().siblings("#mediprice").text();
	
	var chtable ="<tr style='float:center;' ><td class='col-1' style='height:35px; '><input type='checkbox' class='list_check checked' ></td>";
	 
	chtable += "<td class='col-2' id='cate'>"+cate+"</td>";
	chtable += "<td class='col-6' id='mediname'>"+mediname+"</td>";
	chtable += "<td class='col-3' id='mediprice'>"+mediprice+"</td></tr>";
	
	$(".checkedTable").append(chtable);
    
});
	


	



});//func